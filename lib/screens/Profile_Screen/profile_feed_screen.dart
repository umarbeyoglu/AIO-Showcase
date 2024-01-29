import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../colors.dart';
import '../../language.dart';
import '../../models/Article_Model/article_model.dart';
import '../../models/User_Model/user_model.dart';
import '../../repository.dart';
import '../General/item_widget_screen.dart';
import '../General/profile_search_screen.dart';

class Tagstatekeys {
  static final _tagStateKey1 = const Key('__TSK1__');
}

class ProfileFeedScreen extends StatefulWidget {
  final User user;
  const ProfileFeedScreen({Key key, this.user}) : super(key: key);

  @override
  ProfileFeedScreenState createState() => ProfileFeedScreenState(user: user);
}

class ProfileFeedScreenState extends State<ProfileFeedScreen> {
  final User user;
  ProfileFeedScreenState({Key key, this.user});
  int page = 1;
  List<Article> articles = [];
  Future fetchPostsfuture;
  bool isLoading = false;
  bool details;
  bool lol;

  Future _loadData() async {
    List<Article> postsinit = [];
    await new Future.delayed(new Duration(milliseconds: 500));
    postsinit =
        await FetchOwnArticles(user.id, page, user, false, '', '', '', 'A');
    setState(() {
      for (final item2 in postsinit) articles.add(item2);
      isLoading = false;
      return;
    });
  }

  @override
  Future<User> callUser(String userid) async {
    Future<User> _user = FetchUser(userid);
    return _user;
  }

  @override
  void initState() {
    fetchPostsfuture =
        FetchOwnArticles(user.id, page, user, false, '', '', '', 'A');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colordtmainone,
      appBar: AppBar(
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
            icon: Icon(Icons.search),
            color: colordtmaintwo,
            onPressed: () {
              setState(() {
                isfirsttimeprofilesearch = true;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ProfileSearchFilterScreen(
                          user: user,
                          visiteduser: user,
                        )),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_alt),
            color: colordtmaintwo,
            onPressed: () {
              setState(() {
                isfirsttimeprofilesearch = true;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ProfileSearchFilterScreen(
                          user: user,
                          visiteduser: user,
                        )),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Article>>(
        future: fetchPostsfuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          articles = snapshot.data;
          return snapshot.hasData
              ? (snapshot.data.length == 0
                  ? Center(
                      child: Text(nopostst,
                          style: TextStyle(
                              color: colordtmaintwo,
                              fontWeight: FontWeight.bold)),
                    )
                  : PageView.builder(
                      onPageChanged: (indexpage) {
                        if (indexpage + 1 == articles.length) {
                          page = page + 1;
                          _loadData();
                        }
                      },
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ArticleWidgetScreen(
                          user: user,
                          post: articles[index],
                          ischosing: false,
                        );
                      },
                      itemCount: articles.length))
              : Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.pink,
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.pinkAccent)));
        },
      ),
    );
  }
}

class ProfileSearchFilter2Screen {}
