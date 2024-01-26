import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel, EventList;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:Welpie/models/User_Model/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:Welpie/language.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter/cupertino.dart';
import '../../colors.dart';
import 'package:Welpie/repository.dart';
import 'package:Welpie/models/Article_Model/article_tag_model.dart';
import 'package:intl/intl.dart';
import '../../models/Article_Model/article_model.dart';
import '../../models/User_Model/user_calendar_schedule_model.dart';
import '../../repository.dart';
import '../Calendar_Screen/calendar_schedule_screen.dart';
import '../Visited_Profile_Screen/visited_profile_screen.dart';

const SERVER_IP = 'https://welpie.net';
List<String> dateschosenmain = [];
List<String> timeschosenmain = [];
String tcmf = '';
String icmf = '';
String reservation1 = '';
String reservation2 = '';
String reservation3 = '';
List<ArticleTag> tagsss = [];

class ReservationScheduleScreen extends StatefulWidget {
  final User user;
  final User calendarowner;
  final Article reservation;
  ReservationScheduleScreen({Key key,this.user,this.reservation,this.calendarowner}) : super(key: key);
  @override
  ReservationScheduleScreenS createState() => new ReservationScheduleScreenS(user:user,reservation:reservation,calendarowner:calendarowner);
}

class ReservationScheduleScreenS extends State<ReservationScheduleScreen> {
  final User user;
  final User calendarowner;
  final Article reservation;
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  ReservationScheduleScreenS({Key key, this.user,this.reservation,this.calendarowner});
  String date2a = '';
  String mnyia = '';
  bool lol = false;
  String startdate = '';
  String enddate = '';
  String error = '';

  List<String> scheduleddays = [];
  List<String> deactivateddays = [];
  dynamic daysbetween;
  EventList<Event> _markedDateMap = new EventList<Event>(events: Map());

  bool isstockdone(List<String> chosendays){
    int count = 0;

    for(int i=0;i<scheduleddays.length;i++){
      if(chosendays.contains(scheduleddays[i]) ){
        count = count +1;
        if(count >= reservation.stock){return true;}
      }
    }
    if(count >= reservation.stock){return true;}
    return false;
  }

  bool isconflictingdays(){
    List<String> chosendays = datesinbetween(startdate,enddate);
    if(isstockdone(chosendays)){return true;}

    for(int i=0;i<deactivateddays.length;i++){
      if(chosendays.contains(deactivateddays[i])){
        return true;
      }
    }
    return false;
  }


  void daysinbetween(String startdate,String enddate){
    final startdate2 = DateTime(int.parse(startdate.substring(0,4)),
        int.parse(startdate.substring(5,7)),
        int.parse(startdate.substring(8,10)));
    final enddate2 = DateTime(int.parse(enddate.substring(0,4)),
        int.parse(enddate.substring(5,7)),
        int.parse(enddate.substring(8,10)));

    daysbetween = enddate2.difference(startdate2).inDays;
    return;
  }
  List<String> datesinbetween(String startdate,String enddate){
    List<String> dates = [];
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");

    List<DateTime> getDays({
      DateTime start,
      DateTime end
    }) {
      final days = end.difference(start).inDays;

      return [
        for (int i = 0; i < days; i++)
          start.add(Duration(days: i))
      ];
    }

    List<DateTime> days = getDays(
      start: DateTime.parse(startdate),
      end: DateTime.parse(enddate),
    );

    for(final item in days){
      String string = dateFormat.format(item);
      dates.add(string);
    }
    return dates;
  }

  bool isdayactive(String date){
    for(int i=0;i<scheduleddays.length;i++){
      if(scheduleddays[i] == date){return false;}
    }
    for(int i=0;i<deactivateddays.length;i++){
      if(deactivateddays[i] == date){return false;}
    }
    return true;
    }



