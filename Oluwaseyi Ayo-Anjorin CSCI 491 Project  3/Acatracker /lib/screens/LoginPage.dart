// ignore_for_file: unused_field, avoid_unnecessary_containers, file_names, prefer_const_constructors

import 'package:acatracker_homepage/widgets/LoginForm.dart';
import 'package:acatracker_homepage/widgets/Nav_bar.dart';
import 'package:acatracker_homepage/widgets/SignUpForm.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isCreateAccountClicked = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _firstnameTextController =
      TextEditingController();
  final TextEditingController _lastnameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: nav_bar(),
        ),
        body: Column(children: [
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.grey[50],
                      )),
                  Text(isCreateAccountClicked ? 'Sign Up' : 'Sign In',
                      style: Theme.of(context).textTheme.headline5),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      SizedBox(
                          width: 300,
                          height: 500,
                          child: isCreateAccountClicked != true
                              ? /*Login form*/ LoginForm(
                                  formKey: _formKey,
                                  emailTextController: _emailTextController,
                                  passwordTextController:
                                      _passwordTextController)
                              : /*sign up form*/ SignUpForm(
                                  formKey: _formKey,
                                  emailTextController: _emailTextController,
                                  passwordTextController:
                                      _passwordTextController,
                                  lastnameTextController:
                                      _lastnameTextController,
                                  firstnameTextController:
                                      _firstnameTextController,
                                )),
                      TextButton.icon(
                        icon: Icon(Icons.portrait_rounded),
                        style: TextButton.styleFrom(
                            textStyle: TextStyle(
                          fontSize: 15,
                        )),
                        onPressed: () {
                          setState(() {
                            if (!isCreateAccountClicked) {
                              isCreateAccountClicked = true;
                            } else {
                              isCreateAccountClicked = false;
                            }
                          });
                        },
                        label: Text(isCreateAccountClicked
                            ? 'Already Have an Account ?'
                            : 'Create Account'),
                      ),
                    ],
                  ),
                  Spacer(),
                  Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.grey[50],
                      )),
                ],
              ),
            ),
          )
        ]));
  }
}
