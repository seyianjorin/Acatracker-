// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, camel_case_types, file_names

import 'package:flutter/material.dart';

class homeImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: 0.5,
          child: SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'home.jpeg',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Text(
          'AcaTracker',
          style: TextStyle(fontSize: 40.0),
        ),
      ],
    );
  }
}
