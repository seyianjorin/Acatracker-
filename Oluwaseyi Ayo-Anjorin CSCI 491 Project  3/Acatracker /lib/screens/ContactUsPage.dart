// ignore_for_file: avoid_unnecessary_containers, file_names, prefer_const_constructors, unused_field

import 'package:acatracker_homepage/widgets/ContactUsForm.dart';
import 'package:acatracker_homepage/widgets/Nav_bar.dart';
import 'package:flutter/material.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextController = TextEditingController();
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Contact Us', style: Theme.of(context).textTheme.headline5),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                SizedBox(
                  width: 300,
                  height: 500,
                  child: /*Contact Us form*/ ContactUsForm(
                    formKey: _formKey,
                    emailTextController: _emailTextController,
                    lastnameTextController: _lastnameTextController,
                    firstnameTextController: _firstnameTextController,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
