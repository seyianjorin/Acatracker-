// ignore_for_file: file_names, camel_case_types, prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors

import 'package:acatracker_homepage/widgets/Nav_bar.dart';
import 'package:acatracker_homepage/widgets/homeImage.dart';
import 'package:acatracker_homepage/widgets/homeText.dart';
import 'package:flutter/material.dart';

class homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: nav_bar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            homeImage(),
            homeText(),
          ],
        ),
      ),
    );
  }
}
