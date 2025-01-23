
import 'package:flutter/material.dart';

Widget buildPage(
    {required String image,
      required String title,
      required String description}) {
  return Container(
    decoration: BoxDecoration(),
    child: Column(
      children: [
        Image.asset(
          image,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 30),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 15),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}