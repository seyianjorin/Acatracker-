// ignore_for_file: file_names, prefer_const_constructors, avoid_types_as_parameter_names

import 'package:acatracker_homepage/screens/Dashboard.dart';
import 'package:acatracker_homepage/utils/api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'FormInputDecoration.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailTextController,
    required TextEditingController passwordTextController,
    required TextEditingController firstnameTextController,
    required TextEditingController lastnameTextController,
  })  : _formKey = formKey,
        _emailTextController = emailTextController,
        _passwordTextController = passwordTextController,
        _firstnameTextController = firstnameTextController,
        _lastnameTextController = lastnameTextController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailTextController;
  final TextEditingController _passwordTextController;
  final TextEditingController _firstnameTextController;
  final TextEditingController _lastnameTextController;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? uid;
  String? userEmail;

  Future<User?> registerWithEmailPassword(
      String email, String password, BuildContext context) async {
    // Initialize Firebase
    await Firebase.initializeApp();
    User? user;

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;

      if (user != null) {
        uid = user.uid;
        userEmail = user.email;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Weak Password, please enter a minimum of 8 letters and a number')),
        );
        print('Weak Password');
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('An account is already registered with that email')),
        );
        print('An account is already registered with that email');
      }
    } catch (e) {
      print(e);
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter First Name';
              }
              return null;
            },
            autofillHints: const [AutofillHints.name],
            controller: _firstnameTextController,
            decoration:
                FormInputDecoration(label: 'First Name', hintText: 'John'),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Last Name';
              }
              return null;
            },
            autofillHints: const [AutofillHints.nameSuffix],
            controller: _lastnameTextController,
            decoration:
                FormInputDecoration(label: 'Last Name', hintText: 'Deo'),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: TextFormField(
            autofillHints: const [AutofillHints.email],
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
            autofillHints: const [AutofillHints.password],
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
                textStyle: TextStyle(
                  fontSize: 18,
                )),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Loading...')),
                );
              }

              registerWithEmailPassword(_emailTextController.text,
                      _passwordTextController.text, context)
                  .then((value) async {
                if (value != null) {
                  await createUser(value.email!);
                  await FirebaseFirestore.instance
                      .collection("user")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .set({
                    "first": _firstnameTextController.text,
                    "last": _lastnameTextController.text,
                    "email": FirebaseAuth.instance.currentUser!.email,
                  }).then(
                    (a) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyClassApp(value.email!),
                      ),
                    ),
                  );
                }
              });
            },
            child: Text('Sign Up'))
      ]),
    );
  }
}
