part of 'message_bloc.dart';

sealed class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {}

class SendMessageSuccess extends MessageState {
  final String message;

  const SendMessageSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class SendMessageFailure extends MessageState {
  const SendMessageFailure();

  @override
  List<Object> get props => [];
}

class ReceiveMessageLoading extends MessageState {}

class ReceiveMessageSuccess extends MessageState {
  final List<Message> messages;
  const ReceiveMessageSuccess({required this.messages});

  @override
  List<Object> get props => [messages];
}

class ReceiveMessageFailure extends MessageState {
  const ReceiveMessageFailure();

  @override
  List<Object> get props => [];
}

class SendMessageLoading extends MessageState {}
