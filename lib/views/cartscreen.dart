import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mytutor/components/rounded_button.dart';
import 'package:mytutor/constants.dart';
import 'package:mytutor/models/cart.dart';
import 'package:http/http.dart' as http;
import 'package:mytutor/models/user.dart';
import 'package:mytutor/views/mainscreen.dart';
import 'package:mytutor/views/paymentscreen.dart';

class CartScreen extends StatefulWidget {
  final User user;
  const CartScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Cart> cartList = <Cart>[];
  String titlecenter = "Fetching...";
  var totalPayment;

  var currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadCart();
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
        leading: IconButton(
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (content) => MainScreen(user: widget.user))),
          icon: const Icon(
            Icons.home,
            color: Colors.black38,
          ),
        ),
        actions: const <Widget>[
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: cartList.isEmpty
          ? const Center(child: Text("Cart empty!"))
          : Column(
              children: [
                const SizedBox(height: 10),
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
                    children: List.generate(
                      cartList.length,
                      (index) {
                        return Container(
                          margin: const EdgeInsets.all(6),
                          child: InkWell(
                            splashColor: Colors.purple,
                            onTap: null,
                            child: Card(
                              elevation: 6,
                              child: Column(
                                children: [
                                  Flexible(
                                    flex: 6,
                                    child: CachedNetworkImage(
                                      imageUrl: CONSTANTS.server +
                                          "/mytutor/assets/subjects/" +
                                          cartList[index].subjectid.toString() +
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
                                      cartList[index].subjectname.toString(),
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
                                                  Text(
                                                    "RM " +
                                                        double.parse(
                                                                cartList[index]
                                                                    .price
                                                                    .toString())
                                                            .toStringAsFixed(2),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () =>
                                                  _deleteFromCart(index),
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "Total payment: RM " +
                          double.parse(totalPayment.toString())
                              .toStringAsFixed(2),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RoundedButton(
                      press: () => _checkoutDialog(),
                      text: 'CHECKOUT',
                      buttonColor: Colors.green,
                      textColor: Colors.white,
                      borderColor: Colors.green,
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  void _loadCart() {
    http.post(
        Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/fetch_cart.php"),
        body: {
          'user_email': widget.user.useremail.toString(),
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response('Error', 408);
      },
    ).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        titlecenter = "Timeout";
        return http.Response('Error', 408);
      },
    ).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        if (extractdata['cart'] != null) {
          cartList = <Cart>[];
          extractdata['cart'].forEach((v) {
            cartList.add(Cart.fromJson(v));
          });
          totalPayment = 0.00;
          for (var item in cartList) {
            totalPayment = totalPayment + double.parse(item.price.toString());
          }
          titlecenter = cartList.length.toString() + " Subjects in Cart";
          setState(() {});
        }
      } else {
        cartList.clear();
        setState(() {});
      }
    });
  }

  void _checkoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Pay Now",
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
                Navigator.of(context).pop();
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => PaymentScreen(
                              user: widget.user,
                              totalPayment: 1000.0,
                            )));
                _loadCart();
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

  void _deleteFromCart(int index) {
    http.post(
        Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/delete_cart.php"),
        body: {
          "cart_id": cartList[index].cartid.toString(),
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response('Error', 408);
      },
    ).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        setState(() {
          _loadCart();
        });
      }
    });
  }
}
