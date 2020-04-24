import 'dart:math';
import 'package:flutter_flight_reservation_app/model/tab_controller_data.dart';
import 'package:flutter_flight_reservation_app/model/ticket_data.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flight_reservation_app/components/custom_horizontal_divider.dart';
import 'package:flutter_flight_reservation_app/constants.dart';

class FlightTabScreen extends StatelessWidget {
  FlightTabScreen({this.toggleTab});
  final Function toggleTab;
  final int randomNumber = Random().nextInt(15) + 1;

  @override
  Widget build(BuildContext context) {
    var ticket = Provider.of<TicketData>(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0),
            child: Text(
              '$randomNumber Emirates flights avaliable from ${ticket.from.substring(0, 3).toUpperCase()} to ${ticket.to.substring(0, 3).toUpperCase()}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          TicketsList(listLenght: randomNumber),
        ],
      ),
    );
  }
}

class TicketsList extends StatelessWidget {
  TicketsList({this.listLenght});
  final listLenght;

  @override
  Widget build(BuildContext context) {
    var ticket = Provider.of<TicketData>(context);
    String flightNo;
    String flightDuration;
    String flightTime;
    int price;
    List<FlightData> list = [];

    void generateFlightNo() {
      /*  
    this will generate two character randomly. like Kb or aS. 
    And UpperCase method will convert that into Capital letters. 
    */
      String twoCharacters = randomAlpha(2).toUpperCase();
      /* 
    this will generate two integer numbers between 10 and 99. 
    because we need two characters and two interger numbers for flightInfo.
    Ex: KB70 or HD39.
    */
      int twoNumbers = randomBetween(10, 99);
      flightNo = '$twoCharacters$twoNumbers';
    }

    /*
  Both tickDuration and ticketsTime are built on same logic only minor difference
  but we need time and duration different that's why we created seperate method. 
  */
    void generateFlightDuration() {
      //this will generate random number that we will count as a minutes.
      int timeInMinutes = randomBetween(30, 1440);
      //here seperate the total hours in random time divide by 60 and convert into integer.
      int hours = (timeInMinutes ~/ 60).toInt();
      //here after seperating the hours and seperate the remaining minutes from random total minutes.
      int minutes = timeInMinutes - (hours * 60);

      /*  
    we need minutes in two digit form
    so we check here if minutes are between 0 and 9,
    convert them to two digit form by adding zero in fornt of it
    like 0 equals to 00 and 9 equals to 09. 
    */
      String mints = '$minutes';
      if (minutes >= 0 && minutes < 10) {
        mints = '0$minutes';
      }

      flightDuration = '$hours h $mints m';
    }

    void generateFlightTime() {
      //this will generate random number that we will count as a minutes.
      int timeInMinutes = randomBetween(0, 1440);
      //here seperate the total hours in random time divide by 60 and convert into integer.
      int hours = (timeInMinutes ~/ 60).toInt();
      //here after seperating the hours and seperate the remaining minutes from random total minutes.
      int minutes = timeInMinutes - (hours * 60);
      String timePeriod = 'AM';
      /*  
    we need minutes in two digit form
    so we check here if minutes are between 0 and 9,
    convert them to two digit form by adding zero in fornt of it
    like 0 equals to 00 and 9 equals to 09. 
    */
      String mints = '$minutes';
      if (minutes >= 0 && minutes < 10) {
        mints = '0$minutes';
      }

      /*
      check if the hours are greater then 11 it means it is the second part of the day means PM.
      by default we set to AM, in case of hour equal to or less than 11.
    */
      if (hours > 11) {
        hours = hours - 12;
        timePeriod = 'PM';
      }

      flightTime = '$hours:$mints $timePeriod';
    }

    void generateFlightPrice() {
      price = randomBetween(100, 150);
    }

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            generateFlightNo();
            generateFlightDuration();
            generateFlightTime();
            generateFlightPrice();
            list.add(FlightData(
              flightNo: flightNo,
              flightDuration: flightDuration,
              flightTime: flightTime,
              price: price,
            ));
            return GestureDetector(
              onTap: () {
                var selectedTicket = list[index];
                Provider.of<TicketData>(context, listen: false).addflightData(
                  selectedTicket.flightNo,
                  selectedTicket.flightDuration,
                  selectedTicket.flightTime,
                  selectedTicket.price,
                );
                Provider.of<TabControllerData>(context, listen: false)
                    .incrmentIndex();
              },
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                            top: 20.0,
                            bottom: 30.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 5.0),
                                  AcronymCustomText(
                                      text: ticket.from
                                          .substring(0, 3)
                                          .toUpperCase()),
                                  SizedBox(height: 5.0),
                                  ActiveInfoCustomText(
                                    text: ticket.from,
                                    color: kDateTimeAndCitesColor,
                                  ),
                                  SizedBox(height: 30.0),
                                  InactiveInfoCustomText(text: 'DATE'),
                                  SizedBox(height: 5.0),
                                  ActiveInfoCustomText(
                                    text: ticket.date,
                                    color: kActiveColor,
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    height: 118.0,
                                    width: 50.0,
                                    child: Image(
                                        image: AssetImage('images/logo3.png')),
                                  ),
                                  ActiveInfoCustomText(
                                    text: '$flightDuration, $flightTime',
                                    color: kDateTimeAndCitesColor,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(height: 5.0),
                                  AcronymCustomText(
                                      text: ticket.to
                                          .substring(0, 3)
                                          .toUpperCase()),
                                  SizedBox(height: 5.0),
                                  ActiveInfoCustomText(
                                    text: ticket.to,
                                    color: kDateTimeAndCitesColor,
                                  ),
                                  SizedBox(height: 30.0),
                                  InactiveInfoCustomText(text: 'FLIGHT NO'),
                                  SizedBox(height: 5.0),
                                  ActiveInfoCustomText(
                                    text: '$flightNo',
                                    color: kActiveColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        CustomHorizontalDivider(),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height: 30.0,
                                width: 70.0,
                                child: Image(
                                  image: AssetImage('images/bottom_logos.png'),
                                ),
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'Ticket Price',
                                      style: TextStyle(
                                        color: kInactiveColor,
                                      ),
                                    ),
                                    SizedBox(width: 5.0),
                                    Text(
                                      '\$$price.00',
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        color: kActiveColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            );
          },
          itemCount: listLenght,
        ),
      ),
    );
  }
}

