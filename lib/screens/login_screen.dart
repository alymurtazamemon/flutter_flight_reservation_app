import 'package:flutter/material.dart';
import 'package:flutter_flight_reservation_app/components/custom_textfields.dart';
import 'package:flutter_flight_reservation_app/constants.dart';
import 'package:flutter_flight_reservation_app/screens/my_flights.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 50),
              Container(
                height: 150.0,
                width: 150.0,
                child: Image(
                  image: AssetImage('images/emirates_logo.png'),
                ),
              ),
              SizedBox(height: 30.0),
              CustomTextFields(
                icon: Icons.alternate_email,
                title: 'E-MAIL',
              ),
              SizedBox(height: 40.0),
              CustomTextFields(
                icon: Icons.lock_open,
                title: 'PASSWORD',
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              FlatButton(
                onPressed: () {},
                child: CustomText(
                  text: 'Forget Password?',
                  color: kInactiveTextColor,
                ),
              ),
              SizedBox(height: 15.0),
              ButtonTheme(
                height: 60.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(23.0),
                  ),
                  color: kAccentColor,
                  child: CustomText(
                    text: 'Log in',
                    color: kLoginTextColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, MyFlights.id);
                  },
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomText(
                    text: 'Not a member?',
                    color: kInactiveTextColor,
                  ),
                  SizedBox(width: 5.0),
                  CustomText(
                    text: 'Join now',
                    color: kAccentColor,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  CustomText({@required this.text, this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 15.0,
      ),
    );
  }
}
