import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:meta/meta.dart';

import 'package:fcb_calculator_v2_1/repository/repository.dart';

class FirebaseAuthRepository {
  FirebaseAuthRepository({
    CacheClient? cache,
    auth.FirebaseAuth? firebaseAuth,
  })  : _cache = cache ?? CacheClient(),
  _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;
  final CacheClient _cache;
  final auth.FirebaseAuth _firebaseAuth;

  // =======================================================================
  // =======================================================================
  @visibleForTesting
  bool isWeb = kIsWeb;

  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';
  // =======================================================================
  // =======================================================================

  // CACHING USER DATA
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  // GET current_user FROM cache
  User get currentUser => _cache.read<User>(key: userCacheKey) ?? User.empty;

  // SIGN UP/REGISTER
  Future<auth.UserCredential?> signUpWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('An account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        throw Exception('Email is not valid or badly formatted.');
      } else {
        throw Exception(e.message);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // LOGIN EMAIL AND PASSWORD
  Future<auth.UserCredential?> logInWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      } else if (e.code == 'invalid-credential') {
        throw Exception('Invalid email or password. Please try again.');
      } else if (e.code == 'user-disabled') {
        throw Exception('This user has been disabled. Please contact support for help.');
      } else {
        throw Exception(e.message);
      }
    } catch(e) {
      throw Exception(e); 
    }
  }

  // REQUEST RESET PASSWORD
  Future<void> requestResetPassword({
    required String email
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email)
      .catchError((e) => throw Exception(e));
    } catch (e) {
      throw Exception(e);
    }
  }

  // EMAIL VERIFY
  Future<void> verifyEmail() async {
    final user = _firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      return await user.sendEmailVerification();
    }
  }

  // PHONE AUTHENTICATION
  Future<String?> signInWithPhoneNumber({required String phoneNumber}) async {
    try {
      String? otp;
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (auth.PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) => throw Exception(error.message),
        codeSent: (verificationId, resendToken) async {
          otp = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {}
      );
      return otp;
    } on auth.FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }
  
  // OTP VERIFICATION
  void verifyOtp({
    required String verificationId, 
    required String userOtp
  }) async {
    try {
      auth.PhoneAuthCredential credential = auth.PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOtp
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on auth.FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch(e) {
      throw Exception(e);
    }
  }

  // LOGOUT
  Future<void> logOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

// EXTENTION FOR USER CACHING
extension on auth.User {
  User get toUser => User(uid: uid, email: email, isVerified: emailVerified);
}

class LogOutFailure implements Exception {}