  @override
  void initState() {

    for(int i=0;i<calendarowner.reservationdeactivationmonths.length;i++)
    {
      deactivateddays.addAll(datesinbetween(calendarowner.reservationdeactivationmonths[i].startdate,
          calendarowner.reservationdeactivationmonths[i].enddate));
    }
    for(int i=0;i<calendarowner.reservationschedules.length;i++) {
      if(calendarowner.reservationschedules[i].reservation == reservation.id){
        scheduleddays.addAll(datesinbetween(calendarowner.reservationschedules[i].startdate,
            calendarowner.reservationschedules[i].enddate));
      }
    }
    for(final item in scheduleddays){
      _markedDateMap.add(
          DateTime(int.parse(item.substring(0,4)),int.parse(item.substring(5,7)),int.parse(item.substring(8,10))),
          Event(
            date: DateTime(int.parse(item.substring(0,4)),int.parse(item.substring(5,7)),int.parse(item.substring(8,10))),
            title: 'Full',
          ));
    }
    for(final item in deactivateddays){
      _markedDateMap.add(
          DateTime(int.parse(item.substring(0,4)),int.parse(item.substring(5,7)),int.parse(item.substring(8,10))),
          Event(
            date: DateTime(int.parse(item.substring(0,4)),int.parse(item.substring(5,7)),int.parse(item.substring(8,10))),
            title: 'Full',
          ));
    }


    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    int yearnew;
    int monthnew;
    int daynew;
    int year;
    int month;
    int day ;


    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (date, events) {
       setState(() {
         if(date.toString() == startdate){

           startdate = '';error = '';
           if(startdate != ''&&enddate != ''&&isconflictingdays()){
             startdate = '';
             enddate = '';
             error = '$daysareunavailablest 1';
             return;
           }return;
         }
         if(date.toString() == enddate){
           print('2');
           enddate = '';error = '';
           if(startdate != ''&&enddate != ''&&isconflictingdays()){
             startdate = '';
             enddate = '';
             error = '$daysareunavailablest 2';
             return;
           }return;
         }
         if(startdate == ''){

           startdate = date.toString();error = '';
           if(startdate != ''&&enddate != '' &&isconflictingdays()){
             startdate = '';
             enddate = '';
             error = '$daysareunavailablest 3';
             return;
           }return;
         }
         if(enddate != ''){
            yearnew = int.parse(enddate.toString().substring(0,4));
            monthnew = int.parse(enddate.toString().substring(5,7));
            daynew = int.parse(enddate.toString().substring(8,10));
            year = int.parse(startdate.toString().substring(0,4));
            month = int.parse(startdate.toString().substring(5,7));
            day = int.parse(startdate.toString().substring(8,10));
            if(yearnew > year){
              error = 'ERROR/HATA';    if(startdate != ''&&enddate != ''&&isconflictingdays()){
                startdate = '';
                enddate = '';
                error = '$daysareunavailablest 4';
                return;
              }return;
            }
            if(year == yearnew && monthnew > month){error = 'ERROR/HATA';  if(startdate != ''&&enddate != ''&&isconflictingdays()){
              startdate = '';
              enddate = '';
              error = '$daysareunavailablest 5';
              return;
            }return;}
            if(year == year && monthnew == month && daynew > day){error = 'ERROR/HATA';  if(startdate != ''&&enddate != ''&&isconflictingdays()){
              startdate = '';
              enddate = '';
              error = '$daysareunavailablest 6';
              return;
            }return;}
         }

         if(startdate != '' && enddate != ''){
           enddate = date.toString();error = '';  if(startdate != ''&&enddate != ''&&isconflictingdays()){
             startdate = '';
             enddate = '';
             error = '$daysareunavailablest 7';
             return;
           }return;
         }
         if(startdate != '' && enddate == ''){
           enddate = date.toString();
           error = '';
          return;
         }
         if(startdate != ''&&enddate != ''&&isconflictingdays()){
           startdate = '';
           enddate = '';
           error = '$daysareunavailablest 8';
           return;
         }
         if(startdate != '' && enddate != ''){
           enddate = date.toString();error = '';
           if(startdate != ''&&enddate != ''&&isconflictingdays()){
             startdate = '';
             enddate = '';
             error = '$daysareunavailablest 9';
             return;
           }return;
         }
       });

      },

      dayButtonColor: Colors.white,//filter here
      daysHaveCircularBorder: true,
      markedDatesMap: _markedDateMap,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(color:colordtmaintwo),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),


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
      prevDaysTextStyle: TextStyle(fontSize: 16, color: Colors.pinkAccent,),

