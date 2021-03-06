// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mytutor/constants.dart';
import 'package:mytutor/views/cartscreen.dart';
import 'package:mytutor/views/profilescreen.dart';
import 'package:mytutor/views/tutorscreen.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../models/user.dart';
import '../models/subject.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mytutor/components/search_bar.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Subject> subjectList = <Subject>[];
  String titlecenter = "Fetching...";

  var _color;
  var _fontWeight;
  var _fontSize;
  var numofpage, curpage = 1;
  var currentIndex = 0;

  var screens = <dynamic>[
    const Text("Subjects"),
    const TutorScreen(),
    const Text("Subscribe"),
    const Text("Favorite"),
    const Text("Profile"),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      _loadSubjects(1, search);
      screens[4] = ProfileScreen(user: widget.user);
    });
  }

  String search = "";
  final TextEditingController _searchController = TextEditingController();

  Widget subjectsView() {
    Size size = MediaQuery.of(context).size;
    _searchController.text = search;
    return subjectList.isEmpty
        ? const Center(child: Text("No Subject Available!"))
        : Column(children: [
            const SizedBox(height: 10),
            SearchBar(
              searchController: _searchController,
              onSearch: () {
                search = _searchController.text;
                _loadSubjects(1, search);
              },
              onClear: () {
                search = "";
                _searchController.text = "";
                _loadSubjects(1, search);
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                titlecenter,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
                child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: (1 / 1),
                    children: List.generate(subjectList.length, (index) {
                      return Container(
                        margin: const EdgeInsets.all(6),
                        child: InkWell(
                          splashColor: Colors.purple,
                          onTap: () => {_loadSubjectDetails(index)},
                          child: Card(
                              elevation: 6,
                              child: Column(
                                children: [
                                  Flexible(
                                    flex: 6,
                                    child: CachedNetworkImage(
                                      imageUrl: CONSTANTS.server +
                                          "/mytutor/assets/subjects/" +
                                          subjectList[index]
                                              .subjectid
                                              .toString() +
                                          '.jpg',
                                      fit: BoxFit.cover,
                                      width: size.width * 0.6,
                                      placeholder: (context, url) =>
                                          const LinearProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0,
                                    ),
                                    child: Text(
                                      subjectList[index].subjectname.toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
                                                        double.parse(subjectList[
                                                                    index]
                                                                .subjectprice
                                                                .toString())
                                                            .toStringAsFixed(
                                                                2)),
                                                    Text("Rating: " +
                                                        double.parse(subjectList[
                                                                    index]
                                                                .subjectrating
                                                                .toString())
                                                            .toStringAsFixed(
                                                                1)),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: IconButton(
                                                  onPressed: () =>
                                                      _addToCartDialog(index),
                                                  icon: const Icon(
                                                    Icons
                                                        .add_shopping_cart_rounded,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ))
                                ],
                              )),
                        ),
                      );
                    }))),
            // [PAGINATION]
            SizedBox(
              height: 30,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: numofpage,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if ((curpage - 1) == index) {
                    _color = Colors.purple;
                    _fontWeight = FontWeight.bold;
                    _fontSize = 17.0;
                  } else {
                    _color = Colors.blueGrey;
                    _fontWeight = null;
                    _fontSize = 12.0;
                  }
                  return SizedBox(
                    width: 40,
                    child: TextButton(
                        onPressed: () => {_loadSubjects(index + 1, search)},
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(
                            color: _color,
                            fontWeight: _fontWeight,
                            fontSize: _fontSize,
                          ),
                        )),
                  );
                },
              ),
            ),
          ]);
  }

  @override
  Widget build(BuildContext context) {
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
        leading: IconButton(
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (content) => MainScreen(user: widget.user))),
          icon: const Icon(
            Icons.home,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (content) => CartScreen(user: widget.user)),
            ),
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black38,
            ),
          ),
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Subject',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Tutor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.plus_one_outlined),
            label: 'Subscribe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border_outlined),
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

  void _loadSubjects(int _pageno, String _search) {
    curpage = _pageno;
    numofpage ?? 1;
    _search = _searchController.text;
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: 'Loading...', max: 100);
    http.post(
        Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/fetch_subjects.php"),
        body: {
          'pageno': _pageno.toString(),
          'search': _search,
        }).timeout(const Duration(seconds: 5), onTimeout: () {
      return http.Response('Error', 408);
    }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        titlecenter = "Timeout! Please retry.";
        return http.Response('Error', 408);
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
          titlecenter = subjectList.length.toString() + " Subjects Shown";
        } else {
          titlecenter = "No Subject Available";
          subjectList.clear();
        }
        setState(() {
          screens[0] = subjectsView();
        });
      } else {
        titlecenter = "No Subject Available";
        subjectList.clear();
        setState(() {
          screens[0] = subjectsView();
        });
      }
    });
    pd.close();
  }

  _loadSubjectDetails(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Text(
            subjectList[index].subjectname.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurpleAccent,
            ),
            textAlign: TextAlign.center,
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
                  placeholder: (context, url) =>
                      const LinearProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Description:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    Text(subjectList[index].subjectdescription.toString() +
                        "\n"),
                    const Text("Price:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    Text(
                        double.parse(subjectList[index].subjectprice.toString())
                                .toStringAsFixed(2) +
                            "\n"),
                    const Text("Rating:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    Text(double.parse(
                                subjectList[index].subjectrating.toString())
                            .toStringAsFixed(1) +
                        "\n"),
                    const Text("Sessions:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    Text(subjectList[index].subjectsessions.toString() +
                        " sessions\n"),
                    const Text("Tutor:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    Text(subjectList[index].subjecttutor.toString()),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addToCartDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Add to Cart",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () async {
                _addToCart(index);
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addToCart(int index) {
    http.post(
        Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/insert_cart.php"),
        body: {
          "user_id": widget.user.userid.toString(),
          "subject_id": subjectList[index].subjectid.toString(),
          "subject_name": subjectList[index].subjectname.toString(),
          "subject_price": subjectList[index].subjectprice.toString(),
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response('Error', 408);
      },
    ).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        setState(() {});
        Fluttertoast.showToast(
          msg: "Added to cart",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0,
        );
      }
    });
  }
}
