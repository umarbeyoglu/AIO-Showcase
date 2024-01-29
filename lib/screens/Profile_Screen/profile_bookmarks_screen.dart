import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../colors.dart';
import '../../language.dart';
import '../../models/Article_Model/article_model.dart';
import '../../models/User_Model/user_bookmark_model.dart';
import '../../models/User_Model/user_model.dart';
import '../../repository.dart';
import '../General/item_widget_screen.dart';

class ArticleTagstatekeys {
  static final _tagStateKey1 = const Key('__TSK1__');
}

class ArticleUserTagstatekeys {
  static final _tagStateKey2 = const Key('__TSK2__');
}

class BookmarksScreen extends StatefulWidget {
  final User user;
  const BookmarksScreen({Key key, this.user}) : super(key: key);

  @override
  BookmarksScreenState createState() => BookmarksScreenState(user: user);
}

class BookmarksScreenState extends State<BookmarksScreen> {
  final User user;
  BookmarksScreenState({Key key, this.user});
  ScrollController _scrollController = ScrollController();
  int page = 1;
  List<UserBookmark> posts = [];
  Future fetchPostsfuture;
  bool isLoading = false;
  bool examplebool = false;
  @override
  void initState() {
    fetchPostsfuture = FetchOwnBookmark(http.Client(), user.id, page);
  }

  Future _loadData() async {
    FetchOwnBookmark(http.Client(), user.id, page)
      ..then((result) {
        setState(() {
          for (final item2 in result) posts.add(item2);
          isLoading = false;
          return;
        });
      });
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

  Future<Null> refreshList() async {
    setState(() {});
  }

  int _column = 0;
  int _column2 = 0;

  Future<Article> callPost(String bookmarkid) async {
    Future<Article> _bookmark = FetchArticle(bookmarkid);
    return _bookmark;
  }

  Future<User> callUser(String userid) async {
    Future<User> _user = FetchUser(userid);
    return _user;
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
                        bookmarksst,
                        style: TextStyle(
                          color: colordtmaintwo,
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Column(
                        children: [
                          FutureBuilder<List<UserBookmark>>(
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
                                        return FutureBuilder<Article>(
                                            future:
                                                callPost(posts[index].article),
                                            builder: (context, snapshotpost) {
                                              if (snapshotpost.hasError)
                                                print(snapshotpost.error);
                                              return snapshotpost.hasData
                                                  ? ArticleWidgetScreen(
                                                      user: user,
                                                      ischosing: false,
                                                      post: snapshotpost.data)
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
