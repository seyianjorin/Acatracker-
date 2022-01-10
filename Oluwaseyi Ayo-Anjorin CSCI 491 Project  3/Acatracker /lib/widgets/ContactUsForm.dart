// ignore_for_file: file_names, prefer_const_constructors

import 'package:acatracker_homepage/utils/utils.dart';
import 'package:flutter/material.dart';
import 'FormInputDecoration.dart';

class ContactUsForm extends StatelessWidget {
  const ContactUsForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailTextController,
    required TextEditingController firstnameTextController,
    required TextEditingController lastnameTextController,
  })  : _formKey = formKey,
        _emailTextController = emailTextController,
        _firstnameTextController = firstnameTextController,
        _lastnameTextController = lastnameTextController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailTextController;
  final TextEditingController _firstnameTextController;
  final TextEditingController _lastnameTextController;

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
            controller: _firstnameTextController,
            decoration:
                FormInputDecoration(label: 'Firstname', hintText: 'John'),
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
            controller: _lastnameTextController,
            decoration: FormInputDecoration(label: 'Lastname', hintText: 'Doe'),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Email';
              }
              return null;
            },
            controller: _emailTextController,
            decoration: FormInputDecoration(
                label: 'Enter Email', hintText: 'johnDoe@emailprovider.com'),
          ),
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
                launchMailto();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Loading...')),
                );
              }
            },
            child: Text('Submit')),
        Spacer()
      ]),
    );
  }
}
