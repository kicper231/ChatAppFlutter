import 'package:bloc/bloc.dart';
import 'package:chatapp/data_layer/friendsrepo.dart';
import 'package:equatable/equatable.dart';

part 'addfriend_event.dart';
part 'addfriend_state.dart';

class AddfriendBloc extends Bloc<AddfriendEvent, AddfriendState> {
  FriendsRepository friendsRepository;

  AddfriendBloc({required this.friendsRepository}) : super(AddfriendInitial()) {
    on<AddfriendEvent>((event, emit) {});

    on<AddFriend>((event, emit) async {
      emit(AddfriendInProgress());
      try {
        emit(AddfriendInProgress());
        await friendsRepository.addFriend(event.id);
        emit(AddfriendSuccess());
      } catch (e) {
        emit(AddfriendFailure());
      }
    });

    on<ResetState>((event, emit) {
      emit(AddfriendInitial());
    });
  }
}
