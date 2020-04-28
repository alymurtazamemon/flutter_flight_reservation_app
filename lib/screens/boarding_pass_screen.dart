import 'package:flutter/material.dart';
import 'package:flutter_flight_reservation_app/components/custom_appbar.dart';
import 'package:flutter_flight_reservation_app/components/custom_horizontal_divider.dart';
import 'package:flutter_flight_reservation_app/components/inactive_into_custom_text.dart';
import 'package:flutter_flight_reservation_app/model/ticket_data.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class BoardingPassScreen extends StatelessWidget {
  BoardingPassScreen({this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    var ticket = Provider.of<TicketData>(context).tickets[index];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              title: 'My flights',
              navigatorIcon: Icons.clear,
              onIconClick: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 35.0),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: ListView(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 10.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 70.0,
                                      width: 70.0,
                                      child: Image(
                                        image: AssetImage('images/logo4.png'),
                                      ),
                                    ),
                                    Container(
                                      height: 60.0,
                                      width: 60.0,
                                      child: Image(
                                        image: AssetImage(
                                            'images/flight_center_logo3.png'),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    InactiveInfoCustomText(
                                        text: 'Ticket Price'),
                                    SizedBox(height: 10.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '\$',
                                          style: TextStyle(
                                              color: kPrimaryColor,
                                              fontSize: 20.0),
                                        ),
                                        Text(
                                          '${ticket.price}.00',
                                          style: TextStyle(
                                              color: kPrimaryColor,
                                              fontSize: 30.0),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Expanded(
                                    child: Image(
                                        image: AssetImage('images/map.png'))),
                              ],
                            ),
                            SizedBox(height: 30.0),
                            CustomHorizontalDivider(),
                            SizedBox(height: 30.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    InactiveInfoCustomText(text: 'FLIGHT DATE'),
                                    InfoText(text: ticket.date),
                                    SizedBox(height: 40.0),
                                    InactiveInfoCustomText(
                                        text: 'BOARDING TIME'),
                                    InfoText(text: ticket.time),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    InactiveInfoCustomText(text: 'GATE'),
                                    InfoText(text: ticket.gateNumber),
                                    SizedBox(height: 53.0),
                                    InactiveInfoCustomText(
                                      text: 'SEAT',
                                      height: 0.0,
                                    ),
                                    DropdownButton<String>(
                                      icon: Icon(null),
                                      underline: SizedBox(),
                                      items: ticket.seats
                                          .map((String dropDownItem) {
                                        return DropdownMenuItem<String>(
                                          value: dropDownItem,
                                          child: Text(
                                            dropDownItem,
                                            style: TextStyle(
                                              height: 0.0,
                                              color: kPrimaryColor,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {},
                                      value: ticket.seats[0],
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    InactiveInfoCustomText(text: 'FLIGHT NO'),
                                    InfoText(text: ticket.flightNumber),
                                    SizedBox(height: 40.0),
                                    InactiveInfoCustomText(text: 'CLASS'),
                                    InfoText(text: ticket.bookingClass),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 30.0),
                            CustomHorizontalDivider(),
                            SizedBox(height: 30.0),
                            InfoText(text: 'Boarding pass'),
                            SizedBox(height: 30.0),
                            Image(image: AssetImage('images/barcode.png')),
                            SizedBox(height: 30.0),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoText extends StatelessWidget {
  InfoText({@required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: kPrimaryColor,
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
