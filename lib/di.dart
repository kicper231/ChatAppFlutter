import 'dart:async';

import 'package:chatapp/bussines_logic_app/add_friend_bloc/addfriend_bloc.dart';
import 'package:chatapp/bussines_logic_app/auth_bloc/user_login_bloc.dart';
import 'package:chatapp/bussines_logic_app/friends_bloc/friends_bloc_bloc.dart';
import 'package:chatapp/bussines_logic_app/message_bloc/message_bloc.dart';
import 'package:chatapp/bussines_logic_app/themebloc/themebloc_bloc.dart';
import 'package:chatapp/bussines_logic_app/update_user_data_bloc/update_user_data_bloc_bloc.dart';
import 'package:chatapp/bussines_logic_app/user_info_bloc/user_info_bloc.dart';
import 'package:chatapp/data_layer_infrastructure/friends_repository.dart';
import 'package:chatapp/data_layer_infrastructure/user_repository.dart';
import 'package:chatapp/di.config.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
FutureOr<void> configureDependencies() => getIt.init();

class GlobalBlocProviders extends StatelessWidget {
  final Widget child;

  const GlobalBlocProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<MessageBloc>(),
        ),
        BlocProvider(
          create: (context) => AddfriendBloc(
            friendsRepository: getIt<FriendsRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => FriendsBloc(
            friendsRepository: getIt<FriendsRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => AddfriendBloc(
            friendsRepository: getIt<FriendsRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => UpdateUserDataBloc(
            userRepository: getIt<UserRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => UserInfoBloc(
            getIt<FriendsRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
