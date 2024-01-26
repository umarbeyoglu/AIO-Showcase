import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:Welpie/language.dart';
import 'package:Welpie/models/User_Model/user_model.dart';
import 'package:Welpie/repository.dart';
import 'package:Welpie/screens/General/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../colors.dart';
import 'first_time_hotel_screen.dart';
import 'first_time_wifi_screen.dart';

class Tagstatekeys {
  static final _tagStateKey1 = const Key('__TSK1__');
}

class FirstTimeMerchantScreen extends StatefulWidget {
  final User user;
  const FirstTimeMerchantScreen({Key key, this.user,}) : super(key: key);
  @override
  FirstTimeMerchantScreenState createState() => FirstTimeMerchantScreenState(user:user);
}

class FirstTimeMerchantScreenState extends State<FirstTimeMerchantScreen> with SingleTickerProviderStateMixin{
  final User user;

  FirstTimeMerchantScreenState({Key key, this.user});
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
  final TextEditingController gatewayname = TextEditingController();
  final TextEditingController gatewaymerchantid = TextEditingController();
  final TextEditingController merchantid = TextEditingController();
  final TextEditingController merchantname = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  List<String> tagsfinal = [''];
  int _column = 0;
  String type = 'yes';


  Future<User> refreshProfile() async {
    WidgetsFlutterBinding.ensureInitialized();
    final http.Response response = await http.get(Uri.parse("$SERVER_IP/api/ownuser/"),
      headers: <String, String>{"Authorization" : "Token ${globaltoken}"},
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      User mainuser = User.fromJSON(responseJson[0]);

      return Navigator.of(context).push(MaterialPageRoute(builder: (context) => FirstTimeHotelScreen(user: mainuser)));
    }
  }









  Widget build(BuildContext context) {

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
                  Text(firsttimecreditcardinfoexpst,
                    style: TextStyle(
                      color:colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height*0.025,
                      fontWeight: FontWeight.bold,

                    ),),SizedBox(height:20),

                  SizedBox(height:  MediaQuery.of(context).size.height*0.025),
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
                          .width * 0.023,),
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
                          controller: merchantid,

                          maxLength: 50,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            hintText: ibannost,
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
                  SizedBox(height:  MediaQuery.of(context).size.height*0.025),
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
                          .width * 0.023,),
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
                          controller: merchantname,

                          maxLength: 50,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            hintText: namesurnamest,
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
                  SizedBox(height:  MediaQuery.of(context).size.height*0.025),

                  Padding(
                    padding: EdgeInsets.only(left: 25,right:2),
                    child: Text(firsttimecreditcardinfoexpst,
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
                     EditUserMerchantInfo(user, '', gatewayname.text, gatewaymerchantid.text, merchantid.text, merchantname.text);
                     Future.delayed(new Duration(seconds:1), () {refreshProfile();});
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text(skipst, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => FirstTimeHotelScreen(user: user)));
                        },
                      ),SizedBox(width:  MediaQuery.of(context).size.width*0.025),
                      ElevatedButton(

                        child: Text(skipallst, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user: user)));
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.06),
                ],
              ),
            ),


          ],
        ),

      ),

    );

  }

}

