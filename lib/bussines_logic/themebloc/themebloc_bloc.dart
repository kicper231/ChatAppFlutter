import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'themebloc_event.dart';
part 'themebloc_state.dart';

class ThemeblocBloc extends Bloc<ThemeblocEvent, ThemeblocState> {
  ThemeMode actualTheme;

  ThemeblocBloc({required this.actualTheme})
      : super(const ThemeState(ThemeMode.light)) {
    on<ThemeChange>((event, emit) {
      actualTheme =
          actualTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      emit(ThemeState(actualTheme));
    });
  }
}
