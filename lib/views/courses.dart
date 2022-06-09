import 'package:flutter/material.dart';
import 'package:mytutor/views/home.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
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
                  children: const [
                    Text("Course 1"),
                    Text("Course 2"),
                    Text("Course 3"),
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
