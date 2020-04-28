import 'package:flutter/material.dart';
import 'package:flutter_flight_reservation_app/constants.dart';
import 'custom_horizontal_divider.dart';
import 'custom_vertical_divider.dart';

class CustomTextFields extends StatelessWidget {
  CustomTextFields(
      {@required this.icon,
      @required this.title,
      this.obscureText,
      this.hintText,
      this.keyboardType,
      this.onChanged,
      this.onTap,
      this.focusNode,
      this.controller});

  final String title;
  final IconData icon;
  final bool obscureText;
  final String hintText;
  final TextInputType keyboardType;
  final Function onChanged;
  final Function onTap;
  final FocusNode focusNode;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: kAccentColor,
              ),
              SizedBox(width: 15.0),
              CustomVerticalDivider(),
              SizedBox(width: 10.0),
              Flexible(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  keyboardType: keyboardType == null
                      ? TextInputType.visiblePassword
                      : keyboardType,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                  obscureText: obscureText == null ? false : true,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: kInactiveTextColor,
                    ),
                    border: InputBorder.none,
                    labelText: title,
                    labelStyle: TextStyle(
                      color: kActiveTextColor,
                      fontSize: 15.0,
                    ),
                  ),
                  onChanged: onChanged,
                  onTap: onTap,
                ),
              )
            ],
          ),
        ),
        CustomHorizontalDivider()
      ],
    );
  }
}
