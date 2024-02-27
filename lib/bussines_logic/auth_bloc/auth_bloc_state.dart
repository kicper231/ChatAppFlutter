part of 'auth_bloc_bloc.dart';

sealed class AuthSignInState extends Equatable {
  const AuthSignInState();

  @override
  List<Object> get props => [];
}

final class AuthSignInInitial extends AuthSignInState {}

class AuthSignInSuccess extends AuthSignInState {}

class AuthSignInFailure extends AuthSignInState {
  final String? message;

  const AuthSignInFailure({this.message});
}

class AuthSignInProcess extends AuthSignInState {}
