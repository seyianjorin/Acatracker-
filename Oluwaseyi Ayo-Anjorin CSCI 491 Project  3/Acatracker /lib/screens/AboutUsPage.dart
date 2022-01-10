// ignore_for_file: file_names, camel_case_types, prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors

import 'package:acatracker_homepage/widgets/Nav_bar.dart';
import 'package:acatracker_homepage/widgets/AboutUsImage.dart';
import 'package:acatracker_homepage/widgets/AboutUsText.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: nav_bar(),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(children: [
              AboutUsImage(),
            ]),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
              flex: 4,
              child: Column(
                children: [AboutUsText()],
              )),
          Spacer(),
        ],
      ),
    );
  }
}
