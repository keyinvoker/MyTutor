import 'package:flutter/material.dart';
import 'package:mytutor/components/roundedButton.dart';
import 'package:mytutor/views/loginUser.dart';
import 'package:mytutor/views/registerUser.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.house_rounded),
          iconSize: 35.0,
          onPressed: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (content) => const HomeScreen())),
        ),
        title: const Text(
          'MyTutor',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, //?doesn't work
          children: <Widget>[
            Image.asset(
              'assets/images/business-men-illustration.png',
              height: size.height * 0.35,
            ),
            const Text(
              'Choose an action:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  addAutomaticKeepAlives: false,
                  cacheExtent: 100.0,
                  children: <Widget>[
                    RoundedButton(
                      text: "LOGIN",
                      buttonColor: Colors.purple,
                      textColor: Colors.white,
                      press: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (content) => const LoginScreen())),
                    ),
                    RoundedButton(
                      text: "REGISTER",
                      press: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (content) => const RegisterScreen())),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
