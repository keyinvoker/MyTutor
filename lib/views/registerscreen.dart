import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mytutor/components/rounded_button.dart';
import 'package:mytutor/views/landingscreen.dart';
import 'package:mytutor/views/loginscreen.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../constants.dart';
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usremailController = TextEditingController();
  final TextEditingController _usrpasswordController = TextEditingController();
  final TextEditingController _usrpassword2Controller = TextEditingController();
  final TextEditingController _usrnameController = TextEditingController();
  final TextEditingController _usrphoneController = TextEditingController();
  final TextEditingController _usraddressController = TextEditingController();
  // final TextEditingController _usrimageEditingController =
  //     TextEditingController();
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  int _counter = 0;

  void incrementCounter() {
    setState(() {
      _counter = _counter + 1;
    });
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
              MaterialPageRoute(builder: (content) => const LandingScreen())),
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
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/business-men-illustration.png',
                  height: size.height * 0.35,
                ),
                const Text(
                  'REGISTER BELOW!',
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
                              hintText: 'Confirm Password',
                              icon: const Icon(Icons.lock_outline),
                              suffix: InkWell(
                                onTap: _togglePass,
                                child: const Icon(Icons.visibility),
                              ),
                              border: InputBorder.none,
                            ),
                            controller: _usrpassword2Controller,
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
                            decoration: const InputDecoration(
                              icon: Icon(Icons.person),
                              hintText: 'Name',
                              border: InputBorder.none, // ?
                            ),
                            controller: _usrnameController,
                            keyboardType: TextInputType.name,
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
                            decoration: const InputDecoration(
                              icon: Icon(Icons.phone_android),
                              hintText: 'Phone',
                              border: InputBorder.none, // ?
                            ),
                            controller: _usrphoneController,
                            keyboardType: TextInputType.name,
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
                            decoration: const InputDecoration(
                              icon: Icon(Icons.house),
                              hintText: 'Address',
                              border: InputBorder.none, // ?
                            ),
                            controller: _usraddressController,
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: _isChecked,
                                onChanged: (bool? value) {
                                  _onChanged(value!);
                                }),
                            const Text("I agree to the terms & conditions."),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                RoundedButton(
                  text: "REGISTER",
                  press: _onRegister,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: GestureDetector(
                    child: const Text("Already registered? Login"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) => const LoginScreen()));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onChanged(bool value) {
    setState(() {
      _isChecked = value; // ...!;
    });
  }

  void _onRegister() {
    if (_formKey.currentState!.validate() && _isChecked) {
      _formKey.currentState!.save();
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text("Register new user"),
          content: const Text("Are you sure?"),
          actions: [
            TextButton(
                child: const Text("OK"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  _registerCustomer();
                }),
            TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  bool validateEmail(String value) {
    final RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return (!regex.hasMatch(value)) ? false : true;
  }

  void _togglePass() {
    setState(
      () {
        _obscureText = !_obscureText;
      },
    );
  }

  void _registerCustomer() {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: 'Registering new user', max: 100);
    String _usremail = _usremailController.text.toString();
    String _usrpassword = _usrpasswordController.text.toString();
    String _usrpassword2 = _usrpassword2Controller.text.toString();
    String _usrname = _usrnameController.text.toString();
    String _usrphone = _usrphoneController.text.toString();
    String _usraddress = _usraddressController.text.toString();
    // String _usrimage = _usrimageEditingController.text;
    // String base64Image = base64Encode(_image!.readAsBytesSync());

    if (_usremail.isEmpty ||
        _usrpassword.isEmpty ||
        _usrpassword2.isEmpty ||
        _usrname.isEmpty ||
        _usrphone.isEmpty ||
        _usraddress.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill in the empty fields!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    if (!validateEmail(_usremail)) {
      Fluttertoast.showToast(
          msg: "Check your email format",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    http.post(Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/new_user.php"),
        body: {
          "email": _usremail,
          "password": _usrpassword,
          "password2": _usrpassword2,
          "name": _usrname,
          "phone": _usrphone,
          "address": _usraddress,
          // "image": _usrimage,
          // "image": base64Image,
        }).then(
      (response) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && data['status'] == 'success') {
          Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0,
          );
          pd.update(value: 100, msg: "Success");
          pd.close();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (content) => const LoginScreen()));
        } else {
          Fluttertoast.showToast(
            msg: data['status'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0,
          );
          pd.update(value: 0, msg: "Failed");
          pd.close();
        }
      },
    );
  }
}
