import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final bool obscureText;
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const MyTextfield(
      {super.key, this.hintText, required this.obscureText, this.controller,  this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
            fillColor: Theme.of(context).colorScheme.tertiary,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary))),
      ),
    );
  }
}
