import 'package:untitled/screens/General/terms_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:dio_http/dio_http.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/repository.dart';
import 'package:untitled/language.dart';
import 'package:untitled/screens/General/home_screen.dart';
import 'package:untitled/models/User_Model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../colors.dart';
import 'first_time_calendar_screen.dart';
import 'first_time_merchant_screen.dart';

class Tagstatekeys {
  static final _tagStateKey1 = const Key('__TSK1__');
}

class FirstTimeTagsScreen extends StatefulWidget {
  final User user;
  const FirstTimeTagsScreen({Key key, this.user,}) : super(key: key);
  @override
  FirstTimeTagsScreenState createState() => FirstTimeTagsScreenState(user:user);
}

class FirstTimeTagsScreenState extends State<FirstTimeTagsScreen> with SingleTickerProviderStateMixin{
  final User user;

  FirstTimeTagsScreenState({Key key, this.user});
  String createpersonprofiletype = 'P';
  String createpersongendertype = 'NB';
  User uniuser;
  bool approved = false;
  bool errortrue = false;
  bool termsandconditions = false;
  bool allowcalendar = false;
  File image;
  int signupcheck = 0;
  int signupcheck2 = 0;
  bool obscurepassword = true;
  final _formKey = GlobalKey<FormState>();
  final navigatorKey2 = GlobalKey<NavigatorState>();
  final TextEditingController tags = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  List<String> tagsfinal = [''];
  int _column = 0;





  @override
  String tagsinit() {
    tagsfinal = tags.text.split(',');
  }

  Future<User> refreshProfile() async {
    WidgetsFlutterBinding.ensureInitialized();
    final http.Response response = await http.get(Uri.parse("$SERVER_IP/api/ownuser/"),
      headers: <String, String>{"Authorization" : "Token ${globaltoken}"},
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      User mainuser = User.fromJSON(responseJson[0]);

      if(user.profile_type == 'B'){
        return   Navigator.of(context).push(MaterialPageRoute(builder: (context) => FirstTimeMerchantScreen(user: mainuser)));
      }
      if(user.profile_type == 'P'){
        return   Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user: mainuser)));
      }

    }
  }




  Widget build(BuildContext context) {
    tagsinit();
    return Scaffold(
      backgroundColor: colordtmainone,
      key: _scaffoldKey,
      body: SingleChildScrollView(

        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[



            SizedBox(height: MediaQuery.of(context).size.height*0.04),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(firsttimetagsst,
                    style: TextStyle(
                      color:colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height*0.025,
                      fontWeight: FontWeight.bold,

                    ),),SizedBox(height:20),

                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery
                        .of(context)
                        .size
                        .width * 0.01, right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.01),
                    child:
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery
                          .of(context)
                          .size
                          .width * 0.023, vertical: MediaQuery
                          .of(context)
                          .size
                          .height * 0.013),
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
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: tags,
                          onChanged:  (tags){
                            setState(() {
                              tagsinit();
                            });
                          },
                          maxLength: 300,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            hintText: posttagsst,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,

                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400, color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),

                  ),

                  SizedBox(height: 20,),

                  Tags(
                    key: Tagstatekeys._tagStateKey1,
                    columns: _column,
                    itemCount: tagsfinal.length,
                    itemBuilder: (i) {
                      return tagsfinal[i] == '' ? Container(height: 0,width: 0,) : ItemTags(
                        key: Key(i.toString()),
                        index: i,
                        title: tagsfinal[i].toString(),
                        color: Color(0xFFEEEEEE),
                        activeColor: Color(0xFFEEEEEE),
                        textColor: colordtmaintwo,
                        textActiveColor: colordtmaintwo,
                        textStyle: TextStyle(
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height * 0.018, color: colordtmaintwo,),
                      );
                    },
                  ),
                  SizedBox(height:  MediaQuery.of(context).size.height*0.025),
                  Padding(
                    padding: EdgeInsets.only(left: 25,right:2),
                    child: Text(user.profile_type == 'B' ?firsttimetagsexpst :firsttimetagsexpst,
                      style: TextStyle(
                        color:colordtmaintwo,
                        fontSize: MediaQuery.of(context).size.height*0.025,
                        fontWeight: FontWeight.bold,

                      ),),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.02),
                  ElevatedButton(
                    child: Text(donest, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                    onPressed: (){
                      if(tagsfinal.isNotEmpty){ for (int i = 0; i < tagsfinal.length; i++) {CreateUserTags(tagsfinal[i],user.id);}}

                      Future.delayed(new Duration(seconds:1), () {
                        refreshProfile();
                      });

                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text(skipst, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                        onPressed: (){

                          if(user.profile_type == 'B'){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => FirstTimeMerchantScreen(user: user)));
                          }
                          if(user.profile_type == 'P'){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user: user)));
                          } },
                      ),SizedBox(width:  MediaQuery.of(context).size.width*0.025),
                      ElevatedButton(

                        child: Text(skipallst, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user: user)));
                        },
                      ),
                    ],
                  ),  SizedBox(height: MediaQuery.of(context).size.height*0.06),
                ],
              ),
            ),


          ],
        ),

      ),

    );

  }

}
