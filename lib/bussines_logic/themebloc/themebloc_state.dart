part of 'themebloc_bloc.dart';

@immutable
sealed class ThemeblocState extends Equatable {
  final ThemeMode actualTheme;
  const ThemeblocState({required this.actualTheme});

  @override
  List<Object> get props => [actualTheme];
}

final class ThemeState extends ThemeblocState {
  const ThemeState(actualTheme) : super(actualTheme: actualTheme);
  @override
  List<Object> get props => [actualTheme];
}
