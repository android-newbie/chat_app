import 'package:chat_app/auth/auth_gate.dart';
import 'package:chat_app/db/local_db.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/page/login_page.dart';
import 'package:chat_app/services/fcm_service.dart';
import 'package:chat_app/theme/theme_lightmode.dart';
import 'package:chat_app/theme/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Initialize FCM Service
  FCMService fcmService = FCMService();


  
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: const MyApp()));

      
}











class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocalDb().getThemeMode(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
    );
  }
}
