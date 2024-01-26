import 'package:Welpie/repository.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:Welpie/models/User_Model/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../colors.dart';
import '../../language.dart';
import 'package:Welpie/models/User_Model/user_calendar_item_model.dart';
import 'package:Welpie/models/User_Model/user_calendar_schedule_model.dart';
import 'package:Welpie/language.dart';
import 'package:Welpie/screens/Visited_Profile_Screen/visited_profile_screen.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:intl/intl.dart' show DateFormat;
import 'package:Welpie/screens/Calendar_Screen/calendar_create_time_screen.dart';
import 'package:Welpie/screens/General/create_article_screen.dart';
import 'package:Welpie/screens/General/home_screen.dart';

import '../Calendar_Screen/calendar_time_screen.dart';


String event1 = '';
String event2 = '';
String event3 = '';

class StatusScreen extends StatefulWidget {
  final User user;
  const StatusScreen({Key key, this.user}) : super(key: key);
  @override
  StatusScreenState createState() => StatusScreenState(user:user);
}

class StatusScreenState extends State<StatusScreen> {
  final User user;
  StatusScreenState({Key key, this.user});
  int _column = 0;
  List<String> items = [];
  String itemchosen1 = '';
  final TextEditingController item= TextEditingController();
  ScrollController _scrollController = ScrollController();
  int page = 1;
  List<MeetingStatus> posts = [];
  Future fetchPostsfuture;
  bool isLoading = false;

