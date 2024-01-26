import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/repository.dart';
import 'package:untitled/language.dart';
import 'package:untitled/models/User_Model/user_model.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled/screens/General/home_screen.dart';

import '../../colors.dart';

class CreateReportScreen extends StatefulWidget {
  final User user;
  final String article;
  final User visiteduser;
  final String profile;
  const CreateReportScreen({Key key, this.user,this.article,this.profile,this.visiteduser}) : super(key: key);

  @override
  CreateReportScreenState createState() => CreateReportScreenState(user: user,article:article,profile:profile,visiteduser:visiteduser);
}

class CreateReportScreenState extends State<CreateReportScreen> with SingleTickerProviderStateMixin {
  final User user;
  final String article;
  final String profile;
  final User visiteduser;
  CreateReportScreenState({Key key, this.user,this.article,this.profile,this.visiteduser});
  final TextEditingController issue= TextEditingController();
  final formKey = GlobalKey<FormState>();
  int check1 = 0;
  bool val1 = false;
  bool val2 = false;
  bool val3 = false;
  bool val4 = false;
  bool val5 = false;
  bool val6 = false;
  bool val7 = false;
  bool val8 = false;
  bool blockuseris = false;
  bool followed = false;
  bool unfollowed = false;

  void reportbool(){
    if(val1){val1 = true;val2 = false;val3 = false;val4 = false;val5 = false;val6 = false;val7 = false;val8 = false;}
    if(val2){val1 = false;val2 = true;val3 = false;val4 = false;val5 = false;val6 = false;val7 = false;val8 = false;}
    if(val3){val1 = false;val2 = false;val3 = true;val4 = false;val5 = false;val6 = false;val7 = false;val8 = false;}
    if(val4){val1 = false;val2 = false;val3 = false;val4 = true;val5 = false;val6 = false;val7 = false;val8 = false;}
    if(val5){val1 = false;val2 = false;val3 = false;val4 = false;val5 = true;val6 = false;val7 = false;val8 = false;}
    if(val6){val1 = false;val2 = false;val3 = false;val4 = false;val5 = false;val6 = true;val7 = false;val8 = false;}
    if(val7){val1 = false;val2 = false;val3 = false;val4 = false;val5 = false;val6 = false;val7 = true;val8 = false;}
    if(val7){val1 = false;val2 = false;val3 = false;val4 = false;val5 = false;val6 = false;val7 = false;val8 = true;}
  }
  String reportstring(){
    if(val1){return reporttype1st;}
    if(val2){return reporttype2st;}
    if(val3){return reporttype3st;}
    if(val4){return reporttype4st;}
    if(val5){return reporttype5st;}
    if(val6){return reporttype6st;}
    if(val7){return reporttype7st;}
    if(val8){return issue.text;}
  }

