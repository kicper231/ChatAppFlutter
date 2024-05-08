import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatapp/data_layer_infrastructure/friends_repository.dart';
import 'package:chatapp/models_domain/model/friend.dart';
import 'package:equatable/equatable.dart';

part 'friends_bloc_event.dart';
part 'friends_bloc_state.dart';

class FriendsBloc extends Bloc<FriendsBlocEvent, FriendsBlocState> {
  final FriendsInterface _friendsRepository;

  late final Stream<List<Friend>> friends;
  StreamSubscription<List<Friend>>? friendsSubscription;

  FriendsBloc({FriendsInterface? friendsRepository})
      : _friendsRepository = friendsRepository ?? FriendsRepository(),
        super(FriendsBlocInitial()) {
    friends = _friendsRepository.getFriends();
    friendsSubscription = friends.listen((friendsList) {
      if (friendsSubscription != null) {
        add(FriendListChange(friends: friendsList));
      }
    });

    on<FriendListChange>((event, emit) {
      emit(FriendsBlocLoaded(friends: event.friends));
    });

    on<GetFriendList>((event, emit) {
      friends = _friendsRepository.getFriends();
      emit(FriendsBlocLoaded(friends: friends as List<Friend>));
    });

    on<FriendLogout>((event, emit) {
      friendsSubscription?.cancel();
      friendsSubscription = null;
      emit(FriendsBlocInitial());
    });
  }
}
