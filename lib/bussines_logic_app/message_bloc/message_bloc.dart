import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatapp/data_layer_infrastructure/message_repository.dart';
import 'package:chatapp/models_domain/model/message.dart';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

part 'message_event.dart';
part 'message_state.dart';

@singleton
class MessageBloc extends Bloc<MessageEvent, MessageState> {
  late final MessageRepository _messageRepository;
  String fromuser = '';
  String touser = '';

  // ignore: unused_field
  late StreamSubscription? _messageSubscription;
  late Stream<List<Message>> messages;
  MessageBloc({
    required MessageRepository messageRepository,
  })  : _messageRepository = messageRepository,
        super(MessageInitial()) {
    // messages = _messageRepository.getMessages(touser);

    on<SendMessage>((event, emit) {
      emit(SendMessageLoading());

      try {
        _messageRepository.sendMessage(event.receiver, event.message);
      } catch (e) {
        emit(const SendMessageFailure());
      }

      emit(SendMessageSuccess(event.message));
    });

    on<LoadMessage>((event, emit) async {
      emit(ReceiveMessageLoading());

      List<Message> messages;

      try {
        messages = await _messageRepository.getMessages(event.fromuser).first;
      } catch (e) {
        emit(const ReceiveMessageFailure());
        return;
      }

      emit(ReceiveMessageSuccess(messages: messages));
    });

    // zmiana nasluchiwania
    on<EnterChat>((event, emit) {
      fromuser = FirebaseAuth.instance.currentUser!.uid;
      touser = event.userToEnter;

      messages = _messageRepository.getMessages(touser);
      _messageSubscription = messages.listen((messagesList) {
        add(LoadMessage(fromuser: touser));
      });
    });
  }
}
