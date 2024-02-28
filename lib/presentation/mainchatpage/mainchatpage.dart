import 'package:chatapp/bussines_logic/bloc/message_bloc.dart';
import 'package:chatapp/bussines_logic/friends_bloc/friends_bloc_bloc.dart';
import 'package:chatapp/data_layer/model/message.dart';
import 'package:chatapp/presentation/chatpage/chatpage.dart';
import 'package:chatapp/presentation/mainchatpage/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool isLightMode = true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Mydrawer(),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.pen,
                color: Theme.of(context).colorScheme.onBackground,
              )),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Add Friend'),
                      content: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter nickname',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Perform friend adding logic here
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Friends Request Sent!')));
                            Navigator.of(context).pop();
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(
                CupertinoIcons.person,
                color: Theme.of(context).colorScheme.onBackground,
              ))
        ],
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _counter++;
              });

              Scaffold.of(context).openDrawer();
            },
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.menu),
                ),
              ),
            ),
          );
        }),
        title: Text(widget.title, style: const TextStyle()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                  decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                isDense: true,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 8),
                  child: Icon(Icons.search),
                ),
                prefixIconConstraints: BoxConstraints(),
                hintText: "Search",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
              )),
            ),
            SizedBox(
              height: 110,
              child: BlocBuilder<FriendsBloc, FriendsBlocState>(
                builder: (context, state) {
                  if (state is FriendsBlocLoaded) {
                    return ListView.builder(
                      itemCount: state.friends.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: const CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text(state.friends[index].email),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
            BlocBuilder<FriendsBloc, FriendsBlocState>(
              builder: (context, state) {
                if (state is FriendsBlocLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: state.friends.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context.read<MessageBloc>().add(EnterChat(
                                userToEnter: state.friends[index].userId));

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatPage(
                                receiver: state.friends[index],
                              ),
                            ));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ),
                                  child:
                                      CircleAvatar(child: Icon(Icons.person)),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(state.friends[index].email),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
