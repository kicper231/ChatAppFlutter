import 'package:chatapp/bussines_logic_app/auth_bloc/user_login_bloc.dart';

import 'package:chatapp/presentation/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();
  LoginPage({super.key, required this.toggleView});
  final Function toggleView;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          SizedBox(
            height: height * 0.2,
          ),
          Center(child: Icon(Icons.message, size: height * 0.20)),
          const SizedBox(
            height: 10,
          ),
          const Text("Welcome to ChatApp!", style: TextStyle(fontSize: 15)),
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
                // padding: const EdgeInsets.all(15.0),

                onPressed: () {
                  if (_emailControler.text.isNotEmpty &&
                      _passwordControler.text.isNotEmpty) {
                    context.read<UserSignInBloc>().add(UserSignInRequired(
                        _emailControler.text, _passwordControler.text));
                  }
                },
                child:
                    //  Container(
                    // decoration: BoxDecoration(
                    //     border: Border.all(
                    //         width: 1, color: Theme.of(context).colorScheme.outline),
                    //     borderRadius: const BorderRadius.all(Radius.circular(30))),
                    // child:
                    const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Login"),
                  ),
                )),
          ),
          // ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Not a member? "),
              GestureDetector(
                  onTap: () {
                    toggleView();
                  },
                  child: const Text("Register now",
                      style: TextStyle(fontWeight: FontWeight.bold)))
            ],
          ),
        ],
      ),
    );
  }
}
