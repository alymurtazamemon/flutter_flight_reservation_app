import 'package:flutter/material.dart';
import 'package:flutter_flight_reservation_app/components/custom_appbar.dart';
import 'package:flutter_flight_reservation_app/components/custom_floating_action_button.dart';
import 'package:flutter_flight_reservation_app/model/tab_controller_data.dart';
import 'package:flutter_flight_reservation_app/screens/my_flights.dart';
import 'package:flutter_flight_reservation_app/screens/tabs_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  static const String id = 'main_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CustomAppBar(title: 'My flights', navigatorIcon: Icons.menu),
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
          Navigator.pushNamed(context, TabsScreen.id);
        },
      ),
    );
  }
}
