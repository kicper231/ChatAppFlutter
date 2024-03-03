part of 'addfriend_bloc.dart';

sealed class AddfriendEvent extends Equatable {
  const AddfriendEvent();

  @override
  List<Object> get props => [];
}

final class AddFriend extends AddfriendEvent {
  final String id;
  const AddFriend({required this.id});
  @override
  List<Object> get props => [id];
}
