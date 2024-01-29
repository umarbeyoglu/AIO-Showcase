import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/screens/General/search_screen.dart';
import 'package:http/http.dart' as http;

import '../../colors.dart';
import '../../feed_screen.dart';
import '../../models/User_Model/user_model.dart';
import '../../repository.dart';
import '../Profile_Screen/profile_about_screen - Copy.dart';
import '../Profile_Screen/profile_screen.dart';
import 'create_article_screen.dart';
import 'notifications_screen.dart';

int _currentTab = 0;

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({Key key, this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState(user: user, key: key);
}

class _HomeScreenState extends State<HomeScreen> {
  final User user;
  Future myFuture;
  _HomeScreenState({
    Key key,
    this.user,
  });

  PageController _pageController;
  Timer timer;
  int messagecount = 0;
  bool start = true;

  Future<User> refreshProfile() async {
    WidgetsFlutterBinding.ensureInitialized();
    final http.Response response = await http.get(
      Uri.parse("$SERVER_IP/api/ownuser/"),
      headers: <String, String>{"Authorization": "Token ${globaltoken}"},
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(utf8.decode(response.bodyBytes));
      User mainuser = User.fromJSON(responseJson[0]);
      //  final response2 = await http.get(Uri.parse("$SERVER_IP/api/subusers/?format=json") ,headers: <String, String>{'Content-Type': 'application/json',"Authorization" : "Token ${globaltoken}"},);
      // final parsed2 = jsonDecode(utf8.decode(response2.bodyBytes));
      //   mainuser.subusers = parsed2.map<User>((json) => User.fromJSON(json)).toList();
      //   final http.Response response3 = await http.get(Uri.parse("$SERVER_IP/api/groups/"), headers: <String, String>{"Authorization" : "Token $globaltoken"},);
      //  final parsed = jsonDecode(utf8.decode(response3.bodyBytes));
      //   mainuser.groups2 = parsed.map<Group>((json) => Group.fromJSON(json)).toList();
      //   if(mainuser.groups2 == []){Group nullgroup = Group(name: 'null');mainuser.groups2.add(nullgroup);return mainuser;}
      //   if(mainuser.groups2 == null){Group nullgroup = Group(name: 'null');mainuser.groups2.add(nullgroup);return mainuser;}
      return mainuser;
    }
  }

  @override
  void initState() {
    super.initState();
    myFuture = refreshProfile();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: myFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? Scaffold(
                  body: PageView(
                    controller: _pageController,
                    children: <Widget>[
                      ClipsScreen(
                        user: snapshot.data,
                      ),
                      SearchScreen(
                        user: snapshot.data,
                      ),
                      user.profile_type == 'B'
                          ? CreateArticleChooseScreen(user: snapshot.data)
                          : CreateArticleScreen(user: snapshot.data, type: 'A'),
                      NotificationsScreen(user: snapshot.data),
                      ProfileScreen(user: snapshot.data),
                      //    MessagingHomeScreen(user: snapshot.data,)
                    ],
                    onPageChanged: (int index) {
                      setState(() {
                        _currentTab = index;
                      });
                    },
                  ),
                  bottomNavigationBar: CupertinoTabBar(
                    backgroundColor: colordtmainone,
                    currentIndex: _currentTab,
                    onTap: (int index) {
                      setState(() {
                        _currentTab = index;
                      });
                      _pageController.animateToPage(
                        index,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.home,
                          size: MediaQuery.of(context).size.height * 0.045,
                          color:
                              _currentTab == 0 ? Colors.blue : colordtmaintwo,
                        ),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.search,
                          size: MediaQuery.of(context).size.height * 0.045,
                          color:
                              _currentTab == 1 ? Colors.blue : colordtmaintwo,
                        ),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.add,
                          size: MediaQuery.of(context).size.height * 0.045,
                          color:
                              _currentTab == 2 ? Colors.blue : colordtmaintwo,
                        ),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.notifications_none,
                          size: MediaQuery.of(context).size.height * 0.045,
                          color:
                              _currentTab == 3 ? Colors.blue : colordtmaintwo,
                        ),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.person_outline,
                          size: MediaQuery.of(context).size.height * 0.045,
                          color:
                              _currentTab == 4 ? Colors.blue : colordtmaintwo,
                        ),
                      ),
                      //      BottomNavigationBarItem(icon: Icon(Icons.message, size: MediaQuery.of(context).size.height*0.045, color: _currentTab == 5 ? Colors.blue : colordtmaintwo,),),
                    ],
                  ))
              : Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.pink,
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.pinkAccent)));
        });
  }
}
