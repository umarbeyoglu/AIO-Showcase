import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../colors.dart';
import '../../language.dart';
import '../../models/User_Model/user_calendar_item_model.dart';
import '../../models/User_Model/user_model.dart';
import '../../repository.dart';
import '../General/home_screen.dart';
import 'calendar_create_time_screen.dart';

class TimeScreen extends StatefulWidget {
  final User user;
  const TimeScreen({Key key, this.user}) : super(key: key);
  @override
  TimeScreenState createState() => TimeScreenState(user: user);
}

class TimeScreenState extends State<TimeScreen> {
  final User user;
  TimeScreenState({Key key, this.user});
  List<String> times = [];
  List<User> _subusers = List<User>();
  List<User> _subusersForDisplay = List<User>();
  bool searching2 = false;
  var _textfield = TextEditingController();
  var _textfield2 = TextEditingController();
  ScrollController _scrollController = ScrollController();
  int page = 1;
  List<CalendarTime> posts = [];
  Future fetchPostsfuture;
  bool isLoading = false;

  @override
  void initState() {
    fetchPostsfuture = FetchOwnCalendarTime(http.Client(), user.id, page);
  }

  ShowTutorial(dynamic context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [],
          content: Text(
              'Choose items to add for status list. \n \n Press -> to finish \n \nPress specific time to add/remove the time to/from list \n \n'
              'Press (4 dots) to view item list'
              ''),
        );
      },
    );
  }

  Future _loadData() async {
    List<CalendarTime> postsinit = [];
    postsinit = await FetchOwnCalendarTime(http.Client(), user.id, page);
    setState(() {
      for (final item2 in postsinit) posts.add(item2);
      isLoading = false;
      return;
    });
  }

  void ischosen(String timechosen) {
    for (int i = 0; i < times.length; i++) {
      if (times[i] == timechosen) {
        times.removeAt(i);
        return;
      }
    }
    times.add(timechosen);
    return;
  }

  ShowChosenItems(dynamic context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [],
          title: Text(chosenitemsst),
          content: Column(
            children: [
              for (final item in times)
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: SizedBox(
                    child: Text(item),
                  ),
                ),
            ],
          ),
        );
      },
    );
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
        actions: [
          IconButton(
            icon: Icon(Icons.question_mark),
            iconSize: 30.0,
            color: colordtmaintwo,
            onPressed: () {
              ShowTutorial(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            iconSize: 30.0,
            color: colordtmaintwo,
            onPressed: () {
              setState(() {
                timeschosenmain = times;
                String icm = itemschosenmain.join(",");
                String tcm = timeschosenmain.join(",");
                icmf = icm;
                tcmf = tcm;
                print(icmf);
                print(tcmf);

                CreateCalendarStatus(user.id, user, context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomeScreen(user: user)));
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.reorder),
            iconSize: 30.0,
            color: colordtmaintwo,
            onPressed: () {
              ShowChosenItems(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            iconSize: 30.0,
            color: colordtmaintwo,
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) =>
                          CreateCalendarTimeScreen(user: user)))
                  .then((value) {
                Future.delayed(
                    Duration(seconds: 1),
                    () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => super.widget)));
              });
            },
          ),
        ],
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
          children: <Widget>[
            Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    timestatusexpst,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.019,
                      fontWeight: FontWeight.w600,
                      color: colordtmaintwo,
                    ),
                  ),
                  Divider(
                    color: colordtmaintwo,
                  ),
                  Text(
                    calendarstatuswarningst,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.019,
                      fontWeight: FontWeight.w600,
                      color: colordtmaintwo,
                    ),
                  ),
                  Column(
                    children: [
                      FutureBuilder<List<CalendarTime>>(
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
                                          MediaQuery.of(context).size.height *
                                              0.008),
                                      child: InkWell(
                                        child: ListTile(
                                          title: Column(
                                            children: [
                                              Text(
                                                '''$timest: ${posts[index].time.toString()} ''',
                                                style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.03,
                                                  color: colordtmaintwo,
                                                ),
                                              ),
                                            ],
                                          ),
                                          trailing: IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: colordtmaintwo,
                                            ),
                                            onPressed: () {
                                              RemoveCalendarTime(
                                                  posts[index].id);
                                              Future.delayed(
                                                  Duration(seconds: 1),
                                                  () => Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              super.widget)));
                                              //required
                                              return true;
                                            },
                                          ),
                                        ),
                                        onTap: () {
                                          ischosen(posts[index].time);
                                        },
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
                  SizedBox(height: 50),
                ])),
          ],
        ),
      ),
    );
  }
}

class DeleteThingScreen extends StatelessWidget {
  final String id;
  final String category;
  DeleteThingScreen({Key key, this.id, this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colordtmainone,
      body: Column(
        children: [
          SizedBox(height: 70),
          Text(
            doyouwanttodeletethisst,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.03,
              color: colordtmaintwo,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.07,
                child: ElevatedButton(
                  child: Text(
                    yesst,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                  onPressed: () {
                    if (category == 'UPC') {
                      DeleteArticleCategory(id);
                    }
                    if (category == 'USC') {
                      DeleteArticleCategory(id);
                    }
                    if (category == 'MS') {
                      DeleteMessage(id);
                    }
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.07,
                child: ElevatedButton(
                  child: Text(
                    nost,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
