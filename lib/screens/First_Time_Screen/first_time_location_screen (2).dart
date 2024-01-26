import 'package:Welpie/screens/First_Time_Screen/first_time_public_profile_screen.dart';
import 'package:Welpie/screens/General/terms_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:dio_http/dio_http.dart';
import 'package:http/http.dart' as http;
import 'package:Welpie/repository.dart';
import 'package:Welpie/language.dart';
import 'package:Welpie/screens/General/home_screen.dart';
import 'package:Welpie/models/User_Model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../colors.dart';
import 'first_time_calendar_screen.dart';
import 'first_time_tags_screen.dart';

class Tagstatekeys {
  static final _tagStateKey1 = const Key('__TSK1__');
}

class FirstTimeLocationScreen extends StatefulWidget {
  final User user;
  const FirstTimeLocationScreen({Key key, this.user,}) : super(key: key);
  @override
  FirstTimeLocationScreenState createState() => FirstTimeLocationScreenState(user:user);
}

class FirstTimeLocationScreenState extends State<FirstTimeLocationScreen> with SingleTickerProviderStateMixin{
  final User user;

  FirstTimeLocationScreenState({Key key, this.user});
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
  final TextEditingController _email= TextEditingController();
  final TextEditingController _password= TextEditingController();
  final TextEditingController _username= TextEditingController();
  final TextEditingController _firstname= TextEditingController();
  final TextEditingController _lastname= TextEditingController();
  final TextEditingController _location= TextEditingController();
  final TextEditingController _phonenumber = TextEditingController();
  final TextEditingController _businesstype = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  final TextEditingController tags = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  List<String> tagsfinal = [''];
  int _column = 0;
  String type = 'yes';


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

      return Navigator.of(context).push(MaterialPageRoute(builder: (context) => FirstTimeTagsScreen(user: mainuser)));
    }
  }

  @override
  String tagsinit() {
    tagsfinal = tags.text.split(',');
  }
  //    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user:loginuser))) ;
//   if(tagsfinal.isNotEmpty){ for (int i = 0; i < tagsfinal.length; i++) {CreateUserTags(tagsfinal[i],uniuser.id);}}


  void initState(){
    setState(() {
      type = iscyprus ? 'yes' : 'no';
    });
  }


  Future<void> updateloc() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    iscyprus = prefs.getBool('iscyprus');
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


                  Text(firsttimelocationst,
                    style: TextStyle(
                      color:colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height*0.025,
                      fontWeight: FontWeight.bold,

                    ),),SizedBox(height:40),

                  Text(areyouincyprusst,
                    style: TextStyle(
                      color:colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height*0.025,
                      fontWeight: FontWeight.bold,

                    ),),
SizedBox(height:20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

  SizedBox(
                  width:MediaQuery.of(context).size.width*0.4, height:MediaQuery.of(context).size.height*0.07,
                  child: ElevatedButton(
                    child: Text(yesst, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                    onPressed: (){
                      setState(() {
                        type = 'yes';
                        LocationData(type == 'yes' ? true : false);
                        updateloc();
                      });
                    },
                  ),) ,
      SizedBox(width:10),
        SizedBox(
                  width:MediaQuery.of(context).size.width*0.4, height:MediaQuery.of(context).size.height*0.07,
                  child: ElevatedButton(
                    child: Text(nost, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                    onPressed: (){
                      setState(() {
                        type = 'no';
                        LocationData(type == 'yes' ? true : false);
                        updateloc();
                      });
                    },
                  ),)
              ],
            ),
                  SizedBox(height:20),
                  SizedBox(

                    width:MediaQuery.of(context).size.width*0.36, height:MediaQuery.of(context).size.height*0.07,
                    child: ElevatedButton(

                      child: Text(locationst
                        ,style:TextStyle(
                          fontSize: MediaQuery.of(context).size.height*0.025,
                        ),
                      ),

                      onPressed: () {
                        ChooseLocation(context);

                      },

                    ),
                  ),
                  SizedBox(height:  MediaQuery.of(context).size.height*0.025),
                  Padding(
                    padding: EdgeInsets.only(left: 25,right:2),
                    child: Text(firsttimelocationexpst,
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
                     EditUserLocation(user);
                     LocationData(type == 'yes' ? true : false);
                     Future.delayed(new Duration(seconds:1), () {refreshProfile();});
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text(skipst, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                        onPressed: (){
                          LocationData(false);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => FirstTimePublicProfileScreen(user: user)));
                        },
                      ),SizedBox(width:  MediaQuery.of(context).size.width*0.025),
                      ElevatedButton(

                        child: Text(skipallst, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                        onPressed: (){
                          LocationData(false);
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
