import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textField.dart';
import 'package:flutter/material.dart';

class RegisterationPage extends StatelessWidget {
  //email and pw controller

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _rePwController = TextEditingController();

  //tap to go on login page
  final void Function()? onTap;

  RegisterationPage({super.key, this.onTap});

  //register function

  void register(BuildContext context) {
    //get auth service
    final _auth = AuthService();

    //password match-> create user
    if (_pwController.text == _rePwController.text) {
      try {
        _auth.signUpWithEmailPassword(
            _emailController.text, _pwController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }

    //passwords dont match->tell user to fix
    else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Password don't match"),
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

            //re enter password
            MyTextfield(
              obscureText: true,
              hintText: "Re-enter password",
              controller: _rePwController,
            ),

            SizedBox(
              height: 10,
            ),

            //login button
            MyButton(
              data: "Register",
              onPressed: () => register(context),
            ),

            SizedBox(
              height: 20,
            ),

            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already a member? "),
                GestureDetector(
                    onTap: onTap,
                    child: Text(
                      "Sign in",
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
