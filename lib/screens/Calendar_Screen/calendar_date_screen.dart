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
import 'calendar_item_screen.dart';

class DateScreen extends StatefulWidget {
  final User user;
  final User calendarowner;
  const DateScreen({Key key, this.user, this.calendarowner}) : super(key: key);
  @override
  DateScreenState createState() =>
      DateScreenState(user: user, calendarowner: calendarowner);
}

class DateScreenState extends State<DateScreen> {
  final User user;
  final User calendarowner;
  DateScreenState({Key key, this.user, this.calendarowner});
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  List<String> dateschosen = [];
  List<String> dates2chosen = [];
  List<String> monthschosen = [];
  String wholedate = '';
  String mcc;

  void addremovedate(String date) {
    bool ismonthyearfound = false;
    String currentmonth1 = '$_targetDateTime';
    String currentmonth2 = currentmonth1.substring(0, 8);
    String currentdate = '$date';
    String currentdate2 = currentdate.substring(0, 8);
    String currentdatee = '';

    if (currentdate2 == currentmonth2) {
      String currentdate3 = date.substring(8, 10);
      currentdatee = currentdate3;
      for (int i = 0; i < dateschosen.length; i++) {
        if (dateschosen[i] == currentdatee) {
          dateschosen.removeAt(i);
          return;
        }
      }
      dateschosen.add(currentdate3);
    }

    for (int i = 0; i < monthschosen.length; i++) {
      if (monthschosen[i].substring(0, 8) == currentdate2) {
        if (monthschosen[i].substring(7, 8) != '-') {
          monthschosen[i] = '${monthschosen[i]}$currentdatee';
        }
      }
      if (monthschosen[i] == currentdate2) {
        ismonthyearfound = true;
      }
    }

    if (ismonthyearfound == false) {
      monthschosen.add(currentdate2);
      for (int i = 0; i < monthschosen.length; i++) {
        if (monthschosen[i].substring(0, 8) == currentdate2) {
          monthschosen[i] = '${monthschosen[i]},$currentdatee';
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (date, events) {
        setState(() {
          String date1 = '$date';
          String date2 = date1.substring(0, 10);
          addremovedate('$date2');
        });
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
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                choosedatesst,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.023,
                  fontWeight: FontWeight.w600,
                  color: colordtmaintwo,
                ),
              ),
              Divider(
                color: colordtmaintwo,
              ),
            ],
          ),

          Container(
            margin: EdgeInsets.only(
              top: 10,
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
                if (dateschosen.isEmpty)
                  ElevatedButton(
                    child: Text(previousst),
                    onPressed: () {
                      setState(() {
                        dateschosen = [];
                        dates2chosen = [];
                        _targetDateTime = DateTime(
                            _targetDateTime.year, _targetDateTime.month - 1);
                        _currentMonth =
                            DateFormat.yMMM().format(_targetDateTime);
                      });
                    },
                  ),
                if (dateschosen.isEmpty)
                  ElevatedButton(
                    child: Text(nextst),
                    onPressed: () {
                      dateschosen = [];
                      dates2chosen = [];
                      setState(() {
                        _targetDateTime = DateTime(
                            _targetDateTime.year, _targetDateTime.month + 1);
                        _currentMonth =
                            DateFormat.yMMM().format(_targetDateTime);
                      });
                    },
                  )
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: _calendarCarouselNoHeader,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$chosendatesst : $dateschosen',
                style: TextStyle(fontSize: 22),
              )
            ],
          ),

          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.07,
                child: ElevatedButton(
                  child: Text(
                    nextst,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                  onPressed: () {
                    String mny = monthschosen[0].substring(0, 7);
                    String days = monthschosen[0].substring(9);
                    wholedate = '$mny-$days';
                    dates2chosen.add(wholedate);
                    dateschosenmain = dates2chosen;
                    print(dateschosenmain);
                    print('${calendarowner.id} ${user.id}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ItemScreen(
                            user: user,
                            ischosing: true,
                            calendarowner: calendarowner),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 100),
            ],
          ),

          //
        ],
      ),
    ));
  }
}
