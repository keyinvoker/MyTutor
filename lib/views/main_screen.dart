// INFO: MainScreen --> shows subjects from tbl_subjects

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mytutor/constants.dart';
import 'package:mytutor/views/tutor_screen.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../models/user.dart';
import '../models/subject.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Subject> subjectList = <Subject>[];
  String titlecenter = "Fetching...";
  var color;
  int cart = 0;
  var numofpage, curpage = 1;
  var currentIndex = 0;
  var screens = <dynamic>[
    const Text("Subscribe"),
    const Text("Subscribe"),
    const Text("Subscribe"),
    const Text("Subscribe"),
    const Text("Subscribe")
  ];

  Widget home() {
    Size size = MediaQuery.of(context).size;
    return subjectList.isEmpty
        ? Center(child: Text("No Subject Available!"))
        : Container(
            child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(titlecenter,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Expanded(
                child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: (1 / 1),
                    children: List.generate(subjectList.length, (index) {
                      return InkWell(
                        splashColor: Colors.amber,
                        onTap: () => {_loadSubjectDetails(index)},
                        child: Card(
                            child: Column(
                          children: [
                            Flexible(
                              flex: 6,
                              child: CachedNetworkImage(
                                imageUrl: CONSTANTS.server +
                                    "/mytutor/assets/subjects/" +
                                    subjectList[index].subjectid.toString() +
                                    '.jpg',
                                fit: BoxFit.cover,
                                width: size.width * 0.6,
                                placeholder: (context, url) =>
                                    const LinearProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            Text(
                              subjectList[index].subjectname.toString(),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Flexible(
                                flex: 4,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Column(
                                            children: [
                                              Text("RM " +
                                                  double.parse(
                                                          subjectList[index]
                                                              .subjectprice
                                                              .toString())
                                                      .toStringAsFixed(2)),
                                              Text("Rating: " +
                                                  double.parse(
                                                          subjectList[index]
                                                              .subjectrating
                                                              .toString())
                                                      .toStringAsFixed(1)),
                                              Text(
                                                subjectList[index]
                                                        .subjectsessions
                                                        .toString() +
                                                    " sessions",
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Expanded(
                                            flex: 3,
                                            child: IconButton(
                                                onPressed: null,
                                                icon: Icon(Icons.book))),
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        )),
                      );
                    }))),
            SizedBox(
              height: 30,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: numofpage,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if ((curpage - 1) == index) {
                    color = Colors.red;
                  } else {
                    color = Colors.black;
                  }
                  return SizedBox(
                    width: 40,
                    child: TextButton(
                        onPressed: () => {_loadSubjects(index + 1)},
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(color: color),
                        )),
                  );
                },
              ),
            ),
          ]));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      _loadSubjects(1);
      screens[0] = home();
      screens[1] = const TutorScreen();
      screens[2] = const Text("Subscribe");
      screens[3] = const Text("Favorite");
      screens[4] = const Text("Profile");
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.people_alt),
          iconSize: 35.0,
          onPressed: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (content) => const TutorScreen())),
        ),
        title: const Text(
          'MyTutor Subjects',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body:
          // currentIndex == 0
          //     ? (subjectList.isEmpty
          //         ? Center(child: Text("No Subject Available!"))
          //         : Column(children: [
          //             Padding(
          //               padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          //               child: Text(titlecenter,
          //                   style: const TextStyle(
          //                       fontSize: 18, fontWeight: FontWeight.bold)),
          //             ),
          //             Expanded(
          //                 child: GridView.count(
          //                     crossAxisCount: 2,
          //                     childAspectRatio: (1 / 1),
          //                     children: List.generate(subjectList.length, (index) {
          //                       return InkWell(
          //                         splashColor: Colors.amber,
          //                         onTap: () => {_loadSubjectDetails(index)},
          //                         child: Card(
          //                             child: Column(
          //                           children: [
          //                             Flexible(
          //                               flex: 6,
          //                               child: CachedNetworkImage(
          //                                 imageUrl: CONSTANTS.server +
          //                                     "/mytutor/assets/subjects/" +
          //                                     subjectList[index]
          //                                         .subjectid
          //                                         .toString() +
          //                                     '.jpg',
          //                                 fit: BoxFit.cover,
          //                                 width: size.width * 0.6,
          //                                 placeholder: (context, url) =>
          //                                     const LinearProgressIndicator(),
          //                                 errorWidget: (context, url, error) =>
          //                                     const Icon(Icons.error),
          //                               ),
          //                             ),
          //                             Text(
          //                               subjectList[index].subjectname.toString(),
          //                               style: const TextStyle(
          //                                   fontSize: 20,
          //                                   fontWeight: FontWeight.bold),
          //                             ),
          //                             Flexible(
          //                                 flex: 4,
          //                                 child: Column(
          //                                   children: [
          //                                     Row(
          //                                       children: [
          //                                         Expanded(
          //                                           flex: 7,
          //                                           child: Column(
          //                                             children: [
          //                                               Text("RM " +
          //                                                   double.parse(subjectList[
          //                                                               index]
          //                                                           .subjectprice
          //                                                           .toString())
          //                                                       .toStringAsFixed(
          //                                                           2)),
          //                                               Text("Rating: " +
          //                                                   double.parse(subjectList[
          //                                                               index]
          //                                                           .subjectrating
          //                                                           .toString())
          //                                                       .toStringAsFixed(
          //                                                           1)),
          //                                               Text(
          //                                                 subjectList[index]
          //                                                         .subjectsessions
          //                                                         .toString() +
          //                                                     " sessions",
          //                                               ),
          //                                             ],
          //                                           ),
          //                                         ),
          //                                         const Expanded(
          //                                             flex: 3,
          //                                             child: IconButton(
          //                                                 onPressed: null,
          //                                                 icon: Icon(Icons.book))),
          //                                       ],
          //                                     ),
          //                                   ],
          //                                 ))
          //                           ],
          //                         )),
          //                       );
          //                     }))),
          //             SizedBox(
          //               height: 30,
          //               child: ListView.builder(
          //                 shrinkWrap: true,
          //                 itemCount: numofpage,
          //                 scrollDirection: Axis.horizontal,
          //                 itemBuilder: (context, index) {
          //                   if ((curpage - 1) == index) {
          //                     color = Colors.red;
          //                   } else {
          //                     color = Colors.black;
          //                   }
          //                   return SizedBox(
          //                     width: 40,
          //                     child: TextButton(
          //                         onPressed: () => {_loadSubjects(index + 1)},
          //                         child: Text(
          //                           (index + 1).toString(),
          //                           style: TextStyle(color: color),
          //                         )),
          //                   );
          //                 },
          //               ),
          //             ),
          //           ]))
          //     : const Text("FOK"),
          screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Subject',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Tutor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Subscribe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _loadSubjects(int pageno) {
    curpage = pageno;
    numofpage ?? 1;
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: 'Loading...', max: 100);
    http.post(
        Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/fetch_subjects.php"),
        body: {
          'pageno': pageno.toString(),
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        titlecenter = "Timeout! Please retry again later";
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      var jsondata = jsonDecode(response.body);

      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        numofpage = int.parse(jsondata['numofpage']);

        if (extractdata['subjects'] != null) {
          subjectList = <Subject>[];
          extractdata['subjects'].forEach((v) {
            subjectList.add(Subject.fromJson(v));
          });
          titlecenter = subjectList.length.toString() + " Subjects Available";
          setState(() {
            screens[0] = home();
          });
        } else {
          titlecenter = "No Subject Available";
          subjectList.clear();
        }
        setState(() {
          screens[0] = home();
        });
      } else {
        titlecenter = "No Subject Available";
        subjectList.clear();
        setState(() {
          screens[0] = home();
        });
      }
    });
    pd.close();
  }

  _loadSubjectDetails(int index) {
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Subject Details",
              style: TextStyle(),
            ),
            content: SingleChildScrollView(
                child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: CONSTANTS.server +
                      "/mytutor/assets/subjects/" +
                      subjectList[index].subjectid.toString() +
                      '.jpg',
                  fit: BoxFit.cover,
                  width: size.width * 0.6,
                  placeholder: (context, url) =>
                      const LinearProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Text(
                  subjectList[index].subjectname.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Subject Description: \n" +
                      subjectList[index].subjectdescription.toString()),
                  Text("Price: RM " +
                      double.parse(subjectList[index].subjectprice.toString())
                          .toStringAsFixed(2)),
                  Text("Rating: " +
                      double.parse(subjectList[index].subjectrating.toString())
                          .toStringAsFixed(1)),
                  Text("Sessions: " +
                      subjectList[index].subjectsessions.toString() +
                      " sessions"),
                ]),
              ],
            )),
          );
        });
  }
}
