import 'package:Welpie/language.dart';
import 'package:Welpie/models/User_Model/user_calendar_schedule_model.dart';
import 'package:Welpie/models/User_Model/user_model.dart';
import 'package:Welpie/screens/Visited_Profile_Screen/visited_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';

class CalendarScheduleDetailsScreen extends StatefulWidget {
  final CalendarSchedule calendaritem;
  final User user;
  final User client;
  const CalendarScheduleDetailsScreen({Key key,this.client,this.calendaritem,this.user,}) : super(key : key);

  @override
  CalendarScheduleDetailsScreenState createState() => CalendarScheduleDetailsScreenState(user : user,client:client,calendaritem : calendaritem);
}

class CalendarScheduleDetailsScreenState extends State<CalendarScheduleDetailsScreen> {
  final CalendarSchedule calendaritem;
  final User user;
  final User client;
  CalendarScheduleDetailsScreenState({Key key,this.client, this.calendaritem,this.user,});


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
                                        '$itemst : ${calendaritem.item}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
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