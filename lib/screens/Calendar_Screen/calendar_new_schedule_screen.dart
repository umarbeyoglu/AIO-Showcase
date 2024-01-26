import 'package:untitled/repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/Article_Model/article_model.dart';
import '../../models/User_Model/user_model.dart';


class Dates{
   String day;
   String month;
   String year;
   var datepass;
   List<String> days = [];
   List<String> times = [];

  Dates({this.day,this.datepass,this.days,this.times,this.month,this.year});
}


class ScheduleScreenNew extends StatefulWidget {
  final User user;
  final User calendarowner;
  final String itemname;
  final String itemlink;
  final Article item;
  const ScheduleScreenNew({Key key,this.user,this.item,this.calendarowner,
    this.itemname, this.itemlink}) : super(key : key);

  @override
  ScheduleScreenNewState createState() => ScheduleScreenNewState(user:user,itemlink:itemlink,calendarowner:calendarowner,item:item,itemname:itemname);
}

class ScheduleScreenNewState extends State<ScheduleScreenNew> {
  final User user;
  final User calendarowner;
  final String itemname;
  final String itemlink;
  final Article item;
  List<Dates> datess = [];
  String chosendate = '';
  String chosenday = '';
  String chosenmonth = '';
  List<String> daysfin = [];
  var daysbetween;
  ScheduleScreenNewState({Key key,this.user,this.item,this.calendarowner,this.itemname,this.itemlink});

  bool isstockdone(String time){
    int count = 0;
    for(int i=0;i<calendarowner.calendarschedules.length;i++){

      if(calendarowner.calendarschedules[i].date == chosenday
          && calendarowner.calendarschedules[i].time == time
          && itemname == calendarowner.calendarschedules[i].item
      ){}
      if(  itemname == calendarowner.calendarschedules[i].item
      ){}

      if(calendarowner.calendarschedules[i].date == chosenday
          && calendarowner.calendarschedules[i].time == time
          && itemname == calendarowner.calendarschedules[i].item
      ){
        count = count +1;
        if(count >= item.stock){return true;}
      }
    }
    if(count >= item.stock){return true;}
  return false;
  }

  String monthfunc(String month){
    if(month == '01' &&languagest == 'EN'){return 'Jan';}
    if(month == '02'&&languagest == 'EN'){return 'Feb';}
    if(month == '03'&&languagest == 'EN'){return 'Mar';}
    if(month == '04'&&languagest == 'EN'){return 'Apr';}
    if(month == '05'&&languagest == 'EN'){return 'May';}
    if(month == '06'&&languagest == 'EN'){return 'Jun';}
    if(month == '07'&&languagest == 'EN'){return 'Jul';}
    if(month == '08'&&languagest == 'EN'){return 'Aug';}
    if(month == '09'&&languagest == 'EN'){return 'Sep';}
    if(month == '10'&&languagest == 'EN'){return 'Oct';}
    if(month == '11'&&languagest == 'EN'){return 'Nov';}
    if(month == '12'&&languagest == 'EN'){return 'Dec';}

    if(month == '01' &&languagest == 'TR'){return 'Oca';}
    if(month == '02'&&languagest == 'TR'){return 'Şub';}
    if(month == '03'&&languagest == 'TR'){return 'Mar';}
    if(month == '04'&&languagest == 'TR'){return 'Nis';}
    if(month == '05'&&languagest == 'TR'){return 'May';}
    if(month == '06'&&languagest == 'TR'){return 'Haz';}
    if(month == '07'&&languagest == 'TR'){return 'Tem';}
    if(month == '08'&&languagest == 'TR'){return 'Ağu';}
    if(month == '09'&&languagest == 'TR'){return 'Eyl';}
    if(month == '10'&&languagest == 'TR'){return 'Eki';}
    if(month == '11'&&languagest == 'TR'){return 'Kas';}
    if(month == '12'&&languagest == 'TR'){return 'Ara';}

  }

  String daysinbetween(String startdate,String enddate){
    final startdate2 = DateTime(int.parse(startdate.substring(0,4)),
        int.parse(startdate.substring(5,7)),
        int.parse(startdate.substring(8,10)));
    final enddate2 = DateTime(int.parse(enddate.substring(0,4)),
        int.parse(enddate.substring(5,7)),
        int.parse(enddate.substring(8,10)));

    return enddate2.difference(startdate2).inDays.toString();

  }

  void initState(){

    for(int i=0;i<calendarowner.calendarstatuses.length;i++){
      List<String> items = calendarowner.calendarstatuses[i].items.split(',');
      for(int i8 = 0;i8<items.length;i8++){
        if(items[i8] == itemname){
          String daysinit = calendarowner.calendarstatuses[i].dates;
          List<String> times = calendarowner.calendarstatuses[i].times.split(',');
          List<String> days2 = calendarowner.calendarstatuses[i].dates.split(',');
          daysfin = daysinit.split(',');
          for(int iday=0;iday<days2.length;iday++){
          List<String> initd = days2[iday].split('-');
          datess.add(Dates(
            days:daysinit.split(','),
              times:times,
              year: initd[0],
              month:initd[1],
              day:initd[2],
            datepass: daysinbetween(DateNow(),days2[iday]),
          ));
          for(final item in datess) print('${item.day} ${item.datepass}');

          }

        }
      }
    }


    for(int i=0;i<datess.length;i++){
      datess[i].times.toSet().toList();
      if(int.parse(datess[i].datepass) <= 0){datess.removeAt(i);}
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height:60),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:  Row(
                children: <Widget> [
                  for(final item in datess)
                    InkWell(
                        child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Container(
          width: 50.0,
          height: 100.0,
          decoration: BoxDecoration(
              color:  Colors.white ,
              borderRadius: BorderRadius.circular(15.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if(item.day != null)  Text(item.day,
                  style: TextStyle(
                      color:  Colors.blue,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold)),
              if(item.month != null) Text(
                monthfunc(item.month).toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if(item.year != null)  Text(
                item.year.toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
                        onTap:(){
                          setState(() {
                            chosenday = '${item.year}-${item.month}-${item.day}';
                            chosendate = item.days.toString();
                            chosenmonth = item.month;
                          });
                        }
                    ),

                ],
              ),
            ),
            Wrap(
              children: <Widget>[

                for(final item in datess)
                  for(final i2 in item.times)
                    if(isstockdone(i2) == false && chosendate == item.days.toString() && chosenmonth == item.month)
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          CreateCalendarScheduleRequest(user.id,calendarowner.id, itemname, chosendate, i2,itemlink);
                        Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(15.0),
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black ),),
                          child: Column(
                            children: <Widget>[
                              Text(
                                i2,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),

              ],
            ),
            ],
        ),
      ),
    );
  }
}



