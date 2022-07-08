import 'dart:convert';
import 'package:mytutor/models/user.dart';
import 'package:mytutor/views/mainscreen.dart';
import 'package:mytutor/views/registerscreen.dart';

import '../constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mytutor/components/rounded_button.dart';
import 'package:mytutor/views/landingscreen.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usremailController = TextEditingController();
  final TextEditingController _usrpasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _isChecked = false;
  int _counter = 0;

  void incrementCounter() {
    setState(() {
      _counter = _counter + 1;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPref();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
      body: Form(
        key: _formKey,
        child: Stack(children: <Widget>[
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
                          controller: _usremailController,
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
                          controller: _usrpasswordController,
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _isChecked,
                              onChanged: (bool? value) {
                                _onChanged(value!);
                              }),
                          const Text("Remember me"),
                        ],
                      ),
                      RoundedButton(
                        text: "LOGIN",
                        buttonColor: Colors.purple,
                        textColor: Colors.white,
                        press: () => _loginUser(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: GestureDetector(
                          child: const Text(
                            "No account yet? Register",
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (content) =>
                                        const RegisterScreen()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  void _togglePass() {
    setState(
      () {
        _obscureText = !_obscureText;
      },
    );
  }

  void _saveRemovePref(bool value) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String email = _usremailController.text;
      String password = _usrpasswordController.text;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (value) {
        await prefs.setString('email', email);
        await prefs.setString('pass', password);
        await prefs.setBool('_isChecked', true);
        Fluttertoast.showToast(
            msg: "Preference Stored",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
      } else {
        await prefs.setString('email', '');
        await prefs.setString('pass', '');
        await prefs.setBool('_isChecked', false);
        _usremailController.text = "";
        _usrpasswordController.text = "";
        Fluttertoast.showToast(
          msg: "Preference Removed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Preference Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 14.0,
      );
      _isChecked = false;
    }
  }

  void _onChanged(bool value) {
    _isChecked = value;
    setState(() {
      if (_isChecked) {
        _saveRemovePref(true);
      } else {
        _saveRemovePref(false);
      }
    });
  }

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    _isChecked = (prefs.getBool('_isChecked')) ?? false;

    if (_isChecked) {
      setState(() {
        _usremailController.text = email;
        _usrpasswordController.text = password;
        _isChecked = true;
      });
    }
  }

  void _loginUser() {
    String _email = _usremailController.text;
    String _password = _usrpasswordController.text;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ProgressDialog pd = ProgressDialog(context: context);
      pd.show(msg: 'Logging in', max: 100);
      http.post(
          Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/login_user.php"),
          body: {"email": _email, "password": _password}).then((response) {
        var data = jsonDecode(response.body);

        if (response.statusCode == 200 && data['status'] == 'success') {
          Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0,
          );
          pd.update(value: 100, msg: "Completed");
          pd.close();

          var extractdata = data['data'];
          User user = User.fromJson(extractdata);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (content) => MainScreen(user: user),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0,
          );
          pd.update(value: 100, msg: "Failed");
          pd.close();
        }
      });
    }
  }
}
