import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/screens/Visited_Profile_Screen/visited_profile_about_screen.dart';
import 'package:flutter_food_delivery_app/screens/Visited_Profile_Screen/visited_profile_feed_screen.dart';
import 'package:flutter_food_delivery_app/screens/Visited_Profile_Screen/visited_profile_followers_screen.dart';
import 'package:flutter_food_delivery_app/screens/Visited_Profile_Screen/visited_profile_following_screen.dart';
import 'package:http/http.dart' as http;

import '../../colors.dart';
import '../../language.dart';
import '../../models/Article_Model/article_model.dart';
import '../../models/User_Model/user_model.dart';
import '../../repository.dart';
import '../First_Time_Screen/edit_hotel_screen.dart';
import '../General/create_report_screen.dart';
import '../General/home_screen.dart';
import '../General/meeting_screen.dart';
import '../Profile_Screen/profile_image_screen.dart';

class VisitedProfileScreen extends StatefulWidget {
  final User user;
  final User visiteduser;
  final String visiteduserid;
  const VisitedProfileScreen(
      {Key key, this.user, this.visiteduser, this.visiteduserid})
      : super(key: key);

  @override
  _VisitedProfileScreenState createState() => _VisitedProfileScreenState(
      user: user,
      visiteduser: visiteduser,
      visiteduserid: visiteduserid,
      key: key);
}

class _VisitedProfileScreenState extends State<VisitedProfileScreen> {
  final User user;
  final User visiteduser;
  final String visiteduserid;
  bool visit = false;
  _VisitedProfileScreenState(
      {Key key, this.user, this.visiteduser, this.visiteduserid});
  Future fetchpostsfuture;
  bool liked = false;
  bool disliked = false;
  bool followed = false;
  bool unliked = false;
  bool undisliked = false;
  bool unfollowed = false;
  ScrollController _scrollController = ScrollController();
  int page = 1;
  List<Article> posts = [];
  Future fetchPostsfuture;
  bool isLoading = false;
  bool likeresult = false;
  bool dislikeresult = false;
  bool followresult = false;
  bool followresultsilent = false;
  bool followrequestresult = false;
  String followrequestresultid = '';
  bool isfollowed = false;

  bool silentf() {
    isuserfollowedsilently(user.id, visiteduser.id)
      ..then((result) {
        print('first $result');
        return result;
      });
    return false;
  }

  @override
  void initState() {
    // ViewUser(user.id,visiteduserid);
    //  ViewUser(user.id,visiteduser.id);
    isuserliked(user.id, visiteduser.id)
      ..then((result) {
        visiteduser.likeresult = result;
      });
    isuserdisliked(user.id, visiteduser.id)
      ..then((result) {
        visiteduser.dislikeresult = result;
      });
    isuserfollowed(user.id, visiteduser.id)
      ..then((result) {
        followresult = result;
      });
    isuserfollowedsilently(user.id, visiteduser.id)
      ..then((result) {
        followresultsilent = result;
      });
    isuserfollowrequested(user.id, visiteduser.id)
      ..then((result) {
        followrequestresult = result;
      });
    userfollowrequestid(user.id, visiteduser.id)
      ..then((result) {
        followrequestresultid = result;
      });
    isuserfollowed(user.id, visiteduser.id)
      ..then((result) {
        if (user.shouldshowuserinfo(visiteduser, result) == 'followed') {
          setState(() {
            fetchPostsfuture = FetchVisitedProfileFollowedArticles(
                http.Client(), visiteduser.id, page);
            isfollowed = true;
          });
          return;
        }
        if (user.shouldshowuserinfo(visiteduser, result) == 'public') {
          setState(() {
            fetchPostsfuture = FetchVisitedProfilePublicArticles(
                http.Client(), visiteduser.id, page);
          });
          return;
        }
      });
    print('$followrequestresultid');
    super.initState();
  }

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

