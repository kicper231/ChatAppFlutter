import 'package:chatapp/bussines_logic_app/auth_bloc/user_login_bloc.dart';

import 'package:chatapp/bussines_logic_app/themebloc/themebloc_bloc.dart';

import 'package:chatapp/data_layer_infrastructure/user_repository.dart';
import 'package:chatapp/di.dart';
import 'package:chatapp/presentation/info_page/friend_list.dart';
import 'package:chatapp/presentation/info_page/information.dart';

import 'package:chatapp/presentation/loginRegisterToggle.dart';
import 'package:chatapp/presentation/main_chat/pages/mainchatpage.dart';
import 'package:chatapp/presentation/themes/DarkTheme.dart';
import 'package:chatapp/presentation/themes/LightTheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeblocBloc(actualTheme: ThemeService()),
        ),
        BlocProvider(
          create: (context) => getIt<UserSignInBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeblocBloc, ThemeblocState>(
        builder: (context, state) {
          return MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            themeMode: state.actualTheme,
            darkTheme: DarkTheme.theme,
            theme: LightTheme.theme,
            debugShowCheckedModeBanner: false,
            routerConfig: _router,
            // home: StreamBuilder(
            //   stream: FirebaseAuth.instance.authStateChanges(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return Builder(builder: (context) {
            //         return GlobalBlocProviders(
            //             child: MyHomePage(title: "Chats".tr()));
            //       });
            //     } else {
            //       return BlocProvider(
            //         create: (context) => UserSignInBloc(
            //           UserRepository: getIt<UserRepository>(),
            //         ),
            //         child: const LoginRegister(),
            //       );
            //     }
            //   },
            // ),
          );
        },
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    if (isLoggedIn) {
      if (_router.routerDelegate.currentConfiguration.uri.toString() ==
          '/login') return '/home';
    } else {
      return '/login';
    }
    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider.value(
          value: BlocProvider.of<ThemeblocBloc>(context),
          child: GlobalBlocProviders(child: MyHomePage(title: "Chats".tr())),
        );
      },
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      redirect: (context, state) {
        final isLoggedIn = FirebaseAuth.instance.currentUser != null;
        if (isLoggedIn) {
          return '/home';
        } else {
          return '/login';
        }
      },
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (_) =>
              UserSignInBloc(UserRepository: getIt<UserRepository>()),
          child: const LoginRegister(),
        );
      },
    ),
    GoRoute(
      path: '/friend_list',
      name: 'friend_list',
      builder: (BuildContext context, GoRouterState state) {
        return const FriendListPage();
      },
    ),
    GoRoute(
        path: '/info',
        name: 'info',
        builder: (BuildContext context, GoRouterState state) {
          return InformationPage(
            email: state.uri.queryParameters['id'],
            image: state.uri.queryParameters['image'],
          );
        }),
  ],
);
