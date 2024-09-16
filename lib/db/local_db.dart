import 'package:chat_app/theme/theme_darkmode.dart';
import 'package:chat_app/theme/theme_lightmode.dart';
import 'package:chat_app/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class LocalDb {
  void saveThemeMode(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    sharedPreferences.setBool("isDarkMode", isDarkMode);
  }

  void getThemeMode(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isDarkMode = sharedPreferences.getBool("isDarkMode") ?? false;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    themeProvider.themeData = isDarkMode ? darkMode : lightMode;
  }
}

