import 'package:firebase_database/firebase_database.dart';

import 'package:fcb_calculator_v2_1/utils/utils.dart';

class Users {
  const Users({
    this.uid,
    required this.email,
    required this.employeeId,
    required this.phoneId,
    required this.mobileNumber,
    required this.expiry,
    required this.createdAt,
    required this.updatedAt,
  });
  final String? uid;
  final String? email;
  final String? employeeId;
  final String? phoneId;
  final int? mobileNumber;
  final DateTime? expiry;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Users copyWith({
    String? uid,
    String? email,
    String? employeeId,
    String? phoneId,
    int? mobileNumber,
    DateTime? expiry,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Users(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      employeeId: employeeId ?? this.employeeId,
      phoneId: phoneId ?? this.phoneId,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      expiry: expiry ?? this.expiry,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt
    );
  }

  static const empty = Users(
    uid: '',
    email: '',
    employeeId: '',
    phoneId: '',
    mobileNumber: null,
    expiry: null,
    createdAt: null,
    updatedAt: null
  );
  bool get isEmpty => this == Users.empty;
  bool get isNotEmpty => this != Users.empty;

  factory Users.fromSnapshot(DataSnapshot dataSnapshot) {
    final data = dataSnapshot.value as Map?;
    final intExpiry = data?['expiry'] as int?;
    final intCreatedAt = data?['created_at'] as int?;
    final intUpdatedAt = data?['updated_at'] as int?;

    return Users(
      uid: dataSnapshot.key,
      email: data?['email'] as String? ?? '',
      employeeId: data?['employee_id'] as String? ?? '',
      phoneId: data?['phone_id'] as String? ?? '',
      mobileNumber: data?['mobile_number'] as int?,
      expiry: getMillis(intExpiry) ?? DateTime.now(),
      createdAt: getMillis(intCreatedAt) ?? DateTime.now(),
      updatedAt: getMillis(intUpdatedAt) ?? DateTime.now()
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['employee_id'] = employeeId;
    data['phone_id'] = phoneId;
    data['mobile_number'] = mobileNumber;
    data['expiry'] = expiry?.millisecondsSinceEpoch;
    data['created_at'] = createdAt?.millisecondsSinceEpoch;
    data['updated_at'] = updatedAt?.millisecondsSinceEpoch;
    return data;
  }
}