      onCalendarChanged: (DateTime date) {this.setState(() {_targetDateTime = date;_currentMonth = DateFormat.yMMM().format(_targetDateTime);});},

    );
    return Scaffold(
        backgroundColor: colordtmainone,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height:40),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(choosedatesst,style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height*0.023,
                    fontWeight: FontWeight.w600, color: colordtmaintwo,),),
                  Divider(color: colordtmaintwo,),
                ],
              ),
              SizedBox(height:50),
              Container(
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
                      child: Text(previousst,style: TextStyle(       color: colordtmaintwo,),),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(
                              _targetDateTime.year, _targetDateTime.month - 1);
                          _currentMonth =
                              DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                    ),
                    ElevatedButton(
                      child: Text(nextst,style: TextStyle(       color: colordtmaintwo,),),
                      onPressed: () {
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
            if(error != '') Row(
    mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(error,
                      style:TextStyle(color: Colors.black,fontSize: MediaQuery
                          .of(context)
                          .size
                          .height * 0.03,fontWeight: FontWeight.bold, )
                  ),
                ),
              ],
            ),
              if(error == '' && startdate != '' )  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('''$startdatest : ${startdate.substring(0,10)} \n'''
                    ,  style:TextStyle(color: Colors.black,fontSize: MediaQuery
                          .of(context)
                          .size
                          .height * 0.03,fontWeight: FontWeight.bold, )
                  ),
                ],
              ),
              if(error == '' &&  enddate != '')  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('''$enddatest : ${enddate.substring(0,10)}''',
                      style:TextStyle(color: Colors.black,fontSize: MediaQuery
                          .of(context)
                          .size
                          .height * 0.03,fontWeight: FontWeight.bold, )
                  ),
                ],
              ),
    SizedBox(height:50),
    if(error == '')InkWell(
                onTap: ()
                {
                  print(isconflictingdays());
                  if(startdate != ''&& enddate != '' && isconflictingdays() == false)
                  {
                    print('aa');
                    CreateReservationScheduleRequest(user.id, calendarowner.id, reservation.id, startdate.substring(0,10), enddate.substring(0,10));
                       Navigator.pop(context);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 200,
                      color: Colors.blue,
                      child: Center(
                        child: Text(finishst , style: TextStyle(color: Colors.white , fontSize: 20),),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height:200),
            ],
          ),
        ));
  }
}


class ReservationScheduleScreen2 extends StatefulWidget {
  final User user;

  ReservationScheduleScreen2({Key key,this.user,}) : super(key: key);
  @override
  ReservationScheduleScreen2S createState() => new ReservationScheduleScreen2S(user:user,);
}

class ReservationScheduleScreen2S extends State<ReservationScheduleScreen2> {
  final User user;

  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  ReservationScheduleScreen2S({Key key, this.user});
  String date2a = '';
  String mnyia = '';
  bool lol = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (date, events) {
        String date1 = '$date';
        dcmr = date1.substring(0,10);
        String date2 = date1.substring(8,10);
        date2a = date2;
        String mnyi = date1.substring(0,7);
        mnyia = mnyi;

        event1 = date2;
        event2 = mnyi;
        event3 = dcmr;
        Navigator.push(context, MaterialPageRoute(builder: (_) => ScheduleScreen(user: user,  day: date2, mnyinit: mnyi),),);


      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
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
      prevDaysTextStyle: TextStyle(fontSize: 16, color: Colors.pinkAccent,),
      inactiveDaysTextStyle: TextStyle(color: Colors.tealAccent, fontSize: 16,),
      onCalendarChanged: (DateTime date) {this.setState(() {_targetDateTime = date;_currentMonth = DateFormat.yMMM().format(_targetDateTime);});},
      onDayLongPressed: (DateTime date) {print('long pressed date $date');},
    );

