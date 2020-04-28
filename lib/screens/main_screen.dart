import 'package:flutter/material.dart';
import 'package:flutter_flight_reservation_app/components/custom_appbar.dart';
import 'package:flutter_flight_reservation_app/components/custom_floating_action_button.dart';
import 'package:flutter_flight_reservation_app/constants.dart';
import 'package:flutter_flight_reservation_app/model/tab_controller_data.dart';
import 'package:flutter_flight_reservation_app/model/ticket_data.dart';
import 'package:flutter_flight_reservation_app/model/user_data.dart';
import 'package:flutter_flight_reservation_app/screens/my_flights.dart';
import 'package:flutter_flight_reservation_app/screens/profile_screen.dart';
import 'package:flutter_flight_reservation_app/screens/tabs_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  static const String id = 'main_screen';

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData>(context);
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 240,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                ),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: user.image,
                    ),
                    SizedBox(height: 20.0),
                    Text(user.username,
                        style: TextStyle(color: kAccentColor, fontSize: 30)),
                    Text(user.email, style: TextStyle(color: kAccentColor)),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: kPrimaryColor,
              ),
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 18, color: kPrimaryColor),
              ),
              onTap: () {
                Navigator.pushNamed(context, ProfileScreen.id);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: kPrimaryColor,
              ),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 18, color: kPrimaryColor),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.arrow_back,
                color: kPrimaryColor,
              ),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 18, color: kPrimaryColor),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              title: 'My flights',
              navigatorIcon: Icons.menu,
              onIconClick: () {
                scaffoldKey.currentState.openDrawer();
              },
            ),
            SizedBox(height: 20.0),
            MyFlights(),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        heroTag: 'main',
        icon: Icons.add,
        onPressed: () {
          /*
          because index of Tabbar is control with provider package,
          that's why here set the initial index of tabbar, that is zero. 
          */
          Provider.of<TabControllerData>(context, listen: false).initialIndex();
          Provider.of<TicketData>(context, listen: false).seatsList.clear();
          Navigator.pushNamed(context, TabsScreen.id);
        },
      ),
    );
  }
}
