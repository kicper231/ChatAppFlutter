import 'package:bloc/bloc.dart';
import 'package:chatapp/data_layer/authrepo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthSignInBloc extends Bloc<AuthSignInEvent, AuthSignInState> {
  final AuthRepository _authRepository;

  AuthSignInBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthSignInInitial()) {
    on<AuthSignInRequired>((event, emit) async {
      emit(AuthSignInProcess());
      try {
        await _authRepository.singIn(event.email, event.password);
        emit(AuthSignInSuccess());
      } on FirebaseAuthException catch (e) {
        emit(AuthSignInFailure(message: e.code));
      } catch (e) {
        emit(const AuthSignInFailure());
      }
    });
    on<SignOutRequired>((event, emit) async {
      await _authRepository.signOut();
      emit(const AuthSignInFailure());
    });
  }
}
