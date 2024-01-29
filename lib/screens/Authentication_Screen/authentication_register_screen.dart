import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../colors.dart';
import '../../language.dart';
import '../../models/User_Model/user_model.dart';
import '../../repository.dart';
import '../First_Time_Screen/first_time_name_screen.dart';
import '../General/home_screen.dart';
import '../General/terms_screen.dart';

class RegisterScreen extends StatefulWidget {
  final User user;
  final bool issubprofile;
  const RegisterScreen({Key key, this.user, this.issubprofile})
      : super(key: key);
  @override
  RegisterScreenState createState() =>
      RegisterScreenState(user: user, issubprofile: issubprofile);
}

class RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final User user;
  final bool issubprofile;
  RegisterScreenState({Key key, this.user, this.issubprofile});
  String createpersonprofiletype = 'P';
  String createpersongendertype = 'NB';
  User uniuser;
  bool approved = false;
  bool errortrue = false;
  bool termsandconditions = false;
  bool allowcalendar = false;
  bool allowsubusers = false;
  File image;
  int signupcheck = 0;
  int signupcheck2 = 0;
  bool obscurepassword = true;
  final _formKey = GlobalKey<FormState>();
  final navigatorKey2 = GlobalKey<NavigatorState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _phonenumber = TextEditingController();
  final TextEditingController _businesstype = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  final TextEditingController tags = TextEditingController();
  final TextEditingController locations = TextEditingController();
  final TextEditingController phones = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  List<String> locationsfinal = [''];
  List<String> phonesfinal = [''];
  List<String> tagsfinal = [''];
  int _column = 0;
  int _column2 = 0;
  bool emailexists = false;
  bool usernameexists = false;
  List<User> _users = [];
  List<User> _usersForDisplay = [];

  Userdata(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
    prefs.setString("password", password);
  }

  pickFromCamera() async {
    final _image =
        await picker.getImage(source: ImageSource.camera, imageQuality: 80);

    setState(() {
      image = File(_image.path);
    });
  }

  pickFromPhone() async {
    final _image =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 80);

    setState(() {
      image = File(_image.path);
    });
  }

  profiletypechoice(String profiletypes) {
    if (profiletypes == personst) {
      setState(() {
        createpersonprofiletype = 'P';
      });
    } else if (profiletypes == businessst) {
      setState(() {
        createpersonprofiletype = 'B';
      });
    }
  }

  @override
  String tagsinit() {
    locationsfinal = locations.text.split(',');
    phonesfinal = phones.text.split(',');
    tagsfinal = tags.text.split(',');
  }

  bool doesemailexist(List<User> users) {
    for (int i = 0; i < users.length; i++) {
      if (users[i].email == _email.text) {
        emailexists = true;
        return true;
      }
    }
    return false;
  }

  bool doesusernameexist(List<User> users) {
    for (int i = 0; i < users.length; i++) {
      if (users[i].username == _username.text) {
        usernameexists = true;
        return true;
      }
    }
    return false;
  }

  navigatelogin(User loginuser, String subprofileusername) {
    locationcountrygl = '-';
    locationstategl = '-';
    locationcitygl = '-';
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
        loginuser = User.fromJSON(responseJson[0]);

        if (issubprofile) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => HomeScreen(user: user)));
        }
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FirstTimeNameScreen(user: loginuser)));
      }
      //   if(issubprofile){Navigator.pop(context);}
      else {
        String error = response.body;

        _showError(error);
      }
    }

    ;
    Future<String> signIn(String email, String password) async {
      WidgetsFlutterBinding.ensureInitialized();
      final http.Response response = await http.post(
        Uri.parse("$SERVER_IP/auth/"),
        body: jsonEncode(<String, String>{
          'username': issubprofile ? subprofileusername : email,
          'password': password,
        }),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        GetUser(responseJson['token']);
        UserData(issubprofile ? subprofileusername : email, password);
        globaltoken = responseJson['token'];
      } else {
        String error = response.body;
        _showError(error);
      }
    }

    ;
    signIn(issubprofile ? subprofileusername : _email.text, _password.text);
  }

  _showSuccess() {
    print('success');
    return;
  }

  _showError(String error) {
    print(error);
    return;
  }

  void init() {
    locationcountrygl = '';
    locationstategl = '';
    locationcitygl = '';
    if (issubprofile == null) {
      issubprofile == false;
    }
  }

  @override
  void initState() {
    RegisteringCheck().then((value) {
      setState(() {
        _users.addAll(value);
        _usersForDisplay = _users;
      });
    });
    super.initState();
  }

  @override
  Future<List<User>> callUsers() async {
    Future<List<User>> _user = FetchRegisteredUsers();
    return _user;
  }

  Widget build(BuildContext context) {
    init();
    return createpersonprofiletype == 'P'
        ? Scaffold(
            backgroundColor: colordtmainone,
            key: _scaffoldKey,
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 1.7,
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
                          joinusst,
                          style: TextStyle(
                            color: colordtmaintwo,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.07,
                              vertical:
                                  MediaQuery.of(context).size.height * 0.011,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  child: Text(
                                    userst,
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                  ),
                                  onPressed: () {
                                    createpersonprofiletype = 'P';
                                  },
                                ),
                                ElevatedButton(
                                  child: Text(
                                    businessst,
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      createpersonprofiletype = 'B';
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          issubprofile
                              ? Container(
                                  height: 0,
                                  width: 0,
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.01,
                                      right: MediaQuery.of(context).size.width *
                                          0.01),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.023,
                                    ),
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
                                        controller: _email,
                                        maxLength: 30,
                                        maxLengthEnforcement:
                                            MaxLengthEnforcement.enforced,
                                        decoration: InputDecoration(
                                          hintText: emailst,
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: colordtmaintwo),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            doesemailexist(_usersForDisplay)
                                ? emailexistsst
                                : '',
                            style: TextStyle(color: Colors.red),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.01,
                                right:
                                    MediaQuery.of(context).size.width * 0.01),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.023,
                              ),
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
                                  controller: _username,
                                  maxLength: 30,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                  decoration: InputDecoration(
                                    hintText: usernamest,
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: colordtmaintwo),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            doesusernameexist(_usersForDisplay)
                                ? usernameexistsst
                                : '',
                            style: TextStyle(color: Colors.red),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.01,
                                right:
                                    MediaQuery.of(context).size.width * 0.01),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.023,
                              ),
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
                                  controller: _password,
                                  obscureText: true,
                                  maxLength: 60,
                                  maxLengthEnforcement:
                                      MaxLengthEnforcement.enforced,
                                  decoration: InputDecoration(
                                    hintText: passwordst,
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: colordtmaintwo),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(height: 20),
                          CheckboxListTile(
                            title: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TermsScreen()));
                              },
                              child: Text(termsandconditionsst,
                                  style: TextStyle(
                                      color: colordtmaintwo,
                                      fontWeight: FontWeight.w400)),
                            ),
                            value: termsandconditions,
                            onChanged: (bool value) {
                              setState(() {
                                termsandconditions = value;
                              });
                            },
                            secondary: const Icon(Icons.format_list_numbered),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.07),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.36,
                            height: MediaQuery.of(context).size.height * 0.07,
                            child: ElevatedButton(
                              child: Text(
                                registerst,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.025,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  Future<User> CreateUser(
                                      String email,
                                      String password,
                                      String username,
                                      String firstname,
                                      String lastname,
                                      String location,
                                      String gender,
                                      String profiletype,
                                      String phone,
                                      String about,
                                      File image,
                                      String tags) async {
                                    final http.Response response =
                                        await http.post(
                                      Uri.parse(
                                        "$SERVER_IP/api/register/",
                                      ),
                                      headers: <String, String>{
                                        'Content-Type': 'application/json',
                                      },
                                      body: jsonEncode(<String, dynamic>{
                                        'email': email, // done
                                        'username': username, // done
                                        'password': password, // done
                                        'fullname': '-', // done
                                        'phone_number': '0', // done
                                        'business_type': '-',
                                        'calendar_type': 'nocalendar',
                                        'issubusersallowed': false, // done
                                        'details': '-', // done
                                        'isprofileanon': false, // don
                                        'intensity': 'normal',
                                        'parent': '',
                                        'locationcountry': '-',
                                        'locationstate': '-',
                                        'locationcity': '-', // done
                                        'user_type': 'P', // done
                                        'image': null, // done
                                      }),
                                    );

                                    if (response.statusCode == 201) {
                                      _showSuccess();
                                      var responseJson =
                                          json.decode(response.body);
                                      uniuser = User.fromJSON(responseJson);
                                      final http.Response response2 =
                                          await http.post(
                                        Uri.parse("$SERVER_IP/auth/"),
                                        body: jsonEncode(<String, String>{
                                          'username': email,
                                          'password': password,
                                        }),
                                        headers: <String, String>{
                                          'Content-Type': 'application/json',
                                        },
                                      );
                                      if (response2.statusCode == 200) {
                                        var responseJson =
                                            json.decode(response.body);
                                        globaltoken = responseJson['token'];
                                        Future.delayed(new Duration(seconds: 2),
                                            () {
                                          navigatelogin(uniuser, '');
                                        });
                                      }
                                    } else {
                                      errortrue = true;
                                    }
                                  }

                                  Future<User> CreateUserSub(
                                      String email,
                                      String password,
                                      String username,
                                      String firstname,
                                      String lastname,
                                      String location,
                                      String gender,
                                      String profiletype,
                                      String phone,
                                      String about,
                                      File image,
                                      String tags) async {
                                    final http.Response response =
                                        await http.post(
                                      Uri.parse(
                                        "$SERVER_IP/api/register/",
                                      ),
                                      headers: <String, String>{
                                        'Content-Type': 'application/json',
                                        "Authorization": "Token ${globaltoken}",
                                      },
                                      body: jsonEncode(<String, dynamic>{
                                        'email':
                                            '$username.${user.email}', // done
                                        'username': username, // done
                                        'password': password, // done
                                        'fullname': '-', // done
                                        'phone_number': '0', // done
                                        'business_type': '',
                                        'calendar_type': 'nocalendar',
                                        'issubusersallowed': false, // done
                                        'details': '-', // done
                                        'isprofileanon': false, // don
                                        'intensity': 'unspecified',
                                        'parent': user.id,
                                        'locationcountry': '-',
                                        'locationstate': '-',
                                        'locationcity': '-', // done
                                        'user_type': 'P', // done
                                        'image': null, // done
                                      }),
                                    );

                                    if (response.statusCode == 201) {
                                      _showSuccess();

                                      var responseJson =
                                          json.decode(response.body);
                                      String responseinit =
                                          responseJson.toString();

                                      uniuser = User.fromJSON(responseJson);
                                      final http.Response response2 =
                                          await http.post(
                                        Uri.parse("$SERVER_IP/auth/"),
                                        body: jsonEncode(<String, String>{
                                          'username': '$username.${user.email}',
                                          'password': password,
                                        }),
                                        headers: <String, String>{
                                          'Content-Type': 'application/json',
                                        },
                                      );

                                      if (response2.statusCode == 200) {
                                        var responseJson =
                                            json.decode(response.body);
                                        globaltoken = responseJson['token'];
                                        Future.delayed(new Duration(seconds: 2),
                                            () {
                                          navigatelogin(uniuser,
                                              '$username.${user.email}');
                                        });
                                      }
                                    } else {
                                      errortrue = true;
                                    }
                                  }

                                  Userdata(_email.text, _password.text);
                                  // ignore: unnecessary_statements
                                  issubprofile
                                      ? (_email.text = '')
                                      : (_email.text == ''
                                          ? _showError(validemailst)
                                          : signupcheck = signupcheck + 1);
                                  _password.text == ''
                                      ? _showError(validps2st)
                                      : signupcheck = signupcheck + 1;
                                  _username.text == ''
                                      ? _showError(validusernamest)
                                      : signupcheck = signupcheck + 1;
                                  termsandconditions == false
                                      ? _showError(termsandconditionserrorst)
                                      : signupcheck = signupcheck + 1;

                                  if (emailexists == false) {
                                    signupcheck = signupcheck + 1;
                                  }
                                  if (usernameexists == false) {
                                    signupcheck = signupcheck + 1;
                                  }
                                  signupcheck2 = signupcheck;
                                  signupcheck = 0;
                                  // ignore: unnecessary_statements
                                  issubprofile
                                      ? (signupcheck2 == 5
                                          ? CreateUserSub(
                                              _email.text,
                                              _password.text,
                                              _username.text,
                                              _firstname.text,
                                              _lastname.text,
                                              _location.text,
                                              null,
                                              createpersonprofiletype,
                                              _phonenumber.text
                                              // ignore: unnecessary_statements
                                              ,
                                              _bio.text,
                                              image,
                                              tags.text)
                                          : _showError(inputerrorst))
                                      : (signupcheck2 == 6
                                          ? CreateUser(
                                              _email.text,
                                              _password.text,
                                              _username.text,
                                              _firstname.text,
                                              _lastname.text,
                                              _location.text,
                                              null,
                                              createpersonprofiletype,
                                              _phonenumber.text,
                                              _bio.text,
                                              image,
                                              tags.text)
                                          : _showError(inputerrorst));
                                  signupcheck = 0;
                                  if (errortrue == true) {
                                    errortrue = false;
                                    _showError(errortruest);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: colordtmainone,
            key: _scaffoldKey,
            body: SingleChildScrollView(
                child: Container(
              height: MediaQuery.of(context).size.height * 1.7,
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
                        joinusst,
                        style: TextStyle(
                          color: colordtmaintwo,
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.07,
                            vertical:
                                MediaQuery.of(context).size.height * 0.011,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                child: Text(
                                  userst,
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02,
                                  ),
                                ),
                                onPressed: () {
                                  createpersonprofiletype = 'P';
                                },
                              ),
                              ElevatedButton(
                                child: Text(
                                  businessst,
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    createpersonprofiletype = 'B';
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        issubprofile
                            ? Container(
                                height: 0,
                                width: 0,
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.01,
                                    right: MediaQuery.of(context).size.width *
                                        0.01),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.023,
                                  ),
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
                                      controller: _email,
                                      maxLength: 30,
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.enforced,
                                      decoration: InputDecoration(
                                        hintText: emailst,
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: colordtmaintwo),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          doesemailexist(_usersForDisplay) ? emailexistsst : '',
                          style: TextStyle(color: Colors.red),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.01,
                              right: MediaQuery.of(context).size.width * 0.01),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.023,
                            ),
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
                                controller: _username,
                                maxLength: 30,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                decoration: InputDecoration(
                                  hintText: usernamest,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: colordtmaintwo),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          doesusernameexist(_usersForDisplay)
                              ? usernameexistsst
                              : '',
                          style: TextStyle(color: Colors.red),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.01,
                              right: MediaQuery.of(context).size.width * 0.01),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.023,
                            ),
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
                                controller: _password,
                                obscureText: true,
                                maxLength: 60,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                decoration: InputDecoration(
                                  hintText: passwordst,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: colordtmaintwo),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        CheckboxListTile(
                          title: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => TermsScreen()));
                            },
                            child: Text(termsandconditionsst,
                                style: TextStyle(
                                    color: colordtmaintwo,
                                    fontWeight: FontWeight.w400)),
                          ),
                          value: termsandconditions,
                          onChanged: (bool value) {
                            setState(() {
                              termsandconditions = value;
                            });
                          },
                          secondary: const Icon(Icons.format_list_numbered),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.36,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: ElevatedButton(
                            child: Text(
                              registerst,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.025,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                Future<User> CreateUserSub(
                                    String email,
                                    String password,
                                    String username,
                                    String firstname,
                                    String lastname,
                                    String location,
                                    String gender,
                                    String profiletype,
                                    String phone,
                                    String about,
                                    String businesstype,
                                    File image,
                                    String tags) async {
                                  final http.Response response =
                                      await http.post(
                                    Uri.parse(
                                      "$SERVER_IP/api/register/",
                                    ),
                                    headers: <String, String>{
                                      'Content-Type': 'application/json',
                                      "Authorization": "Token ${globaltoken}",
                                    },
                                    body: jsonEncode(<String, dynamic>{
                                      'email':
                                          '$username.${user.email}', // done
                                      'username': username, // done
                                      'password': password, // done
                                      'fullname': '-', // done
                                      'phone_number': '0', // done
                                      'business_type': '',
                                      'calendar_type': 'nocalendar',
                                      'issubusersallowed': false, // done
                                      'details': '-', // done
                                      'isprofileanon': false, // don
                                      'intensity': 'unspecified',
                                      'parent': user.id,
                                      'locationcountry': '-',
                                      'locationstate': '-',
                                      'locationcity': '-', // done
                                      'user_type': 'B', // done
                                      'image': null, // done
                                    }),
                                  );

                                  if (response.statusCode == 201) {
                                    _showSuccess();

                                    var responseJson =
                                        json.decode(response.body);
                                    String responseinit =
                                        responseJson.toString();

                                    uniuser = User.fromJSON(responseJson);
                                    final http.Response response2 =
                                        await http.post(
                                      Uri.parse("$SERVER_IP/auth/"),
                                      body: jsonEncode(<String, String>{
                                        'username': '$username.${user.email}',
                                        'password': password,
                                      }),
                                      headers: <String, String>{
                                        'Content-Type': 'application/json',
                                      },
                                    );

                                    if (response2.statusCode == 200) {
                                      var responseJson =
                                          json.decode(response.body);
                                      globaltoken = responseJson['token'];
                                      Future.delayed(new Duration(seconds: 2),
                                          () {
                                        navigatelogin(
                                            uniuser, '$username.${user.email}');
                                      });
                                    }
                                  } else {
                                    errortrue = true;
                                  }
                                }

                                Future<User> CreateUser(
                                    String email,
                                    String password,
                                    String username,
                                    String firstname,
                                    String lastname,
                                    String location,
                                    String gender,
                                    String profiletype,
                                    String phone,
                                    String about,
                                    String businesstype,
                                    File image,
                                    String tags) async {
                                  final http.Response response =
                                      await http.post(
                                    Uri.parse("$SERVER_IP/api/register/"),
                                    headers: <String, String>{
                                      'Content-Type': 'application/json',
                                    },
                                    body: jsonEncode(<String, dynamic>{
                                      'email': issubprofile
                                          ? '$username.${user.email}'
                                          : email, // done
                                      'username': username, // done
                                      'password': password, // done
                                      'fullname': '-', // done
                                      'phone_number': '0', // done
                                      'business_type': '-', // done
                                      'details': '-', // done
                                      'parent': issubprofile ? user.id : '',
                                      'issubusersallowed': false,
                                      'calendar_type': 'nocalendar', // done
                                      'locationcountry': '-',
                                      'locationstate': '-',
                                      'locationcity': '-', //
                                      'user_type': 'B', // done
                                      'intensity': 'normal',
                                      'isprofileanon': false, // done
                                    }),
                                  );

                                  if (response.statusCode == 201) {
                                    _showSuccess();
                                    var responseJson =
                                        json.decode(response.body);
                                    String responseinit =
                                        responseJson.toString();

                                    uniuser = User.fromJSON(responseJson);
                                    final http.Response response2 =
                                        await http.post(
                                      Uri.parse("$SERVER_IP/auth/"),
                                      body: jsonEncode(<String, String>{
                                        'username': issubprofile
                                            ? '$username.${user.email}'
                                            : email,
                                        'password': password,
                                      }),
                                      headers: <String, String>{
                                        'Content-Type': 'application/json',
                                      },
                                    );

                                    if (response2.statusCode == 200) {
                                      var responseJson =
                                          json.decode(response.body);
                                      globaltoken = responseJson['token'];
                                      Future.delayed(new Duration(seconds: 2),
                                          () {
                                        navigatelogin(uniuser, '');
                                      });
                                    }
                                  } else {
                                    errortrue = true;
                                  }
                                }

                                Userdata(_email.text, _password.text);
                                issubprofile
                                    ? (_email.text = '')
                                    : (_email.text == ''
                                        ? _showError(validemailst)
                                        : signupcheck = signupcheck + 1);
                                _password.text == ''
                                    ? _showError(validps2st)
                                    : signupcheck = signupcheck + 1;
                                _username.text == ''
                                    ? _showError(validusernamest)
                                    : signupcheck = signupcheck + 1;
                                termsandconditions == false
                                    ? _showError(termsandconditionserrorst)
                                    : signupcheck = signupcheck + 1;
                                if (emailexists == false) {
                                  signupcheck = signupcheck + 1;
                                }
                                if (usernameexists == false) {
                                  signupcheck = signupcheck + 1;
                                }
                                signupcheck2 = signupcheck;
                                signupcheck = 0;

                                issubprofile
                                    ? (signupcheck2 == 5
                                        ? CreateUserSub(
                                            _email.text,
                                            _password.text,
                                            _username.text,
                                            _firstname.text,
                                            _lastname.text,
                                            _location.text,
                                            null,
                                            createpersonprofiletype,
                                            _phonenumber.text,
                                            _bio.text,
                                            _businesstype.text,
                                            image,
                                            tags.text)
                                        : _showError(inputerrorst))
                                    : (signupcheck2 == 6
                                        ? CreateUser(
                                            _email.text,
                                            _password.text,
                                            _username.text,
                                            _firstname.text,
                                            _lastname.text,
                                            _location.text,
                                            null,
                                            createpersonprofiletype,
                                            _phonenumber.text,
                                            _bio.text,
                                            _businesstype.text,
                                            image,
                                            tags.text)
                                        : _showError(inputerrorst));
                                signupcheck = 0;
                                if (errortrue == true) {
                                  errortrue = false;
                                  _showError(errortruest);
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          );
  }
}
