import 'package:flutter/material.dart';
import 'package:mytutor/models/user.dart';
import 'package:mytutor/views/login.dart';
import 'package:mytutor/views/main_screen.dart';
import 'package:mytutor/views/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyTutor',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const SplashScreen(),
      // home: MainScreen(user: User()),
      // home: const LoginScreen(),
    );
  }
}
