import 'package:chatapp/bussines_logic_app/add_friend_bloc/addfriend_bloc.dart';
import 'package:chatapp/bussines_logic_app/auth_bloc/user_login_bloc.dart';

import 'package:chatapp/bussines_logic_app/friends_bloc/friends_bloc_bloc.dart';
import 'package:chatapp/bussines_logic_app/message_bloc/message_bloc.dart';
import 'package:chatapp/bussines_logic_app/themebloc/themebloc_bloc.dart';
import 'package:chatapp/bussines_logic_app/update_user_data_bloc/update_user_data_bloc_bloc.dart';

import 'package:chatapp/data_layer_infrastructure/friends_repository.dart';
import 'package:chatapp/data_layer_infrastructure/messagerepo.dart';
import 'package:chatapp/data_layer_infrastructure/userRepository.dart';
import 'package:chatapp/di.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/presentation/loginRegisterToggle.dart';
import 'package:chatapp/presentation/mainchatpage/mainchatpage.dart';
import 'package:chatapp/presentation/themes/DarkTheme.dart';
import 'package:chatapp/presentation/themes/LightTheme.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

// Main function

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();
  runApp(const MyApp());
}

final getIt = GetIt.instance;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Providers
  @override
  Widget build(BuildContext context) {
    return GlobalBlocProviders(
      child: BlocBuilder<ThemeblocBloc, ThemeblocState>(
        builder: (context, state) {
          return MaterialApp(
            themeMode: state.actualTheme,
            darkTheme: DarkTheme.theme,
            theme: LightTheme.theme,
            debugShowCheckedModeBanner: false,
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Builder(builder: (context) {
                    return const MyHomePage(title: "Chats");
                  });
                } else {
                  return BlocProvider(
                    create: (context) => UserSignInBloc(
                      UserRepository: getIt<UserRepository>(),
                    ),
                    child: const LoginRegister(),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
