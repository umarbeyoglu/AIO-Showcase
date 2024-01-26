import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Welpie/language.dart';
import 'package:Welpie/models/User_Model/user_model.dart';
import 'package:Welpie/repository.dart';
import 'package:Welpie/screens/Authentication_Screen/authentication_login_screen.dart';
import 'package:Welpie/screens/General/about_screen.dart';
import 'package:Welpie/screens/General/restart_screen.dart';
import 'package:Welpie/screens/Profile_Screen/profile_blocked_users_screen.dart';
import 'package:Welpie/screens/Profile_Screen/profile_delete_screen.dart';
import 'package:Welpie/screens/Profile_Screen/profile_edit_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../colors.dart';
import '../General/home_screen.dart';


DarkTheme(bool isdark) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("darktheme", isdark);
  var init =prefs.getBool("darktheme");
  print(init);
}

class SettingsScreen extends StatefulWidget {
  final User user;
  const SettingsScreen({Key key, this.user}) : super(key: key);
  @override
  SettingsScreenState createState() => SettingsScreenState(user:user);
}

class SettingsScreenState extends State<SettingsScreen> {
  final User user;
  SettingsScreenState({Key key, this.user});


  CleanSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: colordtmainone,



      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Container(

              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: ListTile(              leading: Icon(Icons.location_on,color: colordtmaintwo),
                      title: Text(locationst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold),),
                    ),
                    onTap: (){
                      Navigator.push(
                        context ,
                        MaterialPageRoute(
                          builder: (_) => LocationScreen(
                            user:user,
                          ),
                        ),
                      );
                    },
                  ),Divider(color: colordtmaintwo,),
                  InkWell(
                    child:ListTile(              leading: Icon(Icons.lightbulb,color: colordtmaintwo),
                      title: Text(darklightthemest,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold),),
                    ),
                    onTap: (){
                      setState(() {

                        if(darktheme){ DarkTheme(false);}
                        if(!darktheme){DarkTheme(true);}
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RestartScreen(
                              languagechangedto : languagest == 'EN' ? 'EN' : 'TR'
                          ),
                        ),
                      );
                    },
                  ),Divider(color: colordtmaintwo,),
                  InkWell(
                    child: ListTile(              leading: Icon(Icons.supervised_user_circle,color: colordtmaintwo),
                      title: Text(blockedusersst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold),),
                    ),
                    onTap: (){
                      Navigator.push(
                        context ,
                        MaterialPageRoute(
                          builder: (_) => BlockedUsersScreen(
                            user:user,
                          ),
                        ),
                      );
                    },
                  ),Divider(color: colordtmaintwo,),
                  InkWell(
                    child: ListTile(              leading: Icon(Icons.reorder,color: colordtmaintwo),
                      title: Text(aboutst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold),),
                    ),
                    onTap: (){
                      Navigator.push(
                        context ,
                        MaterialPageRoute(
                          builder: (_) => GeneralAboutScreen(
                          ),
                        ),
                      );
                    },
                  ),Divider(color: colordtmaintwo,),
                  InkWell(
                    child: ListTile(              leading: Icon(Icons.edit,color: colordtmaintwo),
                      title: Text(edituserst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold),),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditUserScreen(
                            user: user,masteruser: user,
                          ),
                        ),
                      );
                    },
                  ),Divider(color: colordtmaintwo,),
                  InkWell(
                    child:ListTile(              leading: Icon(Icons.delete,color: colordtmaintwo),
                      title: Text(deleteuserst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold),),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DeleteUserScreen(
                            user: user,
                          ),
                        ),
                      );
                    },
                  ),Divider(color: colordtmaintwo,),
                  InkWell(
                    child: ListTile(              leading: Icon(Icons.logout,color: colordtmaintwo),
                      title: Text(logoutst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold),),
                    ),
                    onTap: (){
                      CleanSF();
                      Navigator.push(
                        context ,
                        MaterialPageRoute(
                          builder: (_) => LoginScreen(
                          ),
                        ),
                      );

                    },
                  ),Divider(color: colordtmaintwo,),
                ],
              ),

          ),

        ],),


    );

  }


}

class LocationScreen extends StatefulWidget {
  final User user;
  const LocationScreen({Key key, this.user,}) : super(key: key);
  @override
  LocationScreenState createState() => LocationScreenState(user:user);
}

class LocationScreenState extends State<LocationScreen> with SingleTickerProviderStateMixin{
  final User user;

  LocationScreenState({Key key, this.user});
  final _formKey = GlobalKey<FormState>();
  final navigatorKey2 = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String type = '';


  Userdata(String email,String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
    prefs.setString("password", password);
  }


  Future<User> refreshProfile() async {
    LocationData(type == 'yes' ? true : false);
    WidgetsFlutterBinding.ensureInitialized();
    final http.Response response = await http.get(Uri.parse("$SERVER_IP/api/ownuser/"),
      headers: <String, String>{"Authorization" : "Token ${globaltoken}"},
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      User mainuser = User.fromJSON(responseJson[0]);

      return Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user: mainuser)));
    }
  }



  Future<void> updateloc() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    iscyprus = prefs.getBool('iscyprus');
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

                  Text('areyouincyprusst',
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

