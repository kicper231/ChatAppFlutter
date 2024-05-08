part of 'user_info_bloc.dart';

sealed class UserInfoEvent extends Equatable {
  const UserInfoEvent();

  @override
  List<Object> get props => [];
}

class GetUserInfo extends UserInfoEvent {
  final String userId;
  const GetUserInfo(this.userId);
  @override
  List<Object> get props => [userId];
}