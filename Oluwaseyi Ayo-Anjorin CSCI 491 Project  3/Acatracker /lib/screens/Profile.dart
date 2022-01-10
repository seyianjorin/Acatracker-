// ignore_for_file: unused_field, avoid_unnecessary_containers, file_names, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.amber[300],
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: Color(0xffffd54f),
            ),
          ),
          height: 600.0,
          width: 400.0,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300.0,
                  width: 300.0,
                  child: Icon(
                    Icons.person,
                    color: Colors.amber[300],
                    size: 100.0,
                  ),
                ),
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection("user")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<DocumentSnapshot> user) {
                      if (!user.hasData) {
                        return CircularProgressIndicator();
                      }
                      print("object");
                      Map<String, dynamic> dataOfUser =
                          user.data!.data() as Map<String, dynamic>;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 20.0),
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "First Name : " +
                                  dataOfUser["first"]
                                      .toString()
                                      .characters
                                      .first
                                      .toUpperCase() +
                                  dataOfUser["first"]
                                      .toString()
                                      .substring(1)
                                      .toLowerCase(),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 20.0),
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "Last Name : " +
                                  dataOfUser["last"]
                                      .toString()
                                      .characters
                                      .first
                                      .toUpperCase() +
                                  dataOfUser["last"]
                                      .toString()
                                      .substring(1)
                                      .toLowerCase(),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 20.0),
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "Email : " + dataOfUser["email"],
                            ),
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
