// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mytutor/constants.dart';
import 'package:mytutor/models/tutor_subject.dart';
import '../models/tutor.dart';
import 'package:http/http.dart' as http;

class TutorScreen extends StatefulWidget {
  const TutorScreen({Key? key}) : super(key: key);

  @override
  State<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends State<TutorScreen> {
  List<Tutor> tutorList = <Tutor>[];
  List<TutorSubject> tutorsubjectsList = <TutorSubject>[];

  var color;
  var _numPages, _currentPage = 1;
  var titlecenter = "Fetching...";

  @override
  void initState() {
    super.initState();
    loadTutor(1);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: tutorList.isEmpty
          ? Center(
              child: Text(
              titlecenter,
              style: const TextStyle(fontSize: 60),
            ))
          : Column(
              children: [
                Expanded(
                    child: GridView.count(
                        crossAxisCount: 1,
                        children: List.generate(tutorList.length, (index) {
                          return Container(
                            height: size.height * 0.35,
                            margin: const EdgeInsets.all(16),
                            child: InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              splashColor: Colors.purpleAccent,
                              onTap: () {
                                int tutorid = int.parse(
                                    tutorList[index].tutorid.toString());
                                loadSubjectNames(tutorid);
                                _loadTutorDetails(index);
                              },
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  color: Colors.deepPurpleAccent,
                                  elevation: 6,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: CachedNetworkImage(
                                          height: size.height * 0.25,
                                          imageUrl: CONSTANTS.server +
                                              "/mytutor/assets/tutors/" +
                                              tutorList[index]
                                                  .tutorid
                                                  .toString() +
                                              '.jpg',
                                          fit: BoxFit.cover,
                                          width: size.width * 0.5,
                                          placeholder: (context, url) =>
                                              const LinearProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                      Text(
                                        tutorList[index].tutorname.toString(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 8),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons.mail,
                                                          color: Colors.white70,
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(
                                                          tutorList[index]
                                                              .tutoremail
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.white70,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .phone_android_outlined,
                                                          color: Colors.white70,
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(
                                                          tutorList[index]
                                                              .tutorphone
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.white70,
                                                          ),
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
                                    ],
                                  )),
                            ),
                          );
                        }))),
                SizedBox(
                  height: 20,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _numPages,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if ((_currentPage - 1) == index) {
                        color = Colors.red;
                      } else {
                        color = Colors.black;
                      }
                      return SizedBox(
                        width: 40,
                        child: TextButton(
                            onPressed: () => {loadTutor(index + 1)},
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(color: color),
                            )),
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }

  void loadTutor(int _pageno) {
    _currentPage = _pageno;
    _numPages ?? 1;
    http.post(
        Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/fetch_tutors.php"),
        body: {
          'pageno': _currentPage.toString(),
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      titlecenter = response.body;
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        _numPages = int.parse(jsondata['totalpage']);

        if (extractdata['tutors'] != null) {
          tutorList = <Tutor>[];
          extractdata['tutors'].forEach((v) {
            tutorList.add(Tutor.fromJson(v));
          });
          titlecenter = tutorList.length.toString() + " Tutors Available";
        } else {
          titlecenter = "No Tutor Available";
          tutorList.clear();
        }
        setState(() {});
      }
    });
  }

  _loadTutorDetails(int index) {
    // int i = 0;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: Text(
                tutorList[index].tutorname.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: CONSTANTS.server +
                          "/mytutor/assets/tutors/" +
                          tutorList[index].tutorid.toString() +
                          '.jpg',
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const LinearProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Description:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      Text(tutorList[index].tutordescription.toString() + "\n"),
                      const Text("Email:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      Text(tutorList[index].tutoremail.toString() + "\n"),
                      const Text("Phone:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      Text(tutorList[index].tutorphone.toString() + "\n"),

                      const Text("Subjects:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      //TODO: loop subjects per tutor
                      tutorsubjectsList.isEmpty
                          ? const Text("(None)")
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tutorsubjectsList[0].subjectname.toString(),
                                ),
                                Text(
                                  tutorsubjectsList[1].subjectname.toString(),
                                ),
                              ],
                            )
                    ],
                  )
                ]),
              ));
        });
  }

  loadSubjectNames(int _tutorid) {
    http.post(
        Uri.parse(
            CONSTANTS.server + "/mytutor/mobile/php/fetch_tutorsubjects.php"),
        body: {
          'tutorid': _tutorid.toString(),
        }).timeout(const Duration(seconds: 5), onTimeout: () {
      return http.Response('Error', 408); // Timeout status code
    }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        titlecenter = "Timeout! Please retry again later.";
        return http.Response('Error', 408); // Timeout status code
      },
    ).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        if (extractdata['tutorsubjects'] != null) {
          tutorsubjectsList = <TutorSubject>[];
          extractdata['tutorsubjects'].forEach((v) {
            tutorsubjectsList.add(TutorSubject.fromJson(v));
          });
        }
      }
    });
  }
}
