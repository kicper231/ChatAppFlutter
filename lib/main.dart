import 'package:chatapp/bussines_logic_app/auth_bloc/user_login_bloc.dart';

import 'package:chatapp/bussines_logic_app/themebloc/themebloc_bloc.dart';

import 'package:chatapp/data_layer_infrastructure/user_repository.dart';
import 'package:chatapp/di.dart';

import 'package:chatapp/presentation/loginRegisterToggle.dart';
import 'package:chatapp/presentation/main_chat/pages/mainchatpage.dart';
import 'package:chatapp/presentation/themes/DarkTheme.dart';
import 'package:chatapp/presentation/themes/LightTheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

// Main function

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('pl', 'PL')],
        path: 'assets/translations',
        fallbackLocale: const Locale('pl', 'PL'),
        child: const MyApp()),
  );
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
