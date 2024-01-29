import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_food_delivery_app/screens/General/reservation_screen.dart';
import 'package:flutter_food_delivery_app/screens/General/restart_screen.dart';
import 'package:video_player/video_player.dart';

import '../../colors.dart';
import '../../language.dart';
import '../../models/Article_Model/article_model.dart';
import '../../models/User_Model/user_model.dart';
import '../../repository.dart';
import '../Calendar_Screen/calendar_new_schedule_screen.dart';
import '../Visited_Profile_Screen/visited_profile_screen.dart';
import 'choice_screen.dart';
import 'comments_screen.dart';
import 'create_report_screen.dart';
import 'details_screen.dart';
import 'edit_screen.dart';
import 'home_screen.dart';

List<String> cschosenitem = [];
String cschosenitem1 = '';
Future<User> callUser(String userid) async {
  Future<User> _user = FetchPublicUser(userid);
  return _user;
}

class ArticleWidgetScreen extends StatefulWidget {
  final User user;
  final Article post;
  final bool ischosing;
  final String dayhere;
  final String mnyhere;
  final String dayfullhere;
  const ArticleWidgetScreen(
      {Key key,
      this.post,
      this.dayfullhere,
      this.user,
      this.dayhere,
      this.mnyhere,
      this.ischosing})
      : super(key: key);

  @override
  ArticleWidgetScreenState createState() => ArticleWidgetScreenState(
      user: user,
      post: post,
      dayhere: dayhere,
      mnyhere: mnyhere,
      ischosing: ischosing,
      dayfullhere: dayfullhere);
}

