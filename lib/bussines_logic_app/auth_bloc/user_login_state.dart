part of 'user_login_bloc.dart';

sealed class UserSignInState extends Equatable {
  const UserSignInState();

  @override
  List<Object> get props => [];
}

final class UserSignInInitial extends UserSignInState {}

class UserSignInSuccess extends UserSignInState {}

class UserSignInFailure extends UserSignInState {
  final String? message;

  const UserSignInFailure({this.message});
}

class UserSignInProcess extends UserSignInState {}

class UserSignOutSuccess extends UserSignInState {}
