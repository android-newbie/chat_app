import 'package:chat_app/auth/auth_gate.dart';
import 'package:chat_app/db/local_db.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/page/login_page.dart';
import 'package:chat_app/theme/theme_lightmode.dart';
import 'package:chat_app/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(create: (context) => ThemeProvider(),child: const MyApp()));
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
      home:const AuthGate(),
    );
  }
}