  @override
  Widget build(BuildContext context) {

     return
     Scaffold(

       backgroundColor: colordtmainone,
       body:


       Container(
         child: SingleChildScrollView(
           child: Form(
             key: formKey,
             child: Column(
               children: <Widget>[
                 SizedBox(height:40),
                 CheckboxListTile(
                   title:  Text(reporttype1st,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                   value: val1,
                   onChanged: (bool value) {
                     setState(() { issue.text = reporttype1st;val1 = value;print(issue.text);

                     });
                   },
                   secondary: const Icon(Icons.block),
                 ),
                 CheckboxListTile(
                   title:  Text(reporttype2st,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                   value: val2,
                   onChanged: (bool value) {
                     setState(() { issue.text = reporttype2st;val2 = value;print(issue.text); });
                   },
                   secondary: const Icon(Icons.block),
                 ),
                 CheckboxListTile(
                   title:  Text(reporttype3st,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                   value: val3,
                   onChanged: (bool value) {
                     setState(() { issue.text = reporttype3st;val3 = value;print(issue.text); });
                   },
                   secondary: const Icon(Icons.block),
                 ),
                 CheckboxListTile(
                   title:  Text(reporttype4st,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                   value: val4,
                   onChanged: (bool value) {
                     setState(() { issue.text = reporttype4st;val4 = value;print(issue.text); });
                   },
                   secondary: const Icon(Icons.block),
                 ),
                 CheckboxListTile(
                   title:  Text(reporttype5st,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                   value: val5,
                   onChanged: (bool value) {
                     setState(() { issue.text = reporttype5st;val5 = value;print(issue.text); });
                   },
                   secondary: const Icon(Icons.block),
                 ),
                 CheckboxListTile(
                   title:  Text(reporttype6st,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                   value: val6,
                   onChanged: (bool value) {
                     setState(() {issue.text = reporttype6st; val6 = value;print(issue.text); });
                   },
                   secondary: const Icon(Icons.block),
                 ),
                 CheckboxListTile(
                   title:  Text(reporttype7st,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                   value: val7,
                   onChanged: (bool value) {
                     setState(() { issue.text = reporttype7st;val7 = value;print(issue.text); });
                   },
                   secondary: const Icon(Icons.block),
                 ),
                 CheckboxListTile(
                   title:  Text(reporttype8st,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                   value: val8,
                   onChanged: (bool value) {
                     issue.text = reporttype8st;
                     setState(() { val8 = value;print(issue.text); });
                   },
                   secondary: const Icon(Icons.block),
                 ),
                 val8 ? Padding(
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
                       padding: EdgeInsets.only(left : MediaQuery.of(context).size.width*0.023),
                       child: TextFormField(
  style: TextStyle(color: colordtmaintwo),
                         controller: issue,
                         maxLength: 500,
                         maxLengthEnforcement: MaxLengthEnforcement.enforced,
                         minLines: 1, maxLines: 20,
                         decoration: InputDecoration(
                           border: InputBorder.none,
                           focusedBorder: InputBorder.none,
                           enabledBorder: InputBorder.none,
                           errorBorder: InputBorder.none,
                           disabledBorder: InputBorder.none,

                           hintText: writeotherissueherest,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
                         ),
                       ),
                     ),
                   ),

                 ) : Container(height: 0,width: 0,),
                 SizedBox(height:MediaQuery.of(context).size.height*0.013),
                 CheckboxListTile(
                   title:  Text(blockuserst,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                   value: blockuseris,
                   onChanged: (bool value) {
                     setState(() { blockuseris = value;print(issue.text); });
                   },
                   secondary: const Icon(Icons.block),
                 ),
                 SizedBox(height:MediaQuery.of(context).size.height*0.025),

                 SizedBox(
                   width: MediaQuery.of(context).size.width*0.3 , height: MediaQuery.of(context).size.height*0.06,  child: ElevatedButton(
                   child: Text(donest),
                   onPressed: () {
                     Future<User> refreshProfile() async {
                       User _user1;
                       WidgetsFlutterBinding.ensureInitialized();
                       final http.Response response = await http.get(Uri.parse("$SERVER_IP/api/users/"),
                         headers: <String, String>{
                           'Content-Type': 'application/json; charset=UTF-8',
                           HttpHeaders.authorizationHeader: "9944b09199c62bcf9418ad846dd0e4bbdfc6ee4b",
                         },
                       );
                       if (response.statusCode == 200) {
                         var responseJson = json.decode(response.body);
                         _user1 = User.fromJSON(responseJson);
                         Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user: _user1)));
                       }
                     }
                    Future.delayed(new Duration(seconds:2), () {Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen(user: user,),),);});
                     setState(() async {

                       issue.text == '' ? check1 = 0 : check1 = check1 + 1;

                       check1 == 1 ? CreateReport(user.id,profile,article,reportstring()) : _showError(noissueenteredst);
                       check1 = 0;
                       if(blockuseris){
                         BlockUser(user.id,profile);
                         String followid;
                         followid = await userfollowid(user.id,profile);
                         UnfollowUser(followid);
                         followid = '';
                         followed = false;
                         unfollowed = true;
                         isuserfollowed(user.id,visiteduser.id)..then((result) {
                           isuserfollowrequested(user.id, visiteduser.id)
                             ..then((result2) {
                               visiteduser.isfollowedprofile(
                                   visiteduser, user, followed, unfollowed,
                                   result2, result);
                             });
                         });
                         refreshProfile();
                       }
                     });
                     Navigator.push(context, MaterialPageRoute(builder: (_) =>  HomeScreen(user: user,),),);
                     },
                 ),
                 ),
                 SizedBox(height:MediaQuery.of(context).size.height*0.05),



               ],
             ),
           ),
         ),
       ),
     );

  }

  void _showError(String error) {
    print(error);
    return;
  }
}

