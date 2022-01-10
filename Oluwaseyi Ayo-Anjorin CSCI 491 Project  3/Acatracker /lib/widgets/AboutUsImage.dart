// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, camel_case_types, file_names

import 'package:flutter/material.dart';

class AboutUsImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.amber[300],
              ),
              Text(
                'About Us',
                style: TextStyle(fontSize: 20.0, ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
