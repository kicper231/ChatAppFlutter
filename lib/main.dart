import 'package:chatapp/bussines_logic/themebloc/themebloc_bloc.dart';
import 'package:chatapp/firebase_options.dart';
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
    return BlocProvider<ThemeblocBloc>(
      create: (context) => ThemeblocBloc(actualTheme: ThemeMode.light),
      child: BlocBuilder<ThemeblocBloc, ThemeblocState>(
        builder: (context, state) {
          return MaterialApp(
            themeMode: state.actualTheme,
            darkTheme: ThemeData(
              colorScheme: const ColorScheme(
                  brightness: Brightness.dark,
                  primary: Color(0xFFFFB1C8),
                  onPrimary: Color(0xFF5E1133),
                  primaryContainer: Color(0xFF7B2949),
                  onPrimaryContainer: Color(0xFFFFD9E2),
                  secondary: Color(0xFFE3BDC6),
                  onSecondary: Color(0xFF422931),
                  secondaryContainer: Color(0xFF5A3F47),
                  onSecondaryContainer: Color(0xFFFFD9E2),
                  tertiary: Color(0xFFFFB1C8),
                  onTertiary: Color(0xFF650033),
                  tertiaryContainer: Color(0xFF831E4A),
                  onTertiaryContainer: Color(0xFFFFD9E2),
                  error: Color(0xFFFFB4AB),
                  errorContainer: Color(0xFF93000A),
                  onError: Color(0xFF690005),
                  onErrorContainer: Color(0xFFFFDAD6),
                  background: Color(0xFF201A1B),
                  onBackground: Color(0xFFEBE0E1),
                  surface: Color(0xFF201A1B),
                  onSurface: Color(0xFFEBE0E1),
                  surfaceVariant: Color(0xFF514347),
                  onSurfaceVariant: Color(0xFFD5C2C6),
                  outline: Color(0xFF9E8C90),
                  onInverseSurface: Color(0xFF201A1B),
                  inverseSurface: Color(0xFFEBE0E1),
                  inversePrimary: Color(0xFF984061),
                  shadow: Color(0xFF000000),
                  surfaceTint: Color(0xFFFFB1C8),
                  outlineVariant: Color(0xFF514347),
                  scrim: Color(0xFF000000)),
            ),
            theme: ThemeData(
              colorScheme: const ColorScheme(
                brightness: Brightness.light,
                primary: Color(0xFF984061),
                onPrimary: Color(0xFFFFFFFF),
                primaryContainer: Color(0xFFFFD9E2),
                onPrimaryContainer: Color(0xFF3E001D),
                secondary: Color(0xFF74565F),
                onSecondary: Color(0xFFFFFFFF),
                secondaryContainer: Color(0xFFFFD9E2),
                onSecondaryContainer: Color(0xFF2B151C),
                tertiary: Color(0xFFA23761),
                onTertiary: Color(0xFFFFFFFF),
                tertiaryContainer: Color(0xFFFFD9E2),
                onTertiaryContainer: Color(0xFF3E001D),
                error: Color(0xFFBA1A1A),
                errorContainer: Color(0xFFFFDAD6),
                onError: Color(0xFFFFFFFF),
                onErrorContainer: Color(0xFF410002),
                background: Color(0xFFFFFBFF),
                onBackground: Color(0xFF201A1B),
                surface: Color(0xFFFFFBFF),
                onSurface: Color(0xFF201A1B),
                surfaceVariant: Color(0xFFF2DDE1),
                onSurfaceVariant: Color(0xFF514347),
                outline: Color(0xFF837377),
                onInverseSurface: Color(0xFFFAEEEF),
                inverseSurface: Color(0xFF352F30),
                inversePrimary: Color(0xFFFFB1C8),
                shadow: Color(0xFF000000),
                surfaceTint: Color(0xFF984061),
                outlineVariant: Color(0xFFD5C2C6),
                scrim: Color(0xFF000000),
              ),
            ),
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool isLightMode = true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Switch(
            value: isLightMode,
            onChanged: (bool value) {
              setState(() {
                isLightMode = !isLightMode;
              });

              context.read<ThemeblocBloc>().add(ThemeChange());
            }),
      ),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _counter++;
              });

              Scaffold.of(context).openDrawer();
            },
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.menu),
                ),
              ),
            ),
          );
        }),
        title: Text(widget.title),
      ),

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
