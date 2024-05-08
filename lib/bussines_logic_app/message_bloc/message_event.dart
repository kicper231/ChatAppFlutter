part of 'message_bloc.dart';

sealed class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class SendMessage extends MessageEvent {
  final String message;
  final String receiver;
  const SendMessage({required this.message, required this.receiver});
  @override
  List<Object> get props => [];
}

class LoadMessage extends MessageEvent {
  final String fromuser;
  const LoadMessage({required this.fromuser});

  @override
  List<Object> get props => [fromuser];
}

class EnterChat extends MessageEvent {
  final String userToEnter;
  const EnterChat({required this.userToEnter});
  @override
  List<Object> get props => [userToEnter];
}
