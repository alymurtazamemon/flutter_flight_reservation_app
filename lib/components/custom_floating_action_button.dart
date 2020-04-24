import 'package:flutter/material.dart';

import '../constants.dart';

class CustomFloatingActionButton extends StatelessWidget {
  CustomFloatingActionButton({this.icon, this.onPressed, this.heroTag});
  final IconData icon;
  final Function onPressed;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
      child: FloatingActionButton(
        heroTag: heroTag,
        onPressed: onPressed,
        backgroundColor: kAccentColor,
        child: Icon(
          icon,
          color: kPrimaryColor,
          size: 25.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
