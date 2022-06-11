// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mytutor/constants.dart';
import 'package:mytutor/views/home.dart';
import 'package:mytutor/views/main_screen.dart';
import '../models/tutor.dart';
import 'package:http/http.dart' as http;

class TutorScreen extends StatefulWidget {
  const TutorScreen({Key? key}) : super(key: key);

  @override
  State<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends State<TutorScreen> {
  List<Tutor> TutorList = <Tutor>[];
  var color;
  var _numPages, _currentPage = 1;
  var titlecenter = "Fetching...";
  @override
  void initState() {
    super.initState();
    loadTutor();
    print(TutorList);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: TutorList.isEmpty
          ? Center(
              child: Text(
              titlecenter,
              style: const TextStyle(fontSize: 60),
            ))
          : Column(
              children: [
                Expanded(
                    child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: (1 / 1),
                        children: List.generate(TutorList.length, (index) {
                          return InkWell(
                            splashColor: Colors.purple,
                            // onTap: () => {_loadTutorDetails(index)},
                            child: Card(
                                child: Column(
                              children: [
                                Flexible(
                                  flex: 10,
                                  child: CachedNetworkImage(
                                    imageUrl: CONSTANTS.server +
                                        "/mytutor/assets/tutors/" +
                                        TutorList[index].tutorid.toString() +
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
                                  TutorList[index].tutorname.toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Flexible(
                                    flex: 5,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 8,
                                              child: Column(
                                                children: [
                                                  Text(TutorList[index]
                                                      .tutoremail
                                                      .toString()),
                                                  Text(TutorList[index]
                                                      .tutorphone
                                                      .toString()),
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
                                onPressed: () => {loadTutor()},
                                child: Text(
                                  (index + 1).toString(),
                                  style: TextStyle(color: color),
                                )),
                          );
                        }))
              ],
            ),
    );
  }

  void loadTutor() {
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
      titlecenter = "KON";
      titlecenter = response.body;
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        _numPages = int.parse(jsondata['totalpage']);

        if (extractdata['tutors'] != null) {
          TutorList = <Tutor>[];
          extractdata['tutors'].forEach((v) {
            TutorList.add(Tutor.fromJson(v));
          });
          titlecenter = TutorList.length.toString() + " Tutors Available";
        } else {
          titlecenter = "No Tutor Available";
          TutorList.clear();
        }
        setState(() {});
      }
    });
  }
}
