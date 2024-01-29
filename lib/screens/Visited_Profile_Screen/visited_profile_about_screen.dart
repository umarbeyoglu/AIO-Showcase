import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../colors.dart';
import '../../language.dart';
import '../../models/User_Model/user_model.dart';
import '../General/comments_screen.dart';
import '../General/profile_search_screen.dart';
import '../Profile_Screen/profile_details_screen.dart';
import '../User_Contact_Screen/profile_user_locations_screen.dart';
import '../User_Contact_Screen/profile_user_mails_screen.dart';
import '../User_Contact_Screen/profile_user_phones_screen.dart';

class Tagstatekeys {
  static final _tagStateKey1 = const Key('__TSK1__');
}

class VisitedAboutScreen extends StatefulWidget {
  final User user;
  final User visiteduser;
  const VisitedAboutScreen({Key key, this.user, this.visiteduser})
      : super(key: key);
  @override
  _VisitedAboutScreenState createState() =>
      _VisitedAboutScreenState(user: user, visiteduser: visiteduser, key: key);
}

class _VisitedAboutScreenState extends State<VisitedAboutScreen> {
  final User user;
  final User visiteduser;
  _VisitedAboutScreenState({Key key, this.user, this.visiteduser});
  int _column = 0;
  GlobalKey<TagsState> _tagStateKey = new GlobalKey<TagsState>();

  bool checkifnull(String data) {
    if (data == 'null') {
      return true;
    }
    if (data == null) {
      return true;
    }
    if (data == '') {
      return true;
    }
    if (data == ' ') {
      return true;
    }
    return false;
  }

  String WPComp(String phone) {
    if (phone.substring(0, 1) == '9') {
      return phone;
    }
    if (phone.substring(0, 1) == '0') {
      return '9$phone';
    }
    if (phone.substring(0, 1) == '5') {
      return '90$phone';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colordtmainone,
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
                  InkWell(
                    child: ListTile(
                      leading: Icon(Icons.search, color: colordtmaintwo),
                      title: Text(
                        searchprofilest,
                        style: TextStyle(
                            color: colordtmaintwo, fontWeight: FontWeight.bold),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProfileSearchScreen(
                            user: user,
                            visiteduser: visiteduser,
                          ),
                        ),
                      );
                    },
                  ),
                  Divider(
                    color: colordtmaintwo,
                  ),
                  visiteduser.phone_number == null
                      ? Container(
                          height: 0,
                          width: 0,
                        )
                      : Divider(
                          color: colordtmaintwo,
                        ),
                  (visiteduser.phone_number == null
                      ? Container(
                          height: 0,
                          width: 0,
                        )
                      : InkWell(
                          child: ListTile(
                            leading: Icon(
                              Icons.whatsapp,
                              color: colordtmaintwo,
                            ),
                            title: Text(
                              'Whatsapp',
                              style: TextStyle(
                                  color: colordtmaintwo,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onTap: () {
                            setState(() async {
                              var whatsapplink =
                                  "https://play.google.com/store/apps/details?id=com.whatsapp";
                              var whatsappUrl =
                                  "whatsapp://send?phone=${WPComp(visiteduser.phone_number)}";
                              await canLaunch(whatsappUrl)
                                  ? launch(whatsappUrl)
                                  : launch(whatsapplink);
                            });
                          },
                        )),
                  visiteduser.phone_number == null
                      ? Container(
                          height: 0,
                          width: 0,
                        )
                      : Divider(
                          color: colordtmaintwo,
                        ),
                  visiteduser.profile_type != 'B'
                      ? Container(
                          height: 0,
                          width: 0,
                        )
                      : InkWell(
                          child: ListTile(
                            leading: Icon(
                              Icons.comment,
                              color: colordtmaintwo,
                            ),
                            title: Text(
                              feedbacksst,
                              style: TextStyle(
                                  color: colordtmaintwo,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VisitedFeedbackScreen(
                                  user: user,
                                  visiteduser: visiteduser,
                                ),
                              ),
                            );
                          },
                        ),
                  visiteduser.profile_type != 'B'
                      ? Container(
                          height: 0,
                          width: 0,
                        )
                      : Divider(
                          color: colordtmaintwo,
                        ),
                  InkWell(
                    child: ListTile(
                      leading: Icon(
                        Icons.reorder,
                        color: colordtmaintwo,
                      ),
                      title: Text(
                        detailsst,
                        style: TextStyle(
                            color: colordtmaintwo, fontWeight: FontWeight.bold),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProfileDetailsScreen(
                            user: visiteduser,
                          ),
                        ),
                      );
                    },
                  ),
                  visiteduser.profile_type != 'B'
                      ? Container(
                          height: 0,
                          width: 0,
                        )
                      : Divider(
                          color: colordtmaintwo,
                        ),
                  visiteduser.profile_type != 'B'
                      ? Container(
                          height: 0,
                          width: 0,
                        )
                      : InkWell(
                          child: ListTile(
                            leading:
                                Icon(Icons.contact_mail, color: colordtmaintwo),
                            title: Text(
                              mailsst,
                              style: TextStyle(
                                  color: colordtmaintwo,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UserMailScreen(
                                    user: user, visiteduser: visiteduser),
                              ),
                            );
                          },
                        ),
                  visiteduser.profile_type != 'B'
                      ? Container(
                          height: 0,
                          width: 0,
                        )
                      : Divider(
                          color: colordtmaintwo,
                        ),
                  visiteduser.profile_type != 'B'
                      ? Container(
                          height: 0,
                          width: 0,
                        )
                      : InkWell(
                          child: ListTile(
                            leading:
                                Icon(Icons.location_on, color: colordtmaintwo),
                            title: Text(
                              locationsst,
                              style: TextStyle(
                                  color: colordtmaintwo,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UserLocationScreen(
                                    user: user, visiteduser: visiteduser),
                              ),
                            );
                          },
                        ),
                  visiteduser.profile_type != 'B'
                      ? Container(
                          height: 0,
                          width: 0,
                        )
                      : Divider(
                          color: colordtmaintwo,
                        ),
                  visiteduser.profile_type != 'B'
                      ? Container(
                          height: 0,
                          width: 0,
                        )
                      : InkWell(
                          child: ListTile(
                            leading: Icon(Icons.phone, color: colordtmaintwo),
                            title: Text(
                              phonesst,
                              style: TextStyle(
                                  color: colordtmaintwo,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UserPhoneScreen(
                                    user: user, visiteduser: visiteduser),
                              ),
                            );
                          },
                        ),
                  visiteduser.profile_type != 'B'
                      ? Container(
                          height: 0,
                          width: 0,
                        )
                      : Divider(
                          color: colordtmaintwo,
                        ),
                ]),
              ])),
        ],
      ),
    );
  }
}
