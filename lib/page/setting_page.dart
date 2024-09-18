import 'package:chat_app/db/local_db.dart';
import 'package:chat_app/page/blocked_users_page.dart';
import 'package:chat_app/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        centerTitle: true,
        title: Text("SETTING"),
      ),
      body: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.all(25),
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //dark mode
                  Text("Dark Mode"),

                  //switch toggle
                  CupertinoSwitch(
                    value: Provider.of<ThemeProvider>(context,listen: false).isDarkMode,
                    onChanged: (value) {
                      Provider.of<ThemeProvider>(context,listen: false).toggleTheme();
                      LocalDb().saveThemeMode(context);
                    },
                  )
                ],
              )),

                Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.all(25),
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //dark mode
                  Text("Blocked Users"),

                  //Icon
                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BlockedUsersPage(),));
                  }, icon: Icon(Icons.arrow_forward_ios_rounded)),
                  
                ],
              )),
        ],
      ),
    );
  }
}
