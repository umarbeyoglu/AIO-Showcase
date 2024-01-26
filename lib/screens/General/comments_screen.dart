import 'dart:convert';
import 'package:untitled/models/Article_Model/article_comment_model.dart';
import 'package:untitled/models/Article_Model/article_model.dart';
import 'package:untitled/models/User_Model/user_calendar_item_model.dart';
import 'package:untitled/repository.dart';
import 'package:untitled/language.dart';
import 'package:untitled/screens/General/reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/models/User_Model/user_model.dart';
import 'package:untitled/screens/Visited_Profile_Screen/visited_profile_screen.dart';
import '../../colors.dart';
import 'dart:async';

import '../../models/User_Model/user_comment_model.dart';
import '../../models/User_Model/user_subuser_model.dart';



void initstatsarticlecomment(ArticleComment article,User user){
  isarticlecommentliked(user.id, article.id)
    ..then((result) {
      article.likeresult = result;
    });
  isarticlecommentdisliked(user.id, article.id)
    ..then((result) {
      article.dislikeresult = result;
    });

}
void initstatsusercomment(UserComment article,User user){
  isusercommentliked(user.id, article.id)
    ..then((result) {
      article.likeresult = result;
    });
  isusercommentdisliked(user.id, article.id)
    ..then((result) {
      article.dislikeresult = result;
    });

}


class NotificationCategories2{
  static const String All = 'All';
  static const String Order = 'Order';
  static const String Request = 'Request';
  static const String Notification = 'Notification';

  static const List<String> notificationchoices = <String>[All,Order,Request,Notification];}

class Categories{
  static const String All = 'All';
  static const String Feedback = 'Feedback';
  static const String Insight = 'Insight';
  static const String AccountHealth = 'AccountHealth';
  static const String Review = 'Review';
  static const String Education = 'Education';
  static const String Comment = 'Comment';
  static const String Suggestion = 'Suggestion';

  static const List<String> categorieschoices = <String>[All,Feedback,Insight,AccountHealth,Review,Education,Comment,Suggestion];
}

class FeedbackScreen extends StatefulWidget {

  final User user;
  const FeedbackScreen({Key key,this.user,}) : super(key : key);

  @override
  FeedbackScreenState createState() => FeedbackScreenState(user: user);
}

class FeedbackScreenState extends State<FeedbackScreen> {

  final User user;
  final TextEditingController _feedback= TextEditingController();
  FeedbackScreenState({Key key,this.user});
  Future fetchpostsfuture;
  ScrollController _scrollController = ScrollController();
  int page = 1;
  List<UserComment> posts = [];
  bool isLoading = false;

  @override
  void initState() {
    fetchpostsfuture =  FetchOwnUserComments(http.Client(),user.id,page);

  }



  Future _loadData() async {
    List<UserComment> postsinit = [];
    postsinit = await FetchOwnUserComments(http.Client(),user.id,page);
    setState(() {

     for(final item2 in postsinit)
  posts.add(item2);
      isLoading = false;
      return;
    });
  }




