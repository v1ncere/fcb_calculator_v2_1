import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.uid,
    this.email,
    this.isVerified
  });

  final String? uid;
  final String? email;
  final bool? isVerified;

  User copyWith({
    String? uid,
    String? email,
    bool? isVerified
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      isVerified: isVerified ?? this.isVerified
    );
  }

  static const empty = User(uid: '');
  // extensions
  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [email, uid, isVerified];
}
