import 'dart:math';

import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textField.dart';
import 'package:chat_app/page/registeration_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
//email and pw controller

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  //tap to go on register page
  final void Function()? onTap;

  LoginPage({super.key, this.onTap});

//login function

  void login(BuildContext context) {
    //get auth service
    final _auth = AuthService();

    try {
      _auth.signInWithEmailPassword(_emailController.text, _pwController.text);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            SizedBox(
              height: 50,
            ),
            //welcome back message

            Text(
              "Welcome back, you've been missed!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16),
            ),

            SizedBox(
              height: 50,
            ),
            //email textfield

            MyTextfield(
              obscureText: false,
              hintText: "Email",
              controller: _emailController,
            ),

            SizedBox(
              height: 20,
            ),

            //pw textfield
            MyTextfield(
              obscureText: true,
              hintText: "Password",
              controller: _pwController,
            ),

            SizedBox(
              height: 20,
            ),

            //login button
            MyButton(
              data: "Login",
              onPressed: () => login(context),
            ),

            SizedBox(
              height: 20,
            ),

            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member? "),
                GestureDetector(
                    onTap: onTap,
                    child: Text(
                      "Register now",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
