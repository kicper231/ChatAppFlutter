// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chatapp/bussines_logic_app/add_friend_bloc/addfriend_bloc.dart'
    as _i12;
import 'package:chatapp/bussines_logic_app/auth_bloc/user_login_bloc.dart'
    as _i10;
import 'package:chatapp/bussines_logic_app/message_bloc/message_bloc.dart'
    as _i14;
import 'package:chatapp/bussines_logic_app/themebloc/themebloc_bloc.dart'
    as _i6;
import 'package:chatapp/bussines_logic_app/update_user_data_bloc/update_user_data_bloc_bloc.dart'
    as _i13;
import 'package:chatapp/bussines_logic_app/user_info_bloc/user_info_bloc.dart'
    as _i11;
import 'package:chatapp/data_layer_infrastructure/firebase_module.dart' as _i15;
import 'package:chatapp/data_layer_infrastructure/friends_repository.dart'
    as _i7;
import 'package:chatapp/data_layer_infrastructure/message_repository.dart'
    as _i8;
import 'package:chatapp/data_layer_infrastructure/user_repository.dart' as _i9;
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:firebase_core/firebase_core.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseModule = _$FirebaseModule();
    await gh.factoryAsync<_i3.FirebaseApp>(
      () => firebaseModule.initFirebaseApp,
      preResolve: true,
    );
    gh.factory<_i4.FirebaseAuth>(() => firebaseModule.auth);
    gh.factory<_i5.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.singleton<_i6.ThemeService>(() => _i6.ThemeService());
    gh.singleton<_i7.FriendsRepository>(() => _i7.FriendsRepository());
    gh.singleton<_i8.MessageRepository>(() => _i8.MessageRepository());
    gh.singleton<_i9.UserRepository>(() => _i9.UserRepository());
    gh.singleton<_i10.UserSignInBloc>(
        () => _i10.UserSignInBloc(UserRepository: gh<_i9.UserRepository>()));
    gh.singleton<_i11.UserInfoBloc>(
        () => _i11.UserInfoBloc(gh<_i7.FriendsRepository>()));
    gh.singleton<_i6.ThemeblocBloc>(
        () => _i6.ThemeblocBloc(actualTheme: gh<_i6.ThemeService>()));
    gh.singleton<_i12.AddfriendBloc>(() =>
        _i12.AddfriendBloc(friendsRepository: gh<_i7.FriendsRepository>()));
    gh.singleton<_i13.UpdateUserDataBloc>(() =>
        _i13.UpdateUserDataBloc(userRepository: gh<_i9.UserRepository>()));
    gh.singleton<_i14.MessageBloc>(
        () => _i14.MessageBloc(messageRepository: gh<_i8.MessageRepository>()));
    return this;
  }
}

class _$FirebaseModule extends _i15.FirebaseModule {}
