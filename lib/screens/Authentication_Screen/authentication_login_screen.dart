import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../colors.dart';
import '../../language.dart';
import '../../models/User_Model/user_model.dart';
import '../../repository.dart';
import '../General/home_screen.dart';
import '../General/restart_screen.dart';
import 'authentication_register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  int check = 0;
  int falsecheck = 0;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool loginattempt = false;
  bool loginsuccessful = false;
  bool lol = false;
  int signincheck = 0;
  Future<User> signinFunc;
  String error;
  User _user;
  bool obscurepassword = true;

  Future<User> GetUser(String token) async {
    WidgetsFlutterBinding.ensureInitialized();
    final http.Response response = await http.get(
      Uri.parse("$SERVER_IP/api/ownuser/"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Token $token"
      },
    );
    if (response.statusCode == 200) {
      var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      _user = User.fromJSON(responseJson[0]);
      //          final http.Response response3 = await http.get(Uri.parse("$SERVER_IP/api/groups/"), headers: <String, String>{"Authorization" : "Token $globaltoken"},);
      //        if (response3.statusCode == 200) {
      //                  final parsed = jsonDecode(utf8.decode(response3.bodyBytes));List<Group> groups = parsed.map<Group>((json) => Group.fromJSON(json)).toList();_user.groups2 = groups;
      //                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user:_user)))   ;
      //                      }
      print(_user.messagecount);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HomeScreen(user: _user)));
    } else {
      error = response.body;
      setState(() {
        loginattempt = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loginattempt == true
        ? Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.pink,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)),
                )
              ],
            ),
          )
        : Container(
            alignment: Alignment.center,
            child: Scaffold(
              backgroundColor: colordtmainone,
              body: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
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
                          Text(
                            welcomest,
                            style: TextStyle(
                              color: colordtmaintwo,
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      Form(
                        key: _key,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.04,
                                vertical:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 4),
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
                                    cursorColor: colordtmaintwo,
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _emailController,
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,

                                      labelText: emailst,
                                      labelStyle: TextStyle(
                                        color: colordtmaintwo,
                                      ),
                                      hintText: eyemailst,
                                      hintStyle: TextStyle(
                                        color: colordtmaintwo,
                                      ),
                                      // If  you are using latest version of flutter then lable text and hint text shown like this
                                      // if you r using flutter less then 1.20.* then maybe this is not working properly
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.04,
                                vertical:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 4),
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
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          icon: Icon(Icons.visibility),
                                          iconSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          color: colordtmaintwo,
                                          onPressed: () {
                                            setState(() {
                                              obscurepassword == true
                                                  ? obscurepassword = false
                                                  : obscurepassword = true;
                                            });
                                          }),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,

                                      labelText: passwordst,
                                      labelStyle: TextStyle(
                                        color: colordtmaintwo,
                                      ),
                                      hintText: eypasswordst,
                                      hintStyle: TextStyle(
                                        color: colordtmaintwo,
                                      ),
                                      // If  you are using latest version of flutter then lable text and hint text shown like this
                                      // if you r using flutter less then 1.20.* then maybe this is not working properly
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                    ),
                                    obscureText: obscurepassword,
                                    controller: _passwordController,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.07),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.06,
                              child: ElevatedButton(
                                child: Text(
                                  loginst,
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.025,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    Future<User> GetUser(String token) async {
                                      WidgetsFlutterBinding.ensureInitialized();
                                      final http.Response response =
                                          await http.get(
                                        Uri.parse("$SERVER_IP/api/ownuser/"),
                                        headers: <String, String>{
                                          'Content-Type': 'application/json',
                                          "Authorization": "Token $token"
                                        },
                                      );
                                      if (response.statusCode == 200) {
                                        var responseJson = jsonDecode(
                                            utf8.decode(response.bodyBytes));
                                        _user = User.fromJSON(responseJson[0]);
                                        //          final http.Response response3 = await http.get(Uri.parse("$SERVER_IP/api/groups/"), headers: <String, String>{"Authorization" : "Token $globaltoken"},);
                                        //        if (response3.statusCode == 200) {
                                        //                  final parsed = jsonDecode(utf8.decode(response3.bodyBytes));List<Group> groups = parsed.map<Group>((json) => Group.fromJSON(json)).toList();_user.groups2 = groups;
                                        //                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user:_user)))   ;
                                        //                      }
                                        print(_user.messagecount);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen(user: _user)));
                                      } else {
                                        error = response.body;
                                        setState(() {
                                          loginattempt = false;
                                        });
                                      }
                                    }

                                    Future<String> signIn(
                                        String email, String password) async {
                                      print('lololo');
                                      WidgetsFlutterBinding.ensureInitialized();
                                      final http.Response response =
                                          await http.post(
                                        Uri.parse("$SERVER_IP/auth/"),
                                        body: jsonEncode(<String, String>{
                                          'username': email,
                                          'password': password,
                                        }),
                                        headers: <String, String>{
                                          'Content-Type': 'application/json'
                                        },
                                      );
                                      print(response);
                                      if (response.statusCode == 200) {
                                        print('getting');
                                        var responseJson =
                                            json.decode(response.body);
                                        GetUser(responseJson['token']);
                                        UserData(email, password);
                                        globaltoken = responseJson['token'];
                                      } else {
                                        error = response.body;
                                        setState(() {
                                          loginattempt = false;
                                        });
                                      }
                                    }

                                    ;
                                    signincheck = 2;
                                    //   if(signincheck == 2)  loginattempt = true;

                                    if (signincheck == 2)
                                      signIn(_emailController.text,
                                          _passwordController.text);
                                    signincheck = 0;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.06,
                              child: ElevatedButton(
                                child: Text(
                                  signupst,
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.025,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => RegisterScreen(
                                            issubprofile: false, user: User())),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  child: ElevatedButton(
                                    child: Text(
                                      'English',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.025,
                                      ),
                                    ),
                                    onPressed: () {
                                      LanguageData('EN', true);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => RestartScreen(
                                              languagechangedto: 'EN'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  child: ElevatedButton(
                                    child: Text(
                                      'Türkçe',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.025,
                                      ),
                                    ),
                                    onPressed: () {
                                      LanguageData('TR', true);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => RestartScreen(
                                              languagechangedto: 'TR'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
