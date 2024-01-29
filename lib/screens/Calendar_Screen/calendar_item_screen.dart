import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../language.dart';
import '../../models/Article_Model/article_model.dart';
import '../../models/User_Model/user_model.dart';
import '../../repository.dart';
import '../General/item_widget_screen.dart';
import 'calendar_time_screen.dart';

class ItemScreen extends StatefulWidget {
  final User user;
  final User calendarowner;
  final bool ischosing;
  const ItemScreen({Key key, this.calendarowner, this.ischosing, this.user})
      : super(key: key);
  @override
  ItemScreenState createState() => ItemScreenState(
      user: user, ischosing: ischosing, calendarowner: calendarowner);
}

class ItemScreenState extends State<ItemScreen> {
  final User user;
  final User calendarowner;
  final bool ischosing;
  ItemScreenState({Key key, this.ischosing, this.user, this.calendarowner});

  ScrollController _scrollController = ScrollController();
  int page = 1;
  List<Article> posts = [];
  Future fetchPostsfuture;
  bool isLoading = false;

  ShowTutorial(dynamic context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [],
          content: Text(
              'Choose items to add for status list. \n \n Press -> to go next \n Press + to add item to list \n'
              'Press - to remove item from list \n'
              'Press (4 dots) to view item list'
              ''),
        );
      },
    );
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
              for (final item in cschosenitem)
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
  void initState() {
    if (calendarowner.id == user.id) {
      setState(() {
        print('ff');
        fetchPostsfuture = FetchOwnArticlesFiltered(
            user.id, page, calendarowner, false, '', '', '', 'CI');
      });
      return;
    }
    isuserfollowed(user.id, calendarowner.id)
      ..then((result) {
        if (user.shouldshowuserinfo(calendarowner, result) == 'followed') {
          setState(() {
            fetchPostsfuture = FetchFollowedArticlesFiltered(
                user.id, page, calendarowner, false, '', '', '', 'CI');
          });
          return;
        }
        if (user.shouldshowuserinfo(calendarowner, result) == 'public') {
          setState(() {
            fetchPostsfuture = FetchPublicArticlesFiltered(
                user.id, page, calendarowner, false, '', '', '', 'CI');
          });
          return;
        }
      });
  }

  void initstatsitem(Article article) {
    isarticleliked(user.id, article.id)
      ..then((result) {
        article.likeresult = result;
      });
    isarticledisliked(user.id, article.id)
      ..then((result) {
        article.dislikeresult = result;
      });
  }

  Future _loadData() async {
    if (calendarowner.id == user.id) {
      FetchOwnArticlesFiltered(
          user.id, page, calendarowner, false, '', '', '', 'CI')
        ..then((result2) {
          setState(() {
            for (final item2 in result2) posts.add(item2);
            isLoading = false;
          });
          return;
        });
    }
    isuserfollowed(user.id, calendarowner.id)
      ..then((result) {
        if (user.shouldshowuserinfo(calendarowner, result) == 'followed') {
          FetchFollowedArticlesFiltered(
              user.id, page, calendarowner, false, '', '', '', 'CI')
            ..then((result2) {
              setState(() {
                for (final item2 in result2) posts.add(item2);
                isLoading = false;
              });
              return;
            });
        }
        if (user.shouldshowuserinfo(calendarowner, result) == 'public') {
          FetchPublicArticlesFiltered(
              user.id, page, calendarowner, false, '', '', '', 'CI')
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
  Future<User> callUser(String userid) async {
    Future<User> _user = FetchUser(userid);
    return _user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              elevation: 10.0,
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TimeScreen(
                              user: user,
                            )));
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
              ],
              toolbarHeight: 50,
              expandedHeight: 50,
              forceElevated: innerBoxIsScrolled,
            ),
          ];
        },
        body: FutureBuilder<List<Article>>(
          future: fetchPostsfuture,
          builder: (context, snapshotpost) {
            if (snapshotpost.hasError) print(snapshotpost.error);
            posts = snapshotpost.data;
            return snapshotpost.hasData
                ? PageView.builder(
                    onPageChanged: (indexpage) {
                      if (indexpage + 1 == posts.length) {
                        page = page + 1;
                        _loadData();
                      }
                    },
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      initstatsitem(posts[index]);
                      return ArticleWidgetScreen(
                          post: posts[index],
                          ischosing: true,
                          user: user,
                          dayhere: '',
                          mnyhere: '');
                    })
                : Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.pink,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
