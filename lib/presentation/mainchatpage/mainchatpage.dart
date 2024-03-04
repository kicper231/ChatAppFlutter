import 'package:chatapp/bussines_logic/addfriend_bloc/addfriend_bloc.dart';
import 'package:chatapp/bussines_logic/message_bloc/message_bloc.dart';
import 'package:chatapp/bussines_logic/friends_bloc/friends_bloc_bloc.dart';
import 'package:chatapp/data_layer/model/friend.dart';
import 'package:chatapp/helper.dart';

import 'package:chatapp/presentation/chatpage/chatpage.dart';
import 'package:chatapp/presentation/mainchatpage/drawer.dart';

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
  bool isLightMode = true;
  bool isSearching = false;
  List<Friend> filtredFriends = [];
  TextEditingController searchControler = TextEditingController();
  late FocusNode _focusNode;
  TextEditingController addfriendController = TextEditingController();

  @override
  void dispose() {
    // clean up
    searchControler.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    searchControler.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      if (searchControler.text.isNotEmpty) {
        isSearching = true;
        filtredFriends = (context.read<FriendsBloc>().state
                as FriendsBlocLoaded)
            .friends
            .where((element) => element.email.contains(searchControler.text))
            .toList();
      } else {
        isSearching = false;
        filtredFriends =
            (context.read<FriendsBloc>().state as FriendsBlocLoaded).friends;
      }
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
          // IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       CupertinoIcons.pen,
          //       color: Theme.of(context).colorScheme.onBackground,
          //     )),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return BlocProvider<AddfriendBloc>.value(
                      value: BlocProvider.of<AddfriendBloc>(context),
                      child: AlertDialog(
                        title: const Text('Add Friend'),
                        content: TextField(
                          controller: addfriendController,
                          decoration: const InputDecoration(
                            hintText: 'Enter nickname',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(dialogContext).pop();
                              addfriendController.clear();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              context
                                  .read<AddfriendBloc>()
                                  .add(AddFriend(id: addfriendController.text));
                              Navigator.of(dialogContext).pop();
                              addfriendController.clear();
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(content: Text('Friends Request Sent!')));
                              // Navigator.of(context).pop();
                            },
                            child: const Text('Add'),
                          ),
                        ],
                      ),
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
      body: MultiBlocListener(
        listeners: [
          BlocListener<FriendsBloc, FriendsBlocState>(
            listener: (context, state) {
              if (state is FriendsBlocLoaded) {
                setState(() {
                  filtredFriends = state.friends;
                });
              }
            },
          ),
          BlocListener<AddfriendBloc, AddfriendState>(
            listener: (context, state) {
              if (state is AddfriendSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Friend Added!')));
                context.read<AddfriendBloc>().add(ResetState());
              }
              if (state is AddfriendFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('User not found!'),
                  backgroundColor: Theme.of(context).colorScheme.onError,
                ));
                context.read<AddfriendBloc>().add(ResetState());
              }
            },
          ),
        ],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    focusNode: _focusNode,
                    controller: searchControler,
                    decoration: InputDecoration(
                      suffixIconConstraints: const BoxConstraints(),
                      contentPadding: const EdgeInsets.all(8),
                      isDense: true,
                      prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 8),
                          child: Icon(Icons.search)),
                      prefixIconConstraints: const BoxConstraints(),
                      suffixIcon: isSearching
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSearching = false;
                                  searchControler.text = "";
                                  _focusNode.unfocus();
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.cancel,
                                ),
                              ),
                            )
                          : null,
                      hintText: "Search",
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                    )),
              ),
              SizedBox(
                height: 110,
                child: BlocBuilder<FriendsBloc, FriendsBlocState>(
                  builder: (context, state) {
                    if (state is FriendsBlocLoaded) {
                      return ListView.builder(
                        itemCount: filtredFriends.length,
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
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(filtredFriends[index].email),
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
              Expanded(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: filtredFriends.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.read<MessageBloc>().add(EnterChat(
                            userToEnter: filtredFriends[index].userId));

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                receiver: filtredFriends[index],
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
                                  const CircleAvatar(child: Icon(Icons.person)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(filtredFriends[index].email,
                                      style: const TextStyle(fontSize: 16)),
                                  Row(
                                    children: [
                                      Text(filtredFriends[index].lastMessage!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 12)),
                                      const Text('  '),
                                      Text(
                                          formatTimestamp(
                                              filtredFriends[index].timestamp!),
                                          style: const TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
