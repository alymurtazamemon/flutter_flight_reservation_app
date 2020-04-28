import 'package:flutter/material.dart';
import 'package:flutter_flight_reservation_app/components/acronym_custom_text.dart';
import 'package:flutter_flight_reservation_app/components/active_info_custom_text.dart';
import 'package:flutter_flight_reservation_app/components/custom_floating_action_button.dart';
import 'package:flutter_flight_reservation_app/components/custom_horizontal_divider.dart';
import 'package:flutter_flight_reservation_app/components/custom_vertical_divider.dart';
import 'package:flutter_flight_reservation_app/components/emirates_logo.dart';
import 'package:flutter_flight_reservation_app/components/inactive_into_custom_text.dart';
import 'package:flutter_flight_reservation_app/model/ticket_data.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import '../constants.dart';

class CheckoutTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String gateNumber = '${randomAlpha(1).toUpperCase()}${randomNumeric(1)}';
    var ticket = Provider.of<TicketData>(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      floatingActionButton: CustomFloatingActionButton(
        heroTag: 'checkout',
        icon: Icons.arrow_forward_ios,
        onPressed: () {
          ticket.addGateNumber(gateNumber);
          ticket.addTicket();
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 35.0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 5.0),
                    AcronymCustomText(
                        text: ticket.from.substring(0, 3).toUpperCase()),
                    SizedBox(height: 5.0),
                    ActiveInfoCustomText(text: ticket.from),
                    SizedBox(height: 50.0),
                    InactiveInfoCustomText(text: 'FLIGHT DATE'),
                    SizedBox(height: 5.0),
                    ActiveInfoCustomText(text: ticket.date),
                    SizedBox(height: 40.0),
                    InactiveInfoCustomText(text: 'BOARDING TIME'),
                    SizedBox(height: 5.0),
                    ActiveInfoCustomText(text: ticket.time),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    EmiratesLogo(),
                    Center(child: ActiveInfoCustomText(text: ticket.duration)),
                    SizedBox(height: 50.0),
                    InactiveInfoCustomText(text: 'GATE'),
                    SizedBox(height: 5.0),
                    ActiveInfoCustomText(text: gateNumber),
                    SizedBox(height: 53.0),
                    InactiveInfoCustomText(text: 'SEAT', height: 0.0),
                    DropdownButton<String>(
                      icon: Icon(null),
                      underline: SizedBox(),
                      dropdownColor: kPrimaryColor,
                      items: ticket.seatsList.map((String dropDownItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownItem,
                          child: Text(
                            dropDownItem,
                            style: TextStyle(
                              height: 0.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {},
                      value: ticket.seatsList[0],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(height: 5.0),
                    AcronymCustomText(
                        text: ticket.to.substring(0, 3).toUpperCase()),
                    SizedBox(height: 5.0),
                    ActiveInfoCustomText(text: ticket.to),
                    SizedBox(height: 50.0),
                    InactiveInfoCustomText(text: 'FLIGHT NO'),
                    SizedBox(height: 5.0),
                    ActiveInfoCustomText(text: ticket.flightNumber),
                    SizedBox(height: 40.0),
                    InactiveInfoCustomText(text: 'CLASS'),
                    SizedBox(height: 5.0),
                    ActiveInfoCustomText(text: ticket.bookingClass),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30.0),
            CustomHorizontalDivider(),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  '\$',
                  style: TextStyle(color: kAccentColor),
                ),
                Text(
                  '${ticket.price}.00',
                  style: TextStyle(color: kAccentColor, fontSize: 25.0),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              'Payment via',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            PaymentMethod(),
            SizedBox(height: 100.0),
          ],
        ),
      ),
    );
  }
}

class PaymentMethod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            PaymentButton(text: 'Credit'),
            CustomVerticalDivider(),
            PaymentButton(text: 'PayPal'),
            CustomVerticalDivider(),
            PaymentButton(text: 'Wallet'),
          ],
        ),
        CustomHorizontalDivider(),
      ],
    );
  }
}

class PaymentButton extends StatefulWidget {
  PaymentButton({@required this.text});
  final String text;

  @override
  _PaymentButtonState createState() => _PaymentButtonState();
}

class _PaymentButtonState extends State<PaymentButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Text(
        widget.text,
        style: TextStyle(
          color: isSelected ? kAccentColor : Colors.white,
        ),
      ),
    );
  }
}
