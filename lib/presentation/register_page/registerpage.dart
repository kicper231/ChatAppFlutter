import 'package:chatapp/presentation/components/gaps.dart';
import 'package:chatapp/presentation/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatapp/presentation/components/textfield.dart';
import 'package:chatapp/bussines_logic_app/auth_bloc/user_login_bloc.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;

  const RegisterPage({super.key, required this.toggleView});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.15),
            Center(child: Icon(Icons.message, size: height * 0.20)),
            gapH10,
            const Text("Create new Account!", style: TextStyle(fontSize: 15)),
            const SizedBox(height: 20),
            MyTextfield(
              hintText: "Email",
              controller: _emailController,
            ),
            gapH10,
            MyTextfield(
              hintText: "Name",
              controller: _nameController,
            ),
            gapH10,
            MyTextfield(
              hintText: "Password",
              obscure: true,
              controller: _passwordController,
            ),
            gapH10,
            MyTextfield(
              hintText: "Confirm Password",
              obscure: true,
              controller: _confirmPasswordController,
            ),
            gapH10,
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    context.read<UserSignInBloc>().add(UserSignUpRequired(
                        email: _emailController.text,
                        password: _passwordController.text,
                        name: _nameController.text));
                  }
                },
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Register"),
                  ),
                ),
              ),
            ),
            gapH16,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Have an account? "),
                GestureDetector(
                    onTap: () {
                      widget.toggleView();
                    },
                    child: const Text("Login now",
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
