import 'package:chatapp/bussines_logic/bloc/message_bloc.dart';
import 'package:chatapp/data_layer/model/friend.dart';
import 'package:chatapp/data_layer/model/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  final Friend receiver;

  const ChatPage({Key? key, required this.receiver}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late Friend receiver = widget.receiver;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // BlocProvider.of<MessageBloc>(context).close();
    super.dispose();
  }

  List<Message> messages = [];

  TextEditingController messageController = TextEditingController();

  void sendMessage() {
    String message = messageController.text;
    if (message.isNotEmpty) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Row(
          children: [Text(receiver.email)],
        ),
      ),
      body: BlocListener<MessageBloc, MessageState>(
        listener: (context, state) {
          if (state is ReceiveMessageSuccess) {
            setState(() {
              messages = state.messages;
            });
          }
        },
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                scrollDirection: Axis.vertical,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Container(
                    alignment: messages[index].receiverId == receiver.userId
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Text(messages[index].message),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      context.read<MessageBloc>().add(SendMessage(
                          message: messageController.text,
                          receiver: receiver.userId));
                      setState(() {}); // Move setState here
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
