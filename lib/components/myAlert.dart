import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../constants.dart';

class MyAlert {
  static Future<bool> errorAlert(BuildContext context, {String desc}) {
    return Alert(
        context: context,
        style: AlertStyle(
          descStyle: TextStyle(color: Colors.white),
          backgroundColor: kPrimaryColor,
          titleStyle: TextStyle(
            color: kAccentColor,
          ),
        ),
        type: AlertType.error,
        title: "ERROR!",
        desc: desc,
        buttons: [
          DialogButton(
            color: kAccentColor,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "CANCEL",
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 20,
              ),
            ),
          )
        ]).show();
  }

  static Future<bool> noSeatsAlert(BuildContext context,
      {String bookingClass}) {
    return Alert(
        context: context,
        style: AlertStyle(
          descStyle: TextStyle(color: Colors.white),
          backgroundColor: kPrimaryColor,
          titleStyle: TextStyle(
            color: kAccentColor,
          ),
        ),
        type: AlertType.error,
        title: "ERROR!",
        desc: "There is no any seat available in $bookingClass class",
        buttons: [
          DialogButton(
            color: kAccentColor,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "CANCEL",
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 20,
              ),
            ),
          )
        ]).show();
  }
}
