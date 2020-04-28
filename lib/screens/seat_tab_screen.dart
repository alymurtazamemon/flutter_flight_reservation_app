import 'package:flutter/material.dart';
import 'package:flutter_flight_reservation_app/components/acronym_custom_text.dart';
import 'package:flutter_flight_reservation_app/components/active_info_custom_text.dart';
import 'package:flutter_flight_reservation_app/components/emirates_logo.dart';
import 'package:flutter_flight_reservation_app/components/inactive_into_custom_text.dart';
import 'package:flutter_flight_reservation_app/components/myAlert.dart';
import 'package:flutter_flight_reservation_app/constants.dart';
import 'package:flutter_flight_reservation_app/model/tab_controller_data.dart';
import 'package:flutter_flight_reservation_app/model/ticket_data.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SeatTabScreen extends StatelessWidget {
  SeatTabScreen({this.toggleTab});
  final toggleTab;
  @override
  Widget build(BuildContext context) {
    var ticket = Provider.of<TicketData>(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image(
                  image: AssetImage('images/plane.png'),
                ),
                Positioned(
                  left: 0.0,
                  top: 140.0,
                  bottom: 0.0,
                  right: 10.0,
                  child: Column(
                    children: <Widget>[
                      ActiveInfoCustomText(
                        text: '${ticket.duration}, ${ticket.time}',
                      ),
                      SizedBox(height: 25.0),
                      Text(
                        '${ticket.bookingClass} Class',
                        style: TextStyle(color: kAccentColor),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 32.0,
                  top: 225.0,
                  bottom: 0.0,
                  right: 10.0,
                  child: Column(
                    children: <Widget>[
                      TotalSeats(),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(height: 65.0),
                AcronymCustomText(
                    text: ticket.from.substring(0, 3).toUpperCase()),
                ActiveInfoCustomText(text: ticket.from),
                SizedBox(height: 20.0),
                EmiratesLogo(),
                ActiveInfoCustomText(text: ticket.duration),
                SizedBox(height: 30.0),
                AcronymCustomText(
                    text: ticket.to.substring(0, 3).toUpperCase()),
                ActiveInfoCustomText(text: ticket.to),
                SizedBox(height: 30.0),
                InactiveInfoCustomText(text: 'FLIGHT NO'),
                SizedBox(height: 5.0),
                ActiveInfoCustomText(text: ticket.flightNumber),
                SizedBox(height: 30.0),
                AcronymCustomText(text: ticket.seatNumber),
                ActiveInfoCustomText(text: 'Seat'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TotalSeats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var ticket = Provider.of<TicketData>(context);

    bool checkBookedTickets(String ticketNumber) {
      switch (ticket.bookingClass) {
        case 'Economy':
          return ticket.economyClassSeatsList.contains(ticketNumber);
          break;
        case 'Business':
          return ticket.businessClassSeatsList.contains(ticketNumber);
          break;
        case 'First':
          return ticket.firstClassSeatsList.contains(ticketNumber);
          break;
        default:
          return null;
      }
    }

    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SeatContainer(
                    seatNumber: '${index + 1}A',
                    isBooked: checkBookedTickets('${index + 1}A'),
                  ),
                  SizedBox(width: 10.0),
                  SeatContainer(
                    seatNumber: '${index + 1}B',
                    isBooked: checkBookedTickets('${index + 1}B'),
                  ),
                  SizedBox(width: 30.0),
                  SeatContainer(
                    seatNumber: '${index + 1}C',
                    isBooked: checkBookedTickets('${index + 1}C'),
                  ),
                  SizedBox(width: 10.0),
                  SeatContainer(
                    seatNumber: '${index + 1}D',
                    isBooked: checkBookedTickets('${index + 1}D'),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          );
        },
        itemCount: 10,
      ),
    );
  }
}

class SeatContainer extends StatefulWidget {
  SeatContainer({this.isBooked, this.seatNumber});
  final bool isBooked;
  final String seatNumber;

  @override
  _SeatContainerState createState() => _SeatContainerState();
}

class _SeatContainerState extends State<SeatContainer> {
  bool isSelected = false;

  void addticket(ticket) {
    isSelected = !isSelected;
    ticket.addSeat(widget.seatNumber);
    ticket.decreaseCount();
    if (ticket.getCount == 0)
      Provider.of<TabControllerData>(context, listen: false).incrmentIndex();
  }

  @override
  Widget build(BuildContext context) {
    var ticket = Provider.of<TicketData>(context, listen: false);
    return GestureDetector(
      onTap: () {
        switch (ticket.bookingClass) {
          case 'Economy':
            if (ticket.economyClassSeatsList.contains(widget.seatNumber)) {
              MyAlert.errorAlert(context,
                  desc: "This seat is already booked. Choose another!");
            } else {
              ticket.economyClassSeatsList.add(widget.seatNumber);
              addticket(ticket);
            }
            break;
          case 'Business':
            if (ticket.businessClassSeatsList.contains(widget.seatNumber)) {
              MyAlert.errorAlert(context,
                  desc: "This seat is already booked. Choose another!");
            } else {
              ticket.businessClassSeatsList.add(widget.seatNumber);
              addticket(ticket);
            }
            break;
          case 'First':
            if (ticket.firstClassSeatsList.contains(widget.seatNumber)) {
              MyAlert.errorAlert(context,
                  desc: "This seat is already booked. Choose another!");
            } else {
              ticket.firstClassSeatsList.add(widget.seatNumber);
              addticket(ticket);
            }
            break;
        }
      },
      child: Container(
        height: 40.0,
        width: 30.0,
        decoration: BoxDecoration(
          color: isSelected ? kAccentColor : Color(0xFF5B7775),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
          ),
          border: Border.all(
            color: widget.isBooked ? kAccentColor : kLinesColor,
          ),
        ),
      ),
    );
  }
}
