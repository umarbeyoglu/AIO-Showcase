import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../colors.dart';
import '../../language.dart';
import '../../models/User_Model/user_model.dart';
import '../../models/User_Model/user_tags_model.dart';
import '../../repository.dart';

class UserMailScreen extends StatefulWidget {
  final User user;
  final User visiteduser;
  const UserMailScreen({Key key, this.user, this.visiteduser})
      : super(key: key);

  @override
  UserMailScreenState createState() =>
      UserMailScreenState(user: user, visiteduser: visiteduser);
}

class UserMailScreenState extends State<UserMailScreen> {
  final User user;
  final User visiteduser;
  ScrollController _scrollController = ScrollController();
  int page = 1;
  List<UserMail> posts = [];
  Future fetchPostsfuture;
  bool isLoading = false;
  UserMailScreenState({
    Key key,
    this.user,
    this.visiteduser,
  });
  @override
  void initState() {
    if (visiteduser.id == user.id) {
      setState(() {
        fetchPostsfuture = FetchOwnUserMail(http.Client(), user.id, page);
      });
      return;
    }
    isuserfollowed(user.id, visiteduser.id)
      ..then((result) {
        if (user.shouldshowuserinfo(visiteduser, result) == 'followed') {
          setState(() {
            fetchPostsfuture =
                FetchFollowedUserMail(http.Client(), visiteduser.id, page);
          });
          return;
        }
        if (user.shouldshowuserinfo(visiteduser, result) == 'public') {
          setState(() {
            fetchPostsfuture =
                FetchPublicUserMail(http.Client(), visiteduser.id, page);
          });
          return;
        }
      });
  }

  Future _loadData() async {
    if (visiteduser.id == user.id) {
      FetchOwnUserMail(http.Client(), user.id, page)
        ..then((result) {
          setState(() {
            for (final item2 in result) posts.add(item2);
            isLoading = false;
          });
          return;
        });
    }
    isuserfollowed(user.id, visiteduser.id)
      ..then((result) {
        if (user.shouldshowuserinfo(visiteduser, result) == 'followed') {
          FetchFollowedUserMail(http.Client(), visiteduser.id, page)
            ..then((result2) {
              setState(() {
                for (final item2 in result2) posts.add(item2);
                isLoading = false;
              });
              return;
            });
        }
        if (user.shouldshowuserinfo(visiteduser, result) == 'public') {
          FetchPublicUserMail(http.Client(), visiteduser.id, page)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: colordtmainone,
        actions: [
          visiteduser.id == user.id
              ? IconButton(
                  icon: Icon(Icons.add),
                  iconSize: 30.0,
                  color: colordtmaintwo,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => UserMailCreateScreen(
                                user: user,
                                visiteduser: visiteduser,
                              )),
                    ).then((value) {
                      setState(() {
                        Future.delayed(
                            Duration(seconds: 1),
                            () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        super.widget)));
                      });
                    });
                  },
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 30.0,
          color: colordtmaintwo,
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ),
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
                      Column(
                        children: [
                          FutureBuilder<List<UserMail>>(
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
                                        return Padding(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.008),
                                          child: ListTile(
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.all(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.005),
                                                  padding: EdgeInsets.all(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.005),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            right: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            InkWell(
                                                              child: Text(
                                                                '${posts[index].mail}',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      colordtmaintwo,
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.03,
                                                                ),
                                                              ),
                                                              onTap: () {
                                                                launch(
                                                                    "mailto:<${posts[index].mail}>");
                                                              },
                                                            ),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                visiteduser.id ==
                                                                        user.id
                                                                    ? IconButton(
                                                                        icon: Icon(Icons
                                                                            .delete),
                                                                        iconSize:
                                                                            MediaQuery.of(context).size.height *
                                                                                0.0425,
                                                                        color:
                                                                            colordtmaintwo,
                                                                        onPressed:
                                                                            () {
                                                                          DeleteUserMail(
                                                                              posts[index].id);

                                                                          setState(
                                                                              () {
                                                                            Navigator.pushReplacement(context,
                                                                                MaterialPageRoute(builder: (BuildContext context) => super.widget));
                                                                          });
                                                                        })
                                                                    : Container(
                                                                        height:
                                                                            0,
                                                                        width:
                                                                            0,
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
                                        );
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

class UserMailCreateScreen extends StatefulWidget {
  final User user;
  final User visiteduser;

  const UserMailCreateScreen({Key key, this.user, this.visiteduser})
      : super(key: key);

  @override
  UserMailCreateScreenState createState() => UserMailCreateScreenState(
        user: user,
        visiteduser: visiteduser,
      );
}

class UserMailCreateScreenState extends State<UserMailCreateScreen> {
  final User user;
  final User visiteduser;

  UserMailCreateScreenState({Key key, this.user, this.visiteduser});

  final TextEditingController item = TextEditingController();
  bool disablecomments = false;
  bool disablestats = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: colordtmainone,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 30.0,
          color: colordtmaintwo,
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ),
      backgroundColor: colordtmainone,
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.01,
                      right: MediaQuery.of(context).size.width * 0.01),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.023,
                        vertical: MediaQuery.of(context).size.height * 0.013),
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
                        controller: item,
                        maxLength: 250,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: mailst,
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: colordtmaintwo),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: ElevatedButton(
                    child: Text(
                      donest,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ),
                    onPressed: () {
                      CreateUserMail(item.text, user.id);
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 80),
              ])),
        ],
      ),
    );
  }
}
