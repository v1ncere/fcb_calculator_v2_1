part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState({
    required this.status,
    this.user = User.empty
  });
  final AppStatus status;
  final User user;

  AppState copyWith({
    AppStatus? status,
    User? user
  }) {
    return AppState(
      status: status ?? this.status,
      user: user ?? this.user
    );
  }

  @override
  List<Object?> get props => [status, user];
}

enum AppStatus { signup, forgotpassword, unauthenticated, authenticated }