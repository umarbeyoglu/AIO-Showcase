import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/screens/Profile_Screen/profile_about_screen.dart';
import 'package:flutter_food_delivery_app/screens/Profile_Screen/profile_change_status_screen.dart';
import 'package:flutter_food_delivery_app/screens/Profile_Screen/profile_feed_screen.dart';
import 'package:flutter_food_delivery_app/screens/Profile_Screen/profile_followers_screen.dart';
import 'package:flutter_food_delivery_app/screens/Profile_Screen/profile_following_screen.dart';
import 'package:flutter_food_delivery_app/screens/Profile_Screen/profile_image_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../colors.dart';
import '../../language.dart';
import '../../models/Article_Model/article_model.dart';
import '../../models/User_Model/user_model.dart';
import '../../repository.dart';
import '../First_Time_Screen/edit_hotel_screen.dart';
import '../First_Time_Screen/edit_wifi_screen.dart';
import '../General/home_screen.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  final User visiteduser;
  const ProfileScreen({Key key, this.user, this.visiteduser}) : super(key: key);

  @override
  ProfileScreenState createState() =>
      ProfileScreenState(user: user, visiteduser: visiteduser);
}

class ProfileScreenState extends State<ProfileScreen> {
  final User user;
  final User visiteduser;
  ProfileScreenState({Key key, this.user, this.visiteduser});
  Future fetchPostsfuture;
  ScrollController _scrollController = ScrollController();
  List<Article> posts = [];
  CleanSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  int page = 1;
  bool isLoading = false;

  bool checknullity(String parameter) {
    if (parameter == '-') {
      return true;
    }
    if (parameter == '') {
      return true;
    }
    if (parameter == ' ') {
      return true;
    }
    if (parameter == 'null') {
      return true;
    }
    if (parameter == null) {
      return true;
    }
    return false;
  }