    return Scaffold(
        backgroundColor: colordtmainone,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              SizedBox(height:50),
              Container(
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
                      child: Text(previousst,style: TextStyle(       color: colordtmaintwo,),),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(
                              _targetDateTime.year, _targetDateTime.month - 1);
                          _currentMonth =
                              DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                    ),
                    ElevatedButton(
                      child: Text(nextst,style: TextStyle(       color: colordtmaintwo,),),
                      onPressed: () {
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
              //
            ],
          ),
        ));
  }
}

class ScheduleScreen extends StatefulWidget {
  final User user;
  final String day;
  final String mnyinit;
  const ScheduleScreen({Key key,this.user,this.day,this.mnyinit}) : super(key: key);
  @override
  ScheduleScreenState createState() => ScheduleScreenState(user:user,mnyinit:mnyinit,day:day);
}

class ScheduleScreenState extends State<ScheduleScreen> {
  final User user;
  ScheduleScreenState({Key key, this.user,this.day,this.mnyinit});
  List<String> items = [];
  final String day;
  final String mnyinit;
  ScrollController _scrollController = ScrollController();



  @override
  void initState() {


  }

  bool doesitembelongtoschedule(ReservationSchedule ReservationSchedule){
    String mny = ReservationSchedule.startdate.substring(0,7);
    String dayinit = ReservationSchedule.startdate.substring(8);
    if(mnyinit == mny){
      if(dayinit == day){
        return true;
      }
    }
    return false;
  }

  Future<User> callUser(String userid) async {
    Future<User> _user = FetchUser(userid);
    return _user;
  }


  @override

  Widget build(BuildContext context) {
    print(user.reservationschedules.length);
    return Scaffold(

      body:  ListView.builder(
          shrinkWrap: true,
          itemCount: user.reservationschedules.length,
          physics: ClampingScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (context,index){
            return doesitembelongtoschedule(user.reservationschedules[index]) ?  FutureBuilder<User>(
                future: callUser(user.reservationschedules[index].profile),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData ? Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.008),
                    child: ListTile(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                VisitedProfileScreen(
                                  user: user,visiteduserid: '',
                                  visiteduser: snapshot.data,
                                ),
                          ),
                        );
                      },
                        title: Column(
                          children: [
                            Text('''${snapshot.data.username.toString()} '''
                              ,style: TextStyle(
                                fontSize: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.03, color: colordtmaintwo,),),
                            Text('''$startdatest : ${user.reservationschedules[index].startdate.toString()} '''
                              ,style: TextStyle(
                                fontSize: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.03, color: colordtmaintwo,),),

                            Text('''$enddatest: ${user.reservationschedules[index].enddate.toString()} '''
                              ,style: TextStyle(
                                fontSize: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.03, color: colordtmaintwo,),),

                          ],
                        ),
                        trailing:IconButton(
                          icon: Icon(Icons.delete,color: colordtmaintwo,),
                          onPressed: (){
                            RemoveReservationSchedule(user.reservationschedules[index].id);
                            Future.delayed(Duration(seconds: 1),()=>Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => super.widget)));
                            //required
                            return true;
                          },
                        )),
                  ) :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
                }) : Container(height: 0,width: 0,);

          }),);
  }
}


class RDDStatusScreen extends StatefulWidget {
  final User user;
  const RDDStatusScreen({Key key, this.user}) : super(key: key);
  @override
  RDDStatusScreenState createState() => RDDStatusScreenState(user:user);
}

