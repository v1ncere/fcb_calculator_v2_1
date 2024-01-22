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
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
    } on auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  // LOGIN EMAIL AND PASSWORD
  Future<auth.UserCredential?> logInWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
    } on auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  // REQUEST RESET PASSWORD
  Future<void> requestResetPassword({
    required String email
  }) async {
    try {
      return await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on auth.FirebaseAuthException catch (e) {
      throw RequestResetPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const RequestResetPasswordFailure();
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
  Future<String?> signInWithPhone({required String phoneNumber}) async {
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
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
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

// EXCEPTIONS ==================================================================
// =============================================================================

class SignUpWithEmailAndPasswordFailure implements Exception {
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.'
  ]);

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.'
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.'
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.'
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.'
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
  final String message;
}

class LogInWithEmailAndPasswordFailure implements Exception {
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.'
  ]);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.'
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.'
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.'
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.'
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }
  final String message;
}

class RequestResetPasswordFailure implements Exception {
  const RequestResetPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory RequestResetPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'user-not-found':
        return const RequestResetPasswordFailure(
          'No user corresponding to the email address.',
        );
      case 'invalid-email':
        return const RequestResetPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      default:
        return const RequestResetPasswordFailure();
    }
  }

  final String message;
}

class LogOutFailure implements Exception {}