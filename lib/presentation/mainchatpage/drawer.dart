import 'package:chatapp/bussines_logic/auth_bloc/auth_bloc_bloc.dart';
import 'package:chatapp/bussines_logic/friends_bloc/friends_bloc_bloc.dart';
import 'package:chatapp/bussines_logic/themebloc/themebloc_bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Mydrawer extends StatefulWidget {
  const Mydrawer({super.key});

  @override
  State<Mydrawer> createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  bool isLightMode = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const CircleAvatar(
                  radius: 50.0,

                  child: Icon(Icons.person), // Placeholder icon
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    FirebaseAuth.instance.currentUser?.email ?? '',
                    style: const TextStyle(
                      fontFamily: 'Wendy',
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ListTile(
                  title: const Text("Dark Mode"),
                  leading: const Icon(Icons.lightbulb_outline),
                  trailing: Switch(
                    value: isLightMode,
                    onChanged: (bool value) {
                      setState(() {
                        isLightMode = value;
                      });
                      context.read<ThemeblocBloc>().add(ThemeChange());
                    },
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.settings),
                  title: const Text('Language Settings'),
                ),
                ListTile(
                  onTap: () {
                    context.read<AuthSignInBloc>().add(const SignOutRequired());
                    context.read<FriendsBloc>().add(FriendLogout());
                  },
                  title: const Text("Log Out"),
                  leading: const Icon(Icons.exit_to_app),
                ),
                const Spacer(),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: const Text('Terms of Service & Privacy Policy'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