class RDDStatusScreenState extends State<RDDStatusScreen> {
  final User user;
  RDDStatusScreenState({Key key, this.user});
  int _column = 0;
  List<String> items = [];
  String itemchosen1 = '';
  final TextEditingController item= TextEditingController();
  ScrollController _scrollController = ScrollController();
  int page = 1;
  List<ReservationDeactivationMonth> posts = [];
  Future fetchPostsfuture;
  bool isLoading = false;

  @override
  void initState() {
    fetchPostsfuture = FetchOwnReservationDeactivationMonths(page);
  }

  String correctdatemny(String date){
    String year = date.toString().substring(0,4);
    String month = date.toString().substring(5,7);
    return '$month-$year';
  }

  String correctdatedays(String date){
    String days = date.toString().substring(8,date.length);
    return days;
  }

  Future _loadData() async {
    List<ReservationDeactivationMonth> postsinit = [];
    postsinit = await FetchOwnReservationDeactivationMonths(page+1);
    setState(() {
      page = page +1;
      for(final item2 in postsinit)
        isLoading = false;
      return;
    });
  }

  void ischosen(String itemchosen){
    for(int i=0;i<items.length;i++){
      if(items[i] == itemchosen){
        items.removeAt(i);
        return;
      }
    }
    items.add(itemchosen);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: colordtmainone,
        leading:  IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 30.0,
          color: colordtmaintwo,
          onPressed: () {
            Navigator.pop(context,true);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            iconSize: 30.0,
            color: colordtmaintwo,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReservationDeactDayScreen(
                    user: user,
                  ),
                ),
              );
            },
          ),

        ],
      ),
      backgroundColor: colordtmainone,



      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading && scrollInfo.metrics.pixels ==
              scrollInfo.metrics.maxScrollExtent) {
            _loadData();
            setState(() {isLoading = true;});
            return true;
          }},
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height:10),
                  Text(calendarstatusexpst,style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height*0.019,
                    fontWeight: FontWeight.w600, color: colordtmaintwo,),),
                  Divider(color: colordtmaintwo,),
                  Text(calendarstatuswarningst,style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height*0.019,
                    fontWeight: FontWeight.w600, color: colordtmaintwo,),),
                  Column(children: [
                    Divider(color: colordtmaintwo,),
                    FutureBuilder<List<ReservationDeactivationMonth>>(
                      future: fetchPostsfuture,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                        posts = snapshot.data;
                        return snapshot.hasData ?
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: posts.length,
                            physics: ClampingScrollPhysics(),
                            controller: _scrollController,
                            itemBuilder: (context,index){
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                        '''$startdatest:${posts[index].startdate.toString().substring(0,10)}  \n'''
                                        '''\n'''
                                        '''$enddatest:${posts[index].enddate.toString().substring(0,10)}  \n'''
                                      ,style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.height*0.03,
                                        fontWeight: FontWeight.w600, color: colordtmaintwo,),),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete,color: colordtmaintwo,),
                                      onPressed: (){
                                        RemoveDeactivationMonth(posts[index].id);
                                        Future.delayed(Duration(seconds: 1),()=>           Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext context) => super.widget)));
                                      },
                                    ),





                                  ),
                                  Divider(color: colordtmaintwo,),
                                ],
                              );

                            }) : Center(
                          child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                          ),);},),

                  ],),



                ]
            )],),),);
  }
}

class ReservationDeactDayScreen extends StatefulWidget {
  final User user;
  ReservationDeactDayScreen({Key key,this.user,}) : super(key: key);
  @override
  ReservationDeactDayScreenS createState() => new ReservationDeactDayScreenS(user:user,);
}

class ReservationDeactDayScreenS extends State<ReservationDeactDayScreen> {
  final User user;
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  ReservationDeactDayScreenS({Key key, this.user});
  String error = '';
  String startdate = '';
  String enddate = '';



