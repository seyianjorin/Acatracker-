// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, camel_case_types

import 'package:acatracker_homepage/screens/Dashboard.dart';
import 'package:acatracker_homepage/screens/LoginPage.dart';
import 'package:acatracker_homepage/screens/Profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:menu_button/menu_button.dart';

import '../main.dart';

class Dashboard_Navbar extends StatefulWidget {
  final bool? isFunctional;
  const Dashboard_Navbar({
    this.isFunctional = true,
  });
  @override
  State<Dashboard_Navbar> createState() => _Dashboard_NavbarState();
}

class _Dashboard_NavbarState extends State<Dashboard_Navbar> {
  String selectedKey = "Low";

  List<String> keys = <String>[
    'Low',
    'Medium',
    'High',
  ];

  @override
  Widget build(BuildContext context) {
    return AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.amber[300],
        title: Row(children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextButton(
              onPressed: widget.isFunctional!
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyApp(),
                          ));
                    }
                  : () {},
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
            child: Stack(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyClassApp(
                              FirebaseAuth.instance.currentUser!.email!),
                        ));
                  },
                  child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection("user")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<DocumentSnapshot> user) {
                      if (!user.hasData) {
                        return CircularProgressIndicator();
                      }

                      Map<String, dynamic> dataOfUser =
                          user.data!.data() as Map<String, dynamic>;
                      print("print first char" +
                          dataOfUser["first"]
                              .toString()
                              .characters
                              .first
                              .toUpperCase());
                      return SizedBox(
                        width: 150,
                        child: DropdownButton<String>(
                          // value: widget.selectedPage == null
                          //     ? 'Select Service'
                          //     : widget.selectedPage,
                          dropdownColor: Colors.amber[300],
                          hint: Text(
                            dataOfUser["first"]
                                    .toString()
                                    .characters
                                    .first
                                    .toUpperCase() +
                                dataOfUser["first"]
                                    .toString()
                                    .substring(1)
                                    .toLowerCase(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: RotatedBox(
                            quarterTurns: 1,
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.black87,
                            ),
                          ),
                          iconSize: 14,
                          elevation: 16,
                          isExpanded: true,

                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              if (newValue == "Sign out") {
                                print("signed out");
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyApp(),
                                  ),
                                );
                                // FirebaseAuth.instance.signOut().then((value) {
                                //   print("signed out1");

                                // });
                              }
                              if (newValue == "Profile") {
                                print("profile");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Profile(),
                                  ),
                                );
                              }
                            });
                          },
                          items: <String>[
                            "Profile",
                            "Sign out",
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
