import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:progress_dialog/progress_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usremailEditingController =
      TextEditingController();
  final TextEditingController _usrpasswordEditingController =
      TextEditingController();
  final TextEditingController _usrnameEditingController =
      TextEditingController();
  final TextEditingController _usraddressEditingController =
      TextEditingController();
  // final TextEditingController _usrimageEditingController =
  //     TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/images/laptop-blue-icon.png',
          ),
          onPressed: null,
        ),
        title: const Text(
          'MyTutor',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, //?doesn't work
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
                          controller: _usrnameEditingController,
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
                          controller: _usraddressEditingController,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.35,
                height: size.height * 0.085,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'REGISTER',
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _onRegister,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onRegister() {
    String _usremail = _usremailEditingController.text.toString();
    String _usrpassword = _usrpasswordEditingController.text.toString();
    String _usrname = _usrnameEditingController.text.toString();
    String _usraddress = _usraddressEditingController.text.toString();
    // String _usrimage = _usrimageEditingController.text;
    // String base64Image = base64Encode(_image!.readAsBytesSync());

    if (_usremail.isEmpty ||
        _usrpassword.isEmpty ||
        _usrname.isEmpty ||
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

    //checking the data integrity

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text("Register new user"),
          content: const Text("Are your sure?"),
          actions: [
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
                //
                http.post(
                    Uri.parse(
                        CONSTANTS.server + "/mytutor/mobile/php/new_user.php"),
                    body: {
                      "email": _usremail,
                      "password": _usrpassword,
                      "name": _usrname,
                      "address": _usraddress,
                      // "image": _usrimage,
                      // "image": base64Image,
                    }).then(
                  (response) {
                    var data = jsonDecode(response.body);
                    if (response.statusCode == 200 &&
                        data['status'] == 'success') {
                      Fluttertoast.showToast(
                        msg: "Success",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0,
                      );
                      Navigator.of(context).pop();
                    } else {
                      Fluttertoast.showToast(
                        msg: data['status'],
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0,
                      );
                    }
                  },
                );
                //
              },
            ),
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
}
