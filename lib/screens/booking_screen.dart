import 'package:flutter/material.dart';
import 'package:flutter_flight_reservation_app/components/custom_textfields.dart';
import 'package:flutter_flight_reservation_app/constants.dart';

class Booking extends StatefulWidget {
  Booking(this.id, {this.routeData});
  final String id;
  final Function routeData;

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String date = 'DATE';

  @override
  void initState() {
    super.initState();
    if (widget.id == 'Roundtrip') {
      date = 'DEPARTURE DATE';
    }
  }

  Widget departureWidgetForRoundtrip() {
    if (widget.id == 'One Way' || widget.id == 'Multiple') {
      return SizedBox(
        height: 0.0,
      );
    }

    return Column(
      children: <Widget>[
        SizedBox(height: 25.0),
        CustomTextFields(
          icon: Icons.event_note,
          title: 'RETURN DATE',
        ),
      ],
    );
  }

  Widget anotherTicketOptionForMultipleBooking() {
    if (widget.id == 'One Way' || widget.id == 'Roundtrip') {
      return SizedBox(
        height: 0.0,
      );
    }

    return Column(
      children: <Widget>[
        FlatButton(
          onPressed: () {},
          child: Text(
            '+ Add another flight',
            style: TextStyle(
              color: kAccentColor,
              fontSize: 20.0,
            ),
          ),
        ),
        SizedBox(
          height: 25.0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 25.0),
          CustomTextFields(
            icon: Icons.flight_takeoff,
            title: 'FROM',
            onChanged: (newValue) {},
          ),
          SizedBox(height: 25.0),
          CustomTextFields(
            icon: Icons.flight_land,
            title: 'TO',
            onChanged: (newValue) {},
          ),
          SizedBox(height: 25.0),
          CustomTextFields(
            icon: Icons.date_range,
            title: date,
            keyboardType: TextInputType.datetime,
            onChanged: (newValue) {},
          ),
          departureWidgetForRoundtrip(),
          SizedBox(height: 25.0),
          CustomTextFields(
            icon: Icons.people,
            title: 'TRAVELER',
            keyboardType: TextInputType.number,
            onChanged: (newValue) {},
          ),
          SizedBox(height: 25.0),
          CustomTextFields(
            icon: Icons.airline_seat_recline_extra,
            title: 'CLASS',
            hintText: 'Economy or Business',
            onChanged: (newValue) {},
          ),
          SizedBox(height: 25.0),
          anotherTicketOptionForMultipleBooking(),
        ],
      ),
    );
  }
}
