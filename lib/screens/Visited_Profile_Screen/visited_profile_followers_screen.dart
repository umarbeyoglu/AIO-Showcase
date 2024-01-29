import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/screens/Visited_Profile_Screen/visited_profile_screen.dart';
import 'package:http/http.dart' as http;

import '../../colors.dart';
import '../../language.dart';
import '../../models/User_Model/user_follow_model.dart';
import '../../models/User_Model/user_model.dart';
import '../../repository.dart';

class VisitedFollowersScreen extends StatefulWidget {
  final User user;
  final User visiteduser;
  const VisitedFollowersScreen({Key key, this.user, this.visiteduser})
      : super(key: key);

  @override
  VisitedFollowersScreenState createState() =>
      VisitedFollowersScreenState(user: user, visiteduser: visiteduser);
}

class VisitedFollowersScreenState extends State<VisitedFollowersScreen> {
  final User user;
  final User visiteduser;
  VisitedFollowersScreenState({Key key, this.user, this.visiteduser});
  ScrollController _scrollController = ScrollController();
  int page = 1;
  List<UserFollow> posts = [];
  Future fetchPostsfuture;
  bool isLoading = false;

  @override
  void initState() {
    isuserfollowed(user.id, visiteduser.id)
      ..then((result) {
        if (user.shouldshowuserinfo(visiteduser, result) == 'followed') {
          setState(() {
            fetchPostsfuture =
                FetchFollowedUserFolloweds(http.Client(), visiteduser.id, page);
          });
          return;
        }
        if (user.shouldshowuserinfo(visiteduser, result) == 'public') {
          setState(() {
            fetchPostsfuture =
                FetchPublicUserFolloweds(http.Client(), visiteduser.id, page);
          });
          return;
        }
      });
  }

  Future _loadData() async {
    isuserfollowed(user.id, visiteduser.id)
      ..then((result) {
        if (user.shouldshowuserinfo(visiteduser, result) == 'followed') {
          FetchFollowedUserFolloweds(http.Client(), visiteduser.id, page)
            ..then((result2) {
              setState(() {
                for (final item2 in result2) posts.add(item2);
                isLoading = false;
              });
              return;
            });
        }
        if (user.shouldshowuserinfo(visiteduser, result) == 'public') {
          FetchPublicUserFolloweds(http.Client(), visiteduser.id, page)
            ..then((result2) {
              setState(() {
                for (final item2 in result2) posts.add(item2);
                isLoading = false;
              });
              return;
            });
        }
      });
  }

  Future<Null> refreshList() async {
    setState(() {});
  }

  @override
  Future<User> callUser(String userid) async {
    Future<User> _user = FetchUser(userid);
    return _user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colordtmainone,
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            page = page + 1;
            _loadData();
            setState(() {
              isLoading = true;
            });
            return true;
          }
        },
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colordtmainone,
                    borderRadius: BorderRadius.only(),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Text(
                        followersst,
                        style: TextStyle(
                          color: colordtmaintwo,
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Column(
                        children: [
                          FutureBuilder<List<UserFollow>>(
                            future: fetchPostsfuture,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) print('error1');
                              posts = snapshot.data;
                              return snapshot.hasData
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: posts.length,
                                      physics: ClampingScrollPhysics(),
                                      controller: _scrollController,
                                      itemBuilder: (context, index) {
                                        return FutureBuilder<User>(
                                            future:
                                                callUser(posts[index].author),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasError)
                                                print(snapshot.error);

                                              return snapshot.hasData
                                                  ? Padding(
                                                      padding: EdgeInsets.all(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.008),
                                                      child: ListTile(
                                                        leading: CircleAvatar(
                                                          radius: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.035,
                                                          backgroundImage:
                                                              NetworkImage(snapshot
                                                                          .data
                                                                          .image ==
                                                                      null
                                                                  ? 'https://st2.depositphotos.com/4111759/12123/v/600/depositphotos_121233262-stock-illustration-male-default-placeholder-avatar-profile.jpg'
                                                                  : snapshot
                                                                      .data
                                                                      .image),
                                                        ),
                                                        subtitle: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Container(
                                                              margin: EdgeInsets.all(
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.005),
                                                              padding: EdgeInsets.all(
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.005),
                                                              child: Stack(
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right: MediaQuery.of(context).size.height *
                                                                            0.0),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: <
                                                                          Widget>[
                                                                        Row(
                                                                          children: <
                                                                              Widget>[
                                                                            InkWell(
                                                                              onTap: () {
                                                                                isuserfollowed(user.id, snapshot.data.id)
                                                                                  ..then((res) {
                                                                                    if (user.shouldshowuserinfo(snapshot.data, res) == 'public') {
                                                                                      FetchPublicUserNav(user, snapshot.data.id, context);
                                                                                    }
                                                                                    ;
                                                                                    if (user.shouldshowuserinfo(snapshot.data, res) == 'followed') {
                                                                                      FetchFollowedUserNav(user, snapshot.data.id, context);
                                                                                    }
                                                                                    ;
                                                                                    if (user.shouldshowuserinfo(snapshot.data, res) == 'null') {
                                                                                      if (snapshot.data.id != user.id) {
                                                                                        Navigator.push(
                                                                                          context,
                                                                                          MaterialPageRoute(
                                                                                              builder: (_) => VisitedProfileScreen(
                                                                                                    user: user,
                                                                                                    visiteduserid: '',
                                                                                                    visiteduser: snapshot.data,
                                                                                                  )),
                                                                                        );
                                                                                      }
                                                                                    }
                                                                                    ;
                                                                                  });
                                                                              },
                                                                              child: Text(
                                                                                '${snapshot.data.username}',
                                                                                style: TextStyle(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  color: colordtmaintwo,
                                                                                  fontSize: MediaQuery.of(context).size.height * 0.03,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : Center(
                                                      child: CircularProgressIndicator(
                                                          backgroundColor:
                                                              Colors.pink,
                                                          valueColor:
                                                              new AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors
                                                                      .pinkAccent)));
                                            });
                                      })
                                  : Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.pink,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.pinkAccent),
                                      ),
                                    );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
