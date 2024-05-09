part of 'user_login_bloc.dart';

sealed class UserSignInEvent extends Equatable {
  const UserSignInEvent();

  @override
  List<Object> get props => [];
}

class UserSignInRequired extends UserSignInEvent {
  final String email;
  final String password;

  const UserSignInRequired(this.email, this.password);
}

class UserSignUpRequired extends UserSignInEvent {
  final String email;
  final String password;
  final String name;
  const UserSignUpRequired(
      {required this.email, required this.password, required this.name});
}

class SignOutRequired extends UserSignInEvent {
  const SignOutRequired();
}
