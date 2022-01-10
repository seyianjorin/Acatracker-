// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_import, camel_case_types,, file_names

import 'package:acatracker_homepage/screens/ContactUsPage.dart';
import 'package:acatracker_homepage/screens/HomePage.dart';
import 'package:acatracker_homepage/screens/LoginPage.dart';
import 'package:acatracker_homepage/screens/AboutUsPage.dart';
import 'package:acatracker_homepage/screens/Dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class nav_bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.amber[300],
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => homepage(),
                    ));
              },
              child: Text(
                'AcaTracker',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => homepage(),
                    ));
              },
              child: Text(
                'Home',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutUsPage(),
                    ));
              },
              child: Text(
                'About Us',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactUsPage(),
                    ));
              },
              child: Text(
                'Contact',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(4.0),
          //   child: TextButton(
          //     onPressed: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => MyClassApp(FirebaseAuth.instance.currentUser!.email!),
          //           ));
          //     },
          //     child: Text(
          //       'Product Demo',
          //       style: TextStyle(color: Colors.black),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
