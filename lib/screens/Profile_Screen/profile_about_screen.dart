import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/screens/Profile_Screen/profile_bookmarks_screen.dart';
import 'package:flutter_food_delivery_app/screens/Profile_Screen/profile_details_screen.dart';
import 'package:flutter_food_delivery_app/screens/Profile_Screen/profile_settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../colors.dart';
import '../../language.dart';
import '../../models/User_Model/user_model.dart';
import '../../repository.dart';
import '../Calendar_Screen/calendar_schedule_screen.dart';
import '../General/cart_screen.dart';
import '../General/comments_screen.dart';
import '../General/meeting_screen.dart';
import '../General/reservation_screen.dart';
import '../User_Contact_Screen/profile_user_locations_screen.dart';
import '../User_Contact_Screen/profile_user_mails_screen.dart';
import '../User_Contact_Screen/profile_user_phones_screen.dart';

class AboutScreen extends StatefulWidget {
  final User user;
  const AboutScreen({Key key, this.user}) : super(key: key);
  @override
  AboutScreenState createState() => AboutScreenState(user: user);
}

class AboutScreenState extends State<AboutScreen> {
  final User user;
  AboutScreenState({Key key, this.user});

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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              if (user.profile_type == 'B')
                InkWell(
                  child: ListTile(
                    leading: Icon(
                      Icons.comment,
                      color: colordtmaintwo,
                    ),
                    title: Text(
                      feedbacksst,
                      style: TextStyle(
                          color: colordtmaintwo, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FeedbackScreen(user: user),
                      ),
                    );
                  },
                ),
              if (user.profile_type == 'B')
                Divider(
                  color: colordtmaintwo,
                ),
              user.profile_type != 'B'
                  ? Container(
                      height: 0,
                      width: 0,
                    )
                  : InkWell(
                      child: ListTile(
                        leading: Icon(
                          Icons.reorder,
                          color: colordtmaintwo,
                        ),
                        title: Text(
                          detailsst,
                          style: TextStyle(
                              color: colordtmaintwo,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProfileDetailsScreen(
                              user: user,
                            ),
                          ),
                        );
                      },
                    ),
              if (user.cartitems.isNotEmpty)
                Divider(
                  color: colordtmaintwo,
                ),
              if (user.cartitems.isNotEmpty)
                InkWell(
                  child: ListTile(
                    leading: Icon(Icons.shopping_cart_checkout,
                        color: colordtmaintwo),
                    title: Text(checkoutst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.bold)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GeneralCartScreen(
                          user: user,
                        ),
                      ),
                    );
                  },
                ),
              Divider(
                color: colordtmaintwo,
              ),
              user.profile_type != 'B'
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
                            builder: (_) =>
                                UserMailScreen(user: user, visiteduser: user),
                          ),
                        );
                      },
                    ),
              user.profile_type != 'B'
                  ? Container(
                      height: 0,
                      width: 0,
                    )
                  : Divider(
                      color: colordtmaintwo,
                    ),
              user.profile_type != 'B'
                  ? Container(
                      height: 0,
                      width: 0,
                    )
                  : InkWell(
                      child: ListTile(
                        leading: Icon(Icons.location_on, color: colordtmaintwo),
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
                                user: user, visiteduser: user),
                          ),
                        );
                      },
                    ),
              user.profile_type != 'B'
                  ? Container(
                      height: 0,
                      width: 0,
                    )
                  : Divider(
                      color: colordtmaintwo,
                    ),
              user.profile_type != 'B'
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
                            builder: (_) =>
                                UserPhoneScreen(user: user, visiteduser: user),
                          ),
                        );
                      },
                    ),
              Divider(
                color: colordtmaintwo,
              ),
              InkWell(
                child: ListTile(
                  leading: Icon(Icons.perm_contact_calendar_outlined,
                      color: colordtmaintwo),
                  title: Text(takenappointmentsst,
                      style: TextStyle(
                          color: colordtmaintwo, fontWeight: FontWeight.bold)),
                ),
                onTap: () {
                  FetchUser(user.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CalendarScheduleScreen(
                        user: user,
                      ),
                    ),
                  );
                },
              ),
              Divider(
                color: colordtmaintwo,
              ),
              InkWell(
                child: ListTile(
                  leading:
                      Icon(Icons.perm_contact_calendar, color: colordtmaintwo),
                  title: Text(meetingschedulesst,
                      style: TextStyle(
                          color: colordtmaintwo, fontWeight: FontWeight.bold)),
                ),
                onTap: () {
                  FetchUser(user.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MeetingScheduleScreen(
                        user: user,
                      ),
                    ),
                  );
                },
              ),
              Divider(
                color: colordtmaintwo,
              ),
              InkWell(
                child: ListTile(
                  leading:
                      Icon(Icons.calendar_today_rounded, color: colordtmaintwo),
                  title: Text(reservationschedulesst,
                      style: TextStyle(
                          color: colordtmaintwo, fontWeight: FontWeight.bold)),
                ),
                onTap: () {
                  FetchUser(user.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReservationScheduleScreen2(
                        user: user,
                      ),
                    ),
                  );
                },
              ),
              Divider(
                color: colordtmaintwo,
              ),
              InkWell(
                child: ListTile(
                  leading: Icon(Icons.calendar_today_outlined,
                      color: colordtmaintwo),
                  title: Text(reservationdeactivateddaysst,
                      style: TextStyle(
                          color: colordtmaintwo, fontWeight: FontWeight.bold)),
                ),
                onTap: () {
                  FetchUser(user.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RDDStatusScreen(
                        user: user,
                      ),
                    ),
                  );
                },
              ),
              Divider(
                color: colordtmaintwo,
              ),
              InkWell(
                child: ListTile(
                  leading: Icon(Icons.bookmark, color: colordtmaintwo),
                  title: Text(bookmarksst,
                      style: TextStyle(
                          color: colordtmaintwo, fontWeight: FontWeight.bold)),
                ),
                onTap: () {
                  FetchUser(user.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookmarksScreen(
                        user: user,
                      ),
                    ),
                  );
                },
              ),

              Divider(
                color: colordtmaintwo,
              ),
              InkWell(
                child: ListTile(
                  leading: Icon(Icons.settings, color: colordtmaintwo),
                  title: Text(
                    settingsst,
                    style: TextStyle(
                        color: colordtmaintwo, fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SettingsScreen(
                        user: user,
                      ),
                    ),
                  );
                },
              ),
              Divider(
                color: colordtmaintwo,
              ),

              //Divider(color: colordtmaintwo,), InkWell(child:ListTile(title: Text(groupsst,style: TextStyle(color: colordtmaintwo,)),),
              //  onTap: (){Navigator.push(context , MaterialPageRoute(builder: (_) => GroupFetchScreen(user:user,),),);},),
            ]),
          )
        ],
      ),
    );
  }
}
