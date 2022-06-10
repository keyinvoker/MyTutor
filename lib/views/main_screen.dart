import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.house_rounded),
          iconSize: 35.0,
          onPressed: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (content) => const MainScreen())),
        ),
        title: const Text(
          'MyTutor',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(children: const [
        Text('Welcome back, '),
      ]),
    );
  }
}
