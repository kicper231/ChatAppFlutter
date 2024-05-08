import 'package:bloc/bloc.dart';
import 'package:chatapp/data_layer_infrastructure/friends_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  UserInfoBloc() : super(UserInfoInitial()) {
    FriendsRepository _friendsRepository;

    on<GetUserInfo>((event, emit) {
      emit(UserInfoLoading());

      try {} catch (e) {
        emit(const UserInfoError());
      }
    });
  }
}