  UserCommentCategories(String categorieschoices) {

    if (categorieschoices == Categories.All) {
      setState(() {
        feedbackcategory = 'All';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                FeedbackScreen(
                  user: user,
                ),
          ),
        );
      });
    }
    else if (categorieschoices == Categories.Feedback) {
      setState(() {
        feedbackcategory = 'A';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                FeedbackScreen(
                  user: user,
                ),
          ),
        );
      });
    }
    else if (categorieschoices  == Categories.Insight) {
      setState(() {
        feedbackcategory = 'B';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                FeedbackScreen(
                  user: user,
                ),
          ),
        );
      });

    }
    else if (categorieschoices == Categories.AccountHealth) {
      setState(() {
        feedbackcategory = 'C';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                FeedbackScreen(
                  user: user,
                ),
          ),
        );
      });

    }
    else if (categorieschoices == Categories.Review) {
      setState(() {
        feedbackcategory = 'D';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                FeedbackScreen(
                  user: user,
                ),
          ),
        );
      });
    }
    else if (categorieschoices == Categories.Education) {
      setState(() {
        feedbackcategory = 'E';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                FeedbackScreen(
                  user: user,
                ),
          ),
        );
      });
    }

    else if (categorieschoices == Categories.Comment) {
      setState(() {
        feedbackcategory = 'G';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                FeedbackScreen(
                  user: user,
                ),
          ),
        );
      });
    }
    else if (categorieschoices == Categories.Suggestion) {
      setState(() {
        feedbackcategory = 'H';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                FeedbackScreen(
                  user: user,
                ),
          ),
        );
      });
    }

  }



  @override
  Future<User> callUser(String userid) async {
    Future<User> _user = FetchUser(userid);
    return _user;
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
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: UserCommentCategories,
            icon: Icon(Icons.format_list_bulleted,color: colordtmaintwo,size: MediaQuery.of(context).size.width*0.065,),
            itemBuilder: (BuildContext context){
              return Categories.categorieschoices.map((String categories){
                return PopupMenuItem<String>(
                  value: categories,
                  child: Text(categories),
                );
              }).toList();
            },
          ),
        ],
      ),

      backgroundColor: colordtmainone,
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading && scrollInfo.metrics.pixels ==
              scrollInfo.metrics.maxScrollExtent) {
            page = page +1;
            _loadData();
            setState(() {isLoading = true;});
            return true;
          }},child:  ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [ Column(
          children: <Widget>[


            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colordtmainone,
                borderRadius: BorderRadius.only(
                ),
              ),
              child: Column(

                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height*0.05),

                  Text(
                    feedbacksst,
                    style: TextStyle(
                      color:colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height*0.03,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Column(children: [
                    FutureBuilder<List<UserComment>>(
                      future: fetchpostsfuture,

                      builder: (context, snapshot) {

                        if (snapshot.hasError) print(snapshot.error);
                        posts = snapshot.data;
                        return snapshot.hasData ?
                        (snapshot.data.length == 0 ? Center(
                          child: Text(nocommentsyetst,style:TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold)),
                        ):  ListView.builder(
                            shrinkWrap: true,
                            itemCount: posts.length,
                            physics: ClampingScrollPhysics(),
                            controller: _scrollController,
                            itemBuilder: (context,index){
                              initstatsusercomment(posts[index],user);
                              return    FutureBuilder<User>(
                                  future: callUser(posts[index].author),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) print(snapshot.error);

                                    return snapshot.hasData ? Padding(
                                      padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.008),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          radius: MediaQuery.of(context).size.height*0.035,
                                          backgroundImage: NetworkImage(snapshot.data.image == null ? 'https://st2.depositphotos.com/4111759/12123/v/600/depositphotos_121233262-stock-illustration-male-default-placeholder-avatar-profile.jpg' : snapshot.data.image),

                                        ),

                                        subtitle:
                                        Column(
                                          crossAxisAlignment :CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin:  EdgeInsets.all(MediaQuery.of(context).size.height*0.005),
                                              padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.005),
                                              child: Stack(
                                                children: <Widget>[
                                                  Padding(

                                                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.height*0.0),
                                                    child: Column(
                                                      crossAxisAlignment :CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            InkWell(
                                                              onTap: () {
                                                                isuserfollowed(user.id,snapshot.data.id)..then((res){
                                                                  if(user.shouldshowuserinfo(snapshot.data,res) == 'public'){
                                                                    FetchPublicUserNav(user,snapshot.data.id,context);
                                                                  };
                                                                  if(user.shouldshowuserinfo(snapshot.data,res) == 'followed'){
                                                                    FetchFollowedUserNav(user,snapshot.data.id,context);
                                                                  };
                                                                  if(user.shouldshowuserinfo(snapshot.data,res) == 'null'){
                                                                    if(snapshot.data.id != user.id){
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (_) => VisitedProfileScreen(
                                                                              user:user,visiteduserid: '',
                                                                              visiteduser: snapshot.data,
                                                                            )
                                                                        ),
                                                                      );
                                                                    }
                                                                  };
                                                                });   },
                                                              child: Text(
                                                                '${snapshot.data.username}',
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  color:  colordtmaintwo,
                                                                  fontSize: MediaQuery.of(context).size.height*0.03,
                                                                ),
                                                              ),
                                                            ),

                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              '${posts[index].content}',
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                color:  colordtmaintwo,
                                                                fontSize: MediaQuery.of(context).size.height*0.023,
                                                              ),
                                                            ),
                                                            snapshot.data.id == user.id ? IconButton(
                                                              icon: Icon(Icons.delete ),
                                                              iconSize: MediaQuery.of(context).size.height*0.03,
                                                              color:colordtmaintwo ,
                                                              onPressed: (){
                                                                DeleteUserComment(posts[index].id);
                                                                Future.delayed(new Duration(seconds:1), ()
                                                                {    Navigator.pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (BuildContext context) => super.widget));});
                                                              },
                                                            ) : Container(height: 0,width: 0,),
                                                          ],
                                                        ),
                                                        SizedBox(height: MediaQuery.of(context).size.height*0.01),
                                                        Row(
                                                          children: [
                                                            posts[index].articleliked(user.id,posts[index].liked,posts[index].unliked,posts[index].likeresult) == true ?
                                                            IconButton(
                                                              icon: Icon(Icons.thumb_up),
                                                              iconSize: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.0425,
                                                              color: Colors.blue,
                                                              onPressed: () {
                                                                setState(() {


                                                                  usercommentlikeid(user.id,posts[index].id)..then((result){
                                                                    posts[index].articleunlikeprocess(user.id,result);
                                                                  });
                                                                  isusercommentliked(user.id,posts[index].id)..then((result){
                                                                    posts[index].articleliked(user.id,posts[index].liked,posts[index].unliked,result);
                                                                  });

                                                                });
                                                              },
                                                            ):
                                                            IconButton(
                                                                icon: Icon(Icons.thumb_up_outlined),
                                                                iconSize: MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .height * 0.0425,
                                                                color: colordtmaintwo,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    posts[index].liked = true;
                                                                    posts[index].unliked = false;
                                                                    isusercommentliked(user.id,posts[index].id)..then((result){
                                                                      posts[index].articleliked(user.id,posts[index].liked,posts[index].unliked,result);
                                                                    });

                                                                    usercommentdislikeid(user.id,posts[index].id)..then((result){
                                                                      posts[index].articleundislikeprocess(user.id,result);
                                                                    });
                                                                    isusercommentdisliked(user.id,posts[index].id)..then((result){
                                                                      posts[index].articledisliked(user.id,posts[index].liked,posts[index].unliked,result);
                                                                    });
                                                                  });

                                                                  LikeUserComment(user.id, posts[index].id);
                                                                }
                                                            ),

                                                            InkWell(
                                                                child:  Text(posts[index].liked == true ? "${posts[index].likes+1}" : "${posts[index].likes}",
                                                                  textAlign: TextAlign.center,

                                                                  style: TextStyle(
                                                                    fontSize:  MediaQuery.of(context).size.width*0.04,
                                                                    color:colordtmaintwo,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),),
                                                                onTap: () {

                                                                }
                                                            ),

                                                            InkWell(
                                                                child:  Text("${posts[index].likes}",
                                                                  textAlign: TextAlign.center,

                                                                  style: TextStyle(
                                                                    fontSize:  MediaQuery.of(context).size.width*0.04,
                                                                    color:colordtmainone,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),),
                                                                onTap: () {

                                                                }
                                                            ),

                                                            posts[index].articledisliked(user.id,posts[index].disliked,posts[index].undisliked,posts[index].dislikeresult) == true ?
                                                            IconButton(
                                                              icon: Icon(Icons.thumb_down),
                                                              iconSize: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.0425,
                                                              color: Colors.red,
                                                              onPressed: () {
                                                                setState(() {


                                                                  usercommentdislikeid(user.id,posts[index].id)..then((result){
                                                                    posts[index].articleundislikeprocess(user.id,result);
                                                                  });
                                                                  isusercommentdisliked(user.id,posts[index].id)..then((result){
                                                                    posts[index].articledisliked(user.id,posts[index].liked,posts[index].unliked,result);
                                                                  }); });
                                                              },
                                                            ):
                                                            IconButton(
                                                                icon: Icon(Icons.thumb_down_outlined),
                                                                iconSize: MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .height * 0.0425,
                                                                color: colordtmaintwo,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    posts[index].disliked = true;
                                                                    posts[index].undisliked = false;

                                                                    isusercommentdisliked(user.id,posts[index].id)..then((result){
                                                                      posts[index].articledisliked(user.id,posts[index].liked,posts[index].unliked,result);
                                                                    });

                                                                    usercommentlikeid(user.id,posts[index].id)..then((result){
                                                                      posts[index].articleunlikeprocess(user.id,result);
                                                                    });
                                                                    isusercommentliked(user.id,posts[index].id)..then((result){
                                                                      posts[index].articleliked(user.id,posts[index].liked,posts[index].unliked,result);
                                                                    });
                                                                  });

                                                                  DislikeUserComment(user.id, posts[index].id);
                                                                }
                                                            ),


                                                            InkWell(
                                                                child:  Text(posts[index].disliked == true ? "${posts[index].dislikes+1}" : "${posts[index].dislikes}",
                                                                  textAlign: TextAlign.center,

                                                                  style: TextStyle(
                                                                    fontSize:  MediaQuery.of(context).size.width*0.04,
                                                                    color:colordtmaintwo,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),),
                                                                onTap: () {
                                                                }
                                                            ),

                                                            InkWell(
                                                                child:  Text("${posts[index].dislikes}",
                                                                  textAlign: TextAlign.center,

                                                                  style: TextStyle(
                                                                    fontSize:  MediaQuery.of(context).size.width*0.04,
                                                                    color:colordtmainone,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),),
                                                                onTap: () {

                                                                }
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
                                    ) :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
                                  });

                            })) : Center(
                          child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                          ),);},),

                  ],),

                  SizedBox(height: MediaQuery.of(context).size.height*0.5),
                ],
              ),
            )
          ],
        )],
      ),),



      bottomNavigationBar: Transform.translate(
        offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          height: 60.0,
          color: colordtmainone,
          child: Row(
            children: <Widget>[

              Expanded(
                child: TextField(
                  controller: _feedback,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (value) {},
                  decoration: InputDecoration.collapsed(
                    hintText: writeafeedbackst,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                iconSize: 26,
                color: colordtmainthree,
                onPressed: () {
                  setState(() {CreateUserComment(user.id,user.id,_feedback.text,feedbackcategory);
                  _feedback.clear();
                  Future.delayed(new Duration(seconds:1), ()
                  {    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => super.widget));});
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VisitedFeedbackScreen extends StatefulWidget {

  final User user;
  final User visiteduser;
  const VisitedFeedbackScreen({Key key,this.user,this.visiteduser}) : super(key : key);

  @override
  VisitedFeedbackScreenState createState() => VisitedFeedbackScreenState(user: user,visiteduser: visiteduser );
}

class VisitedFeedbackScreenState extends State<VisitedFeedbackScreen> {

  final User user;
  final User visiteduser;
  final TextEditingController _feedback= TextEditingController();
  VisitedFeedbackScreenState({Key key,this.user,this.visiteduser});
  Future fetchpostsfuture;
  ScrollController _scrollController = ScrollController();
  int page = 1;
  List<UserComment> posts = [];
  bool isLoading = false;

  @override
  void initState() {

    isuserfollowed(user.id,visiteduser.id)..then((result){
      if(user.shouldshowuserinfo(visiteduser,result) == 'followed'){
        setState(() {
          fetchpostsfuture = FetchFollowedUserComments(http.Client(),visiteduser.id,page);
        });   return;

      }
      if(user.shouldshowuserinfo(visiteduser,result) == 'public'){
        setState(() {
          fetchpostsfuture = FetchPublicUserComments(http.Client(),visiteduser.id,page);
        });   return;

      }
    });

  }

  Future _loadData() async {
    List<UserComment> postsinit = [];
    isuserfollowed(user.id,visiteduser.id)..then((result){
      if(user.shouldshowuserinfo(visiteduser,result) == 'followed'){
        FetchFollowedUserComments(http.Client(),visiteduser.id,page)..then((result2){
          setState(() {
            for(final item2 in result2)
              posts.add(item2);
            isLoading = false;

          });   return;
        });
      }
      if(user.shouldshowuserinfo(visiteduser,result) == 'public'){
        FetchPublicUserComments(http.Client(),visiteduser.id,page)..then((result2){
          setState(() {
            for(final item2 in result2)
              posts.add(item2);
            isLoading = false;

          });   return;
        });
      }

    });

    setState(() {

     for(final item2 in postsinit)
  posts.add(item2);
      isLoading = false;
      return;
    });
  }



  @override
  Future<User> callUser(String userid) async {
    Future<User> _user = FetchUser(userid);
    return _user;
  }



  Future<UserComment> RefreshList(){
    Navigator.push(
      context ,
      MaterialPageRoute(
        builder: (_) => VisitedFeedbackScreen(
            user : user,visiteduser:visiteduser
        ),
      ),
    );
  }

  UserCommentCategories(String categorieschoices) {

    if (categorieschoices == Categories.All) {
      setState(() {
        feedbackcategory = 'All';

      });
    }
    else if (categorieschoices == Categories.Feedback) {
      setState(() {
        feedbackcategory = 'A';

      });
    }
    else if (categorieschoices  == Categories.Insight) {
      setState(() {
        feedbackcategory = 'B';

      });

    }
    else if (categorieschoices == Categories.AccountHealth) {
      setState(() {
        feedbackcategory = 'C';

      });

    }
    else if (categorieschoices == Categories.Review) {
      setState(() {
        feedbackcategory = 'D';

      });
    }
    else if (categorieschoices == Categories.Education) {
      setState(() {
        feedbackcategory = 'E';

      });
    }

    else if (categorieschoices == Categories.Comment) {
      setState(() {
        feedbackcategory = 'G';

      });
    }
    else if (categorieschoices == Categories.Suggestion) {
      setState(() {
        feedbackcategory = 'H';

      });
    }

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
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: UserCommentCategories,
            icon: Icon(Icons.format_list_bulleted,color: colordtmaintwo,size: MediaQuery.of(context).size.width*0.065,),
            itemBuilder: (BuildContext context){
              return Categories.categorieschoices.map((String categories){
                return PopupMenuItem<String>(
                  value: categories,
                  child: Text(categories),
                );
              }).toList();
            },
          ),
        ],
      ),


      backgroundColor: colordtmainone,
      body:
      NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading && scrollInfo.metrics.pixels ==
              scrollInfo.metrics.maxScrollExtent) {
            page = page +1;
            _loadData();
            setState(() {isLoading = true;});
            return true;
          }},child:   ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [Column(
          children: <Widget>[


            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colordtmainone,
                borderRadius: BorderRadius.only(
                ),
              ),
              child: Column(

                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height*0.05),

                  Text(
                    feedbacksst,
                    style: TextStyle(
                      color:colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height*0.03,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Column(children: [
                    FutureBuilder<List<UserComment>>(
                      future: fetchpostsfuture,

                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                        posts = snapshot.data;
                        return snapshot.hasData ?
                        (snapshot.data.length == 0 ? Center(
                          child: Text(nocommentsyetst,style:TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold)),
                        ):
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: posts.length,
                            physics: ClampingScrollPhysics(),
                            controller: _scrollController,
                            itemBuilder: (context,index){
                              initstatsusercomment(posts[index],user);
                              return FutureBuilder<User>(
                                  future: callUser(posts[index].author),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) print(snapshot.error);

                                    return snapshot.hasData ?  Padding(
                                      padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.008),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: CircleAvatar(
                                              radius: MediaQuery.of(context).size.height*0.035,
                                              backgroundImage: NetworkImage(snapshot.data.image == null ? 'https://st2.depositphotos.com/4111759/12123/v/600/depositphotos_121233262-stock-illustration-male-default-placeholder-avatar-profile.jpg' : snapshot.data.image),

                                            ),

                                            subtitle:
                                            Column(
                                              crossAxisAlignment :CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin:  EdgeInsets.all(MediaQuery.of(context).size.height*0.005),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Padding(

                                                        padding: EdgeInsets.only(right: MediaQuery.of(context).size.height*0.0),
                                                        child: Column(
                                                          crossAxisAlignment :CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Row(
                                                              children: <Widget>[
                                                                InkWell(
                                                                  onTap: () {
                                                                    isuserfollowed(user.id,snapshot.data.id)..then((res){
                                                                      if(user.shouldshowuserinfo(snapshot.data,res) == 'public'){
                                                                        FetchPublicUserNav(user,snapshot.data.id,context);
                                                                      };
                                                                      if(user.shouldshowuserinfo(snapshot.data,res) == 'followed'){
                                                                        FetchFollowedUserNav(user,snapshot.data.id,context);
                                                                      };
                                                                      if(user.shouldshowuserinfo(snapshot.data,res) == 'null'){
                                                                        if(snapshot.data.id != user.id){
                                                                          Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (_) => VisitedProfileScreen(
                                                                                  user:user,visiteduserid: '',
                                                                                  visiteduser: snapshot.data,
                                                                                )
                                                                            ),
                                                                          );
                                                                        }
                                                                      };
                                                                    });   },
                                                                  child:
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        '${snapshot.data.username}',
                                                                        style: TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          color:  colordtmaintwo,
                                                                          fontSize: MediaQuery.of(context).size.height*0.03,
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: MediaQuery.of(context).size.width*0.08,),

                                                                    ],
                                                                  ),

                                                                ),

                                                              ],
                                                            ),
                                                            // SizedBox(height: MediaQuery.of(context).size.height*0.01),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  '${posts[index].content}',
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    color:  colordtmaintwo,
                                                                    fontSize: MediaQuery.of(context).size.height*0.023,
                                                                  ),
                                                                ),
                                                                snapshot.data.id == user.id ? IconButton(
                                                                  icon: Icon(Icons.delete ),
                                                                  iconSize: MediaQuery.of(context).size.height*0.03,
                                                                  color:colordtmaintwo ,
                                                                  onPressed: (){
                                                                    DeleteUserComment(posts[index].id);
                                                                    Future.delayed(new Duration(seconds:1), ()
                                                                    {
                                                                      Navigator.pushReplacement(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (BuildContext context) => super.widget));


                                                                    });
                                                                  },
                                                                ) : Container(height: 0,width: 0,),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                posts[index].articleliked(user.id,posts[index].liked,posts[index].unliked,posts[index].likeresult) == true ?
                                                                IconButton(
                                                                  icon: Icon(Icons.thumb_up),
                                                                  iconSize: MediaQuery
                                                                      .of(context)
                                                                      .size
                                                                      .height * 0.0425,
                                                                  color: Colors.blue,
                                                                  onPressed: () {
                                                                    setState(() {


                                                                      usercommentlikeid(user.id,posts[index].id)..then((result){
                                                                        posts[index].articleunlikeprocess(user.id,result);
                                                                      });
                                                                      isusercommentliked(user.id,posts[index].id)..then((result){
                                                                        posts[index].articleliked(user.id,posts[index].liked,posts[index].unliked,result);
                                                                      });

                                                                    });
                                                                  },
                                                                ):
                                                                IconButton(
                                                                    icon: Icon(Icons.thumb_up_outlined),
                                                                    iconSize: MediaQuery
                                                                        .of(context)
                                                                        .size
                                                                        .height * 0.0425,
                                                                    color: colordtmaintwo,
                                                                    onPressed: () {
                                                                      setState(() {
                                                                        posts[index].liked = true;
                                                                        posts[index].unliked = false;
                                                                        isusercommentliked(user.id,posts[index].id)..then((result){
                                                                          posts[index].articleliked(user.id,posts[index].liked,posts[index].unliked,result);
                                                                        });

                                                                        usercommentdislikeid(user.id,posts[index].id)..then((result){
                                                                          posts[index].articleundislikeprocess(user.id,result);
                                                                        });
                                                                        isusercommentdisliked(user.id,posts[index].id)..then((result){
                                                                          posts[index].articledisliked(user.id,posts[index].liked,posts[index].unliked,result);
                                                                        });
                                                                      });

                                                                      LikeUserComment(user.id, posts[index].id);
                                                                    }
                                                                ),

                                                                InkWell(
                                                                    child:  Text(posts[index].liked == true ? "${posts[index].likes+1}" : "${posts[index].likes}",
                                                                      textAlign: TextAlign.center,

                                                                      style: TextStyle(
                                                                        fontSize:  MediaQuery.of(context).size.width*0.04,
                                                                        color:colordtmaintwo,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),),
                                                                    onTap: () {

                                                                    }
                                                                ),

                                                                InkWell(
                                                                    child:  Text("${posts[index].likes}",
                                                                      textAlign: TextAlign.center,

                                                                      style: TextStyle(
                                                                        fontSize:  MediaQuery.of(context).size.width*0.04,
                                                                        color:colordtmainone,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),),
                                                                    onTap: () {

                                                                    }
                                                                ),

                                                                posts[index].articledisliked(user.id,posts[index].disliked,posts[index].undisliked,posts[index].dislikeresult) == true ?
                                                                IconButton(
                                                                  icon: Icon(Icons.thumb_down),
                                                                  iconSize: MediaQuery
                                                                      .of(context)
                                                                      .size
                                                                      .height * 0.0425,
                                                                  color: Colors.red,
                                                                  onPressed: () {
                                                                    setState(() {


                                                                      usercommentdislikeid(user.id,posts[index].id)..then((result){
                                                                        posts[index].articleundislikeprocess(user.id,result);
                                                                      });
                                                                      isusercommentdisliked(user.id,posts[index].id)..then((result){
                                                                        posts[index].articledisliked(user.id,posts[index].liked,posts[index].unliked,result);
                                                                      }); });
                                                                  },
                                                                ):
                                                                IconButton(
                                                                    icon: Icon(Icons.thumb_down_outlined),
                                                                    iconSize: MediaQuery
                                                                        .of(context)
                                                                        .size
                                                                        .height * 0.0425,
                                                                    color: colordtmaintwo,
                                                                    onPressed: () {
                                                                      setState(() {
                                                                        posts[index].disliked = true;
                                                                        posts[index].undisliked = false;

                                                                        isusercommentdisliked(user.id,posts[index].id)..then((result){
                                                                          posts[index].articledisliked(user.id,posts[index].liked,posts[index].unliked,result);
                                                                        });

                                                                        usercommentlikeid(user.id,posts[index].id)..then((result){
                                                                          posts[index].articleunlikeprocess(user.id,result);
                                                                        });
                                                                        isusercommentliked(user.id,posts[index].id)..then((result){
                                                                          posts[index].articleliked(user.id,posts[index].liked,posts[index].unliked,result);
                                                                        });
                                                                      });

                                                                      DislikeUserComment(user.id, posts[index].id);
                                                                    }
                                                                ),


                                                                InkWell(
                                                                    child:  Text(posts[index].disliked == true ? "${posts[index].dislikes+1}" : "${posts[index].dislikes}",
                                                                      textAlign: TextAlign.center,

                                                                      style: TextStyle(
                                                                        fontSize:  MediaQuery.of(context).size.width*0.04,
                                                                        color:colordtmaintwo,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),),
                                                                    onTap: () {
                                                                    }
                                                                ),

                                                                InkWell(
                                                                    child:  Text("${posts[index].dislikes}",
                                                                      textAlign: TextAlign.center,

                                                                      style: TextStyle(
                                                                        fontSize:  MediaQuery.of(context).size.width*0.04,
                                                                        color:colordtmainone,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),),
                                                                    onTap: () {

                                                                    }
                                                                ),


                                                              ],
                                                            ),
                                                            SizedBox(height: MediaQuery.of(context).size.height*0.01),





                                                          ],
                                                        ),

                                                      ),

                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),






                                          ),

                                        ],
                                      ),
                                    ) :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
                                  });

                            })) :
                        Center(
                          child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                          ),);},),

                  ],),

                  SizedBox(height: MediaQuery.of(context).size.height*0.5),
                ],
              ),
            )
          ],
        )],
      ),),


      bottomNavigationBar: Transform.translate(
        offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          height: 60.0,
          color: colordtmainone,
          child: Row(
            children: <Widget>[

              Expanded(
                child: TextField(
                  controller: _feedback,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (value) {},
                  decoration: InputDecoration.collapsed(
                    hintText: writeafeedbackst,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                iconSize: 26,
                color: colordtmainthree,
                onPressed: () {
                  setState(() {CreateUserComment(user.id,visiteduser.id,_feedback.text,feedbackcategory);
                  _feedback.clear();
                  Future.delayed(new Duration(seconds:1), ()
                  { Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => super.widget));}
                  );
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentsScreen extends StatefulWidget {
  final Article post;
  final User user;
  const CommentsScreen({Key key,this.post,this.user}) : super(key : key);

  @override
  CommentsScreenState createState() => CommentsScreenState(user : user,post : post);
}

class CommentsScreenState extends State<CommentsScreen> {
  final Article post;
  final User user;
  CommentsScreenState({Key key,this.post,this.user});
  final TextEditingController _comment= TextEditingController();
  Future fetchpostsfuture;
  ScrollController _scrollController = ScrollController();
  int page = 1;
  User author = User();
  List<ArticleComment> posts = [];
  bool isLoading = false;

  @override
  void initState(){
    //   author = await FetchUser(post.author);
    if(user.id == post.author){
      setState(() {
        fetchpostsfuture = FetchOwnArticleComments(http.Client(),post.id,page);
      });   return;

    }
    FetchUser(post.author)..then((authorresult){

      isuserfollowed(user.id,post.author)..then((result){

        if(user.shouldshowuserinfo(authorresult,result) == 'followed'){
          setState(() {
            fetchpostsfuture = FetchOwnFollowedArticleComments(http.Client(),post.id,page);
          });   return;

        }
        if(user.shouldshowuserinfo(authorresult,result) == 'public'){
          setState(() {
            fetchpostsfuture = FetchPublicArticleComments(http.Client(),post.id,page);
          });   return;

        }
      });
    });

  }

  Future _loadData() async {
    if(user.id == post.author){
      FetchOwnArticleComments(http.Client(),post.id,page)..then((result){
        setState(() {
          for(final item2 in result)
            posts.add(item2);
          isLoading = false;

        });   return;
      });
    }
    isuserfollowed(user.id,post.author)..then((result) {
      if (user.shouldshowuserinfo(author, result) == 'followed') {
        FetchOwnFollowedArticleComments(http.Client(), post.id, page)
          ..then((result2) {
            setState(() {
              for(final item2 in result2)
                posts.add(item2);
              isLoading = false;

            });   return;
          });
      }
      if (user.shouldshowuserinfo(author, result) == 'public') {
        FetchPublicArticleComments(http.Client(), post.id, page)
          ..then((result2) {
            setState(() {
              for(final item2 in result2)
                posts.add(item2);
              isLoading = false;

            });   return;
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


      appBar: new AppBar(
        backgroundColor: colordtmainone,
        leading:  IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 30.0,
          color: colordtmaintwo,
          onPressed: () {
            Navigator.pop(context,true);
          },
        ),
      ),

      backgroundColor: colordtmainone,
      body:
      NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading && scrollInfo.metrics.pixels ==
              scrollInfo.metrics.maxScrollExtent) {
            page = page +1;
            _loadData();
            setState(() {isLoading = true;});
            return true;
          }},child:   ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [Column(
          children: <Widget>[


            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colordtmainone,
                borderRadius: BorderRadius.only(
                ),
              ),
              child: Column(

                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height*0.05),

                  Text(
                    comment2st,
                    style: TextStyle(
                      color:colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height*0.03,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Column(children: [
                    FutureBuilder<List<ArticleComment>>(
                      future: fetchpostsfuture,

                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                        posts = snapshot.data;
                        return snapshot.hasData ?
                        (snapshot.data.length == 0 ? Center(
                          child: Text(nocommentsyetst,style:TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold)),
                        ):  ListView.builder(
                            shrinkWrap: true,
                            itemCount: posts.length,
                            physics: ClampingScrollPhysics(),
                            controller: _scrollController,
                            itemBuilder: (context,index){
                              initstatsarticlecomment(posts[index],user);
                              return FutureBuilder<User>(
                                  future: callUser(posts[index].authorstring),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) print(snapshot.error);

                                    return snapshot.hasData ? Padding(
                                      padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.008),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          radius: MediaQuery.of(context).size.height*0.035,
                                          backgroundImage: NetworkImage(snapshot.data.image == null ? 'https://st2.depositphotos.com/4111759/12123/v/600/depositphotos_121233262-stock-illustration-male-default-placeholder-avatar-profile.jpg' : snapshot.data.image),

                                        ),

                                        subtitle:
                                        Column(
                                          crossAxisAlignment :CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin:  EdgeInsets.all(MediaQuery.of(context).size.height*0.005),
                                              child: Stack(
                                                children: <Widget>[
                                                  Padding(

                                                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.height*0.0),
                                                    child: Column(
                                                      crossAxisAlignment :CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            InkWell(
                                                              onTap: () {
                                                                isuserfollowed(user.id,snapshot.data.id)..then((res){
                                                                  if(user.shouldshowuserinfo(snapshot.data,res) == 'public'){
                                                                    FetchPublicUserNav(user,snapshot.data.id,context);
                                                                  };
                                                                  if(user.shouldshowuserinfo(snapshot.data,res) == 'followed'){
                                                                    FetchFollowedUserNav(user,snapshot.data.id,context);
                                                                  };
                                                                  if(user.shouldshowuserinfo(snapshot.data,res) == 'null'){
                                                                    if(snapshot.data.id != user.id){
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (_) => VisitedProfileScreen(
                                                                              user:user,visiteduserid: '',
                                                                              visiteduser: snapshot.data,
                                                                            )
                                                                        ),
                                                                      );
                                                                    }
                                                                  };
                                                                });   },
                                                              child:
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    '${snapshot.data.username}',
                                                                    style: TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      color:  colordtmaintwo,
                                                                      fontSize: MediaQuery.of(context).size.height*0.03,
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: MediaQuery.of(context).size.width*0.08,),

                                                                ],
                                                              ),

                                                            ),

                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              '${posts[index].content}',
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                color:  colordtmaintwo,
                                                                fontSize: MediaQuery.of(context).size.height*0.023,
                                                              ),
                                                            ),
                                                            snapshot.data.id == user.id ? IconButton(
                                                              icon: Icon(Icons.delete ),
                                                              iconSize: MediaQuery.of(context).size.height*0.03,
                                                              color:colordtmaintwo ,
                                                              onPressed: (){
                                                                DeleteArticleComment(posts[index].id);
                                                                Future.delayed(new Duration(seconds:1), ()
                                                                {    Navigator.pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (BuildContext context) => super.widget));});
                                                              },
                                                            ) : Container(height: 0,width: 0,),
                                                          ],
                                                        ),
                                                        SizedBox(height: MediaQuery.of(context).size.height*0.01),
                                                        Row(
                                                          children: [
                                                            posts[index].articleliked(user.id,posts[index].liked,posts[index].unliked,posts[index].likeresult) == true ?
                                                            IconButton(
                                                              icon: Icon(Icons.thumb_up),
                                                              iconSize: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.0425,
                                                              color: Colors.blue,
                                                              onPressed: () {
                                                                setState(() {


                                                                  articlecommentlikeid(user.id,posts[index].id)..then((result){
                                                                    posts[index].articleunlikeprocess(user.id,result);
                                                                  });
                                                                  isarticlecommentliked(user.id,posts[index].id)..then((result){
                                                                    posts[index].articleliked(user.id,posts[index].liked,posts[index].unliked,result);
                                                                  });

                                                                });
                                                              },
                                                            ):
                                                            IconButton(
                                                                icon: Icon(Icons.thumb_up_outlined),
                                                                iconSize: MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .height * 0.0425,
                                                                color: colordtmaintwo,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    posts[index].liked = true;
                                                                    posts[index].unliked = false;
                                                                    isarticlecommentliked(user.id,posts[index].id)..then((result){
                                                                      posts[index].articleliked(user.id,posts[index].liked,posts[index].unliked,result);
                                                                    });

                                                                    articlecommentdislikeid(user.id,posts[index].id)..then((result){
                                                                      posts[index].articleundislikeprocess(user.id,result);
                                                                    });
                                                                    isarticlecommentdisliked(user.id,posts[index].id)..then((result){
                                                                      posts[index].articledisliked(user.id,posts[index].liked,posts[index].unliked,result);
                                                                    });
                                                                  });

                                                                  LikeArticleComment(user.id, posts[index].id);
                                                                }
                                                            ),

                                                            InkWell(
                                                                child:  Text(posts[index].liked == true ? "${posts[index].likes+1}" : "${posts[index].likes}",
                                                                  textAlign: TextAlign.center,

                                                                  style: TextStyle(
                                                                    fontSize:  MediaQuery.of(context).size.width*0.04,
                                                                    color:colordtmaintwo,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),),
                                                                onTap: () {

                                                                }
                                                            ),

                                                            InkWell(
                                                                child:  Text("${posts[index].likes}",
                                                                  textAlign: TextAlign.center,

                                                                  style: TextStyle(
                                                                    fontSize:  MediaQuery.of(context).size.width*0.04,
                                                                    color:colordtmainone,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),),
                                                                onTap: () {

                                                                }
                                                            ),

                                                            posts[index].articledisliked(user.id,posts[index].disliked,posts[index].undisliked,posts[index].dislikeresult) == true ?
                                                            IconButton(
                                                              icon: Icon(Icons.thumb_down),
                                                              iconSize: MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .height * 0.0425,
                                                              color: Colors.red,
                                                              onPressed: () {
                                                                setState(() {


                                                                  articlecommentdislikeid(user.id,posts[index].id)..then((result){
                                                                    posts[index].articleundislikeprocess(user.id,result);
                                                                  });
                                                                  isarticlecommentdisliked(user.id,posts[index].id)..then((result){
                                                                    posts[index].articledisliked(user.id,posts[index].liked,posts[index].unliked,result);
                                                                  }); });
                                                              },
                                                            ):
                                                            IconButton(
                                                                icon: Icon(Icons.thumb_down_outlined),
                                                                iconSize: MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .height * 0.0425,
                                                                color: colordtmaintwo,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    posts[index].disliked = true;
                                                                    posts[index].undisliked = false;

                                                                    isarticlecommentdisliked(user.id,posts[index].id)..then((result){
                                                                      posts[index].articledisliked(user.id,posts[index].liked,posts[index].unliked,result);
                                                                    });

                                                                    articlecommentlikeid(user.id,posts[index].id)..then((result){
                                                                      posts[index].articleunlikeprocess(user.id,result);
                                                                    });
                                                                    isarticlecommentliked(user.id,posts[index].id)..then((result){
                                                                      posts[index].articleliked(user.id,posts[index].liked,posts[index].unliked,result);
                                                                    });
                                                                  });

                                                                  DislikeArticleComment(user.id, posts[index].id);
                                                                }
                                                            ),


                                                            InkWell(
                                                                child:  Text(posts[index].disliked == true ? "${posts[index].dislikes+1}" : "${posts[index].dislikes}",
                                                                  textAlign: TextAlign.center,

                                                                  style: TextStyle(
                                                                    fontSize:  MediaQuery.of(context).size.width*0.04,
                                                                    color:colordtmaintwo,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),),
                                                                onTap: () {
                                                                }
                                                            ),

                                                            InkWell(
                                                                child:  Text("${posts[index].dislikes}",
                                                                  textAlign: TextAlign.center,

                                                                  style: TextStyle(
                                                                    fontSize:  MediaQuery.of(context).size.width*0.04,
                                                                    color:colordtmainone,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),),
                                                                onTap: () {

                                                                }
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
                                    ) :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
                                  });

                            })) :
                        Center(
                          child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                          ),);},),

                  ],),

                  SizedBox(height: MediaQuery.of(context).size.height*0.5),
                ],
              ),
            )
          ],
        )],
      ),),


      bottomNavigationBar:Transform.translate(
        offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          height: 60.0,
          color: colordtmainone,
          child: Row(
            children: <Widget>[

              Expanded(
                child: TextField(
                  controller: _comment,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (value) {},
                  decoration: InputDecoration.collapsed(
                    hintText: writeacommentst,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                iconSize: 26,
                color: colordtmainthree,
                onPressed: () {
                  setState(() {
                    CreateArticleComment(user.id,post.id,_comment.text);
                    _comment.clear();
                    Future.delayed(new Duration(seconds:1), ()
                    {    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => super.widget));});


                  });

                },
              ),
            ],
          ),
        ),
      ),

    );
  }

}

