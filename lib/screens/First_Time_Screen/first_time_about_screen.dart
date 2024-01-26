import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:untitled/language.dart';
import 'package:untitled/models/User_Model/user_model.dart';
import 'package:untitled/repository.dart';
import 'package:untitled/screens/First_Time_Screen/first_time_image_screen.dart';
import 'package:untitled/screens/General/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../colors.dart';

class Tagstatekeys {
  static final _tagStateKey1 = const Key('__TSK1__');
}

class FirstTimeAboutScreen extends StatefulWidget {
  final User user;
  const FirstTimeAboutScreen({Key key, this.user,}) : super(key: key);
  @override
  FirstTimeAboutScreenState createState() => FirstTimeAboutScreenState(user:user);
}

class FirstTimeAboutScreenState extends State<FirstTimeAboutScreen> with SingleTickerProviderStateMixin{
  final User user;

  FirstTimeAboutScreenState({Key key, this.user});
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

  final TextEditingController _bio = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  List<String> tagsfinal = [''];
  int _column = 0;



  Userdata(String email,String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
    prefs.setString("password", password);
  }

  pickFromCamera() async {
     final _image = await picker.getImage(source: ImageSource.camera,  imageQuality: 80);

    setState(() {
      image = File(_image.path);
    });
  }

  pickFromPhone() async {
   final _image = await picker.getImage(source: ImageSource.gallery,  imageQuality: 80);

    setState(() {
      image = File(_image.path);
    });
  }

  profiletypechoice(String profiletypes) {
    if (profiletypes == personst) {
      setState(() {
        createpersonprofiletype = 'P';
      });

    }
    else if (profiletypes  == businessst) {
      setState(() {
        createpersonprofiletype = 'B';
      });
    }

  }

  Future<User> refreshProfile() async {
    WidgetsFlutterBinding.ensureInitialized();
    final http.Response response = await http.get(Uri.parse("$SERVER_IP/api/ownuser/"),
      headers: <String, String>{"Authorization" : "Token ${globaltoken}"},
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      User mainuser = User.fromJSON(responseJson[0]);
      return Navigator.of(context).push(MaterialPageRoute(builder: (context) => FirstTimeImageScreen(user: mainuser)));
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

                  Text(firsttimeaboutst,
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
                          controller: _bio,

                          maxLength: 64000,
                          minLines: 1, maxLines:200,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            hintText: aboutst,
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
                    child: Text(user.profile_type == 'B' ? firsttimeaboutbsexpst: firsttimeaboutexpst,
                      style: TextStyle(
                        color:colordtmaintwo,
                        fontSize: MediaQuery.of(context).size.height*0.025,
                        fontWeight: FontWeight.bold,

                      ),),
                  ),
             ],
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height*0.02),
            ElevatedButton(
              child: Text(donest, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

              onPressed: (){
                EditUserBio(user,_bio.text);
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

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => FirstTimeImageScreen(user: user)));
                  },
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

    );

  }

}
