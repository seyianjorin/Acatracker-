// ignore_for_file: camel_case_types, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore

import 'package:acatracker_homepage/widgets/homeSignUpButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AboutUsText extends StatelessWidget {
  const AboutUsText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Column(
              children: [
                Text(
                  'AcaTracker is one of the worlds fastest growing academic tools used to achieve academic success. AcaTracker Is a web tool used for tracking your progress on goals you set out to complete In each of your classes. With our easy to navigate dashboard, you will be able to easily track your progress on your tasks, add new tasks to your list, and mark certain tasks as completed among many other features. \n\nWe Pride ourself In having a product available to everyone regardless of what school registered In, all for free.\n\nSign up now to start your journey to success! ',
                  style: TextStyle(fontSize: 18.0),
                ),
                // Text(
                //   '\nAcaTracker is one of the worlds fastest growing academic tools used to achieve academic success. AcaTracker Is a web tool used for tracking your progress on goals you set out to complete In each of your classes. With our easy to navigate dashboard, you will be able to easily track your progress on your tasks, add new tasks to your list, prioritize certain tasks, and mark certain tasks as completed among many other features. \n\nWe Pride ourself In having a product available to everyone regardless of what school registered In, all for free.\n\nSign up now to start your journey to success! ',
                //   style: TextStyle(fontSize: 18.0),
                // ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.5, vertical: 10.0),
                      child: homeSignUpButton(
                        buttonText: 'Sign In',
                        icon: Icon(Icons.mail_outline),
                        onPressed: () {},
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
