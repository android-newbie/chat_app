import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String email;
  final void Function()? onTap;
  const UserTile({super.key, required this.email, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Card(
        
        color: Colors.white,
        child: ListTile(leading: Icon(Icons.person),
        onTap: onTap,
        title: Text(email),),
      ),
    );
  }
}
