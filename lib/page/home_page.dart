import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/page/chat_page.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //chat and auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        centerTitle: true,
        title: Text("HOME"),
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  //build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersSreamExcludingBlocked(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Text("ERROE");
          }

          //loading...
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loding");
          }

          //return list view
          return ListView(
            children: snapshot.data!
                .map((userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  //build individual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display all users except current user
    print(_authService.getCurrentUser());
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
          email: userData["email"],
          onTap: () {
            // tapped on a user --> go to chat page
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData["uid"],
              );
            }));
          });
    } else {
      return Container();
    }
  }
}
