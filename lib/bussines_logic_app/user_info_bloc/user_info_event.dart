part of 'user_info_bloc.dart';

sealed class UserInfoEvent extends Equatable {
  const UserInfoEvent();

  @override
  List<Object> get props => [];
}

class GetUserInfo extends UserInfoEvent {
  const GetUserInfo();
  @override
  List<Object> get props => [];
}