  @override
  void initState() {
    fetchPostsfuture = FetchOwnMeetingStatus(http.Client(),user.id,page);
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
    List<MeetingStatus> postsinit = [];
    postsinit = await FetchOwnMeetingStatus(http.Client(),user.id,page+1);
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
                  builder: (_) => StatusDateChooseScreen(
                    user: user,
                    calendarowner:user,
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
          }},child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height:10),
                Text(meetingstatuswarningst,style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height*0.019,
                  fontWeight: FontWeight.w600, color: colordtmaintwo,),),
                Column(children: [
                  Divider(color: colordtmaintwo,),
                  FutureBuilder<List<MeetingStatus>>(
                    future: fetchPostsfuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print('error1');
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
                                  title: Text('''$daysst: ${correctdatedays(posts[index].dates).toString()} \n'''
                                      '''\n'''
                                      '''$monthandyearst: ${correctdatemny(posts[index].dates).toString()} \n'''
                                      '''\n'''
                                      '''$timesst:${posts[index].times.toString()}  \n'''
                                      '''\n'''

                                    ,style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height*0.03,
                                      fontWeight: FontWeight.w600, color: colordtmaintwo,),),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete,color: colordtmaintwo,),
                                    onPressed: (){
                                      RemoveMeetingStatus(posts[index].id);
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

class StatusDateChooseScreen extends StatefulWidget {
  final User user;
  final User calendarowner;
  const StatusDateChooseScreen({Key key, this.user,this.calendarowner}) : super(key: key);
  @override
  StatusDateChooseScreenState createState() => StatusDateChooseScreenState(user:user,calendarowner:calendarowner);
}

class StatusDateChooseScreenState extends State<StatusDateChooseScreen> {
  final User user;
  final User calendarowner;
  StatusDateChooseScreenState({Key key, this.user,this.calendarowner});
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  List<String> dateschosen = [];
  List<String> dates2chosen = [];
  List<String> monthschosen = [];
  String wholedate = '';
  String mcc ;

  void addremovedate(String date){
    bool ismonthyearfound = false;
    String currentmonth1 = '$_targetDateTime';
    String currentmonth2 = currentmonth1.substring(0,8);
    String currentdate = '$date';
    String currentdate2 = currentdate.substring(0,8);
    String currentdatee = '';

    if(currentdate2 == currentmonth2){
      String currentdate3 = date.substring(8,10);
      currentdatee = currentdate3;
      dateschosen.add(currentdate3);}
    for(int i=0;i<monthschosen.length;i++){
      if(monthschosen[i].substring(0,8) == currentdate2){
        if(monthschosen[i].substring(7,8) != '-'){
          monthschosen[i] = '${monthschosen[i]}$currentdatee';
        }}
      if(monthschosen[i] == currentdate2){
        ismonthyearfound = true;}}
    if(ismonthyearfound == false){
      monthschosen.add(currentdate2);
      for(int i=0;i<monthschosen.length;i++){
        if(monthschosen[i].substring(0,8) == currentdate2){
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
          String date2 = date1.substring(0,10);
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
      prevDaysTextStyle: TextStyle(fontSize: 16, color: Colors.pinkAccent,),
      inactiveDaysTextStyle: TextStyle(color: Colors.tealAccent, fontSize: 16,),
      onCalendarChanged: (DateTime date) {this.setState(() {_targetDateTime = date;_currentMonth = DateFormat.yMMM().format(_targetDateTime);});},
      onDayLongPressed: (DateTime date) {print('long pressed date $date');},
    );

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //custom icon
              // This trailing comma makes auto-formatting nicer for build methods.
              //custom icon without header
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
                    if(dateschosen != [])    ElevatedButton(
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
                    if(dateschosen != [])   ElevatedButton(
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
              Wrap(
                children: [
                  Text(calendardatewarningst,style: TextStyle(fontSize: 22,color: Colors.red),)
                ],
              ),
              SizedBox(height:20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$chosendatesst : $dateschosen',style: TextStyle(fontSize: 12),)
                ],
              ),

              SizedBox(height:20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(

                    width:MediaQuery.of(context).size.width*0.4, height:MediaQuery.of(context).size.height*0.07,
                    child: ElevatedButton(
                      child: Text(commitst, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                      onPressed: (){
                        String mny = monthschosen[0].substring(0,7);
                        String days = monthschosen[0].substring(9);
                        wholedate = '$mny-$days';
                        dates2chosen.add(wholedate);
                        dateschosenmain = dates2chosen;
                        print(dateschosenmain);
                        Navigator.push(context, MaterialPageRoute(builder: (_) => StatusTimeChooseScreen(user: user,
                        ),),);
                      },
                    ),),
                  SizedBox(height:100),
                ],
              ),

              //
            ],
          ),
        ));
  }
}

class StatusTimeChooseScreen extends StatefulWidget {
  final User user;
  const StatusTimeChooseScreen({Key key, this.user}) : super(key: key);
  @override
  StatusTimeChooseScreenState createState() => StatusTimeChooseScreenState(user:user);
}

class StatusTimeChooseScreenState extends State<StatusTimeChooseScreen> {
  final User user;
  StatusTimeChooseScreenState({Key key, this.user});
  List<String> times = [];
  List<User> _subusers = List<User>();
  List<User> _subusersForDisplay = List<User>();
  bool searching2 = false;
  var _textfield = TextEditingController();
  var _textfield2 = TextEditingController();
  ScrollController _scrollController = ScrollController();
  int page = 1;
  List<CalendarTime> posts = [];
  Future fetchPostsfuture;
  bool isLoading = false;

  @override
  void initState() {
    fetchPostsfuture = FetchOwnCalendarTime(http.Client(),user.id,page);



  }


  Future _loadData() async {
    List<CalendarTime> postsinit = [];
    postsinit = await FetchOwnCalendarTime(http.Client(),user.id,page);
    setState(() {
      for(final item2 in postsinit)
        posts.add(item2);
      isLoading = false;
      return;
    });
  }

  void ischosen(String timechosen){
    for(int i=0;i<times.length;i++){
      if(times[i] == timechosen){
        times.removeAt(i);
        return;
      }
    }
    times.add(timechosen);
    return;
  }

  ShowChosenItems(dynamic context){
    return showDialog(

      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [

          ],
          title: Text(chosenitemsst),

          content: Column(
            children:[

              for (final item in times)
                Padding(
                  padding:EdgeInsets.only(top:20),
                  child:    SizedBox(child: Text(item),),
                ),
            ],
          ),
        );
      },
    );

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
            icon: Icon(Icons.arrow_forward),
            iconSize: 30.0,
            color: colordtmaintwo,
            onPressed: () {
              setState(() {

                timeschosenmain = times;
                String icm = itemschosenmain.join(",");
                String tcm = timeschosenmain.join(",");
                icmf = icm;
                tcmf = tcm;

                CreateMeetingStatus(user.id,user,context);
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user: user)));
              });
            },
          ),

          IconButton(
            icon: Icon(Icons.reorder),
            iconSize: 30.0,
            color: colordtmaintwo,
            onPressed: () {
              ShowChosenItems(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            iconSize: 30.0,
            color: colordtmaintwo,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateCalendarTimeScreen(user: user))).then((value) {
                Future.delayed(Duration(seconds: 1),()=> Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => super.widget)));
              });
            },
          ),
        ],
      ),
      backgroundColor: colordtmainone,



      body:
      NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading && scrollInfo.metrics.pixels ==
              scrollInfo.metrics.maxScrollExtent) {
            page = page +1;
            _loadData();
            setState(() {isLoading = true;});
            return true;
          }},child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Container(

              child:
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(meetingstatuswarningst),
                    Column(children: [
                      FutureBuilder<List<CalendarTime>>(
                        future: fetchPostsfuture,

                        builder: (context, snapshot) {
                          if (snapshot.hasError) print('error1');
                          posts = snapshot.data;
                          return snapshot.hasData ?
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: posts.length,
                              physics: ClampingScrollPhysics(),
                              controller: _scrollController,
                              itemBuilder: (context,index){
                                return       Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.008),
                                  child: InkWell(
                                    child: ListTile(
                                      title:  Column(
                                        children: [
                                          Text('''$timest: ${posts[index].time.toString()} '''
                                            ,style: TextStyle(
                                              fontSize: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.03, color: colordtmaintwo,),),

                                        ],
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete,color: colordtmaintwo,),
                                        onPressed: (){
                                          RemoveCalendarTime(posts[index].id);
                                          Future.delayed(Duration(seconds: 1),()=>           Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext context) => super.widget)));
                                          //required
                                          return true;
                                        },
                                      ),





                                    ),
                                    onTap: (){
                                      ischosen(posts[index].time);
                                    },

                                  ),
                                );

                              }) : Center(
                            child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                            ),);},),

                    ],),






                  ]
              )
          ),],),),
    );
  }
}


