import 'package:chatapp/bussines_logic_app/message_bloc/message_bloc.dart';
import 'package:chatapp/models_domain/model/friend.dart';
import 'package:chatapp/models_domain/model/message.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  final Friend receiver;

  const ChatPage({Key? key, required this.receiver}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
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
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: SizedBox(
                width: 30,
                height: 30,

                // glupie ale dziala
                child: CircleAvatar(
                  backgroundImage: receiver.image != ""
                      ? NetworkImage(receiver.image!)
                      : null,
                  child: receiver.image == "" ? const Icon(Icons.person) : null,
                ),
              ),
            ),
            Text(receiver.email, style: const TextStyle(fontSize: 20)),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.info,
                size: 30,
              ),
            ),
          )
        ],
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
                      return chatTitle(index, receiver.image, context);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                          hintText: 'Type a message'.tr(),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 10, 10, 10),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none)),
                    )),
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
            ),
          ],
        ),
      ),
    );
  }

  Padding chatTitle(int index, String? image, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      child: Row(
          mainAxisAlignment: messages[index].receiverId == receiver.userId
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (messages[index].receiverId != receiver.userId)
              SizedBox(
                width: 40,
                height: 40,
                child: CircleAvatar(
                  backgroundImage: receiver.image != ""
                      ? NetworkImage(receiver.image!)
                      : null,
                  child: receiver.image == "" ? const Icon(Icons.person) : null,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(messages[index].message,
                        style: const TextStyle(fontSize: 16)),
                  )),
            ),
          ]),
    );
  }
}
