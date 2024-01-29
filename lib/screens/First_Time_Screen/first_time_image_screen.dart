import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio_http/dio_http.dart';
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
import 'first_time_public_profile_screen.dart';

class Tagstatekeys {
  static final _tagStateKey1 = const Key('__TSK1__');
}

class FirstTimeImageScreen extends StatefulWidget {
  final User user;
  const FirstTimeImageScreen({
    Key key,
    this.user,
  }) : super(key: key);
  @override
  FirstTimeImageScreenState createState() =>
      FirstTimeImageScreenState(user: user);
}

class FirstTimeImageScreenState extends State<FirstTimeImageScreen>
    with SingleTickerProviderStateMixin {
  final User user;

  FirstTimeImageScreenState({Key key, this.user});
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  List<String> tagsfinal = [''];
  int _column = 0;

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
          builder: (context) => FirstTimePublicProfileScreen(user: mainuser)));
    }
  }

  @override

  //    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user:loginuser))) ;
//   if(tagsfinal.isNotEmpty){ for (int i = 0; i < tagsfinal.length; i++) {CreateUserTags(tagsfinal[i],uniuser.id);}}

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
                    firsttimeimagest,
                    style: TextStyle(
                      color: colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height * 0.025,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  image == null
                      ? Container(
                          height: 0,
                          width: 0,
                        )
                      : SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Image.file(
                            image,
                            fit: BoxFit.cover,
                          )),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.035),
                      IconButton(
                        tooltip: tfcamerast,
                        icon: Icon(Icons.add_a_photo, color: colordtmaintwo),
                        onPressed: () {
                          pickFromCamera();
                        },
                      ),
                      IconButton(
                        tooltip: tfphonest,
                        icon: Icon(Icons.add_photo_alternate,
                            color: colordtmaintwo),
                        onPressed: () {
                          pickFromPhone();
                        },
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 2),
                    child: Text(
                      user.profile_type == 'B'
                          ? firsttimeimagebsexpst
                          : firsttimeimageexpst,
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
                      CreateUserPP(String userid, File image) async {
                        String imagename;
                        imagename = image == null
                            ? 'empty'
                            : (imagename = image.path.split('/').last);
                        try {
                          if (imagename == 'empty') {
                          } else if (imagename != 'empty') {
                            FormData formData2 = new FormData.fromMap({
                              'image': await MultipartFile.fromFile(image.path,
                                  filename: imagename),
                            });
                            Response response2 = await Dio().patch(
                                "$SERVER_IP/api/ownuser/$userid/",
                                data: formData2,
                                options: Options(headers: {
                                  "Authorization": "Token ${globaltoken}"
                                }));
                            if (response2.statusCode == 201) {
                              print('Image Created');
                            }
                          }
                        } catch (e) {
                          print(e);
                        }
                      }

                      CreateUserPP(user.id, image);
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
                          print(globaltoken);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  FirstTimeLocationScreen(user: user)));
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
