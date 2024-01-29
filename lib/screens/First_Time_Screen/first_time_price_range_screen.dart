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

class Tagstatekeys {
  static final _tagStateKey1 = const Key('__TSK1__');
}

class FirstTimePriceRangeScreen extends StatefulWidget {
  final User user;
  const FirstTimePriceRangeScreen({
    Key key,
    this.user,
  }) : super(key: key);
  @override
  FirstTimePriceRangeScreenState createState() =>
      FirstTimePriceRangeScreenState(user: user);
}

class FirstTimePriceRangeScreenState extends State<FirstTimePriceRangeScreen>
    with SingleTickerProviderStateMixin {
  final User user;

  FirstTimePriceRangeScreenState({Key key, this.user});
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  List<String> tagsfinal = [''];
  int _column = 0;
  String pricerange = '';

  categories13(String categorieschoices) {
    if (categorieschoices == premiumst) {
      pricerange = '$premiumst';
      setState(() {
        EditUserPriceRange(user, 'premium', context);
      });
    }
    if (categorieschoices == highst) {
      pricerange = '$highst';
      setState(() {
        EditUserPriceRange(user, 'high', context);
      });
    }
    if (categorieschoices == standardst) {
      pricerange = '$standardst';
      setState(() {
        EditUserPriceRange(user, 'standard', context);
      });
    }
    if (categorieschoices == lowst) {
      setState(() {
        pricerange = '$lowst';
        EditUserPriceRange(user, 'low', context);
      });
    }
    if (categorieschoices == unspecifiedst) {
      pricerange = '$unspecifiedst';
      setState(() {
        EditUserPriceRange(user, '', context);
      });
    }
  }

  Future<User> refreshProfile() async {
    WidgetsFlutterBinding.ensureInitialized();
    final http.Response response = await http.get(
      Uri.parse("$SERVER_IP/api/ownuser/"),
      headers: <String, String>{"Authorization": "Token ${globaltoken}"},
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      User mainuser = User.fromJSON(responseJson[0]);

      return Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HomeScreen(user: mainuser)));
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    firsttimepricerangest,
                    style: TextStyle(
                      color: colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height * 0.025,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        '$pricerangest : $pricerange',
                        style: TextStyle(
                          color: colordtmaintwo,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.026,
                        ),
                      ),
                      PopupMenuButton<String>(
                        onSelected: categories13,
                        itemBuilder: (BuildContext context) {
                          return pricerangechoices.map((String categories) {
                            return PopupMenuItem<String>(
                              value: categories,
                              child: Text(
                                categories,
                                style: TextStyle(
                                  color: colordtmaintwo,
                                ),
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 2),
                    child: Text(
                      firsttimepricerangeexpst,
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomeScreen(user: user)));
                    },
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
