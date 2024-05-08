import 'package:bloc/bloc.dart';
import 'package:chatapp/data_layer_infrastructure/friends_repository.dart';
import 'package:chatapp/models_domain/model/user_info.dart';
import 'package:equatable/equatable.dart';

import 'package:injectable/injectable.dart';
import 'package:chatapp/models_domain/model/user_info.dart' as Info;
part 'user_info_event.dart';
part 'user_info_state.dart';

@singleton
class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final FriendsRepository _friendsRepository;
  UserInfoBloc(FriendsRepository friendsRepository)
      : _friendsRepository = friendsRepository,
        super(UserInfoInitial()) {
    on<GetUserInfo>((event, emit) async {
      emit(UserInfoLoading());

      try {
        Info.UserData info = await _friendsRepository.getUserData();
        emit(UserInfoLoaded(user: info));
      } catch (e) {
        emit(const UserInfoError());
      }
    });
  }
}
