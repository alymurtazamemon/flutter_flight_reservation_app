import 'package:flutter/material.dart';
import 'package:flutter_flight_reservation_app/components/custom_textfields.dart';
import 'package:flutter_flight_reservation_app/components/myAlert.dart';
import 'package:flutter_flight_reservation_app/constants.dart';
import 'package:flutter_flight_reservation_app/model/ticket_data.dart';
import 'package:flutter_flight_reservation_app/model/user_data.dart';
import 'package:flutter_flight_reservation_app/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailTextFieldController;

  TextEditingController _passwordTextFieldController;

  @override
  void initState() {
    super.initState();
    _emailTextFieldController = TextEditingController();
    _passwordTextFieldController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextFieldController.dispose();
    _passwordTextFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String email;
    String password;

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
                controller: _emailTextFieldController,
                icon: Icons.alternate_email,
                keyboardType: TextInputType.emailAddress,
                title: 'E-MAIL',
                onChanged: (newValue) {
                  email = newValue;
                },
              ),
              SizedBox(height: 40.0),
              CustomTextFields(
                controller: _passwordTextFieldController,
                icon: Icons.lock_open,
                title: 'PASSWORD',
                obscureText: true,
                onChanged: (newValue) {
                  password = newValue;
                },
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
                    if (email == null || password == null) {
                      MyAlert.errorAlert(context,
                          desc:
                              "One of the field is emplty. Fill all the fields");
                      return;
                    }
                    FocusScope.of(context).unfocus();
                    Provider.of<UserData>(context, listen: false)
                        .setEmailAndPassword(email, password);
                    Navigator.pushNamed(context, MainScreen.id).then((value) {
                      _emailTextFieldController.clear();
                      _passwordTextFieldController.clear();
                    });
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
                  GestureDetector(
                    onTap: () {
                      Alert(
                          context: context,
                          title: "LOGIN",
                          style: AlertStyle(
                            backgroundColor: kPrimaryColor,
                            titleStyle: TextStyle(
                              color: kAccentColor,
                            ),
                          ),
                          content: Column(
                            children: <Widget>[
                              CustomTextFields(
                                icon: Icons.account_circle,
                                title: 'EMAIL',
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (newValue) {
                                  email = newValue;
                                },
                              ),
                              SizedBox(height: 10.0),
                              CustomTextFields(
                                icon: Icons.lock,
                                title: 'PASSWORD',
                                obscureText: true,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (newValue) {
                                  password = newValue;
                                },
                              ),
                            ],
                          ),
                          buttons: [
                            DialogButton(
                              color: kAccentColor,
                              onPressed: () {
                                if (email == null || password == null) {
                                  MyAlert.errorAlert(context,
                                      desc:
                                          "One of the field is emplty. Fill all the fields");
                                  return;
                                }
                                Provider.of<UserData>(context, listen: false)
                                    .setEmailAndPassword(email, password);
                                Navigator.pop(context);
                                Navigator.pushNamed(context, MainScreen.id);
                              },
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ]).show();
                    },
                    child: CustomText(
                      text: 'Join now',
                      color: kAccentColor,
                    ),
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
