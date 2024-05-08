import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatapp/data_layer_infrastructure/friends_repository.dart';
import 'package:chatapp/models_domain/model/friend.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'friends_bloc_event.dart';
part 'friends_bloc_state.dart';

@singleton
class FriendsBloc extends Bloc<FriendsBlocEvent, FriendsBlocState> {
  final FriendsRepository _friendsRepository;
  late final Stream<List<Friend>> friends;
  StreamSubscription<List<Friend>>? friendsSubscription;

  FriendsBloc({required FriendsRepository friendsRepository})
      : _friendsRepository = friendsRepository,
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
