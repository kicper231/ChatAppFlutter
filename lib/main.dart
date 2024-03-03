import 'package:chatapp/bussines_logic/addfriend_bloc/addfriend_bloc.dart';
import 'package:chatapp/bussines_logic/auth_bloc/auth_bloc_bloc.dart';
import 'package:chatapp/bussines_logic/message_bloc/message_bloc.dart';
import 'package:chatapp/bussines_logic/friends_bloc/friends_bloc_bloc.dart';
import 'package:chatapp/bussines_logic/themebloc/themebloc_bloc.dart';
import 'package:chatapp/data_layer/authrepo.dart';
import 'package:chatapp/data_layer/friendsrepo.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/presentation/loginRegisterToggle.dart';

import 'package:chatapp/presentation/mainchatpage/mainchatpage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: RepositoryProvider(
        create: (context) => FriendsRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AddfriendBloc>(
              create: (context) => AddfriendBloc(
                  friendsRepository: context.read<FriendsRepository>()),
            ),
            BlocProvider<ThemeblocBloc>(
              create: (context) => ThemeblocBloc(actualTheme: ThemeMode.light),
            ),
            BlocProvider(
              create: (context) => AuthSignInBloc(
                  authRepository: context.read<AuthRepository>()),
            ),
            BlocProvider(
              create: (context) => FriendsBloc(
                  friendsRepository: context.read<FriendsRepository>()),
            ),
            BlocProvider(
              create: (context) => MessageBloc(),
            ),
          ],
          child: BlocBuilder<ThemeblocBloc, ThemeblocState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: state.actualTheme,
                darkTheme: ThemeData(
                  useMaterial3: true,
                  colorScheme: const ColorScheme(
                    brightness: Brightness.light,
                    primary: Color(0xFF006685),
                    onPrimary: Color(0xFFFFFFFF),
                    primaryContainer: Color(0xFFBEE9FF),
                    onPrimaryContainer: Color(0xFF001F2A),
                    secondary: Color(0xFF4D616C),
                    onSecondary: Color(0xFFFFFFFF),
                    secondaryContainer: Color(0xFFD0E6F2),
                    onSecondaryContainer: Color(0xFF081E27),
                    tertiary: Color(0xFF00639B),
                    onTertiary: Color(0xFFFFFFFF),
                    tertiaryContainer: Color(0xFFCEE5FF),
                    onTertiaryContainer: Color(0xFF001D33),
                    error: Color(0xFFBA1A1A),
                    errorContainer: Color(0xFFFFDAD6),
                    onError: Color(0xFFFFFFFF),
                    onErrorContainer: Color(0xFF410002),
                    background: Color(0xFFF8FDFF),
                    onBackground: Color(0xFF001F25),
                    surface: Color(0xFFF8FDFF),
                    onSurface: Color(0xFF001F25),
                    surfaceVariant: Color(0xFFDCE4E9),
                    onSurfaceVariant: Color(0xFF40484C),
                    outline: Color(0xFF70787D),
                    onInverseSurface: Color(0xFFD6F6FF),
                    inverseSurface: Color(0xFF00363F),
                    inversePrimary: Color(0xFF6AD3FF),
                    shadow: Color(0xFF000000),
                    surfaceTint: Color(0xFF006685),
                    outlineVariant: Color(0xFFC0C8CD),
                    scrim: Color(0xFF000000),
                  ),
                ),
                theme: ThemeData(
                  useMaterial3: true,
                  colorScheme: const ColorScheme(
                    brightness: Brightness.dark,
                    primary: Color(0xFF6AD3FF),
                    onPrimary: Color(0xFF003546),
                    primaryContainer: Color(0xFF004D65),
                    onPrimaryContainer: Color(0xFFBEE9FF),
                    secondary: Color(0xFFB4CAD6),
                    onSecondary: Color(0xFF1F333D),
                    secondaryContainer: Color(0xFF354A54),
                    onSecondaryContainer: Color(0xFFD0E6F2),
                    tertiary: Color(0xFF96CCFF),
                    onTertiary: Color(0xFF003353),
                    tertiaryContainer: Color(0xFF004A76),
                    onTertiaryContainer: Color(0xFFCEE5FF),
                    error: Color(0xFFFFB4AB),
                    errorContainer: Color(0xFF93000A),
                    onError: Color(0xFF690005),
                    onErrorContainer: Color(0xFFFFDAD6),
                    background: Color(0xFF001F25),
                    onBackground: Color(0xFFA6EEFF),
                    surface: Color(0xFF001F25),
                    onSurface: Color(0xFFA6EEFF),
                    surfaceVariant: Color(0xFF40484C),
                    onSurfaceVariant: Color(0xFFC0C8CD),
                    outline: Color(0xFF8A9297),
                    onInverseSurface: Color(0xFF001F25),
                    inverseSurface: Color(0xFFA6EEFF),
                    inversePrimary: Color(0xFF006685),
                    shadow: Color(0xFF000000),
                    surfaceTint: Color(0xFF6AD3FF),
                    outlineVariant: Color(0xFF40484C),
                    scrim: Color(0xFF000000),
                  ),
                ),
                home: StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return const MyHomePage(title: "Chats");
                      } else {
                        return const LoginRegister();
                      }
                    }),
              );
            },
          ),
        ),
      ),
    );
  }
}
