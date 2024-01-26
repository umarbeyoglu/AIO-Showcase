import 'package:untitled/language.dart';
import 'package:untitled/models/User_Model/user_model.dart';
import 'package:untitled/repository.dart';
import 'package:untitled/screens/General/create_article_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../colors.dart';



class Tagstatekeys {
  static final _tagStateKey1 = const Key('__TSK1__');
  static final _tagStateKey2 = const Key('__TSK2__');
}


class CreateCalendarTimeScreen extends StatefulWidget {
  final User user;
  const CreateCalendarTimeScreen({Key key, this.user}) : super(key: key);
  @override
  CreateCalendarTimeScreenState createState() => CreateCalendarTimeScreenState(user:user);
}

class CreateCalendarTimeScreenState extends State<CreateCalendarTimeScreen> {
  final User user;
  CreateCalendarTimeScreenState({Key key, this.user});
  int _column = 0;
  List<String> times = [];
  final TextEditingController time= TextEditingController();
  final TextEditingController stock= TextEditingController();
  List<User> _subusers = List<User>();
  List<User> _subusersForDisplay = List<User>();
  bool searching2 = false;
  bool allowstocks = false;
  var _textfield = TextEditingController();
  var _textfield2 = TextEditingController();


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
  @override
  void initState() {

    super.initState();
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
      ),
      backgroundColor: colordtmainone,



      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Container(

              child:
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01 ,right: MediaQuery.of(context).size.width*0.01),
                      child:
                      Container(
                        margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.023 , vertical: MediaQuery.of(context).size.height*0.013),
                        decoration: BoxDecoration(
                          color: colordtmainone,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child:  Padding(
                          padding: EdgeInsets.only(left : 8),
                          child: TextFormField(
                            style: TextStyle(color: colordtmaintwo),
                            controller: time,
                            maxLength: 250,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,

                              hintText: timeforcalendarst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
                            ),
                          ),
                        ),
                      ),

                    ),



                    SizedBox(
                      width:MediaQuery.of(context).size.width*0.4, height:MediaQuery.of(context).size.height*0.07,
                      child: ElevatedButton(
                        child: Text(addtimest, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                        onPressed: (){

                          CreateCalendarTime(user.id,time.text);
                       Navigator.pop(context);
                        },
                      ),),
                    SizedBox(height:50),

                  ]
              )
          ),],),);
  }
}

class CreateMeetingTimeScreen extends StatefulWidget {
  final User user;
  const CreateMeetingTimeScreen({Key key, this.user}) : super(key: key);
  @override
  CreateMeetingTimeScreenState createState() => CreateMeetingTimeScreenState(user:user);
}

class CreateMeetingTimeScreenState extends State<CreateMeetingTimeScreen> {
  final User user;
  CreateMeetingTimeScreenState({Key key, this.user});
  int _column = 0;
  List<String> times = [];
  final TextEditingController time= TextEditingController();
  final TextEditingController stock= TextEditingController();
  List<User> _subusers = List<User>();
  List<User> _subusersForDisplay = List<User>();
  bool searching2 = false;
  bool allowstocks = false;
  var _textfield = TextEditingController();
  var _textfield2 = TextEditingController();


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
  @override
  void initState() {

    super.initState();
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
      ),
      backgroundColor: colordtmainone,



      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Container(

              child:
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01 ,right: MediaQuery.of(context).size.width*0.01),
                      child:
                      Container(
                        margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.023 , vertical: MediaQuery.of(context).size.height*0.013),
                        decoration: BoxDecoration(
                          color: colordtmainone,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child:  Padding(
                          padding: EdgeInsets.only(left : 8),
                          child: TextFormField(
                            style: TextStyle(color: colordtmaintwo),
                            controller: time,
                            maxLength: 250,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,

                              hintText: timeforcalendarst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
                            ),
                          ),
                        ),
                      ),

                    ),


                    SizedBox(
                      width:MediaQuery.of(context).size.width*0.4, height:MediaQuery.of(context).size.height*0.07,
                      child: ElevatedButton(
                        child: Text(addtimest, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                        onPressed: (){

                          CreateCalendarTime(user.id,time.text);
                          Navigator.pop(context);
                        },
                      ),),
                    SizedBox(height:50),

                  ]
              )
          ),],),);
  }
}
