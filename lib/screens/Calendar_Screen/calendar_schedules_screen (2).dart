import 'package:Welpie/models/User_Model/user_calendar_item_model.dart';
import 'package:Welpie/models/User_Model/user_calendar_schedule_model.dart';
import 'package:Welpie/repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'dart:async';
import 'package:Welpie/models/User_Model/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:Welpie/language.dart';
import 'package:flutter/cupertino.dart';
import '../../colors.dart';
import 'calendar_schedule_details_screen.dart';


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

  bool doesitembelongtoschedule(CalendarSchedule calendarschedule){
    String mny = calendarschedule.date.substring(0,7);
    String dayinit = calendarschedule.date.substring(8);
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
    return Scaffold(

      body:  ListView.builder(
          shrinkWrap: true,
          itemCount: user.calendarschedules.length,
          physics: ClampingScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (context,index){
            return doesitembelongtoschedule(user.calendarschedules[index]) ?  FutureBuilder<User>(
                future: callUser(user.calendarschedules[index].profile),
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
                            Text('''${user.calendarschedules[index].item.toString()} '''
                              ,style: TextStyle(
                                fontSize: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.03, color: colordtmaintwo,),),

                            Text('''$timest: ${user.calendarschedules[index].time.toString()} '''
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
                            RemoveCalendarSchedule(user.calendarschedules[index].id);
                            String id = user.id == user.calendarschedules[index].profile ? user.calendarschedules[index].author:
                            user.calendarschedules[index].profile;
                            CancelAppointment(user.id, id, user.calendarschedules[index].item,
                                user.calendarschedules[index].date, user.calendarschedules[index].time,
                                user.calendarschedules[index].item);
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

