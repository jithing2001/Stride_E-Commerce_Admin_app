import 'package:flutter/material.dart';

class HomeListWidgets extends StatelessWidget {
  String? title;
  HomeListWidgets({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      color: Colors.grey,
      child: Center(
          child: Text(
        '$title',
        style: const TextStyle(fontSize: 25, color: Colors.black),
      )),
    );
  }
}