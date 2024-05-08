part of 'user_info_bloc.dart';

sealed class UserInfoState extends Equatable {
  const UserInfoState();

  @override
  List<Object> get props => [];
}

final class UserInfoInitial extends UserInfoState {}

final class UserInfoLoading extends UserInfoState {}

final class UserInfoLoaded extends UserInfoState {
  final UserInfo user;
  const UserInfoLoaded({required this.user});
  @override
  List<Object> get props => [user];
}

final class UserInfoError extends UserInfoState {
  const UserInfoError();
  @override
  List<Object> get props => [];
}
