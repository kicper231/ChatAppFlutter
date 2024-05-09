import 'package:bloc/bloc.dart';
import 'package:chatapp/data_layer_infrastructure/user_repository.dart';

import 'package:equatable/equatable.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

part 'user_login_event.dart';
part 'user_login_state.dart';

@singleton
class UserSignInBloc extends Bloc<UserSignInEvent, UserSignInState> {
  final UserRepository _userRepository;

  UserSignInBloc({required UserRepository UserRepository})
      : _userRepository = UserRepository,
        super(UserSignInInitial()) {
    on<UserSignInRequired>((event, emit) async {
      emit(UserSignInProcess());
      try {
        await _userRepository.singIn(event.email, event.password);
        emit(UserSignInSuccess());
      } on FirebaseAuthException catch (e) {
        emit(UserSignInFailure(message: e.code));
      } catch (e) {
        emit(const UserSignInFailure());
      }
    });
    on<SignOutRequired>((event, emit) async {
      await _userRepository.signOut();
      emit(const UserSignInFailure());
    });

    on<UserSignUpRequired>((event, emit) async {
      emit(UserSignInProcess());

      try {
        await _userRepository.signup(event.email, event.password);
        emit(UserSignInSuccess());
      } on FirebaseAuthException catch (e) {
        emit(UserSignInFailure(message: e.code));
      } catch (e) {
        emit(const UserSignInFailure());
      }
    });
  }
}
