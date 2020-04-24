import 'package:flutter/material.dart';
import 'package:flutter_flight_reservation_app/components/custom_floating_action_button.dart';
import 'package:flutter_flight_reservation_app/components/custom_horizontal_divider.dart';
import 'package:flutter_flight_reservation_app/components/custom_textfields.dart';
import 'package:flutter_flight_reservation_app/components/custom_vertical_divider.dart';
import 'package:flutter_flight_reservation_app/model/tab_controller_data.dart';
import 'package:flutter_flight_reservation_app/model/ticket_data.dart';
import 'package:flutter_flight_reservation_app/screens/booking_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class RouteTabScreen extends StatefulWidget {
  @override
  _RouteTabScreenState createState() => _RouteTabScreenState();
}

class _RouteTabScreenState extends State<RouteTabScreen> {
  String from;
  String to;
  String date;
  int travelers;
  String bookingClass;
  var _bookingClassList = ['Economy', 'Business', 'First'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 15.0),
            Expanded(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      //This is responsible for the background of the tabbar, does the magic
                      decoration: BoxDecoration(
                        //This is for background color
                        color: kLinesColor.withOpacity(0.0),
                        //This is for bottom border that is needed
                        border: Border(
                          bottom: BorderSide(color: kLinesColor, width: 0.8),
                        ),
                      ),
                      child: Center(
                        child: TabBar(
                          labelColor: kAccentColor,
                          unselectedLabelColor: Colors.white,
                          isScrollable: true,
                          indicatorColor: Colors.transparent,
                          tabs: [
                            Row(
                              children: <Widget>[
                                CustomTabs(text: 'One Way'),
                                SizedBox(width: 30.0),
                                CustomVerticalDivider(),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                CustomTabs(text: 'Roundtrip'),
                                SizedBox(width: 30.0),
                                CustomVerticalDivider(),
                              ],
                            ),
                            CustomTabs(text: 'Multiple'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: new TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            ListView(
                              children: <Widget>[
                                SizedBox(height: 25.0),
                                CustomTextFields(
                                  icon: Icons.flight_takeoff,
                                  title: 'FROM',
                                  onChanged: (newSource) {
                                    from = newSource;
                                  },
                                ),
                                SizedBox(height: 25.0),
                                CustomTextFields(
                                  icon: Icons.flight_land,
                                  title: 'TO',
                                  onChanged: (newDestination) {
                                    to = newDestination;
                                  },
                                ),
                                SizedBox(height: 25.0),
                                CustomTextFields(
                                  icon: Icons.date_range,
                                  title: 'DATE',
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate:
                                          DateTime(DateTime.now().year + 1),
                                    ).then((date) {
                                      this.date =
                                          DateFormat('MMM d').format(date);
                                      print(this.date);
                                    });
                                  },
                                ),
                                SizedBox(height: 25.0),
                                CustomTextFields(
                                  icon: Icons.people,
                                  title: 'TRAVELER',
                                  keyboardType: TextInputType.number,
                                  onChanged: (numberOfTravelers) {
                                    travelers = numberOfTravelers;
                                  },
                                ),
                                SizedBox(height: 25.0),
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.airline_seat_recline_extra,
                                            color: kAccentColor,
                                          ),
                                          SizedBox(width: 15.0),
                                          CustomVerticalDivider(),
                                          SizedBox(width: 10.0),
                                          DropdownButton<String>(
                                            icon: Icon(null),
                                            underline: SizedBox(),
                                            dropdownColor: kPrimaryColor,
                                            hint: Text(
                                              'CLASS',
                                              style: TextStyle(
                                                color: kActiveTextColor,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            items: _bookingClassList
                                                .map((String dropDownItem) {
                                              return DropdownMenuItem<String>(
                                                value: dropDownItem,
                                                child: Text(
                                                  dropDownItem,
                                                  style: TextStyle(
                                                    color: kAccentColor,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                this.bookingClass = newValue;
                                              });
                                            },
                                            value: bookingClass,
                                          )
                                        ],
                                      ),
                                    ),
                                    CustomHorizontalDivider()
                                  ],
                                ),
                                SizedBox(height: 25.0),
                              ],
                            ),
                            Booking('Roundtrip'),
                            Booking('Multiple'),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        heroTag: 'route',
        icon: Icons.arrow_forward_ios,
        onPressed: () {
          Provider.of<TicketData>(context, listen: false)
              .addRouteData(from, to, date, travelers, bookingClass);
          Provider.of<TabControllerData>(context, listen: false)
              .incrmentIndex();
        },
      ),
    );
  }
}

class CustomTabs extends StatelessWidget {
  CustomTabs({@required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        text,
        style: TextStyle(fontSize: 12.0),
      ),
    );
  }
}