  Future<Null> refreshList() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(
          user: user,
        ),
      ),
    );
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
      //   final http.Response response3 = await http.get(Uri.parse("$SERVER_IP/api/groups/"),
      //    headers: <String, String>{"Authorization" : "Token $globaltoken"},);
      //    final parsed = jsonDecode(utf8.decode(response3.bodyBytes));
      //  mainuser.groups2 = parsed.map<Group>((json) => Group.fromJSON(json)).toList();
      //   print(mainuser.groups2.first.name);
      setState(() {
        user.pricerange = mainuser.pricerange;
        user.intensity = mainuser.intensity;
        user.businessstatus = mainuser.businessstatus;
      });
    }
  }

  categories11(String categorieschoices) {
    if (categorieschoices == verybusyst) {
      setState(() {
        EditUserIntensity(user, 'verybusy', context);
        Future.delayed(Duration(seconds: 1), () => refreshProfile());
      });
    }
    if (categorieschoices == busyst) {
      setState(() {
        EditUserIntensity(user, 'busy', context);
        Future.delayed(Duration(seconds: 1), () => refreshProfile());
      });
    }
    if (categorieschoices == normalst) {
      setState(() {
        EditUserIntensity(user, 'normal', context);
        Future.delayed(Duration(seconds: 1), () => refreshProfile());
      });
    }
    if (categorieschoices == lowst) {
      setState(() {
        EditUserIntensity(user, 'low', context);
        Future.delayed(Duration(seconds: 1), () => refreshProfile());
      });
    }
    if (categorieschoices == idlest) {
      setState(() {
        EditUserIntensity(user, 'idle', context);
        Future.delayed(Duration(seconds: 1), () => refreshProfile());
      });
    }
  }

  categories13(String categorieschoices) {
    if (categorieschoices == premiumst) {
      setState(() {
        EditUserPriceRange(user, 'premium', context);
        refreshProfile();
      });
    }
    if (categorieschoices == highst) {
      setState(() {
        EditUserPriceRange(user, 'high', context);
        Future.delayed(Duration(seconds: 1), () => refreshProfile());
      });
    }
    if (categorieschoices == standardst) {
      setState(() {
        EditUserPriceRange(user, 'standard', context);
        Future.delayed(Duration(seconds: 1), () => refreshProfile());
      });
    }
    if (categorieschoices == lowst) {
      setState(() {
        EditUserPriceRange(user, 'low', context);
        Future.delayed(Duration(seconds: 1), () => refreshProfile());
      });
    }
    if (categorieschoices == unspecifiedst) {
      setState(() {
        EditUserPriceRange(user, '', context);
        Future.delayed(Duration(seconds: 1), () => refreshProfile());
      });
    }
  }

  categories12(String categorieschoices) {
    print(categorieschoices);
    if (categorieschoices == operatingasusualst) {
      setState(() {
        EditUserBusinessStatus(user, 'oas', context);
        Future.delayed(Duration(seconds: 1), () => refreshProfile());
      });
    }
    if (categorieschoices == underservicechangesst) {
      setState(() {
        EditUserBusinessStatus(user, 'sc', context);
        Future.delayed(Duration(seconds: 1), () => refreshProfile());
      });
    }
    if (categorieschoices == temporarilyclosedst) {
      setState(() {
        EditUserBusinessStatus(user, 'tc', context);
        Future.delayed(Duration(seconds: 1), () => refreshProfile());
      });
    }
    if (categorieschoices == permanentlyclosedst) {
      setState(() {
        EditUserBusinessStatus(user, 'fc', context);
        Future.delayed(Duration(seconds: 1), () => refreshProfile());
      });
    }
    if (categorieschoices == unspecifiedst) {
      setState(() {
        EditUserBusinessStatus(user, '', context);
        Future.delayed(Duration(seconds: 1), () => refreshProfile());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colordtmainone,
        body: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            Column(
              children: <Widget>[
                user.image == null
                    ? Container(
                        height: 0,
                        width: 0,
                      )
                    : InkWell(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: Image.network(
                                  user.image == null
                                      ? 'https://st2.depositphotos.com/4111759/12123/v/600/depositphotos_121233262-stock-illustration-male-default-placeholder-avatar-profile.jpg'
                                      : user.image,
                                  fit: BoxFit.cover,
                                )),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ViewImageScreen(image: user.image),
                            ),
                          );
                        },
                      ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                checknullity(user.full_name)
                    ? Text(
                        "@${user.username}",
                        style: TextStyle(
                          color: colordtmaintwo,
                          fontSize: MediaQuery.of(context).size.height * 0.023,
                        ),
                      )
                    : Text(
                        "@${user.username} (${user.full_name})",
                        style: TextStyle(
                          color: colordtmaintwo,
                          fontSize: MediaQuery.of(context).size.height * 0.023,
                        ),
                      ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                checknullity(user.locationcountry)
                    ? Container(
                        height: 0,
                        width: 0,
                      )
                    : Text(
                        '${user.location()}',
                        style: TextStyle(
                          color: colordtmaintwo,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.023,
                        ),
                      ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: ElevatedButton(
                        child: Text(
                          detailsst,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AboutScreen(
                                user: user,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.036,
                ),
                if (user.profile_type == 'B' && user.ishotel)
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditHotelScreen(
                                  user: user,
                                ),
                              ),
                            );
                          },
                          title: Text(
                            '${user.hotelclass.toString()} $starsst',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: colordtmaintwo,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(hotelclassst.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colordtmaintwo,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.018,
                              )),
                        ),
                      ),
                    ],
                  ),
                if (user.profile_type == 'B')
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProfileChangeStatusScreen(
                                    user: user, category: 'PR'),
                              ),
                            );
                          },
                          title: Text(
                            '${user.pricerangefuncicontext()}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: colordtmaintwo,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(pricerangest.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colordtmaintwo,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.018,
                              )),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProfileChangeStatusScreen(
                                    user: user, category: 'CR'),
                              ),
                            );
                          },
                          title: Text(
                            '${user.intensityfuncicontext()}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: colordtmaintwo,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(intensityst.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colordtmaintwo,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.018,
                              )),
                        ),
                      ),
                    ],
                  ),
                if (user.profile_type == 'B')
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditWifiScreen(user: user),
                              ),
                            );
                          },
                          title: Text(
                            'Wi-fi',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: colordtmaintwo,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              '''${user.wifiname} \n'''
                              '''${user.wifipassword}''',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colordtmaintwo,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.018,
                              )),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProfileChangeStatusScreen(
                                    user: user, category: 'BS'),
                              ),
                            );
                          },
                          title: Text(
                            '${user.businessstatusfuncicontext()}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: colordtmaintwo,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(businessstatusst.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colordtmaintwo,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.018,
                              )),
                        ),
                      ),
                    ],
                  ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                            child: ListTile(
                              title: Text(
                                user.following.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: colordtmaintwo,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(followingst.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: colordtmaintwo,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018,
                                  )),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FollowingScreen(user: user),
                                ),
                              );
                            }),
                      ),
                      Expanded(
                        child: InkWell(
                            child: ListTile(
                              title: Text(
                                user.followers.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: colordtmaintwo,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(followersst.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: colordtmaintwo,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018,
                                  )),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FollowersScreen(user: user),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                if (user.profile_type == 'B')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          title: Text(
                            user.likes.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: colordtmaintwo,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(likesst.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colordtmaintwo,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.018,
                              )),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            user.dislikes.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: colordtmaintwo,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(dislikesst.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colordtmaintwo,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.018,
                              )),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: ElevatedButton(
                        child: Text(
                          gotopostsst,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProfileFeedScreen(
                                user: user,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
