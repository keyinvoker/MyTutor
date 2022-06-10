import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color buttonColor, borderColor, textColor;
  final Function() press;
  const RoundedButton({
    Key? key,
    required this.text,
    this.buttonColor = Colors.white,
    this.borderColor = Colors.purple,
    this.textColor = Colors.purple,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      // width: size.width * 0.35,
      height: size.height * 0.085,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            side: BorderSide(width: 2, color: borderColor),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: press,
        ),
      ),
    );
  }
}
