import 'package:bloc/bloc.dart';
import 'package:chatapp/data_layer_infrastructure/user_repository.dart';

import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'update_user_data_bloc_event.dart';
part 'update_user_data_bloc_state.dart';

@singleton
class UpdateUserDataBloc
    extends Bloc<UpdateUserDataEvent, UpdateUserDataState> {
  final UserRepository _userRepository;

  UpdateUserDataBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UpdateUserDataBlocInitial()) {
    on<UploadPicture>((event, emit) async {
      emit(UploadPictureLoading());
      try {
        String userImage =
            await _userRepository.uploadPicture(event.file, event.userId);
        emit(UploadPictureSuccess(userImage));
      } catch (e) {
        emit(UploadPictureFailure());
      }
    });
  }
}
