part of 'aa_bloc.dart';

sealed class AaState extends Equatable {
  const AaState();
  
  @override
  List<Object> get props => [];
}

final class AaInitial extends AaState {}
