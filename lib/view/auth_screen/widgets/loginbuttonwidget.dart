import 'package:flutter/material.dart';

class LoginBottonWidget extends StatelessWidget {
  String? title;
  final Function() onPressed;
  // final dynamic page;
  LoginBottonWidget({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        height: 40,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            onPressed: onPressed,
            child: Text(
              '$title',
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
      ),
    );
  }
}
