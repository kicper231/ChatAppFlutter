part of 'user_sign_in_bloc.dart';

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
  const UserSignUpRequired({required this.email, required this.password});
}

class SignOutRequired extends UserSignInEvent {
  const SignOutRequired();
}
