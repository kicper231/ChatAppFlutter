part of 'friends_bloc_bloc.dart';

sealed class FriendsBlocState extends Equatable {
  const FriendsBlocState();

  @override
  List<Object> get props => [];
}

final class FriendsBlocInitial extends FriendsBlocState {}

final class FriendsBlocLoading extends FriendsBlocState {}

final class FriendsBlocLoaded extends FriendsBlocState {
  final List<String> friends;
  const FriendsBlocLoaded({required this.friends});
  @override
  List<Object> get props => [friends];
}

final class FriendsBlocError extends FriendsBlocState {
  final String message;
  const FriendsBlocError({required this.message});
  @override
  List<Object> get props => [message];
}
