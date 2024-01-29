import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:intl/intl.dart' show DateFormat;

import '../../colors.dart';
import '../../language.dart';
import '../../models/User_Model/user_model.dart';
import '../../repository.dart';
import '../General/profile_search_screen.dart';

String event1 = '';
String event2 = '';
String event3 = '';

class Calendar extends StatefulWidget {
  final User user;
  final bool issearch;
  final User calendarowner;
  Calendar({Key key, this.user, this.issearch, this.calendarowner})
      : super(key: key);
  @override
  CalendarS createState() => new CalendarS(
      issearch: issearch, user: user, calendarowner: calendarowner);
}

class CalendarS extends State<Calendar> {
  final User user;
  final User calendarowner;
  bool issearch;
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  CalendarS({Key key, this.user, this.issearch, this.calendarowner});
  String date2a = '';
  String mnyia = '';
  bool lol = false;

  @override
  void initState() {
    if (issearch == null) {
      issearch = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (date, events) {
        String date1 = '$date';
        dcmr = date1.substring(0, 10);
        String date2 = date1.substring(8, 10);
        date2a = date2;
        String mnyi = date1.substring(0, 7);
        mnyia = mnyi;

        event1 = date2;
        event2 = mnyi;
        event3 = dcmr;
        // ignore: unnecessary_statements

        if (issearch) {
          searchdate = date2;
          searchmny = mnyi;
          Navigator.pop(context);
        }
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.black,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      dayButtonColor: Colors.white,
//      firstDayOfWeek: 4,
      height: 420.0,

      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: Colors.yellow)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: colordtmainthree,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: colordtmainthree,
      ),
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return Scaffold(
        backgroundColor: colordtmainone,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),
              calendarowner.calendar_type == 'calendartype2'
                  ? Row()
                  : Container(
                      margin: EdgeInsets.only(
                        top: 30.0,
                        bottom: 16.0,
                        left: 16.0,
                        right: 16.0,
                      ),
                      child: new Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                            _currentMonth,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                            ),
                          )),
                          ElevatedButton(
                            child: Text(
                              previousst,
                              style: TextStyle(
                                color: colordtmaintwo,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _targetDateTime = DateTime(_targetDateTime.year,
                                    _targetDateTime.month - 1);
                                _currentMonth =
                                    DateFormat.yMMM().format(_targetDateTime);
                              });
                            },
                          ),
                          ElevatedButton(
                            child: Text(
                              nextst,
                              style: TextStyle(
                                color: colordtmaintwo,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _targetDateTime = DateTime(_targetDateTime.year,
                                    _targetDateTime.month + 1);
                                _currentMonth =
                                    DateFormat.yMMM().format(_targetDateTime);
                              });
                            },
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ));
  }
}
