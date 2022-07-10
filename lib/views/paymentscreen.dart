import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mytutor/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../models/user.dart';

class PaymentScreen extends StatefulWidget {
  final User user;
  final double totalPayment;

  const PaymentScreen(
      {Key? key, required this.user, required this.totalPayment})
      : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Payment'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: WebView(
                initialUrl: CONSTANTS.server +
                    '/slumshop/mobile/php/payment.php?email=' +
                    widget.user.useremail.toString() +
                    '&mobile=' +
                    widget.user.userphone.toString() +
                    '&name=' +
                    widget.user.username.toString() +
                    '&amount=' +
                    widget.totalPayment.toString(),
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
              ),
            )
          ],
        ));
  }
}