  @override
  void initState() {

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    int yearnew;
    int monthnew;
    int daynew;
    int year;
    int month;
    int day ;


    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (date, events) {
        setState(() {
          if(date.toString() == startdate){
            startdate = '';
            if(startdate != ''&&enddate != ''){
              startdate = '';
              enddate = '';
              error = '3';
              return;
            }return;
          }
          if(date.toString() == enddate){
            enddate = '';error = '';
            if(startdate != ''&&enddate != ''){
              startdate = '';
              enddate = '';
              error = '2';
              return;
            }return;
          }
          if(startdate == ''){
            startdate = date.toString();error = '';
            if(startdate != ''&&enddate != ''){
              startdate = '';
              enddate = '';
              error = '1';
              return;
            }return;
          }
          if(enddate != ''){
            yearnew = int.parse(enddate.toString().substring(0,4));
            monthnew = int.parse(enddate.toString().substring(5,7));
            daynew = int.parse(enddate.toString().substring(8,10));
            year = int.parse(startdate.toString().substring(0,4));
            month = int.parse(startdate.toString().substring(5,7));
            day = int.parse(startdate.toString().substring(8,10));
            if(yearnew > year){
              error = 'ERROR/HATA';    if(startdate != ''&&enddate != ''){
                startdate = '';
                enddate = '';
                error = '4';
                return;
              }return;
            }
            if(year == yearnew && monthnew > month){error = 'ERROR/HATA';  if(startdate != ''&&enddate != ''){
              startdate = '';
              enddate = '';
              error = '5';
              return;
            }return;}
            if(year == year && monthnew == month && daynew > day){error = 'ERROR/HATA';  if(startdate != ''&&enddate != ''){
              startdate = '';
              enddate = '';
              error = '6';
              return;
            }return;}
          }
          if(startdate != '' && enddate == ''){
            enddate = date.toString();

          }

        });

      },

      dayButtonColor: Colors.white,//filter here
      daysHaveCircularBorder: true,

      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(color:colordtmaintwo),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),


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
      prevDaysTextStyle: TextStyle(fontSize: 16, color: Colors.pinkAccent,),

      onCalendarChanged: (DateTime date) {this.setState(() {_targetDateTime = date;_currentMonth = DateFormat.yMMM().format(_targetDateTime);});},

    );
    return Scaffold(
        backgroundColor: colordtmainone,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height:40),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(choosedatesst,style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height*0.023,
                    fontWeight: FontWeight.w600, color: colordtmaintwo,),),
                  Divider(color: colordtmaintwo,),
                ],
              ),
              SizedBox(height:50),
              Container(
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
                      child: Text(previousst,style: TextStyle(       color: colordtmaintwo,),),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(
                              _targetDateTime.year, _targetDateTime.month - 1);
                          _currentMonth =
                              DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                    ),
                    ElevatedButton(
                      child: Text(nextst,style: TextStyle(       color: colordtmaintwo,),),
                      onPressed: () {
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
              if(error != '') Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(error,
                        style:TextStyle(color: Colors.black,fontSize: MediaQuery
                            .of(context)
                            .size
                            .height * 0.03,fontWeight: FontWeight.bold, )
                    ),
                  ),
                ],
              ),
              if(error == '' && startdate != '' )  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('''$startdatest : ${startdate.substring(0,10)} \n'''
                      ,  style:TextStyle(color: Colors.black,fontSize: MediaQuery
                          .of(context)
                          .size
                          .height * 0.03,fontWeight: FontWeight.bold, )
                  ),
                ],
              ),
              if(error == '' &&  enddate != '')  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('''$enddatest : ${enddate.substring(0,10)}''',
                      style:TextStyle(color: Colors.black,fontSize: MediaQuery
                          .of(context)
                          .size
                          .height * 0.03,fontWeight: FontWeight.bold, )
                  ),
                ],
              ),
              SizedBox(height:50),
              if(error == '')InkWell(
                onTap: ()
                {
                  if(startdate != ''&& enddate != '')
                  {
                     CreateReservationDeactivationMonth(user.id, startdate, enddate);
                    Navigator.pop(context);

                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 200,
                      color: Colors.blue,
                      child: Center(
                        child: Text(finishst , style: TextStyle(color: Colors.white , fontSize: 20),),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ));
  }
}



