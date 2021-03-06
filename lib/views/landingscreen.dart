import 'package:flutter/material.dart';
import 'package:mytutor/components/rounded_button.dart';
import 'package:mytutor/views/loginscreen.dart';
import 'package:mytutor/views/registerscreen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool remember = false;
  String status = "Loading";
  @override
  void initState() {
    super.initState();
    // loadPref();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
                            builder: (content) => const RegisterScreen()),
                      ),
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

  // Future<void> loadPref() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String email = (prefs.getString('email')) ?? '';
  //   String password = (prefs.getString('pass')) ?? '';
  //   remember = (prefs.getBool('remember')) ?? false;

  //   if (remember) {
  //     setState(() {
  //       status = "Logging in";
  //     });
  //     _loginUser(email, password);
  //   } else {
  //     _loginUser(email, password);
  //     setState(() {
  //       status = "Login as guest...";
  //     });
  //   }
  // }

  // void _loginUser(_email, _password) {
  //   http.post(
  //       Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/login_user.php"),
  //       body: {"email": _email, "password": _password}).then(
  //     (response) {
  //       var data = jsonDecode(response.body);

  //       if (response.statusCode == 200 && data['status'] == 'success') {
  //         var extractdata = data['data'];
  //         User user = User.fromJson(extractdata);

  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (content) => MainScreen(user: user),
  //           ),
  //         );
  //       } else {
  //         User user = User(
  //           userid: '0',
  //           username: 'Guest',
  //           useremail: 'guest@mytutor.com',
  //           useraddress: 'Guest Room',
  //           userphone: '-',
  //           // userimage: 'default',
  //         );
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (content) => MainScreen(user: user),
  //           ),
  //         );
  //       }
  //     },
  //   );
  // }
}
