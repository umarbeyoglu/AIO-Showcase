import 'package:Welpie/models/Article_Model/article_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:Welpie/repository.dart';
import 'package:Welpie/models/User_Model/user_model.dart';
import '../../colors.dart';


import 'package:Welpie/language.dart';

import '../../profile_user_product_screen.dart';
import '../General/item_widget_screen.dart';
import '../General/profile_search_screen.dart';




class Tagstatekeys {
  static final _tagStateKey1 = const Key('__TSK1__');
}

class VisitedProfileFeedScreen extends StatefulWidget {
  final User user;
  final User visiteduser;
  const VisitedProfileFeedScreen({Key key,this.visiteduser, this.user}) : super(key: key);

  @override
  VisitedProfileFeedScreenState createState() => VisitedProfileFeedScreenState(user: user,visiteduser:visiteduser);
}

class VisitedProfileFeedScreenState extends State<VisitedProfileFeedScreen> {
  final User user;
  final User visiteduser;
  VisitedProfileFeedScreenState({Key key,this.visiteduser,this.user});
  int page = 1;
  List<Article> posts = [];
  Future fetchPostsfuture;
  bool isLoading = false;
  bool details;
  bool lol;
  @override
  Future<User> callUser(String userid) async {
    Future<User> _user = FetchUser(userid);
    return _user;
  }



  Future _loadData() {


   isuserfollowed(user.id,visiteduser.id)..then((result) {
     if(user.shouldshowuserinfo(visiteduser,result) == 'followed'){
       FetchVisitedProfileFollowedArticles(http.Client(),visiteduser.id,page)..then((result2){
         setState(() {
           for(final item in result2)
             posts.add(item);
           isLoading = false;

         });   return;
       });
     }
     if(user.shouldshowuserinfo(visiteduser,result) == 'public'){
       FetchVisitedProfilePublicArticles(http.Client(),visiteduser.id,page)..then((result2){
         setState(() {
           for(final item in result2)
             posts.add(item);
           isLoading = false;

         });   return;
       });
     }

    });

  }

  @override
  void initState() {
       isuserfollowed(user.id,visiteduser.id)..then((result) {
         if (user.shouldshowuserinfo(visiteduser, result) == 'followed') {
           setState(() {
             fetchPostsfuture = FetchVisitedProfileFollowedArticles(
                 http.Client(), visiteduser.id, page);
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
  }

  void initstats(Article article){
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
      appBar: AppBar(
        backgroundColor: colordtmainone,
        leading:  IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 30.0,
          color: colordtmaintwo,
          onPressed: () {
            Navigator.pop(context,true);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color:colordtmaintwo,
            onPressed: () {
              setState(() {isfirsttimeprofilesearch = true;});
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ProfileSearchFilterScreen(
                      user:user,visiteduser: visiteduser,
                    )
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_alt),
            color:colordtmaintwo,
            onPressed: () {
              setState(() {isfirsttimeprofilesearch = true;});
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ProfileSearchFilter2Screen(
                      user:user,visiteduser: visiteduser,
                    )
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: colordtmainone,
      body: FutureBuilder<List<Article>>(
        future: fetchPostsfuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          posts = snapshot.data;
          return snapshot.hasData ? (snapshot.data.length == 0 ? Center(
            child: Text(nopostst,style:TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold)),
          ):

          PageView.builder(
              onPageChanged: (indexpage){
                if (indexpage + 1 == posts.length) {
                  page = page +1;
                  _loadData();
                }
              },
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context,index) {
                return ArticleWidgetScreen(
                    user:user,post:posts[index],ischosing: false,
                );},
              itemCount: posts.length))
              :
          Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));

        },
      ),
    );}}

