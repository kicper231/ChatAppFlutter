part of 'auth_bloc_bloc.dart';

sealed class AuthSignInEvent extends Equatable {
  const AuthSignInEvent();

  @override
  List<Object> get props => [];
}

class AuthSignInRequired extends AuthSignInEvent {
  final String email;
  final String password;

  const AuthSignInRequired(this.email, this.password);
}

class AuthSignUpRequired extends AuthSignInEvent {
  final String email;
  final String password;
  const AuthSignUpRequired({required this.email, required this.password});
}

class SignOutRequired extends AuthSignInEvent {
  const SignOutRequired();
}
