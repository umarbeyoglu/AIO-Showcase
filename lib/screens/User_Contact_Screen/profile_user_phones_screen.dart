import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../colors.dart';
import '../../language.dart';
import '../../models/User_Model/user_model.dart';
import '../../models/User_Model/user_subuser_model.dart';
import '../../repository.dart';

class UserPhoneScreen extends StatefulWidget {
  final User user;
  final User visiteduser;
  const UserPhoneScreen({Key key, this.user, this.visiteduser})
      : super(key: key);

  @override
  UserPhoneScreenState createState() =>
      UserPhoneScreenState(user: user, visiteduser: visiteduser);
}

class UserPhoneScreenState extends State<UserPhoneScreen> {
  final User user;
  final User visiteduser;
  ScrollController _scrollController = ScrollController();
  int page = 1;
  List<UserPhone> posts = [];
  Future fetchPostsfuture;
  bool isLoading = false;

  @override
  void initState() {
    if (visiteduser.id == user.id) {
      setState(() {
        fetchPostsfuture = FetchOwnUserPhone(http.Client(), user.id, page);
      });
      return;
    }
    isuserfollowed(user.id, visiteduser.id)
      ..then((result) {
        if (user.shouldshowuserinfo(visiteduser, result) == 'followed') {
          setState(() {
            fetchPostsfuture =
                FetchFollowedUserPhone(http.Client(), visiteduser.id, page);
          });
          return;
        }
        if (user.shouldshowuserinfo(visiteduser, result) == 'public') {
          setState(() {
            fetchPostsfuture =
                FetchPublicUserPhone(http.Client(), visiteduser.id, page);
          });
          return;
        }
      });
  }

  Future _loadData() async {
    if (visiteduser.id == user.id) {
      FetchOwnUserPhone(http.Client(), user.id, page)
        ..then((result2) {
          setState(() {
            for (final item2 in result2) posts.add(item2);
            isLoading = false;
          });
          return;
        });
    }
    isuserfollowed(user.id, visiteduser.id)
      ..then((result) {
        if (user.shouldshowuserinfo(visiteduser, result) == 'followed') {
          FetchFollowedUserPhone(http.Client(), visiteduser.id, page)
            ..then((result2) {
              setState(() {
                for (final item2 in result2) posts.add(item2);
                isLoading = false;
              });
              return;
            });
        }
        if (user.shouldshowuserinfo(visiteduser, result) == 'public') {
          FetchPublicUserPhone(http.Client(), visiteduser.id, page)
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

  UserPhoneScreenState({
    Key key,
    this.user,
    this.visiteduser,
  });

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
                          builder: (_) => UserPhoneCreateScreen(
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
                          FutureBuilder<List<UserPhone>>(
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
                                                                '${posts[index].phone}',
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
                                                              onTap: () async {
                                                                posts[index]
                                                                        .iswp
                                                                    ? (await canLaunch("whatsapp://send?phone=${posts[index].phone}")
                                                                        ? launch(
                                                                            "whatsapp://send?phone=${posts[index].phone}")
                                                                        : launch(
                                                                            "https://play.google.com/store/apps/details?id=com.whatsapp&hl=en&gl=US"))
                                                                    : launch(
                                                                        "tel:<${posts[index].phone}>");
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
                                                                          DeleteUserPhone(
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

class UserPhoneCreateScreen extends StatefulWidget {
  final User user;
  final User visiteduser;

  const UserPhoneCreateScreen({Key key, this.user, this.visiteduser})
      : super(key: key);

  @override
  UserPhoneCreateScreenState createState() => UserPhoneCreateScreenState(
        user: user,
        visiteduser: visiteduser,
      );
}

class UserPhoneCreateScreenState extends State<UserPhoneCreateScreen> {
  final User user;
  final User visiteduser;

  UserPhoneCreateScreenState({Key key, this.user, this.visiteduser});

  final TextEditingController item = TextEditingController();
  bool iswp = false;

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
                          hintText: phonest,
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: colordtmaintwo),
                        ),
                      ),
                    ),
                  ),
                ),
                CheckboxListTile(
                  title: Text(iswhatsappst,
                      style: TextStyle(
                          color: colordtmaintwo, fontWeight: FontWeight.w400)),
                  value: iswp,
                  onChanged: (bool value) {
                    setState(() {
                      iswp = value;
                    });
                  },
                  secondary:
                      Icon(Icons.format_list_numbered, color: colordtmaintwo),
                ),
                CheckboxListTile(
                  title: Text(istelegramst,
                      style: TextStyle(
                          color: colordtmaintwo, fontWeight: FontWeight.w400)),
                  value: iswp,
                  onChanged: (bool value) {
                    setState(() {
                      iswp = value;
                    });
                  },
                  secondary:
                      Icon(Icons.format_list_numbered, color: colordtmaintwo),
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
                      CreateUserPhones(item.text, user.id, iswp);
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
