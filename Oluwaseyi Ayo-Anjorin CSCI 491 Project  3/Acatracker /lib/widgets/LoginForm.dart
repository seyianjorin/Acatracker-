// ignore_for_file: file_names, prefer_const_constructors

import 'package:acatracker_homepage/screens/Dashboard.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FormInputDecoration.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailTextController,
    required TextEditingController passwordTextController,
  })  : _formKey = formKey,
        _emailTextController = emailTextController,
        _passwordTextController = passwordTextController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailTextController;
  final TextEditingController _passwordTextController;

  //login requirements
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? uid;
  String? userEmail;

//login handle function
  Future<User?> signInWithEmailPassword(
      String email, String password, BuildContext context) async {
    // await Firebase.initializeApp();
    User? user;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;

      if (user != null) {
        uid = user.uid;
        userEmail = user.email;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('auth', true);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found for that email.')),
        );
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wrong password provided.')),
        );
        print('Wrong password provided.');
      }
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        Padding(
          padding: EdgeInsets.all(15.0),
          child: TextFormField(
            controller: _emailTextController,
            decoration: FormInputDecoration(
                label: 'Enter Email', hintText: 'johnDoe@emailprovider.com'),
            validator: (value) =>
                value != null && !EmailValidator.validate(value)
                    ? 'Enter Valid Email'
                    : null,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Password';
              }
              return null;
            },
            autofillHints: const [AutofillHints.email],
            controller: _passwordTextController,
            obscureText: true,
            decoration: FormInputDecoration(label: 'Password', hintText: ''),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
            style: TextButton.styleFrom(
                primary: Colors.black,
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                backgroundColor: Colors.amber[300],
                textStyle: TextStyle(fontSize: 18, color: Colors.black)),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Loading...')),
                );
              }
              signInWithEmailPassword(_emailTextController.text,
                      _passwordTextController.text, context)
                  .then((value) {
                if (value != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyClassApp(value.email!),
                      ));
                }
              });
            },
            child: Text('Sign In'))
      ]),
    );
  }

  setState(Null Function() param0) {}
}
