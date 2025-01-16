part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.user = Users.empty,
    this.status = Status.initial,
    this.message = ""
  });
  final Users user;
  final Status status;
  final String message;

  HomeState copyWith({
    Users? user,
    Status? status,
    String? message
  }) {
    return HomeState(
      user: user ?? this.user,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [user, status, message];
}

enum Status { initial, loading, success, failure }

extension StatusX on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get isFailure => this == Status.failure;
}
