// ignore_for_file: camel_case_types, file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, duplicate_ignore, unused_import, non_constant_identifier_names

import 'dart:io';

import 'package:acatracker_homepage/screens/LoginPage.dart';
import 'package:acatracker_homepage/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'FormInputDecoration.dart';
import 'LoginForm.dart';
import 'SignUpForm.dart';

import 'package:http/http.dart' as http;

class homeSignUpButton extends StatelessWidget {
  const homeSignUpButton(
      {Key? key,
      required String buttonText,
      required Icon icon,
      required Null Function() onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[300],
      child: TextButton(
        style: TextButton.styleFrom(
            primary: Colors.black,
            padding: EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            backgroundColor: Colors.amber[300],
            textStyle: TextStyle(
              fontSize: 18,
            )),
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
        },
        child: Text('Sign In'),
      ),
    );
  }
}
