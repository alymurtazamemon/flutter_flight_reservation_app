import 'package:flutter/material.dart';
import 'package:flutter_flight_reservation_app/model/ticket_data.dart';
import 'package:flutter_flight_reservation_app/model/user_data.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/shape/gf_avatar_shape.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({this.navigatorIcon, @required this.title, this.onIconClick});
  final IconData navigatorIcon;
  final String title;
  final Function onIconClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: onIconClick,
                child: Icon(
                  navigatorIcon,
                  color: kPrimaryColor,
                ),
              ),
              Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    height: 90.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                      color: kUpperContainerColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 15.0,
                    left: -25.0,
                    child: GFAvatar(
                        backgroundColor: Colors.grey,
                        radius: 30.0,
                        backgroundImage: Provider.of<UserData>(context).image,
                        shape: GFAvatarShape.standard),
                  ),
                ],
              )
            ],
          ),
          Text(
            title,
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 30.0,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
