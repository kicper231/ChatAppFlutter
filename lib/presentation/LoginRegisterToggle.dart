import 'package:chatapp/presentation/loginpage/loginpage.dart';
import 'package:chatapp/presentation/registerpage/registerpage.dart';
import 'package:flutter/material.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginPage(
        toggleView: toggleView,
      );
    } else {
      return RegisterPage(toggleView: toggleView);
    }
  }
}
