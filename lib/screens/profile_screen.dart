import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_flight_reservation_app/components/custom_textfields.dart';
import 'package:flutter_flight_reservation_app/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_flight_reservation_app/model/user_data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File _image;
  TextEditingController _usernameTFController;
  TextEditingController _emailTFController;
  TextEditingController _passwordTFController;
  String username;
  String email;
  String password;
  bool showSpinner = false;
  bool isChanged = false;

  @override
  void initState() {
    super.initState();
    _usernameTFController = new TextEditingController();
    _emailTFController = new TextEditingController();
    _passwordTFController = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameTFController.dispose();
    _emailTFController.dispose();
    _passwordTFController.dispose();
  }

  void getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    this.setState(() {
      _image = image;
    });
    isChanged = true;
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData>(context);
    _usernameTFController.text = user.username;
    _emailTFController.text = user.email;
    _passwordTFController.text = user.password;
    //collecting these things here, because if the user will update any of one then the other will be same.
    username = user.username;
    email = user.email;
    password = user.password;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: ModalProgressHUD(
        color: kPrimaryColor,
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Center(
                  child: CircleAvatar(
                    radius: 100.0,
                    backgroundImage:
                        _image == null ? user.image : Image.file(_image).image,
                  ),
                ),
              ),
              SizedBox(height: 50.0),
              CustomTextFields(
                icon: Icons.account_circle,
                title: 'USERNAME',
                controller: _usernameTFController,
                onChanged: (newValue) {
                  username = newValue;
                },
              ),
              SizedBox(height: 20.0),
              CustomTextFields(
                icon: Icons.alternate_email,
                title: 'EMAIL',
                controller: _emailTFController,
                onChanged: (newValue) {
                  email = newValue;
                },
              ),
              SizedBox(height: 20.0),
              CustomTextFields(
                icon: Icons.lock,
                obscureText: true,
                title: 'PASSWORD',
                controller: _passwordTFController,
                onChanged: (newValue) {
                  password = newValue;
                },
              ),
              SizedBox(height: 50),
              Center(
                child: RaisedButton(
                  textColor: kPrimaryColor,
                  color: kAccentColor,
                  child: Text('SAVE CHANGES'),
                  onPressed: () {
                    user.saveProfileChanges(
                        username: username, email: email, password: password);
                    if (isChanged) user.uploadImage(Image.file(_image).image);
                    setState(() {
                      showSpinner = true;
                    });

                    Timer(Duration(seconds: 2), () {
                      setState(() {
                        showSpinner = false;
                        Navigator.of(context).pop();
                      });
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
