import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatapp/data_layer_infrastructure/friends_repository.dart';
import 'package:chatapp/models_domain/model/friend.dart';
import 'package:equatable/equatable.dart';

part 'friends_bloc_event.dart';
part 'friends_bloc_state.dart';

class FriendsBloc extends Bloc<FriendsBlocEvent, FriendsBlocState> {
  final FriendsRepository _friendsRepository;
  late Stream<List<Friend>> friends;
  StreamSubscription<List<Friend>>? friendsSubscription;

  FriendsBloc({required FriendsRepository friendsRepository})
      : _friendsRepository = friendsRepository,
        super(FriendsBlocInitial()) {
    friends = _friendsRepository.getFriends();
    friendsSubscription = friends.listen((friendsList) {
      if (friendsSubscription != null) {
        emit(FriendsBlocLoaded(friends: friendsList));
      }
    });

    on<GetFriendList>((event, emit) {
      emit(FriendsBlocLoaded(friends: friends as List<Friend>));
    });

    on<FriendLogout>((event, emit) {
      friendsSubscription?.cancel();
      friendsSubscription = null;
      friends = const Stream.empty();
      emit(FriendsBlocInitial());
    });
  }
}
