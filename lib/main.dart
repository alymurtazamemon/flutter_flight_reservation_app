import 'package:flutter/material.dart';
import 'package:flutter_flight_reservation_app/model/tab_controller_data.dart';
import 'package:flutter_flight_reservation_app/screens/main_screen.dart';
import 'package:flutter_flight_reservation_app/screens/profile_screen.dart';
import 'package:flutter_flight_reservation_app/screens/tabs_screen.dart';
import 'package:provider/provider.dart';
import 'model/ticket_data.dart';
import 'model/user_data.dart';
import 'screens/login_screen.dart';
import 'screens/my_flights.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TicketData()),
        ChangeNotifierProvider(create: (_) => TabControllerData()),
        ChangeNotifierProvider(create: (_) => UserData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flight Reservation System',
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          MainScreen.id: (context) => MainScreen(),
          MyFlights.id: (context) => MyFlights(),
          TabsScreen.id: (context) => TabsScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
        },
      ),
    );
  }
}
