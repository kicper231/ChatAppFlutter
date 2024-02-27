import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String hintText;
  final bool obscure;
  final TextEditingController controller;
  const MyTextfield(
      {super.key,
      required this.hintText,
      this.obscure = false,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            prefixIconConstraints: const BoxConstraints(minWidth: 10),
            hintText: hintText,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
          )),
    );
  }
}
