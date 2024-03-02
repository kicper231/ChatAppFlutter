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
      resizeToAvoidBottomInset: true,
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
              child: BlocBuilder<MessageBloc, MessageState>(
                builder: (context, state) {
                  if (state is ReceiveMessageSuccess) {
                    messages = state.messages;
                  }
                  return ListView.builder(
                    reverse: true,
                    scrollDirection: Axis.vertical,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                        child: Column(
                          crossAxisAlignment:
                              messages[index].receiverId == receiver.userId
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                          children: [
                            Text(messages[index].senderEmail),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(messages[index].message,
                                        style: TextStyle(fontSize: 16)),
                                  )),
                            ),
                          ],
                        ),
                      );
                    },
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
                      setState(() {});
                      messageController.clear(); // Move setState here
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
