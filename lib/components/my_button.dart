import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String data;
  final void Function()? onPressed;
  const MyButton({super.key, required this.data, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 2.7, vertical: 15),
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.tertiary,
      child: Text(data),
    );
  }
}
