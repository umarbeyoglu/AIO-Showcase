import 'package:untitled/models/User_Model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../repository.dart';




class RestartScreen extends StatelessWidget{
  final User user;
  final String languagechangedto;
  RestartScreen({Key key, this.user,this.languagechangedto});



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: colordtmainone,



      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Container(

              child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height:100),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width* 0.043,
                        vertical: 0,
                      ),
                      child: Text(languagechangedto == 'EN' ? 'Please restart app' : 'Lütfen uygulamayı tekrar başlatın',
                        style: TextStyle(
                          fontSize:  MediaQuery.of(context).size.width*0.043,
                          color:colordtmaintwo,
                          fontWeight: FontWeight.w500,

                        ),
                      ),
                    ),
                    SizedBox(height:200),
                  ]
              )

          ),],),);
  }
}

class CalendarRequestSentScreen extends StatelessWidget{
  CalendarRequestSentScreen({Key key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: colordtmainone,



      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Container(

              child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height:100),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width* 0.043,
                        vertical: 0,
                      ),
                      child: Text(languagest == 'EN' ? 'Request sent successfully!Wait for calendar owner to send you notification!'
                          : '',
                        style: TextStyle(
                          fontSize:  MediaQuery.of(context).size.width*0.043,
                          color:colordtmaintwo,
                          fontWeight: FontWeight.w500,

                        ),
                      ),
                    ),
                    SizedBox(height:200),
                  ]
              )

          ),],),);
  }
}