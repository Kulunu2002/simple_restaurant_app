import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final onPressed;
  final text;
  final width;
  final buttonColor;
  final btColor;

  const CustomButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      required this.width,
      required this.buttonColor,
       this.btColor,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: buttonColor,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: btColor ?? Colors.white),
        ), 
      ),
    );
  }
}
