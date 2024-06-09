import 'package:chatapp/bussines_logic_app/auth_bloc/user_login_bloc.dart';
import 'package:chatapp/bussines_logic_app/themebloc/themebloc_bloc.dart';
import 'package:chatapp/data_layer_infrastructure/user_repository.dart';
import 'package:chatapp/di.dart';
import 'package:chatapp/presentation/info_page/friend_list.dart';
import 'package:chatapp/presentation/info_page/information.dart';
import 'package:chatapp/presentation/login_register_toggle.dart';
import 'package:chatapp/presentation/main_chat/pages/mainchatpage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

final getIt = GetIt.instance;

final GoRouter router = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    if (isLoggedIn) {
      if (router.routerDelegate.currentConfiguration.uri.toString() == '/login')
        return '/home';
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

class _router {}
