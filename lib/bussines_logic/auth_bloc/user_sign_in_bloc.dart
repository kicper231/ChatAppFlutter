import 'package:bloc/bloc.dart';
import 'package:chatapp/data_layer/userRepository.dart';

import 'package:equatable/equatable.dart';

import 'package:firebase_auth/firebase_auth.dart';

part 'user_sign_in_event.dart';
part 'user_sign_in_state.dart';

class UserSignInBloc extends Bloc<UserSignInEvent, UserSignInState> {
  final UserRepository _UserRepository;

  UserSignInBloc({required UserRepository UserRepository})
      : _UserRepository = UserRepository,
        super(UserSignInInitial()) {
    on<UserSignInRequired>((event, emit) async {
      emit(UserSignInProcess());
      try {
        await _UserRepository.singIn(event.email, event.password);
        emit(UserSignInSuccess());
      } on FirebaseAuthException catch (e) {
        emit(UserSignInFailure(message: e.code));
      } catch (e) {
        emit(const UserSignInFailure());
      }
    });
    on<SignOutRequired>((event, emit) async {
      await _UserRepository.signOut();
      emit(const UserSignInFailure());
    });

    on<UserSignUpRequired>((event, emit) async {
      emit(UserSignInProcess());
      try {
        await _UserRepository.signup(event.email, event.password);
        emit(UserSignInSuccess());
      } on FirebaseAuthException catch (e) {
        emit(UserSignInFailure(message: e.code));
      } catch (e) {
        emit(const UserSignInFailure());
      }
    });
  }
}
