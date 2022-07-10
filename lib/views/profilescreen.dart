import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mytutor/models/user.dart';
import 'package:mytutor/components/rounded_button.dart';
import 'package:mytutor/views/landingscreen.dart';

import '../constants.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
                height: size.height / 3,
                width: 390.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.deepPurpleAccent,
                  border: Border.all(
                    color: Colors.white70,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Student Card",
                      style: TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10000.0),
                            child: CachedNetworkImage(
                              imageUrl: CONSTANTS.server +
                                  "/mytutor/assets/pfps/" +
                                  'nanami' +
                                  '.jpg',
                              height: size.height / 10,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start, //to align text
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Name: ",
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                  Text(
                                    widget.user.username.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 15,
                                      color: Colors.white70,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Email: ",
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                  Text(
                                    widget.user.useremail.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 15,
                                      color: Colors.white70,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Phone: ",
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                  Text(
                                    widget.user.userphone.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 15,
                                      color: Colors.white70,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Address: ",
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                  Text(
                                    widget.user.useraddress.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 15,
                                      color: Colors.white70,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            RoundedButton(
              text: "LOGOUT",
              buttonColor: Colors.red,
              textColor: Colors.white,
              borderColor: Colors.red,
              press: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (content) => const LandingScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
