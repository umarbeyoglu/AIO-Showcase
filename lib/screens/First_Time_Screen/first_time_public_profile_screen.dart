import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../colors.dart';
import '../../language.dart';
import '../../models/User_Model/user_model.dart';
import '../../repository.dart';
import '../General/home_screen.dart';
import 'first_time_location_screen.dart';
import 'first_time_tags_screen.dart';

class Tagstatekeys {
  static final _tagStateKey1 = const Key('__TSK1__');
}

class FirstTimePublicProfileScreen extends StatefulWidget {
  final User user;
  const FirstTimePublicProfileScreen({
    Key key,
    this.user,
  }) : super(key: key);
  @override
  FirstTimePublicProfileScreenState createState() =>
      FirstTimePublicProfileScreenState(user: user);
}

class FirstTimePublicProfileScreenState
    extends State<FirstTimePublicProfileScreen>
    with SingleTickerProviderStateMixin {
  final User user;

  FirstTimePublicProfileScreenState({Key key, this.user});
  String createpersonprofiletype = 'P';
  String createpersongendertype = 'NB';
  User uniuser;
  bool approved = false;
  bool errortrue = false;
  bool termsandconditions = false;
  bool allowcalendar = true;
  File image;
  int signupcheck = 0;
  int signupcheck2 = 0;
  bool obscurepassword = true;
  final _formKey = GlobalKey<FormState>();
  final navigatorKey2 = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  List<String> tagsfinal = [''];
  int _column = 0;

  Future<User> refreshProfile() async {
    WidgetsFlutterBinding.ensureInitialized();
    final http.Response response = await http.get(
      Uri.parse("$SERVER_IP/api/ownuser/"),
      headers: <String, String>{"Authorization": "Token ${globaltoken}"},
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      User mainuser = User.fromJSON(responseJson[0]);

      return Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FirstTimeLocationScreen(user: mainuser)));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colordtmainone,
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    firsttimepublicprofilest,
                    style: TextStyle(
                      color: colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height * 0.025,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  CheckboxListTile(
                    title: Text(publicprofilest,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.w400)),
                    value: allowcalendar,
                    onChanged: (bool value) {
                      setState(() {
                        allowcalendar = value;
                      });
                    },
                    secondary: const Icon(Icons.format_list_numbered),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 2),
                    child: Text(
                      firsttimepublicprofileexpst,
                      style: TextStyle(
                        color: colordtmaintwo,
                        fontSize: MediaQuery.of(context).size.height * 0.025,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ElevatedButton(
                    child: Text(
                      donest,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ),
                    onPressed: () {
                      EditUserPublicProfile(user, allowcalendar);
                      Future.delayed(new Duration(seconds: 1), () {
                        refreshProfile();
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text(
                          skipst,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  FirstTimeTagsScreen(user: user)));
                        },
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.025),
                      ElevatedButton(
                        child: Text(
                          skipallst,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomeScreen(user: user)));
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
