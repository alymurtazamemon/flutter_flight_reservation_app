import 'package:flutter/material.dart';
import 'package:flutter_flight_reservation_app/components/custom_appbar.dart';
import 'package:flutter_flight_reservation_app/constants.dart';
import 'package:flutter_flight_reservation_app/model/tab_controller_data.dart';
import 'package:flutter_flight_reservation_app/screens/checkout_tab_screen.dart';
import 'package:flutter_flight_reservation_app/screens/route_tab_screen.dart';
import 'package:flutter_flight_reservation_app/screens/seat_tab_screen.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:provider/provider.dart';
import 'flight_tab_screen.dart';

class TabsScreen extends StatelessWidget {
  static const String id = 'tabs_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CustomAppBar(
              title: 'Add flight',
              navigatorIcon: Icons.clear,
              onIconClick: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: CustomTabbar(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTabbar extends StatefulWidget {
  @override
  _CustomTabbarState createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    /*
    animate to next tab by getting index from TabControllerData class,
    The index will be incremented by each tab.
    */
    _tabController.animateTo(Provider.of<TabControllerData>(context).tabIndex);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          //This is responsible for the background of the tabbar, does the magic
          decoration: BoxDecoration(
              //This is for background color
              color: kLinesColor.withOpacity(0.0),
              //This is for bottom border that is needed
              border:
                  Border(bottom: BorderSide(color: kLinesColor, width: 0.8))),

          child: Center(
            child: IgnorePointer(
              child: TabBar(
                controller: _tabController,
                labelColor: kAccentColor,
                unselectedLabelColor: kInactiveTextColor,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: MD2Indicator(
                    //it begins here
                    indicatorHeight: 3,
                    indicatorColor: kAccentColor,
                    indicatorSize: MD2IndicatorSize
                        .normal //3 different modes tiny-normal-full
                    ),
                labelPadding: EdgeInsets.symmetric(horizontal: 24.0),
                tabs: [
                  Tab(text: 'Route'),
                  Tab(text: 'Flight'),
                  Tab(text: 'Seat'),
                  Tab(text: 'Checkout'),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: new TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: <Widget>[
                RouteTabScreen(),
                FlightTabScreen(),
                SeatTabScreen(),
                CheckoutTabScreen(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