class MeetingScheduleScreen extends StatefulWidget {
  final User user;

  MeetingScheduleScreen({Key key,this.user,}) : super(key: key);
  @override
  MeetingScheduleScreenS createState() => new MeetingScheduleScreenS(user:user,);
}

class MeetingScheduleScreenS extends State<MeetingScheduleScreen> {
  final User user;

  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  MeetingScheduleScreenS({Key key, this.user});
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

  bool doesitembelongtoschedule(MeetingSchedule MeetingSchedule){
    String mny = MeetingSchedule.date.substring(0,7);
    String dayinit = MeetingSchedule.date.substring(8);
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
    print(user.meetingschedules.length);
    return Scaffold(

      body:  ListView.builder(
          shrinkWrap: true,
          itemCount: user.meetingschedules.length,
          physics: ClampingScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (context,index){
            return doesitembelongtoschedule(user.meetingschedules[index]) ?  FutureBuilder<User>(
                future: callUser(user.meetingschedules[index].profile),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData ? Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.008),
                    child: ListTile(
                        title: Column(
                          children: [
                            Text('''${snapshot.data.username.toString()} '''
                              ,style: TextStyle(
                                fontSize: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.03, color: colordtmaintwo,),),
                            Text('''${user.meetingschedules[index].date.toString()} '''
                              ,style: TextStyle(
                                fontSize: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.03, color: colordtmaintwo,),),

                            Text('''$timest: ${user.meetingschedules[index].time.toString()} '''
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
                            RemoveMeetingSchedule(user.meetingschedules[index].id);
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

class MeetingScheduleDetailsScreen extends StatefulWidget {
  final MeetingSchedule calendaritem;
  final User user;
  final User client;
  const MeetingScheduleDetailsScreen({Key key,this.client,this.calendaritem,this.user,}) : super(key : key);

  @override
  MeetingScheduleDetailsScreenState createState() => MeetingScheduleDetailsScreenState(user : user,client:client,calendaritem : calendaritem);
}

class MeetingScheduleDetailsScreenState extends State<MeetingScheduleDetailsScreen> {
  final MeetingSchedule calendaritem;
  final User user;
  final User client;
  MeetingScheduleDetailsScreenState({Key key,this.client, this.calendaritem,this.user,});


  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: colordtmainone,
      body: Stack(
        children: <Widget>[

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colordtmainone,
                borderRadius: BorderRadius.only(
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:0.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return ListView(

                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[


                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[


                                    SizedBox(height: MediaQuery.of(context).size.height *0.03),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      iconSize: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.0413,
                                      color: colordtmaintwo,

                                    ),
                                    SizedBox(height:50),
                                    InkWell(
                                      child:    Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context).size.width* 0.043,
                                          vertical: 0,
                                        ),
                                        child: Text(
                                          '$clientst : ${client.username}',
                                          style: TextStyle(
                                            fontSize:  MediaQuery.of(context).size.width*0.043,
                                            color:colordtmaintwo,
                                            fontWeight: FontWeight.w500,

                                          ),
                                        ),
                                      ),
                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                VisitedProfileScreen(
                                                  user: user,visiteduserid: '',
                                                  visiteduser: client,
                                                ),
                                          ),
                                        );
                                      },
                                    ),

                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        '$timest ${calendaritem.time}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),



                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );

  }
}


class CalendarMeet extends StatefulWidget {
  final User user;
  final bool issearch;final User calendarowner;
  CalendarMeet({Key key,this.user,this.issearch,this.calendarowner}) : super(key: key);
  @override
  CalendarMeetS createState() => new CalendarMeetS(issearch:issearch,user:user,calendarowner:calendarowner);
}

class CalendarMeetS extends State<CalendarMeet> {
  final User user;
  final User calendarowner;
  bool issearch;
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  CalendarMeetS({Key key, this.user,this.issearch,this.calendarowner});
  String date2a = '';
  String mnyia = '';
  bool lol = false;


  @override
  void initState() {

    if( issearch == null){
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
        dcmr = date1.substring(0,10);
        String date2 = date1.substring(8,10);
        date2a = date2;
        String mnyi = date1.substring(0,7);
        mnyia = mnyi;

        event1 = date2;
        event2 = mnyi;
        event3 = dcmr;
        // ignore: unnecessary_statements
        print('going to');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TimeRequestScreen(
              user: user,calendarowner: calendarowner,day: date2, mnyinit: mnyi,
            ),
          ),
        );



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
                    calendarowner.id == user.id ?  IconButton(
                      icon:Icon(Icons.edit),
                      color: colordtmaintwo,
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => StatusScreen(
                              user: user,
                            ),
                          ),
                        );
                      },
                    ) : Container(height: 0,width: 0,),

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
                    ),


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

class TimeRequestScreen extends StatefulWidget {
  final User user;
  final User calendarowner;
  final String link;
  final String day;
  final bool issearch;
  final String mnyinit;
  const TimeRequestScreen({Key key,this.issearch,this.user,this.calendarowner,this.day,this.mnyinit,this.link}) : super(key: key);
  @override
  TimeRequestScreenState createState() => TimeRequestScreenState(user:user,issearch:issearch,link:link,calendarowner:calendarowner,day:day,mnyinit:mnyinit);
}

class TimeRequestScreenState extends State<TimeRequestScreen> {
  final User user;
  final User calendarowner;
  final String day;
  final String link;
  final String mnyinit;
  bool issearch;
  TimeRequestScreenState({Key key,this.issearch, this.user,this.link,this.calendarowner,this.day,this.mnyinit});
  int _column = 0;
  List<String> times =[];
  ScrollController _scrollController = ScrollController();
  int page = 1;
  List<CalendarTime> posts = [];
  Future<List<CalendarTime>> fetchPostsfuture;
  bool isLoading = false;


  @override
  void initState() {
    print('here');
    if(issearch == null){
      issearch = false;
    }
    if(calendarowner.id == user.id){
      setState(() {
        print('herea');
        fetchPostsfuture =  FetchOwnCalendarTime(http.Client(),user.id,page);
      });   return;

    }
    isuserfollowed(user.id,calendarowner.id)..then((result){
      if(user.shouldshowuserinfo(calendarowner,result) == 'followed'){
        setState(() {
          print('hereb');
          fetchPostsfuture = FetchFollowedCalendarTime(http.Client(),calendarowner.id,page);
        });   return;

      }
      if(user.shouldshowuserinfo(calendarowner,result) == 'public'){
        setState(() {
          print('herec');
          fetchPostsfuture = FetchPublicCalendarTime(http.Client(),calendarowner.id,page);
        });   return;

      }

    });

  }

  Future _loadData() async {
    if(calendarowner.id == user.id){
      FetchOwnCalendarTime(http.Client(),user.id,page)..then((result){
        setState(() {
          for(final item2 in result)
            posts.add(item2);
          isLoading = false;

        });   return;
      });
    }
    isuserfollowed(user.id,calendarowner.id)..then((result){
      if(user.shouldshowuserinfo(calendarowner,result) == 'followed'){
        FetchFollowedCalendarTime(http.Client(),calendarowner.id,page)..then((result2){
          setState(() {
            for(final item2 in result2)
              posts.add(item2);
            isLoading = false;

          });   return;
        });
      }
      if(user.shouldshowuserinfo(calendarowner,result) == 'public'){
        FetchPublicCalendarTime(http.Client(),calendarowner.id,page)..then((result2){
          setState(() {
            for(final item2 in result2)
              posts.add(item2);
            isLoading = false;

          });   return;
        });
      }

    });


  }


  bool canitembechosen(String calendartime){

    for(int i=0;i<calendarowner.meetingschedules.length;i++){
      String mnyincalendar = calendarowner.meetingschedules[i].date.substring(0,7);
      String dayincalendar = calendarowner.meetingschedules[i].date.substring(8,10);
      String timeincalendar = calendarowner.meetingschedules[i].time;
      if(mnyinit == mnyincalendar){
        if(day == dayincalendar){
          if(calendartime == timeincalendar){

            return false;
          }
        }
      }}
    return true;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(    appBar: new AppBar(
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
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateMeetingTimeScreen(user: calendarowner))).then((value) {
              Future.delayed(Duration(seconds: 1),()=> Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget)));
            });
          },
        ),
      ],
    ),
      body:
      NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading && scrollInfo.metrics.pixels ==
              scrollInfo.metrics.maxScrollExtent) {
            page = page +1;
            _loadData();
            setState(() {isLoading = true;});
            return true;
          }},child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height:80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(choosetimesst),
                ],
              ),
              SizedBox(height:40),
              Column(children: [
                FutureBuilder<List<CalendarTime>>(
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
                          return canitembechosen(posts[index].time) ?
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                child: ListTile(
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text('''$timest: ${posts[index].time.toString()} '''
                                            ,style: TextStyle(
                                              fontSize: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.03, color: colordtmaintwo,),),
                                        ],),

                                    ],),
                                  trailing: calendarowner.id != user.id ? IconButton(
                                    icon: Icon(Icons.delete,color: colordtmaintwo,),
                                    onPressed: (){
                                      RemoveCalendarTime(posts[index].id);
                                      Future.delayed(Duration(seconds: 1),()=>                Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) => super.widget)));
                                    },
                                  ) : SizedBox(),
                                ),
                                onTap: (){setState(() {
                                  tcmr = posts[index].time;});
                                CreateMeetingScheduleRequest(calendarowner.id,user.id, dcmr, tcmr,link);

                                icmr = [];
                                if(issearch == false){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user: calendarowner)));

                                }
                                if(issearch){
                                  Navigator.pop(context);

                                }
                                },
                              )
                            ],
                          ) : Container(height: 0,width: 0,);

                        }) : Center(
                      child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                      ),);},),

              ],),


              SizedBox(height:40),



              //
            ],
          ),
        ],
      ),),
    );
  }
}
