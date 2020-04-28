import 'package:flutter/material.dart';
import 'package:flutter_flight_reservation_app/components/acronym_custom_text.dart';
import 'package:flutter_flight_reservation_app/components/active_info_custom_text.dart';
import 'package:flutter_flight_reservation_app/components/emirates_logo.dart';
import 'package:flutter_flight_reservation_app/components/inactive_into_custom_text.dart';
import 'package:flutter_flight_reservation_app/constants.dart';
import 'package:flutter_flight_reservation_app/model/ticket_data.dart';
import 'package:flutter_flight_reservation_app/screens/boarding_pass_screen.dart';
import 'package:provider/provider.dart';

class MyFlights extends StatelessWidget {
  static const String id = 'myFlight_screen';

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 35.0),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: TicketsList(),
      ),
    );
  }
}

class TicketsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TicketData>(
      builder: (context, ticketData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            var ticket = ticketData.tickets[index];
            return Ticket(
              index: index,
              from: ticket.from,
              to: ticket.to,
              time: ticket.time,
              duration: ticket.duration,
              date: ticket.date,
              flightNumber: ticket.flightNumber,
            );
          },
          itemCount: ticketData.totalTickets,
        );
      },
    );
  }
}

class Ticket extends StatelessWidget {
  Ticket({
    this.index,
    this.from,
    this.to,
    this.date,
    this.time,
    this.duration,
    this.flightNumber,
  });
  final int index;
  final String from;
  final String to;
  final String date;
  final String time;
  final String duration;
  final String flightNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            print(Provider.of<TicketData>(context, listen: false)
                .tickets[index]
                .seats
                .toList());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BoardingPassScreen(index: index),
              ),
            );
          },
          child: Container(
            color: kPrimaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 5.0),
                    AcronymCustomText(text: from.substring(0, 3).toUpperCase()),
                    SizedBox(height: 5.0),
                    ActiveInfoCustomText(text: from),
                    SizedBox(height: 30.0),
                    InactiveInfoCustomText(text: 'DATE'),
                    SizedBox(height: 5.0),
                    ActiveInfoCustomText(text: '$date, $time'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    EmiratesLogo(),
                    ActiveInfoCustomText(text: duration),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(height: 5.0),
                      AcronymCustomText(text: to.substring(0, 3).toUpperCase()),
                      SizedBox(height: 5.0),
                      ActiveInfoCustomText(text: to),
                      SizedBox(height: 30.0),
                      InactiveInfoCustomText(text: 'FLIGHT NO'),
                      SizedBox(height: 5.0),
                      ActiveInfoCustomText(text: flightNumber),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 30.0),
        Divider(
          thickness: 1.5,
          color: kLinesColor,
        ),
        SizedBox(height: 20.0),
      ],
    );
  }
}
