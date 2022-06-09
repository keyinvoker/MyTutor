// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:mytutor/components/roundedButton.dart';
import 'package:mytutor/views/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usremailEditingController =
      TextEditingController();
  final TextEditingController _usrpasswordEditingController =
      TextEditingController();
  bool _obscureText = true;

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
              'LOGIN BELOW!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
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
                    Container(
                      width: size.width * 0.6,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[200],
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          hintText: 'Email',
                          border: InputBorder.none, // ?
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: _usremailEditingController,
                      ),
                    ),
                    Container(
                      width: size.width * 0.8,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[200],
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextField(
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          icon: const Icon(Icons.lock),
                          suffix: InkWell(
                            onTap: _togglePass,
                            child: const Icon(Icons.visibility),
                          ),
                          border: InputBorder.none,
                        ),
                        controller: _usrpasswordEditingController,
                      ),
                    ),
                    RoundedButton(
                      text: "LOGIN",
                      buttonColor: Colors.purple,
                      textColor: Colors.white,
                      press: () => null,
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

  void _togglePass() {
    setState(
      () {
        _obscureText = !_obscureText;
      },
    );
  }
}