class ArticleWidgetScreenState extends State<ArticleWidgetScreen> {
  final User user;
  final Article post;
  final bool ischosing;
  final String dayhere;
  final String mnyhere;
  final String dayfullhere;
  bool hidewidgets = false;
  bool portraitinit = true;
  bool landscapeinit = false;
  ArticleWidgetScreenState(
      {Key key,
      this.dayfullhere,
      this.post,
      this.user,
      this.dayhere,
      this.mnyhere,
      this.ischosing});
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    if (post.videos.isNotEmpty) {
      print('initiatingvideoplayer');
      _controller = VideoPlayerController.network(post.videos.first.video)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  IconTextSizePort() {
    if (portraitinit) {
      return MediaQuery.of(context).size.height * 0.021;
    }
    if (landscapeinit) {
      return MediaQuery.of(context).size.height * 0.042;
    }
  }

  IconSizePort() {
    if (portraitinit) {
      return MediaQuery.of(context).size.height * 0.07;
    }
    if (landscapeinit) {
      return MediaQuery.of(context).size.height * 0.15;
    }
  }

  Future forward5Seconds() async =>
      goToPosition((currentPosition) => currentPosition + Duration(seconds: 5));

  Future rewind5Seconds() async =>
      goToPosition((currentPosition) => currentPosition - Duration(seconds: 5));

  Future goToPosition(
    Duration Function(Duration currentPosition) builder,
  ) async {
    final currentPosition = await _controller.position;
    final newPosition = builder(currentPosition);

    await _controller.seekTo(newPosition);
  }

  init1() {
    portraitinit = false;
    landscapeinit = true;
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  init2() {
    landscapeinit = false;
    portraitinit = true;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  void ischosen(String itemchosen) {
    for (int i = 0; i < cschosenitem.length; i++) {
      if (cschosenitem[i] == itemchosen) {
        cschosenitem.removeAt(i);
        return;
      }
    }
    cschosenitem.add(itemchosen);
    return;
  }

  bool ischosenfunc(String itemchosen) {
    for (int i = 0; i < cschosenitem.length; i++) {
      if (cschosenitem[i] == itemchosen) {
        return true;
      }
    }

    return false;
  }

  void initstats(Article article) {
    isarticleliked(user.id, article.id)
      ..then((result) {
        article.likeresult = result;
      });
    isarticledisliked(user.id, article.id)
      ..then((result) {
        article.dislikeresult = result;
      });
    isarticlebookmarked(user.id, article.id)
      ..then((result) {
        article.bookmarkresult = result;
      });
    articlebookmarkid(user.id, article.id)
      ..then((result) {
        article.bookmarkidresult = result;
      });
  }

  bool doesitembelong(User calendarowner, String articleitem) {
    for (int i = 0; i < calendarowner.calendarstatuses.length; i++) {
      List<String> items = calendarowner.calendarstatuses[i].items.split(',');
      for (int it = 0; it < items.length; it++) {
        if (items[it] == articleitem) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    print(post.author);
    return FutureBuilder<User>(
        future: callUser(post.author),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData) initstats(post);
          return snapshot.hasData
              ? Scaffold(
                  backgroundColor: colordtblack,
                  body: Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 1,
                        decoration: BoxDecoration(
                          color: colordtblack,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: post.iscensored(user)
                            ? SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: ElevatedButton(
                                  child: Text(
                                    articleincludescensoredcontentst(
                                        post.censortype),
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      post.iscensorremoved = true;
                                    });
                                  },
                                ),
                              )
                            : post.clipsatt(context),
                        // _controller.value.isInitialized ? AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller),)
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Padding(
                          //                      padding: EdgeInsets.only(top: 21),
                          //                      child: Row(
                          //                        mainAxisAlignment: MainAxisAlignment.center,
                          //                        children: <Widget>[
                          //                          Text(
                          //                            'Following',
                          //                            style: TextStyle(
                          //                                fontWeight: FontWeight.bold,
                          //                                fontSize: 18,
                          //                                color: colordtmainone.withOpacity(.7)),
                          //                          ),
                          //                          Container(
                          //                            margin: EdgeInsets.symmetric(horizontal: 8),
                          //                            color: colordtmainone.withOpacity(.7),
                          //                            height: 11,
                          //                            width: 1,
                          //                          ),
                          //                          Text(
                          //                            'For you',
                          //                            style: TextStyle(
                          //                                fontWeight: FontWeight.bold,
                          //                                fontSize: 18,
                          //                                color: colordtmainone),
                          //                          ),
                          //                        ],
                          //                      ),
                          //                    ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.87,
                                width: double.infinity,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.018,
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            if (hidewidgets == false)
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.018,
                                              ),
                                            if (hidewidgets == false)
                                              Text(
                                                snapshot.data.username,
                                                style: TextStyle(
                                                    color: colordtwhite,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            if (hidewidgets == false)
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.018,
                                              ),
                                            if (hidewidgets == false)
                                              Text(
                                                "${post.formatDate().day.toString().padLeft(2, '0')}-${post.formatDate().month.toString()}-${post.formatDate().year.toString().padLeft(2, '0')} ${post.formatDate().hour.toString().padLeft(2, '0')}:${post.formatDate().minute.toString().padLeft(2, '0')}",
                                                style: TextStyle(
                                                    color: colordtwhite,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            if (hidewidgets == false)
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.018,
                                              ),
                                            if (post.images.isEmpty &&
                                                post.videos.isEmpty &&
                                                hidewidgets == false)
                                              Text(
                                                post.caption == '-'
                                                    ? ''
                                                    : post.caption,
                                                style: TextStyle(
                                                    color: colordtwhite,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            if (hidewidgets == false)
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.018,
                                              ),
                                            if (isintnull(post.price) ==
                                                    false &&
                                                hidewidgets == false)
                                              Text(
                                                '$pricest : ${post.price.toString()} USD',
                                                style: TextStyle(
                                                    color: colordtwhite,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            if (post.price != 0 &&
                                                hidewidgets == false)
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.018,
                                              ),
                                            if (isintnull(post.stock) ==
                                                    false &&
                                                hidewidgets == false)
                                              Text(
                                                '$stockst : ${post.stock.toString()}',
                                                style: TextStyle(
                                                    color: colordtwhite,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            if (isintnull(post.stock) ==
                                                    false &&
                                                hidewidgets == false)
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.018,
                                              ),
                                            if (isstringnull(post
                                                        .productcondition) ==
                                                    false &&
                                                hidewidgets == false)
                                              Text(
                                                '$productconditionst : ${post.productcondition.toString()} USD',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            if (isstringnull(post
                                                        .productcondition) ==
                                                    false &&
                                                hidewidgets == false)
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.018,
                                              ),
                                            if (isstringnull(
                                                        post.deliveryfee) ==
                                                    false &&
                                                hidewidgets == false)
                                              Text(
                                                '$deliveryfeest : ${post.deliveryfee.toString()} USD',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            if (isstringnull(
                                                        post.deliveryfee) ==
                                                    false &&
                                                hidewidgets == false)
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.018,
                                              ),
                                            if (isstringnull(post.etatime) ==
                                                    false &&
                                                hidewidgets == false)
                                              Text(
                                                post.etatime,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            if (isstringnull(post.etatime) ==
                                                    false &&
                                                hidewidgets == false)
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.018,
                                              ),
                                            if (post.islocationnull() ==
                                                    false &&
                                                hidewidgets == false)
                                              Text(
                                                '${post.location()}',
                                                style: TextStyle(
                                                    color: colordtwhite,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            if (hidewidgets == false)
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.018,
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (post.iscensored(user) == false)
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.175,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.006,
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.006,
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                SizedBox(height: 50),
                                                if (post.videos.isNotEmpty)
                                                  Column(
                                                    children: <Widget>[
                                                      IconButton(
                                                          icon: Icon(
                                                            hidewidgets
                                                                ? Icons
                                                                    .visibility
                                                                : Icons
                                                                    .visibility_off,
                                                          ),
                                                          iconSize:
                                                              IconSizePort(),
                                                          color: colordtwhite,
                                                          onPressed: () {
                                                            setState(() {
                                                              hidewidgets =
                                                                  hidewidgets ==
                                                                          false
                                                                      ? true
                                                                      : false;
                                                            });
                                                          }),
                                                      Text(
                                                        hidewidgets
                                                            ? 'Show Widgets'
                                                            : 'Hide Widgets',
                                                        style: TextStyle(
                                                            fontSize:
                                                                IconTextSizePort(),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                colordtwhite),
                                                      )
                                                    ],
                                                  ),
                                                if (post.videos.isNotEmpty &&
                                                    hidewidgets == false)
                                                  Column(
                                                    children: <Widget>[
                                                      IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .perm_device_info,
                                                          ),
                                                          iconSize:
                                                              IconSizePort(),
                                                          color: colordtwhite,
                                                          onPressed: () {
                                                            setState(() {
                                                              portraitinit
                                                                  ? init1()
                                                                  : init2();
                                                            });
                                                          }),
                                                      Text(
                                                        'Change Orientation',
                                                        style: TextStyle(
                                                            fontSize:
                                                                IconTextSizePort(),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                colordtwhite),
                                                      )
                                                    ],
                                                  ),
                                                if (post.videos.isNotEmpty &&
                                                    hidewidgets == false)
                                                  Column(
                                                    children: <Widget>[
                                                      IconButton(
                                                          icon: Icon(
                                                            Icons.fast_rewind,
                                                          ),
                                                          iconSize:
                                                              IconSizePort(),
                                                          color: colordtwhite,
                                                          onPressed: () {
                                                            setState(() {
                                                              rewind5Seconds();
                                                            });
                                                          }),
                                                      Text(
                                                        'Rewind',
                                                        style: TextStyle(
                                                            fontSize:
                                                                IconTextSizePort(),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                colordtwhite),
                                                      )
                                                    ],
                                                  ),
                                                if (post.videos.isNotEmpty &&
                                                    hidewidgets == false)
                                                  Column(
                                                    children: <Widget>[
                                                      IconButton(
                                                          icon: Icon(
                                                            Icons.fast_forward,
                                                          ),
                                                          iconSize:
                                                              IconSizePort(),
                                                          color: colordtwhite,
                                                          onPressed: () {
                                                            setState(() {
                                                              forward5Seconds();
                                                            });
                                                          }),
                                                      Text(
                                                        'Forward',
                                                        style: TextStyle(
                                                            fontSize:
                                                                IconTextSizePort(),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                colordtwhite),
                                                      )
                                                    ],
                                                  ),
                                                if (post.videos.isNotEmpty &&
                                                    hidewidgets == false)
                                                  Column(
                                                    children: <Widget>[
                                                      IconButton(
                                                          icon: Icon(
                                                            _controller.value
                                                                    .isPlaying
                                                                ? Icons.pause
                                                                : Icons
                                                                    .play_arrow,
                                                          ),
                                                          iconSize:
                                                              IconSizePort(),
                                                          color: colordtwhite,
                                                          onPressed: () {
                                                            setState(() {
                                                              _controller.value
                                                                      .isPlaying
                                                                  ? _controller
                                                                      .pause()
                                                                  : _controller
                                                                      .play();
                                                            });
                                                          }),
                                                      Text(
                                                        _controller
                                                                .value.isPlaying
                                                            ? 'Pause'
                                                            : 'Play',
                                                        style: TextStyle(
                                                            fontSize:
                                                                IconTextSizePort(),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                colordtwhite),
                                                      )
                                                    ],
                                                  ),
                                                if (ischosing &&
                                                    hidewidgets == false)
                                                  Column(
                                                    children: [
                                                      ischosenfunc(post.caption)
                                                          ? IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  if (ischosing) {
                                                                    ischosen(post
                                                                        .caption);
                                                                    itemschosenmain =
                                                                        cschosenitem;
                                                                  }
                                                                  if (ischosing ==
                                                                      false) {
                                                                    if (doesitembelong(
                                                                        snapshot
                                                                            .data,
                                                                        post.caption)) {
                                                                      Navigator.of(context).push(MaterialPageRoute(
                                                                          builder: (context) => ScheduleScreenNew(
                                                                              item: post,
                                                                              user: user,
                                                                              calendarowner: snapshot.data,
                                                                              itemname: post.caption,
                                                                              itemlink: post.id)));
                                                                    }
                                                                    if (doesitembelong(
                                                                            snapshot.data,
                                                                            post.caption) ==
                                                                        false) {
                                                                      CreateCalendarScheduleRequestCTT(
                                                                          user
                                                                              .id,
                                                                          snapshot
                                                                              .data
                                                                              .id,
                                                                          post.caption);
                                                                      Navigator.of(
                                                                              context)
                                                                          .push(
                                                                              MaterialPageRoute(builder: (context) => CalendarRequestSentScreen()));
                                                                    }
                                                                  }
                                                                });
                                                              },
                                                              icon: Icon(
                                                                Icons.remove,
                                                                color:
                                                                    colordtwhite,
                                                                size: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.07,
                                                              ),
                                                            )
                                                          : IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  if (ischosing) {
                                                                    ischosen(post
                                                                        .caption);
                                                                    itemschosenmain =
                                                                        cschosenitem;
                                                                  }
                                                                  if (ischosing ==
                                                                      false) {
                                                                    if (doesitembelong(
                                                                        snapshot
                                                                            .data,
                                                                        post.caption)) {
                                                                      Navigator.of(context).push(MaterialPageRoute(
                                                                          builder: (context) => ScheduleScreenNew(
                                                                              item: post,
                                                                              user: user,
                                                                              calendarowner: snapshot.data,
                                                                              itemname: post.caption,
                                                                              itemlink: post.id)));
                                                                    }
                                                                    if (doesitembelong(
                                                                            snapshot.data,
                                                                            post.caption) ==
                                                                        false) {
                                                                      CreateCalendarScheduleRequestCTT(
                                                                          user
                                                                              .id,
                                                                          snapshot
                                                                              .data
                                                                              .id,
                                                                          post.caption);
                                                                      Navigator.of(
                                                                              context)
                                                                          .push(
                                                                              MaterialPageRoute(builder: (context) => CalendarRequestSentScreen()));
                                                                    }
                                                                  }
                                                                });
                                                              },
                                                              icon: Icon(
                                                                Icons.add,
                                                                color:
                                                                    colordtwhite,
                                                                size: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.07,
                                                              ),
                                                            ),
                                                      Text(
                                                        ischosenfunc(
                                                                post.caption)
                                                            ? removefromlistst
                                                            : addtolistst,
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.021,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                colordtwhite),
                                                      ),
                                                    ],
                                                  ),
                                                if (post.type != 'R' &&
                                                    ischosing == false &&
                                                    post.type != 'OFFER' &&
                                                    post.type != 'A' &&
                                                    hidewidgets == false)
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          if (doesitembelong(
                                                              snapshot.data,
                                                              post.caption)) {
                                                            print('belongs');
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ScheduleScreenNew(
                                                                              user: user,
                                                                              calendarowner: snapshot.data,
                                                                              itemname: post.caption,
                                                                              itemlink: post.id,
                                                                              item: post,
                                                                            )));
                                                          }
                                                          if (doesitembelong(
                                                                  snapshot.data,
                                                                  post.caption) ==
                                                              false) {
                                                            CreateCalendarScheduleRequestCTT(
                                                                user.id,
                                                                snapshot
                                                                    .data.id,
                                                                post.caption);
                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            CalendarRequestSentScreen()));
                                                            print('no belongs');
                                                          }
                                                        },
                                                        icon: Icon(
                                                          Icons.arrow_forward,
                                                          color: colordtmainone,
                                                          size: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.07,
                                                        ),
                                                      ),
                                                      Text(
                                                        choosest,
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.021,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                colordtwhite),
                                                      ),
                                                    ],
                                                  ),
                                                if (post.type == 'R' &&
                                                    hidewidgets == false)
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        icon: Icon(Icons
                                                            .shopping_cart),
                                                        iconSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.07,
                                                        color: colordtwhite,
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      ReservationScheduleScreen(
                                                                        user:
                                                                            user,
                                                                        calendarowner:
                                                                            snapshot.data,
                                                                        reservation:
                                                                            post,
                                                                      )));
                                                        },
                                                      ),
                                                      Text(
                                                        buyst,
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.021,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                colordtwhite),
                                                      ),
                                                    ],
                                                  ),
                                                if (post.type == 'US' &&
                                                    hidewidgets == false)
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        icon: Icon(Icons
                                                            .shopping_cart),
                                                        iconSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.07,
                                                        color: colordtwhite,
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  UserServiceFormScreen(
                                                                      userproduct:
                                                                          post,
                                                                      user:
                                                                          user,
                                                                      visiteduser:
                                                                          snapshot
                                                                              .data),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      Text(
                                                        buyst,
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.021,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                colordtwhite),
                                                      ),
                                                    ],
                                                  ),
                                                if (post.isbuyenabled &&
                                                    post.allowstocks == false &&
                                                    hidewidgets == false)
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        icon: Icon(Icons
                                                            .shopping_cart),
                                                        iconSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.07,
                                                        color: colordtwhite,
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  UserProductChoiceScreen(
                                                                user: user,
                                                                visiteduser:
                                                                    snapshot
                                                                        .data,
                                                                product: post,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      Text(
                                                        buyst,
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.021,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                colordtwhite),
                                                      ),
                                                    ],
                                                  ),
                                                if (post.isbuyenabled &&
                                                    post.allowstocks &&
                                                    post.stock > 0 &&
                                                    hidewidgets == false)
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        icon: Icon(Icons
                                                            .shopping_cart),
                                                        iconSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.07,
                                                        color: colordtwhite,
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  UserProductChoiceScreen(
                                                                user: user,
                                                                visiteduser:
                                                                    snapshot
                                                                        .data,
                                                                product: post,
                                                              ),
                                                            ),
                                                          );
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  CalendarEventChoiceScreen(
                                                                user: user,
                                                                visiteduser:
                                                                    snapshot
                                                                        .data,
                                                                product: post,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      Text(
                                                        buyst,
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.021,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                colordtwhite),
                                                      ),
                                                    ],
                                                  ),
                                                if (hidewidgets == false)
                                                  InkWell(
                                                    onDoubleTap: () {},
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (_) =>
                                                              DetailsScreen(
                                                            user: user,
                                                            details:
                                                                post.details,
                                                            article: post,
                                                            usertags:
                                                                post.usertags,
                                                            articletags:
                                                                post.tagsnew(),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Column(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.reorder,
                                                          color: colordtwhite,
                                                          size: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.07,
                                                        ),
                                                        Text(
                                                          detailsst,
                                                          style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.021,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  colordtwhite),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                if (hidewidgets == false &&
                                                    post.type != 'OFFER')
                                                  Column(
                                                    children: <Widget>[
                                                      post.articleliked(
                                                                  user.id,
                                                                  post.liked,
                                                                  post.unliked,
                                                                  post
                                                                      .likeresult) ==
                                                              true
                                                          ? IconButton(
                                                              icon: Icon(Icons
                                                                  .thumb_up),
                                                              iconSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.07,
                                                              color:
                                                                  Colors.blue,
                                                              onPressed: () {
                                                                setState(() {
                                                                  articlelikeid(
                                                                      user.id,
                                                                      post.id)
                                                                    ..then(
                                                                        (result) {
                                                                      post.articleunlikeprocess(
                                                                          user.id,
                                                                          post,
                                                                          result);
                                                                    });
                                                                  isarticleliked(
                                                                      user.id,
                                                                      post.id)
                                                                    ..then(
                                                                        (result) {
                                                                      post.articleliked(
                                                                          user.id,
                                                                          post.liked,
                                                                          post.unliked,
                                                                          result);
                                                                    });
                                                                });
                                                              },
                                                            )
                                                          : IconButton(
                                                              icon: Icon(Icons
                                                                  .thumb_up_outlined),
                                                              iconSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.07,
                                                              color:
                                                                  colordtwhite,
                                                              onPressed: () {
                                                                setState(() {
                                                                  post.liked =
                                                                      true;
                                                                  post.unliked =
                                                                      false;

                                                                  isarticleliked(
                                                                      user.id,
                                                                      post.id)
                                                                    ..then(
                                                                        (result) {
                                                                      post.articleliked(
                                                                          user.id,
                                                                          post.liked,
                                                                          post.unliked,
                                                                          result);
                                                                    });
                                                                  articledislikeid(
                                                                      user.id,
                                                                      post.id)
                                                                    ..then(
                                                                        (result) {
                                                                      post.articleundislikeprocess(
                                                                          user.id,
                                                                          post,
                                                                          result);
                                                                    });
                                                                  isarticledisliked(
                                                                      user.id,
                                                                      post.id)
                                                                    ..then(
                                                                        (result) {
                                                                      post.articledisliked(
                                                                          user.id,
                                                                          post.liked,
                                                                          post.unliked,
                                                                          result);
                                                                    });
                                                                });

                                                                LikeArticle(
                                                                    user.id,
                                                                    post.id);
                                                              }),
                                                      post.anonymity == true
                                                          ? Text(
                                                              likest,
                                                              style: TextStyle(
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.021,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      colordtwhite),
                                                            )
                                                          : InkWell(
                                                              child: Text(
                                                                "${post.likes}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.04,
                                                                  color:
                                                                      colordtwhite,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              onTap: () {}),
                                                    ],
                                                  ),
                                                if (hidewidgets == false &&
                                                    post.type != 'OFFER')
                                                  Column(
                                                    children: <Widget>[
                                                      post.articledisliked(
                                                                  user.id,
                                                                  post.disliked,
                                                                  post
                                                                      .undisliked,
                                                                  post
                                                                      .dislikeresult) ==
                                                              true
                                                          ? IconButton(
                                                              icon: Icon(Icons
                                                                  .thumb_down),
                                                              iconSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.07,
                                                              color: Colors.red,
                                                              onPressed: () {
                                                                setState(() {
                                                                  articledislikeid(
                                                                      user.id,
                                                                      post.id)
                                                                    ..then(
                                                                        (result) {
                                                                      post.articleundislikeprocess(
                                                                          user.id,
                                                                          post,
                                                                          result);
                                                                    });
                                                                  isarticledisliked(
                                                                      user.id,
                                                                      post.id)
                                                                    ..then(
                                                                        (result) {
                                                                      post.articledisliked(
                                                                          user.id,
                                                                          post.liked,
                                                                          post.unliked,
                                                                          result);
                                                                    });
                                                                });
                                                              },
                                                            )
                                                          : IconButton(
                                                              icon: Icon(Icons
                                                                  .thumb_down_outlined),
                                                              iconSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.07,
                                                              color:
                                                                  colordtwhite,
                                                              onPressed: () {
                                                                setState(() {
                                                                  post.disliked =
                                                                      true;
                                                                  post.undisliked =
                                                                      false;
                                                                  isarticledisliked(
                                                                      user.id,
                                                                      post.id)
                                                                    ..then(
                                                                        (result) {
                                                                      post.articledisliked(
                                                                          user.id,
                                                                          post.liked,
                                                                          post.unliked,
                                                                          result);
                                                                    });
                                                                  articlelikeid(
                                                                      user.id,
                                                                      post.id)
                                                                    ..then(
                                                                        (result) {
                                                                      post.articleunlikeprocess(
                                                                          user.id,
                                                                          post,
                                                                          result);
                                                                    });
                                                                  isarticleliked(
                                                                      user.id,
                                                                      post.id)
                                                                    ..then(
                                                                        (result) {
                                                                      post.articleliked(
                                                                          user.id,
                                                                          post.liked,
                                                                          post.unliked,
                                                                          result);
                                                                    });
                                                                });

                                                                DislikeArticle(
                                                                    user.id,
                                                                    post.id);
                                                              }),
                                                      post.anonymity == true
                                                          ? Text(
                                                              dislikest,
                                                              style: TextStyle(
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.021,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      colordtwhite),
                                                            )
                                                          : InkWell(
                                                              child: Text(
                                                                "${post.dislikes}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.04,
                                                                  color:
                                                                      colordtwhite,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              onTap: () {}),
                                                    ],
                                                  ),
                                                if (post.allowcomments ==
                                                        false &&
                                                    post.type != 'OFFER' &&
                                                    hidewidgets == false)
                                                  InkWell(
                                                    onDoubleTap: () {},
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (_) =>
                                                              CommentsScreen(
                                                            user: user,
                                                            post: post,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Column(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.comment,
                                                          color: colordtwhite,
                                                          size: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.07,
                                                        ),
                                                        post.anonymity == true
                                                            ? Text(
                                                                commentst,
                                                                style: TextStyle(
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.021,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        colordtwhite),
                                                              )
                                                            : post.allowcomments ==
                                                                    true
                                                                ? Container(
                                                                    height: 0,
                                                                    width: 0,
                                                                  )
                                                                : Text(
                                                                    "${post.comments}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            MediaQuery.of(context).size.height *
                                                                                0.021,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color:
                                                                            colordtwhite),
                                                                  )
                                                      ],
                                                    ),
                                                  ),
                                                if (hidewidgets == false &&
                                                    post.type != 'OFFER')
                                                  Column(
                                                    children: [
                                                      post.articlebookmarked(
                                                                  user.id,
                                                                  post
                                                                      .bookmarked,
                                                                  post
                                                                      .unbookmarked,
                                                                  user) ==
                                                              true
                                                          ? IconButton(
                                                              icon: Icon(Icons
                                                                  .bookmark),
                                                              iconSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.07,
                                                              color:
                                                                  colordtwhite,
                                                              onPressed: () {
                                                                setState(() {
                                                                  articlebookmarkid(
                                                                      user.id,
                                                                      post.id)
                                                                    ..then(
                                                                        (result) {
                                                                      post.articleunbookmarkprocess(
                                                                          user.id,
                                                                          post,
                                                                          user,
                                                                          post.bookmarkidresult);
                                                                    });
                                                                  isarticlebookmarked(
                                                                      user.id,
                                                                      post.id)
                                                                    ..then(
                                                                        (result) {
                                                                      post.articlebookmarked(
                                                                          user.id,
                                                                          post.bookmarked,
                                                                          post.unbookmarked,
                                                                          user);
                                                                    });
                                                                });
                                                              },
                                                            )
                                                          : IconButton(
                                                              icon: Icon(Icons
                                                                  .bookmark_border),
                                                              iconSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.07,
                                                              color:
                                                                  colordtwhite,
                                                              onPressed: () {
                                                                setState(() {
                                                                  post.bookmarked =
                                                                      true;
                                                                  post.unbookmarked =
                                                                      false;
                                                                  post.articlebookmarked(
                                                                      user.id,
                                                                      post.bookmarked,
                                                                      post.unbookmarked,
                                                                      user);
                                                                });
                                                                BookmarkArticle(
                                                                    user.id,
                                                                    post.id);
                                                              }),
                                                      Text(
                                                        bookmarkst,
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.021,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                colordtwhite),
                                                      ),
                                                    ],
                                                  ),
                                                if (post.details != '' &&
                                                    post.tags.isNotEmpty &&
                                                    post.usertags.isNotEmpty &&
                                                    hidewidgets == false)
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        icon: Icon(
                                                            Icons.more_horiz),
                                                        iconSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.07,
                                                        color: colordtwhite,
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  DetailsScreen(
                                                                user: user,
                                                                details: post
                                                                    .details,
                                                                usertags: post
                                                                    .usertags,
                                                                articletags: post
                                                                    .tagsnew(),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      Text(
                                                        morest,
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.021,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                colordtwhite),
                                                      ),
                                                    ],
                                                  ),
                                                if (post.author == user.id &&
                                                    hidewidgets == false)
                                                  InkWell(
                                                    onDoubleTap: () {},
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (_) =>
                                                              EditPostScreen(
                                                                  user: user,
                                                                  post: post,
                                                                  day: dayhere,
                                                                  mnyinit:
                                                                      mnyhere,
                                                                  dayfull:
                                                                      dayfullhere),
                                                        ),
                                                      );
                                                    },
                                                    child: Column(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.edit,
                                                          color: colordtwhite,
                                                          size: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.07,
                                                        ),
                                                        Text(
                                                          editst,
                                                          style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.021,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  colordtwhite),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                if (post.author == user.id &&
                                                    hidewidgets == false)
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        icon:
                                                            Icon(Icons.delete),
                                                        iconSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.07,
                                                        color: colordtwhite,
                                                        onPressed: () {
                                                          DeleteArticle(
                                                              user.id);
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  HomeScreen(
                                                                user: user,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      Text(
                                                        deletest,
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.021,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                colordtwhite),
                                                      ),
                                                    ],
                                                  ),
                                                if (hidewidgets == false)
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        icon:
                                                            Icon(Icons.report),
                                                        iconSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.07,
                                                        color: colordtwhite,
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  CreateReportScreen(
                                                                user: user,
                                                                article:
                                                                    post.id,
                                                                profile:
                                                                    post.author,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      Text(
                                                        reportst,
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.021,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                colordtwhite),
                                                      ),
                                                    ],
                                                  ),
                                                if (hidewidgets == false)
                                                  InkWell(
                                                    onDoubleTap: () {},
                                                    onTap: () {
                                                      isuserfollowed(user.id,
                                                          snapshot.data.id)
                                                        ..then((res) {
                                                          if (user.shouldshowuserinfo(
                                                                  snapshot.data,
                                                                  res) ==
                                                              'public') {
                                                            FetchPublicUserNav(
                                                                user,
                                                                snapshot
                                                                    .data.id,
                                                                context);
                                                          }
                                                          ;
                                                          if (user.shouldshowuserinfo(
                                                                  snapshot.data,
                                                                  res) ==
                                                              'followed') {
                                                            FetchFollowedUserNav(
                                                                user,
                                                                snapshot
                                                                    .data.id,
                                                                context);
                                                          }
                                                          ;
                                                          if (user.shouldshowuserinfo(
                                                                  snapshot.data,
                                                                  res) ==
                                                              'null') {
                                                            if (snapshot
                                                                    .data.id !=
                                                                user.id) {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (_) =>
                                                                        VisitedProfileScreen(
                                                                          user:
                                                                              user,
                                                                          visiteduserid:
                                                                              '',
                                                                          visiteduser:
                                                                              snapshot.data,
                                                                        )),
                                                              );
                                                            }
                                                          }
                                                          ;
                                                        });
                                                    },
                                                    child: Stack(
                                                      clipBehavior: Clip.none,
                                                      children: <Widget>[
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                color:
                                                                    colordtwhite,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.002),
                                                          ),
                                                          child: Material(
                                                            shape:
                                                                CircleBorder(),
                                                            child: CircleAvatar(
                                                              radius: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.035,
                                                              backgroundImage: NetworkImage(snapshot
                                                                          .data
                                                                          .image ==
                                                                      null
                                                                  ? 'https://st2.depositphotos.com/4111759/12123/v/600/depositphotos_121233262-stock-illustration-male-default-placeholder-avatar-profile.jpg'
                                                                  : snapshot
                                                                      .data
                                                                      .image),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                SizedBox(height: 50),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.pink,
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.pinkAccent)));
        });
  }
}
