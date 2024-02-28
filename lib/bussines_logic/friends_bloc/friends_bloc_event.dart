part of 'friends_bloc_bloc.dart';

sealed class FriendsBlocEvent extends Equatable {
  const FriendsBlocEvent();

  @override
  List<Object> get props => [];
}

class GetFriendList extends FriendsBlocEvent {}

class FriendListChange extends FriendsBlocEvent {
  final List<Friend> friends;
  const FriendListChange({required this.friends});
  @override
  List<Object> get props => [friends];
}
