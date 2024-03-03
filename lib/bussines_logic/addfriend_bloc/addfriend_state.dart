part of 'addfriend_bloc.dart';

sealed class AddfriendState extends Equatable {
  const AddfriendState();

  @override
  List<Object> get props => [];
}

final class AddfriendInitial extends AddfriendState {}

final class AddfriendInProgress extends AddfriendState {}

final class AddfriendSuccess extends AddfriendState {}

final class AddfriendFailure extends AddfriendState {}
