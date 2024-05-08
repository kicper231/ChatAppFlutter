import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'themebloc_event.dart';
part 'themebloc_state.dart';

@singleton
class ThemeblocBloc extends Bloc<ThemeblocEvent, ThemeblocState> {
  late ThemeService actualTheme;

  ThemeblocBloc({required ThemeService actualTheme})
      : super(ThemeState(actualTheme.currentTheme)) {
    on<ThemeChange>((event, emit) {
      actualTheme.currentTheme = actualTheme.currentTheme == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
      emit(ThemeState(actualTheme.currentTheme));
    });
  }
}

@singleton
class ThemeService {
  ThemeMode currentTheme = ThemeMode.light;
}
