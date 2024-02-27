import 'package:chatapp/bussines_logic/auth_bloc/auth_bloc_bloc.dart';

import 'package:chatapp/presentation/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key, required this.toggleView});

  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();
  final TextEditingController _confirmPasswordControler =
      TextEditingController();
  final Function toggleView;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.2,
            ),
            Center(child: Icon(Icons.message, size: height * 0.20)),
            const SizedBox(
              height: 10,
            ),
            const Text("Create new Account!", style: TextStyle(fontSize: 15)),
            const SizedBox(
              height: 20,
            ),
            MyTextfield(
              hintText: "Email",
              controller: _emailControler,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextfield(
              hintText: "Password",
              obscure: true,
              controller: _passwordControler,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextfield(
              hintText: "Confirm Password",
              obscure: true,
              controller: _confirmPasswordControler,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                // padding: const EdgeInsets.all(15.0),

                onPressed: () {
                  if (_emailControler.text.isNotEmpty &&
                      _passwordControler.text.isNotEmpty) {
                    context.read<AuthSignInBloc>().add(AuthSignUpRequired(
                        email: _emailControler.text,
                        password: _passwordControler.text));
                  }
                },
                child: Container(
                    // decoration: BoxDecoration(
                    //     border: Border.all(
                    //         width: 1, color: Theme.of(context).colorScheme.outline),
                    //     borderRadius: const BorderRadius.all(Radius.circular(30))),
                    child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Register"),
                  ),
                )),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Have a account? "),
                GestureDetector(
                    onTap: () {
                      toggleView();
                    },
                    child: const Text("Login now",
                        style: TextStyle(fontWeight: FontWeight.bold)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