class FlightData {
  String flightNo;
  String flightDuration;
  String flightTime;
  int price;

  FlightData({this.flightNo, this.flightDuration, this.flightTime, this.price});
}

class DayAndDateRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(width: 20.0),
          DayAndDateContainer(day: 'MON', date: '15', check: false),
          SizedBox(width: 20.0),
          DayAndDateContainer(day: 'TUE', date: '16', check: false),
          SizedBox(width: 20.0),
          DayAndDateContainer(day: 'WED', date: '17', check: false),
          SizedBox(width: 20.0),
          DayAndDateContainer(day: 'THU', date: '18', check: false),
          SizedBox(width: 20.0),
          DayAndDateContainer(day: 'FRI', date: '19', check: true),
          SizedBox(width: 20.0),
          DayAndDateContainer(day: 'SAT', date: '20', check: false),
          SizedBox(width: 20.0),
          DayAndDateContainer(day: 'SUN', date: '21', check: false),
          SizedBox(width: 20.0),
        ],
      ),
    );
  }
}

class DayAndDateContainer extends StatelessWidget {
  DayAndDateContainer({@required this.date, @required this.day, this.check});
  final String day;
  final String date;
  final bool check;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
      decoration: BoxDecoration(
        color: check ? Color(0xFF3E5858) : kPrimaryColor,
        border: Border.all(
          color: check ? Color(0xFF3E5858) : kInactiveTextColor,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            day,
            style: TextStyle(
              color: check ? kAccentColor : kLinesColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            date,
            style: TextStyle(
              color: check ? kAccentColor : Colors.white,
              fontSize: check ? 30.0 : 20.0,
            ),
          ),
        ],
      ),
    );
  }
}

class InactiveInfoCustomText extends StatelessWidget {
  InactiveInfoCustomText({@required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: kInactiveColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class ActiveInfoCustomText extends StatelessWidget {
  ActiveInfoCustomText({@required this.text, this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class AcronymCustomText extends StatelessWidget {
  AcronymCustomText({@required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: kActiveColor,
        fontSize: 35.0,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
