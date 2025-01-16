import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:fcb_calculator_v2_1/repository/repository.dart';

class FirebaseDatabaseRepository {
  FirebaseDatabaseRepository({
    FirebaseDatabase? firebaseDatabase
  }) : _firebaseDatabase = firebaseDatabase ?? FirebaseDatabase.instance;
  final FirebaseDatabase _firebaseDatabase;
  
  String userID() => FirebaseAuth.instance.currentUser!.uid;

  Future<void> addUsers(String uid, Users users) async {
    try {
      await _firebaseDatabase.ref('users/$uid').set(users.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Users> getUsers(String uid) async {
    try {
      final snapshot = await _firebaseDatabase.ref('users/$uid').get();
      if (snapshot.exists) {
        return Users.fromSnapshot(snapshot);
      } else {
        throw Exception('User not found.');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}