  Future<Widget> NavgListPublic() async {
    Future.delayed(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => super.widget)));
  }

  Future<Widget> NavgListFollowed() async {
    Future.delayed(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => super.widget)));
  }

  Future<Widget> NavgListPrivate() async {
    Future.delayed(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => super.widget)));
  }

  Future<Widget> RefreshListPublic() async {
    Future.delayed(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => super.widget)));
  }

  Future<Widget> RefreshListFollowed() async {
    Future.delayed(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => super.widget)));
  }

  Future<Widget> refreshProfileBlock() async {
    User _user1;
    WidgetsFlutterBinding.ensureInitialized();
    final http.Response response = await http.get(
      Uri.parse("$SERVER_IP/api/ownuser/"),
      headers: <String, String>{"Authorization": "Token ${globaltoken}"},
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      _user1 = User.fromJSON(responseJson[0]);
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => HomeScreen(user: _user1),
        ),
      );
    }
  }

  Future<Null> refreshList() async {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VisitedProfileScreen(
            user: user,
            visiteduser: visiteduser,
            visiteduserid: visiteduserid,
          ),
        ),
      );
    });
  }

  @override
  Future<User> callUser(String userid) async {
    Future<User> _user = FetchUser(userid);
    return _user;
  }

  @override
  void init() {
    if (visiteduserid != '') {
      if (globalvisiteduserid != visiteduserid) {
        globalvisiteduserid = visiteduserid;
        NavgListPublic();
      }
    }
    globalvisiteduserid = visiteduser.id;
    if (globalvisiteduserid != visiteduser.id) {
      globalvisiteduserid = visiteduser.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      backgroundColor: colordtmainone,
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          Column(
            children: <Widget>[
              visiteduser.image == null
                  ? SizedBox(height: 0, width: 0)
                  : InkWell(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Image.network(
                                visiteduser.image == null
                                    ? 'https://st2.depositphotos.com/4111759/12123/v/600/depositphotos_121233262-stock-illustration-male-default-placeholder-avatar-profile.jpg'
                                    : visiteduser.image,
                                fit: BoxFit.cover,
                              )),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ViewImageScreen(image: visiteduser.image),
                          ),
                        );
                      },
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              checknullity(visiteduser.full_name)
                  ? Text(
                      "@${visiteduser.username}",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.023,
                      ),
                    )
                  : Text(
                      "@${visiteduser.username} (${visiteduser.full_name})",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.023,
                      ),
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              checknullity(visiteduser.locationcountry)
                  ? SizedBox(height: 0, width: 0)
                  : Text(
                      '${visiteduser.location()}',
                      style: TextStyle(
                        color: colordtmaintwo,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.023,
                      ),
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              visiteduser.public_profile == false
                  ? (visiteduser.isfollowingprofile(user.id, followresult)
                      ? SizedBox(
                          width: languagest == 'TR'
                              ? MediaQuery.of(context).size.width * 0.45
                              : MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.046,
                          child: ElevatedButton(
                            child: Text(
                              aboutst,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VisitedAboutScreen(
                                    user: user,
                                    visiteduser: visiteduser,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : (visiteduser.isdetailsprivate
                          ? SizedBox(height: 0, width: 0)
                          : SizedBox(
                              width: languagest == 'TR'
                                  ? MediaQuery.of(context).size.width * 0.45
                                  : MediaQuery.of(context).size.width * 0.35,
                              height:
                                  MediaQuery.of(context).size.height * 0.046,
                              child: ElevatedButton(
                                child: Text(
                                  aboutst,
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => VisitedAboutScreen(
                                        user: user,
                                        visiteduser: visiteduser,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )))
                  : SizedBox(
                      width: languagest == 'TR'
                          ? MediaQuery.of(context).size.width * 0.45
                          : MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.height * 0.046,
                      child: ElevatedButton(
                        child: Text(
                          aboutst,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => VisitedAboutScreen(
                                user: user,
                                visiteduser: visiteduser,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              if (visiteduser.profile_type == 'B' && visiteduser.ishotel)
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          '${visiteduser.hotelclass.toString()} $starsst',
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
              if (visiteduser.profile_type == 'B')
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          '${visiteduser.pricerangefuncicontext()}',
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
                        title: Text(
                          '${visiteduser.intensityfuncicontext()}',
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
              if (visiteduser.profile_type == 'B')
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'Wi-fi',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: colordtmaintwo,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            '''${visiteduser.wifiname} \n'''
                            '''${visiteduser.wifipassword}''',
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
                          '${visiteduser.businessstatusfuncicontext()}',
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
              if (visiteduser.profile_type == 'B')
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      child: ListTile(
                        title: Text(
                          '$hotelclassst',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: colordtmaintwo,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            '''${visiteduser.hotelclass.toString()} $starst''',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: colordtmaintwo,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.018,
                            )),
                      ),
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
                    )),
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
                              visiteduser.following.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: colordtmaintwo,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(followingst.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: colordtmaintwo,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.018,
                                )),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VisitedFollowingScreen(
                                    user: user, visiteduser: visiteduser),
                              ),
                            );
                          }),
                    ),
                    Expanded(
                      child: InkWell(
                          child: ListTile(
                            title: Text(
                              visiteduser.followers.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: colordtmaintwo,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(followersst.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: colordtmaintwo,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.018,
                                )),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VisitedFollowersScreen(
                                    user: user, visiteduser: visiteduser),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              if (visiteduser.profile_type == 'B')
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
              if (visiteduser.profile_type == 'B')
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        title: Text(
                          visiteduser.likes.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(likesst.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.018,
                            )),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          visiteduser.dislikes.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(dislikesst.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.018,
                            )),
                      ),
                    ),
                  ],
                ),
              if (visiteduser.profile_type == 'B')
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.034,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.14,
                child: visiteduser.profile_type == 'B'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              visiteduser.islikedprofile(visiteduser, user,
                                          liked, unliked, likeresult) ==
                                      true
                                  ? SizedBox(
                                      width: languagest == 'TR'
                                          ? MediaQuery.of(context).size.width *
                                              0.45
                                          : MediaQuery.of(context).size.width *
                                              0.35,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.046,
                                      child: ElevatedButton(
                                        child: Text(
                                          unlikest,
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            user.likeresult = false;
                                            userlikeid(user.id, visiteduser.id)
                                              ..then((result) {
                                                UnlikeUser(result);
                                              });

                                            isuserliked(user.id, visiteduser.id)
                                              ..then((result) {
                                                visiteduser.islikedprofile(
                                                    visiteduser,
                                                    user,
                                                    liked,
                                                    unliked,
                                                    result);
                                                if (user.shouldshowuserinfo(
                                                        visiteduser, result) ==
                                                    'public') {
                                                  RefreshListPublic();
                                                }
                                                ;
                                                if (user.shouldshowuserinfo(
                                                        visiteduser, result) ==
                                                    'followed') {
                                                  RefreshListFollowed();
                                                }
                                                ;
                                              });
                                            liked = false;
                                            unliked = true;
                                          });
                                        },
                                      ),
                                    )
                                  : SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.046,
                                      child: ElevatedButton(
                                        child: Text(
                                          likest,
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            user.likeresult = true;
                                            user.dislikeresult = false;
                                            LikeUser(user.id, visiteduser.id);
                                            liked = true;
                                            unliked = false;
                                            isuserliked(user.id, visiteduser.id)
                                              ..then((result) {
                                                visiteduser.islikedprofile(
                                                    visiteduser,
                                                    user,
                                                    liked,
                                                    unliked,
                                                    result);
                                              });
                                            String dislikeid;
                                            userdislikeid(
                                                user.id, visiteduser.id)
                                              ..then((a) {
                                                UndislikeUser(a);
                                              });

                                            dislikeid = '';
                                            disliked = false;
                                            undisliked = true;
                                            isuserdisliked(
                                                user.id, visiteduser.id)
                                              ..then((a) {
                                                visiteduser.isdislikedprofile(
                                                    visiteduser,
                                                    user,
                                                    disliked,
                                                    undisliked,
                                                    a);
                                                if (user.shouldshowuserinfo(
                                                        visiteduser, a) ==
                                                    'public') {
                                                  RefreshListPublic();
                                                }
                                                ;
                                                if (user.shouldshowuserinfo(
                                                        visiteduser, a) ==
                                                    'followed') {
                                                  RefreshListFollowed();
                                                }
                                                ;
                                              });
                                          });
                                        },
                                      ),
                                    ),
                              SizedBox(
                                width: 25.0,
                              ),
                              visiteduser.isdislikedprofile(
                                          visiteduser,
                                          user,
                                          disliked,
                                          undisliked,
                                          dislikeresult) ==
                                      true
                                  ? SizedBox(
                                      width: languagest == 'TR'
                                          ? MediaQuery.of(context).size.width *
                                              0.45
                                          : MediaQuery.of(context).size.width *
                                              0.35,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.046,
                                      child: ElevatedButton(
                                        child: Text(
                                          undislikest,
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            user.dislikeresult = false;
                                            userdislikeid(
                                                user.id, visiteduser.id)
                                              ..then((result) {
                                                UndislikeUser(result);
                                              });

                                            disliked = false;
                                            undisliked = true;

                                            isuserdisliked(
                                                user.id, visiteduser.id)
                                              ..then((result) {
                                                visiteduser.isdislikedprofile(
                                                    visiteduser,
                                                    user,
                                                    disliked,
                                                    undisliked,
                                                    result);
                                                if (user.shouldshowuserinfo(
                                                        visiteduser, result) ==
                                                    'public') {
                                                  RefreshListPublic();
                                                }
                                                ;
                                                if (user.shouldshowuserinfo(
                                                        visiteduser, result) ==
                                                    'followed') {
                                                  RefreshListFollowed();
                                                }
                                                ;
                                              });
                                          });
                                        },
                                      ),
                                    )
                                  : SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.046,
                                      child: ElevatedButton(
                                        child: Text(
                                          dislikest,
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                        ),
                                        onPressed: () {
                                          user.dislikeresult = true;
                                          user.likeresult = false;
                                          setState(() {
                                            DislikeUser(
                                                user.id, visiteduser.id);
                                            disliked = true;
                                            undisliked = false;
                                            isuserdisliked(
                                                user.id, visiteduser.id)
                                              ..then((result) {
                                                visiteduser.isdislikedprofile(
                                                    visiteduser,
                                                    user,
                                                    disliked,
                                                    undisliked,
                                                    result);
                                              });

                                            String likeid;
                                            userlikeid(user.id, visiteduser.id)
                                              ..then((result) {
                                                UnlikeUser(result);
                                              });

                                            likeid = '';
                                            liked = false;
                                            unliked = true;
                                            isuserliked(user.id, visiteduser.id)
                                              ..then((result) {
                                                visiteduser.isdislikedprofile(
                                                    visiteduser,
                                                    user,
                                                    disliked,
                                                    undisliked,
                                                    result);
                                                if (user.shouldshowuserinfo(
                                                        visiteduser, result) ==
                                                    'public') {
                                                  RefreshListPublic();
                                                }
                                                ;
                                                if (user.shouldshowuserinfo(
                                                        visiteduser, result) ==
                                                    'followed') {
                                                  RefreshListFollowed();
                                                }
                                                ;
                                              });
                                          });
                                        },
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              visiteduser.public_profile == false
                                  ? (visiteduser.isfollowedprofile(
                                              visiteduser,
                                              user,
                                              followed,
                                              unfollowed,
                                              followrequestresult,
                                              followresult) ==
                                          true
                                      ? SizedBox(
                                          width: languagest == 'TR'
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.45
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.35,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.046,
                                          child: ElevatedButton(
                                            child: Text(
                                              unfollowst,
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                userfollowid(
                                                    user.id, visiteduser.id)
                                                  ..then((result) {
                                                    UnfollowUser(result);
                                                  });

                                                followed = false;
                                                unfollowed = true;
                                                isuserfollowrequested(
                                                    user.id, visiteduser.id)
                                                  ..then((result1) {
                                                    isuserfollowed(
                                                        user.id, visiteduser.id)
                                                      ..then((result2) {
                                                        visiteduser
                                                            .isfollowedprofile(
                                                                visiteduser,
                                                                user,
                                                                followed,
                                                                unfollowed,
                                                                result1,
                                                                result2);
                                                        if (user.shouldshowuserinfo(
                                                                visiteduser,
                                                                result2) ==
                                                            'public') {
                                                          RefreshListPublic();
                                                        }
                                                        ;
                                                        if (user.shouldshowuserinfo(
                                                                visiteduser,
                                                                result2) ==
                                                            'followed') {
                                                          RefreshListFollowed();
                                                        }
                                                        ;
                                                      });
                                                  });
                                              });
                                            },
                                          ),
                                        )
                                      : (visiteduser.ismaderequestfunc(
                                              user,
                                              visiteduser,
                                              followrequestresult,
                                              followrequestresultid)
                                          ? InkWell(
                                              child: Text(cancelrequestst),
                                              onTap: () {
                                                setState(() {
                                                  visiteduser
                                                      .cancelfollowrequest();
                                                  isuserfollowed(
                                                      user.id, visiteduser.id)
                                                    ..then((a) {
                                                      if (user.shouldshowuserinfo(
                                                              visiteduser, a) ==
                                                          'public') {
                                                        RefreshListPublic();
                                                      }
                                                      ;
                                                      if (user.shouldshowuserinfo(
                                                              visiteduser, a) ==
                                                          'followed') {
                                                        RefreshListFollowed();
                                                      }
                                                      ;
                                                    });
                                                });
                                              },
                                            )
                                          : FittedBox(
                                              child: ElevatedButton(
                                                child: Text(
                                                  sendfollowrequestst,
                                                  style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.02,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    visiteduser.followrequest(
                                                        user, visiteduser);
                                                    isuserfollowed(
                                                        user.id, visiteduser.id)
                                                      ..then((a) {
                                                        if (user.shouldshowuserinfo(
                                                                visiteduser,
                                                                a) ==
                                                            'public') {
                                                          RefreshListPublic();
                                                        }
                                                        ;
                                                        if (user.shouldshowuserinfo(
                                                                visiteduser,
                                                                a) ==
                                                            'followed') {
                                                          RefreshListFollowed();
                                                        }
                                                        ;
                                                      });
                                                  });
                                                },
                                              ),
                                            )))
                                  : (visiteduser.isfollowedprofile(
                                              visiteduser,
                                              user,
                                              followed,
                                              unfollowed,
                                              followrequestresult,
                                              followresult) ==
                                          true
                                      ? SizedBox(
                                          width: languagest == 'TR'
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.45
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.35,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.046,
                                          child: ElevatedButton(
                                            child: Text(
                                              unfollowst,
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                userfollowid(
                                                    user.id, visiteduser.id)
                                                  ..then((a) {
                                                    UnfollowUser(a);
                                                  });
                                                followed = false;
                                                unfollowed = true;
                                                isuserfollowed(
                                                    user.id, visiteduser.id)
                                                  ..then((a) {
                                                    isuserfollowrequested(
                                                        user.id, visiteduser.id)
                                                      ..then((b) {
                                                        visiteduser
                                                            .isfollowedprofile(
                                                                visiteduser,
                                                                user,
                                                                followed,
                                                                unfollowed,
                                                                b,
                                                                a);

                                                        if (user.shouldshowuserinfo(
                                                                visiteduser,
                                                                a) ==
                                                            'public') {
                                                          RefreshListPublic();
                                                        }
                                                        ;
                                                        if (user.shouldshowuserinfo(
                                                                visiteduser,
                                                                a) ==
                                                            'followed') {
                                                          RefreshListFollowed();
                                                        }
                                                        ;
                                                      });
                                                  });
                                              });
                                            },
                                          ),
                                        )
                                      : SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.046,
                                          child: ElevatedButton(
                                            child: Text(
                                              followst,
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                FollowUser(
                                                    user.id, visiteduser.id);
                                                followed = true;
                                                unfollowed = false;
                                                isuserfollowed(
                                                    user.id, visiteduser.id)
                                                  ..then((a) {
                                                    isuserfollowrequested(
                                                        user.id, visiteduser.id)
                                                      ..then((b) {
                                                        visiteduser
                                                            .isfollowedprofile(
                                                                visiteduser,
                                                                user,
                                                                followed,
                                                                unfollowed,
                                                                b,
                                                                a);
                                                        if (user.shouldshowuserinfo(
                                                                visiteduser,
                                                                a) ==
                                                            'public') {
                                                          RefreshListPublic();
                                                        }
                                                        ;
                                                        if (user.shouldshowuserinfo(
                                                                visiteduser,
                                                                a) ==
                                                            'followed') {
                                                          RefreshListFollowed();
                                                        }
                                                        ;
                                                      });
                                                  });
                                              });
                                            },
                                          ),
                                        ))
                            ],
                          ),
                        ],
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: languagest == 'TR'
                        ? MediaQuery.of(context).size.width * 0.45
                        : MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.046,
                    child: ElevatedButton(
                      child: Text(
                        blockst,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ),
                      onPressed: () {
                        userfollowid(user.id, visiteduser.id)
                          ..then((result) {
                            UnfollowUser(result);
                          });

                        followed = false;
                        unfollowed = true;
                        BlockUser(user.id, visiteduser.id);
                        refreshProfileBlock();
                      },
                    ),
                  ),
                  SizedBox(width: 22),
                  SizedBox(
                    width: languagest == 'TR'
                        ? MediaQuery.of(context).size.width * 0.45
                        : MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.046,
                    child: ElevatedButton(
                      child: Text(
                        reportst,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CreateReportScreen(
                              user: user,
                              article: '',
                              profile: visiteduser.id,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: visiteduser.profile_type == 'B' ? 40 : 0,
                child: visiteduser.profile_type == 'B'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          visiteduser.isfollowedprofile(
                                      visiteduser,
                                      user,
                                      followed,
                                      unfollowed,
                                      followrequestresult,
                                      followresult) ==
                                  true
                              ? SizedBox(
                                  width: languagest == 'TR'
                                      ? MediaQuery.of(context).size.width * 0.45
                                      : MediaQuery.of(context).size.width *
                                          0.35,
                                  height: MediaQuery.of(context).size.height *
                                      0.046,
                                  child: ElevatedButton(
                                    child: Text(
                                      unfollowst,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        userfollowid(user.id, visiteduser.id)
                                          ..then((a) {
                                            UnfollowUser(a);
                                          });
                                        followed = false;
                                        unfollowed = true;
                                        isuserfollowed(user.id, visiteduser.id)
                                          ..then((a) {
                                            isuserfollowrequested(
                                                user.id, visiteduser.id)
                                              ..then((b) {
                                                visiteduser.isfollowedprofile(
                                                    visiteduser,
                                                    user,
                                                    followed,
                                                    unfollowed,
                                                    b,
                                                    a);

                                                if (user.shouldshowuserinfo(
                                                        visiteduser, a) ==
                                                    'public') {
                                                  RefreshListPublic();
                                                }
                                                ;
                                                if (user.shouldshowuserinfo(
                                                        visiteduser, a) ==
                                                    'followed') {
                                                  RefreshListFollowed();
                                                }
                                                ;
                                              });
                                          });
                                      });
                                    },
                                  ),
                                )
                              : SizedBox(
                                  width: languagest == 'TR'
                                      ? MediaQuery.of(context).size.width * 0.45
                                      : MediaQuery.of(context).size.width *
                                          0.35,
                                  height: MediaQuery.of(context).size.height *
                                      0.046,
                                  child: ElevatedButton(
                                    child: Text(
                                      followst,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        FollowUser(user.id, visiteduser.id);
                                        followed = true;
                                        unfollowed = false;
                                        isuserfollowed(user.id, visiteduser.id)
                                          ..then((a) {
                                            isuserfollowrequested(
                                                user.id, visiteduser.id)
                                              ..then((b) {
                                                visiteduser.isfollowedprofile(
                                                    visiteduser,
                                                    user,
                                                    followed,
                                                    unfollowed,
                                                    b,
                                                    a);
                                                if (user.shouldshowuserinfo(
                                                        visiteduser, a) ==
                                                    'public') {
                                                  RefreshListPublic();
                                                }
                                                ;
                                                if (user.shouldshowuserinfo(
                                                        visiteduser, a) ==
                                                    'followed') {
                                                  RefreshListFollowed();
                                                }
                                                ;
                                              });
                                          });
                                      });
                                    },
                                  ),
                                ),
                        ],
                      )
                    : SizedBox(height: 0, width: 0),
              ),
              SizedBox(height: 50),
            ],
          ),
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: ElevatedButton(
                  child: Text(
                    followresultsilent
                        ? 'Disable Silent Follow'
                        : 'Enable Silent Follow',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                  onPressed: () async {
                    String id = await userfollowid(user.id, visiteduser.id);
                    silentf()
                        ? FollowUserSilent(id, false, user.id, visiteduser.id)
                        : FollowUserSilent(id, true, user.id, visiteduser.id);
                    Future.delayed(
                        Duration(seconds: 2),
                        () => setState(() {
                              followresultsilent = silentf();
                            }));
                  },
                ),
              ),
            ],
          ),
          if (user.profile_type == 'B')
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: ElevatedButton(
                    child: Text(
                      sendmeetingrequestst,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CalendarMeet(
                            user: visiteduser,
                            calendarowner: user,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          visiteduser.public_profile == false
              ? (visiteduser.isfollowingprofile(user.id, followresult)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          child: ElevatedButton(
                            child: Text(
                              gotopostsst,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VisitedProfileFeedScreen(
                                    user: user,
                                    visiteduser: visiteduser,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : SizedBox(height: 0, width: 0))
              : Row(
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
                              builder: (_) => VisitedProfileFeedScreen(
                                user: user,
                                visiteduser: visiteduser,
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
    );
  }
}
