import 'dart:async';

import 'package:Welpie/language.dart';
import 'package:Welpie/models/Article_Model/article_model.dart';
import 'package:Welpie/models/User_Model/notification_model.dart';
import 'package:Welpie/models/User_Model/user_calendar_item_model.dart';
import 'package:Welpie/models/User_Model/user_model.dart';
import 'package:Welpie/repository.dart';

import 'package:Welpie/screens/General/home_screen.dart';
import 'package:Welpie/screens/General/reservation_screen.dart';



import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:photo_view/photo_view.dart';

import '../../colors.dart';
import '../../models/User_Model/user_subuser_model.dart';
import '../../repository.dart';
import '../Visited_Profile_Screen/visited_profile_screen.dart';

import 'cart_screen.dart';
import 'comments_screen.dart';
import 'home_screen.dart';
import 'item_widget_screen.dart';
class NotificationsScreen extends StatefulWidget {
  final User user;
  const NotificationsScreen({Key key,this.user,}) : super(key : key);

  @override
  NotificationsScreenState createState() => NotificationsScreenState(user: user );
}

class NotificationsScreenState extends State<NotificationsScreen> {
  final User user;
  NotificationsScreenState({Key key,this.user});
  String type = 'Notif';
  int page = 1;
  List<Notifications> posts = [];
  Future fetchPostsfuture;
  bool isLoading = false;

  @override
  void initState() {
    fetchPostsfuture = FetchNotificationNew(user,page);
  }



  Future _loadData() async {
    FetchNotificationNew(user,page)..then((result){
     setState(() {
       for(final item2 in result)
         posts.add(item2);
       isLoading = false;
       return;
     });
    });
  }

  Future<Null> refreshList() async {setState(() {});}

  Future<User> callUser(String userid) async {
    Future<User> _user = FetchUser(userid);
    return _user;
  }




  Future<Article> callArticle(String userid) async {
    Future<Article> _user = FetchOwnArticle(userid);
    return _user;
  }

  //  Future<List<Group>> callGroups() async {Future<List<Group>> _groups = FetchGroups();return _groups;}



 // Future<Group> callGroup(String groupid) async {Future<Group> _groups = FetchGroup(groupid);return _groups;}
//Widget RequestType(User user,Request request,List<Group> usergroups)

  bool isserviceaccepted(Notifications notification){
    if(notification.clientnow){
      if(notification.isaccepted){
        return true;
      }
    }
    return false;
  }

  bool isservicedenied(Notifications notification){
    if(notification.clientnow){
      if(notification.isdenied){
          return true;
      }
    }
    return false;
  }




  Widget subusers(User user,Notifications notification){
  if(notification.type == 'SubuserTaggedArticle'){
    return  FutureBuilder<Article>(
        future: callArticle(notification.article),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData ? InkWell(
            child:ListTile(leading  : Icon(Icons.tag,color: colordtmaintwo,),
              title:  Text(
                '$userst $articleusertagst',textAlign:TextAlign.center,
                style: TextStyle(
                  color: colordtmaintwo,
                  fontSize: MediaQuery.of(context).size.height*0.024,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ),
            onTap: (){
              Navigator.push(context , MaterialPageRoute(builder: (_) => ArticleWidgetScreen(
                user:user,post: snapshot.data,
              ),),);

            },
          ) :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
        });
  }
  if(notification.type == 'SubuserArticleComment'){
    return FutureBuilder<Article>(
        future: callArticle(notification.article),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData ?
          InkWell(
            child:ListTile(leading  : Icon(Icons.comment,color: colordtmaintwo,),
              title:  Text(
                '${snapshot.data.comments} $userst $articlecommentst',textAlign:TextAlign.center,
                style: TextStyle(
                  color: colordtmaintwo,
                  fontSize: MediaQuery.of(context).size.height*0.024,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ),
            onTap: (){
              Navigator.push(context , MaterialPageRoute(builder: (_) => ArticleWidgetScreen(
                user:user,post: snapshot.data,
              ),),);

            },
          ) :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
        });
  }
  if(notification.type == 'SubuserUserComment'){
    return  InkWell(
      child:ListTile(leading  : Icon(Icons.comment,color: colordtmaintwo,),
        title:   Text(
          '${user.comments} $userst $usercommentst',textAlign:TextAlign.center,
          style: TextStyle(
            color: colordtmaintwo,
            fontSize: MediaQuery.of(context).size.height*0.024,
            fontWeight: FontWeight.bold,
          ),),),
      onTap: (){
        Navigator.push(context , MaterialPageRoute(builder: (_) => FeedbackScreen(user:user,),),);
      },
    );
  }
}

  bool notificationcategorywidget(Notifications notification){

    if(notificationcategory == NotificationCategories2.All){return true;}
    if(notificationcategory == NotificationCategories2.Order){if(notification.requesttype == 'buy'){return true;}}
    if(notificationcategory == NotificationCategories2.Request){
      if(notification.requesttype == 'follow'|| notification.requesttype == 'userservice' || notification.requesttype == 'calendar'){return true;}
    }
    if(notificationcategory == NotificationCategories2.Notification){
      if(
      notification.type == 'SubuserUserComment'|| notification.type == 'UserComment'||
      notification.type == 'SubuserArticleComment'|| notification.type == 'ArticleComment'||

      notification.type == 'SubuserTaggedArticle'|| notification.type == 'UserTaggedArticle'
      ){return true;}
    }
  return false;
  }



  Widget NotificationType(User user,Notifications notification){
    print(notification.requesttype);
    if(notification.type == 'UserTaggedArticle'){
      return  FutureBuilder<Article>(
          future: callArticle(notification.article),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData ? InkWell(
              child:ListTile(leading  : Icon(Icons.tag,color: colordtmaintwo,),
                title:  Text(
                  '$userst $articleusertagst',textAlign:TextAlign.center,
                  style: TextStyle(
                    color: colordtmaintwo,
                    fontSize: MediaQuery.of(context).size.height*0.024,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ),
              onTap: (){
                Navigator.push(context , MaterialPageRoute(builder: (_) =>  ArticleWidgetScreen(
                  user:user,post: snapshot.data,
                ),),);

              },
            ) :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
          });
    }
    if(notification.type == 'ArticleComment'){
      return  FutureBuilder<Article>(
          future: callArticle(notification.article),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData ?
            InkWell(
              child:ListTile(leading  : Icon(Icons.comment,color: colordtmaintwo,),
                title:  Text(
                  '${snapshot.data.comments} $userst $articlecommentst',textAlign:TextAlign.center,
                  style: TextStyle(
                    color: colordtmaintwo,
                    fontSize: MediaQuery.of(context).size.height*0.024,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ),
              onTap: (){
                Navigator.push(context , MaterialPageRoute(builder: (_) =>

                    ArticleWidgetScreen(
                      user:user,post: snapshot.data,
                    ),
                ),);

              },
            ) :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
          });
    }
    if(notification.type == 'UserComment'){
      return  FutureBuilder<Article>(
          future: callArticle(notification.userservice),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData ?
            InkWell(
              child:ListTile(leading  : Icon(Icons.comment,color: colordtmaintwo,),
                title: Text(
                  '${snapshot.data.comments} $userst $userservicecommentst',textAlign:TextAlign.center,
                  style: TextStyle(
                    color: colordtmaintwo,
                    fontSize: MediaQuery.of(context).size.height*0.024,
                    fontWeight: FontWeight.bold,
                  ),
                ),),
              onTap: (){
                Navigator.push(context , MaterialPageRoute(builder: (_) => CommentsScreen(user:user,post: snapshot.data,),),);
              },
            ):  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
          });
    }
    if(notification.requesttype == 'buy'){
      return FutureBuilder<User>(
          future: callUser(notification.author),
          builder: (context, snapshotcsrr) {
            if (snapshotcsrr.hasError) print(snapshotcsrr.error);
            return snapshotcsrr.hasData ? InkWell(
              child:ListTile(       leading:     Icon(Icons.shopping_cart,color: colordtmaintwo,),
                title: Text(
                  '''${snapshotcsrr.data.username} $boughtanitemst  : \n ''',
                  style: TextStyle(
                    color: colordtmaintwo,
                    fontSize: MediaQuery.of(context).size.height*0.024,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle:Text(
                  '$itemst: ${notification.item}',
                  style: TextStyle(
                    color: colordtmaintwo,
                    fontSize: MediaQuery.of(context).size.height*0.024,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: (){
                FetchOwnArticle(notification.link)..then((result){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BuyDetailsScreen(
                          user:user,category: 'CE',notifications: notification,
                          visiteduser: user,
                        )
                    ),
                  );
                });
              },
            ) :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
          });
    }
    if(notification.requesttype == 'follow'){
      return notification.show == false ? Container(height: 0,width: 0,) :  FutureBuilder<User>(
          future: callUser(notification.author),
          builder: (context, snapshotufr) {
            if (snapshotufr.hasError) print(snapshotufr.error);

            return snapshotufr.hasData ? InkWell(
              child:ListTile( leading: Icon(Icons.people,color: colordtmaintwo,),
                title: Text(
                  '${snapshotufr.data.username} $sentfollowrequestst',
                  style: TextStyle(
                    color: colordtmaintwo,
                    fontSize: MediaQuery.of(context).size.height*0.024,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.3 , height: MediaQuery.of(context).size.height*0.06,  child: ElevatedButton(
                        child: Text(acceptst),
                        onPressed: () {  setState(() {
                          notification.show = false;
                        });
                        FollowUser(notification.author, notification.profile);
                          //    CancelFollowRequest(request.id);
                        }

                    ),
                    ),


                    SizedBox(
                        width: MediaQuery.of(context).size.width*0.3 , height: MediaQuery.of(context).size.height*0.06,  child: ElevatedButton(
                        child: Text(denyst),
                        onPressed: () {
                          setState(() {
                            notification.show = false;
                          });
                          CancelFollowRequest(notification.id);


                        }
                    )
                    ),
                  ],
                ),

              ),
              onTap: (){

              },
            ) :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
          });
    }
    if(notification.requesttype == 'userservice' && isservicedenied(notification)){

      return notification.show == false ? Container(height: 0,width: 0,) :
      FutureBuilder<User>(
          future: callUser(notification.author),
          builder: (context, snapshotufr) {
            if (snapshotufr.hasError) print(snapshotufr.error);

            return snapshotufr.hasData ?
            InkWell(
              child:ListTile(
              leading:  Icon(Icons.note_alt_outlined,color: colordtmaintwo,),
                title: Text(
                  '${snapshotufr.data.username} $deniedyourservicest \n',
                  style: TextStyle(
                    color: colordtmaintwo,
                    fontSize: MediaQuery.of(context).size.height*0.024,
                    fontWeight: FontWeight.bold,
                  ),
                ),
subtitle:  Text(
      ''' ${notification.item}'''
  ,
  textAlign: TextAlign.center,
  style: TextStyle(
    color: colordtmaintwo,
    fontSize: MediaQuery.of(context).size.height*0.024,
    fontWeight: FontWeight.bold,
  ),
),
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestDenyDetailsScreen(user: user,visiteduser: user,category:'',userproduct: notification,deny:true)));

              },
            )
           : Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
          });

    }
    if(notification.requesttype == 'userservice' && isserviceaccepted(notification)){
      return notification.show == false ? Container(height: 0,width: 0,) :

      FutureBuilder<User>(
          future: callUser(notification.author),
          builder: (context, snapshotufr) {
            if (snapshotufr.hasError) print(snapshotufr.error);

            return snapshotufr.hasData ?
            InkWell(
              child:ListTile(     leading:  Icon(Icons.note_alt_outlined,color: colordtmaintwo,),
                title: Text(
                  '${snapshotufr.data.username} $acceptedyourservicest \n',
                  style: TextStyle(
                    color: colordtmaintwo,
                    fontSize: MediaQuery.of(context).size.height*0.024,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle:  Text(
                  ''' ${notification.item}'''
                  ,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colordtmaintwo,
                    fontSize: MediaQuery.of(context).size.height*0.024,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: (){
                isuserfollowed(user.id,snapshotufr.data.id)..then((result){
                  if(user.shouldshowuserinfo(snapshotufr.data,result) == 'followed'){
                    setState(() {
                      FetchFollowedArticle(http.Client(),notification.link,)..then((resultus){
                        CreateCartItem(resultus, user.id,resultus.author, resultus.caption, resultus.id, 'UserService', 1, resultus.price,0);

                      });
                    });

                  }
                  if(user.shouldshowuserinfo(snapshotufr.data,result) == 'public'){
                    setState(() {
                      FetchPublicArticle(http.Client(),notification.link,)..then((resultus){
                        print(resultus.id);
                        CreateCartItem(resultus, user.id,resultus.author, resultus.caption, resultus.id, 'UserService', 1, resultus.price,0);
                      });
                    });

                  }
                });
              },
            ):  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
          });
    }
    if(notification.requesttype == 'userservice'){
      return notification.show == false ? Container(height: 0,width: 0,) :  FutureBuilder<User>(
          future: callUser(notification.author),
          builder: (context, snapshotufr) {
            if (snapshotufr.hasError) print(snapshotufr.error);

            return snapshotufr.hasData ?

            InkWell(
              child:ListTile(
                leading:     Icon(Icons.note_alt_outlined,color: colordtmaintwo,),
                title: Text(
                  '''${snapshotufr.data.username} $requestedfollowingservicest : \n ${notification.item}''',
                  style: TextStyle(
                    color: colordtmaintwo,
                    fontSize: MediaQuery.of(context).size.height*0.024,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle:  Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.3 , height: MediaQuery.of(context).size.height*0.06,  child: ElevatedButton(
                        child: Text(acceptst),
                        onPressed: () {
                          setState(() {
                            notification.show = false;
                          });
                          CreateUserServiceRequest(notification.profile, notification.author, true, false, true, '', notification.item, null, null, null,notification.link);
                          DeleteArticleRequest(notification.id);
                          AcceptServiceRequest(notification.profile, notification.author, true, false, true, '', notification.item, null, null, null);
                        }
                    ),
                    ),


                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.3 , height: MediaQuery.of(context).size.height*0.06,  child: ElevatedButton(
                      child: Text(denyst),
                      onPressed: () {
                        setState(() {
                          notification.show = false;
                        });
                        DeleteArticleRequest(notification.id);
                        CreateUserServiceRequest(notification.profile, notification.author, true, true, false, '', notification.item, null, null, null,notification.link);
                      },


                    ),
                    ),

                  ],mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestDetailsScreen(user: user,visiteduser: user,category:'',userproduct: notification,)));

              },
            )
            :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
          });
    }
    if(notification.requesttype == 'calendarcancel'){
      return FutureBuilder<User>(
          future: callUser(notification.author),
          builder: (context, snapshotcsr) {
            if (snapshotcsr.hasError) print(snapshotcsr.error);

            return snapshotcsr.hasData ?
            InkWell(
              child:ListTile(   leading:  Icon(Icons.calendar_today,color: colordtmaintwo,),
                title: Text(
                  '''${snapshotcsr.data.username} $canceledappointmentst \n:''',
                  style: TextStyle(
                    color: colordtmaintwo,
                    fontSize: MediaQuery.of(context).size.height*0.024,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle:  Text(

                  '''$itemst: ${notification.item}''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colordtmaintwo,
                    fontSize: MediaQuery.of(context).size.height*0.024,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: (){
                isuserfollowed(user.id,snapshotcsr.data.id)..then((result){
                  if(user.shouldshowuserinfo(snapshotcsr.data,result) == 'followed'){
                    setState(() {
                      FetchFollowedArticle(http.Client(),notification.link,)..then((resultus){
                        CreateCartItem(resultus, user.id,resultus.author, resultus.caption, resultus.id, 'CalendarItem', 1,resultus.price,0);
                      });
                    });

                  }
                  if(user.shouldshowuserinfo(snapshotcsr.data,result) == 'public'){
                    setState(() {
                      FetchPublicArticle(http.Client(),notification.link)..then((resultus){
                        CreateCartItem(resultus, user.id,resultus.author, resultus.caption, resultus.id, 'CalendarItem', 1,resultus.price,0);
                      });
                    });

                  }
                });
              },
            )

                :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
          });
    }
    if(notification.requesttype == 'calendar'){
      if(notification.isdenied){
        return notification.author == user.id ? (notification.clientnow?  (notification.show == false ? Container(height: 0,width: 0,) : FutureBuilder<User>(
            future: callUser(notification.profile),
            builder: (context, snapshotcsr) {
              if (snapshotcsr.hasError) print(snapshotcsr.error);

              return snapshotcsr.hasData ?
              InkWell(
                child:ListTile(     leading:  Icon(Icons.calendar_today,color: colordtmaintwo,),
                  title: Text(
                    '''${snapshotcsr.data.username} $deniedyourrequestst: \n''',
                    style: TextStyle(
                      color: colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height*0.024,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle:  Text(

                    '''$itemst: ${notification.item}''',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height*0.024,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestDetailsScreen(user: user,visiteduser: user,category:'',userproduct: notification,)));

                },
              ) :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
            })):
        Container(height: 0,width: 0,)) : Container(height: 0,width: 0,);
      }
      if(notification.isaccepted){
        return notification.author == user.id ? (notification.clientnow?  (notification.show == false ? Container(height: 0,width: 0,) : FutureBuilder<User>(
            future: callUser(notification.profile),
            builder: (context, snapshotcsr) {
              if (snapshotcsr.hasError) print(snapshotcsr.error);

              return snapshotcsr.hasData ?
              InkWell(
                child:ListTile(   leading:  Icon(Icons.calendar_today,color: colordtmaintwo,),
                  title: Text(
                    '''${snapshotcsr.data.username} $acceptedyourrequestst \n:''',
                    style: TextStyle(
                      color: colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height*0.024,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle:  Text(

                    '''$itemst: ${notification.item}''',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height*0.024,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: (){
                  isuserfollowed(user.id,snapshotcsr.data.id)..then((result){
                    if(user.shouldshowuserinfo(snapshotcsr.data,result) == 'followed'){
                      setState(() {
                        FetchFollowedArticle(http.Client(),notification.link,)..then((resultus){
                          CreateCartItem(resultus, user.id,resultus.author, resultus.caption, resultus.id, 'CalendarItem', 1,resultus.price,0);
                        });
                      });

                    }
                    if(user.shouldshowuserinfo(snapshotcsr.data,result) == 'public'){
                      setState(() {
                        FetchPublicArticle(http.Client(),notification.link)..then((resultus){
                          CreateCartItem(resultus, user.id,resultus.author, resultus.caption, resultus.id, 'CalendarItem', 1,resultus.price,0);
                        });
                      });

                    }
                  });
                },
              )

             :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
            })):
        Container(height: 0,width: 0,)) : Container(height: 0,width: 0,);
      }
    }
    if(notification.requesttype == 'calendar'){
     return notification.show == false ? Container(height: 0,width: 0,) : FutureBuilder<User>(
         future: callUser(notification.author),
         builder: (context, snapshotcsrr) {
           if (snapshotcsrr.hasError) print(snapshotcsrr.error);
           return snapshotcsrr.hasData ? (notification.clientnow? (notification.profile == user.id ?
           InkWell(
             child:ListTile(   leading:  Icon(Icons.calendar_today,color: colordtmaintwo,),
               title: Text(
                 '${snapshotcsrr.data.username} $sentcalendardetailsst \n $itemst: ${notification.item} $datest ${notification.date} ${notification.time}',

                 style: TextStyle(
                   color: colordtmaintwo,
                   fontSize: MediaQuery.of(context).size.height*0.024,
                   fontWeight: FontWeight.bold,
                 ),
               ),
               subtitle:     Row(
                 children: [
                   SizedBox(
                     width: MediaQuery.of(context).size.width*0.3 , height: MediaQuery.of(context).size.height*0.06,  child: ElevatedButton(
                       child: Text(acceptst),
                       onPressed: () {
                         setState(() {
                           notification.show = false;
                         });
                         CreateCalendarSchedule(user,notification.profile,notification.author, notification.item, notification.date, notification.time);
                         RemoveCalendarScheduleRequest(notification.id);
                         AcceptCalendarRequest(notification.profile,notification.author, notification, true, false, true);
                       }

                   ),
                   ),


                   SizedBox(
                     width: MediaQuery.of(context).size.width*0.3 , height: MediaQuery.of(context).size.height*0.06,  child: ElevatedButton(
                     child: Text(denyst),
                     onPressed: () {
                       setState(() {
                         notification.show = false;
                       });
                       RemoveCalendarScheduleRequest(notification.id);
                       CreateCalendarScheduleRequesttype2(user.id,notification.author, notification.item, notification.date, notification.time, false, true,false,notification.link);
                     },


                   ),
                   ),

                 ],mainAxisAlignment: MainAxisAlignment.center,
               ),

             ),
           )
           : Container(height: 0,width: 0,)) :
           (user.calendar_type == 'calendartype3' ?
           InkWell(
             child:ListTile(   leading:  Icon(Icons.calendar_today,color: colordtmaintwo,),
               title: Text(
                 notification.isdenied == true ? '''${snapshotcsrr.data.username} $deniedcalendarst''' : '''$sentcalendarrequestst \n'''
                 ''' $itemst: ${notification.item} $datest ${notification.date} ${notification.time}''',
                 style: TextStyle(
                   color: colordtmaintwo,
                   fontSize: MediaQuery.of(context).size.height*0.024,
                   fontWeight: FontWeight.bold,
                 ),
               ),
               subtitle:   Row(
                 children: [
                   SizedBox(
                     width: MediaQuery.of(context).size.width*0.3 , height: MediaQuery.of(context).size.height*0.06,  child: ElevatedButton(
                       child: Text(acceptst),
                       onPressed: () {
                         setState(() {
                           notification.show = false;
                         });
                         if(user.calendar_type == 'calendartype3'){
                           CreateCalendarSchedule(user,notification.profile,notification.author, notification.item, notification.date, notification.time);
                           RemoveCalendarScheduleRequest(notification.id);
                           AcceptCalendarRequest(notification.profile,notification.author, notification, true, false, true);
                         }
                         if(user.calendar_type == 'calendartype2'){
                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalendarTTScreen(user: user,date:'',request: notification)));
                         }}

                   ),
                   ),


                   SizedBox(
                     width: MediaQuery.of(context).size.width*0.3 , height: MediaQuery.of(context).size.height*0.06,  child: ElevatedButton(
                     child: Text(denyst),
                     onPressed: () {
                       setState(() {
                         notification.show = false;
                       });
                       RemoveCalendarScheduleRequest(notification.id);
                     },


                   ),
                   ),

                 ],mainAxisAlignment: MainAxisAlignment.center,
               ),
             ),
           )
         :
           InkWell(
             child:ListTile(   leading:  Icon(Icons.calendar_today,color: colordtmaintwo,),
               title: Text(
                 notification.isdenied == true ? '''${snapshotcsrr.data.username} $deniedcalendarst''' : '''$sentcalendarrequestst \n'''
                     '''$itemst: ${notification.item}''',
                 style: TextStyle(
                   color: colordtmaintwo,
                   fontSize: MediaQuery.of(context).size.height*0.024,
                   fontWeight: FontWeight.bold,
                 ),
               ),
               subtitle:   Row(
                 children: [
                   SizedBox(
                     width: MediaQuery.of(context).size.width*0.3 , height: MediaQuery.of(context).size.height*0.06,  child: ElevatedButton(
                       child: Text(acceptst),
                       onPressed: () {
                         Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalendarTTScreen(user: user,date:'',request: notification)));
                       }

                   ),
                   ),


                   SizedBox(
                     width: MediaQuery.of(context).size.width*0.3 , height: MediaQuery.of(context).size.height*0.06,  child: ElevatedButton(
                     child: Text(denyst),
                     onPressed: () {
                       RemoveCalendarScheduleRequest(notification.id);
                     },


                   ),
                   ),

                 ],mainAxisAlignment: MainAxisAlignment.center,
               ),
             ),
           )

          )) :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
         });
   }
    if(notification.requesttype == 'reservation'){
      if(notification.isdenied){
        return notification.author == user.id ? (notification.clientnow?  (notification.show == false ? Container(height: 0,width: 0,) : FutureBuilder<User>(
            future: callUser(notification.profile),
            builder: (context, snapshotcsr) {
              if (snapshotcsr.hasError) print(snapshotcsr.error);

              return snapshotcsr.hasData ?
              InkWell(
                child:ListTile(     leading:  Icon(Icons.calendar_today,color: colordtmaintwo,),
                  title: Text(
                    '''${snapshotcsr.data.username} $deniedyourrequestst: \n''',
                    style: TextStyle(
                      color: colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height*0.024,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle:  Text(

                    '''$itemst: ${notification.item}''',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height*0.024,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestDetailsScreen(user: user,visiteduser: user,category:'',userproduct: notification,)));

                },
              ) :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
            })):
        Container(height: 0,width: 0,)) : Container(height: 0,width: 0,);
      }
      if(notification.isaccepted){
        return notification.author == user.id ? (notification.clientnow?  (notification.show == false ? Container(height: 0,width: 0,) : FutureBuilder<User>(
            future: callUser(notification.profile),
            builder: (context, snapshotcsr) {
              if (snapshotcsr.hasError) print(snapshotcsr.error);

              return snapshotcsr.hasData ?
              InkWell(
                child:ListTile(   leading:  Icon(Icons.calendar_today,color: colordtmaintwo,),
                  title: Text(
                    '''${snapshotcsr.data.username} $acceptedyourrequestst \n:''',
                    style: TextStyle(
                      color: colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height*0.024,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle:  Text(

                    '''$itemst: ${notification.item}''',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height*0.024,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: (){
                  isuserfollowed(user.id,snapshotcsr.data.id)..then((result){
                    if(user.shouldshowuserinfo(snapshotcsr.data,result) == 'followed'){
                      setState(() {
                        FetchFollowedArticle(http.Client(),notification.link)..then((resultus){
                          CreateCartItem(resultus, user.id,resultus.author, resultus.caption, resultus.id, 'Reservation', 1, resultus.price,0);
                        });
                      });

                    }
                    if(user.shouldshowuserinfo(snapshotcsr.data,result) == 'public'){
                      setState(() {
                        FetchPublicArticle(http.Client(),notification.link)..then((resultus){
                          CreateCartItem(resultus, user.id,resultus.author, resultus.caption, resultus.id, 'Reservation', 1, resultus.price,0);
                        });
                      });

                    }
                  });
                },
              )

                  :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
            })):
        Container(height: 0,width: 0,)) : Container(height: 0,width: 0,);
      }
    }
    if(notification.requesttype == 'reservation'){
      return notification.show == false ? Container(height: 0,width: 0,) : FutureBuilder<User>(
          future: callUser(notification.author),
          builder: (context, snapshotcsrr) {
            if (snapshotcsrr.hasError) print(snapshotcsrr.error);
            return snapshotcsrr.hasData ?     FutureBuilder<Article>(
                future: callArticle(notification.item),
                builder: (context, snapshotrsrv) {
                  if (snapshotrsrv.hasError) print(snapshotrsrv.error);
                  return snapshotrsrv.hasData ? InkWell(
                    child:ListTile(   leading:  Icon(Icons.calendar_today,color: colordtmaintwo,),
                      title: Text(
                        notification.isdenied == true ? '''${snapshotcsrr.data.username} $deniedcalendarst''' : '''${snapshotcsrr.data.username} $sentreservationrequestst \n'''
                            '''\n '''
                            ''' $itemst: ${snapshotrsrv.data.caption} \n '''
                            '''Start date : ${notification.date.substring(0,10)}\n'''
                            '''End date : ${notification.date.substring(11,21)}\n''',
                        style: TextStyle(
                          color: colordtmaintwo,
                          fontSize: MediaQuery.of(context).size.height*0.024,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle:   Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.3 , height: MediaQuery.of(context).size.height*0.06,  child: ElevatedButton(
                              child: Text(acceptst),
                              onPressed: () {
                                setState(() {
                                    notification.show = false;
                                });
                                CreateReservationSchedule(user,notification.profile,notification.author, notification.item, notification.date, notification.time);
                                RemoveReservationScheduleRequest(notification.id);
                                AcceptReservationScheduleRequest(notification.profile,notification.author, notification, true, false, true);
                              }

                          ),
                          ),


                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.3 , height: MediaQuery.of(context).size.height*0.06,  child: ElevatedButton(
                            child: Text(denyst),
                            onPressed: () {
                              setState(() {
                                notification.show = false;
                              });
                                 RemoveReservationScheduleRequest(notification.id);
                            },


                          ),
                          ),

                        ],mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                  ) :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
                }) :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
          });
    }
    if(notification.requesttype == 'meeting'){
      if(notification.isdenied){
        return notification.author == user.id ? (notification.clientnow?  (notification.show == false ? Container(height: 0,width: 0,) : FutureBuilder<User>(
            future: callUser(notification.profile),
            builder: (context, snapshotcsr) {
              if (snapshotcsr.hasError) print(snapshotcsr.error);

              return snapshotcsr.hasData ?
              InkWell(
                child:ListTile(     leading:  Icon(Icons.calendar_today,color: colordtmaintwo,),
                  title: Text(
                    '''${snapshotcsr.data.username} $deniedmeetingrequestst: \n''',
                    style: TextStyle(
                      color: colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height*0.024,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ) :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
            })):
        Container(height: 0,width: 0,)) : Container(height: 0,width: 0,);
      }
      if(notification.isaccepted){
        return notification.author == user.id ? (notification.clientnow?  (notification.show == false ? Container(height: 0,width: 0,) : FutureBuilder<User>(
            future: callUser(notification.profile),
            builder: (context, snapshotcsr) {
              if (snapshotcsr.hasError) print(snapshotcsr.error);

              return snapshotcsr.hasData ?
              InkWell(
                child:ListTile(   leading:  Icon(Icons.calendar_today,color: colordtmaintwo,),
                  title: Text(
                    '''${snapshotcsr.data.username} $acceptedmeetingrequestst \n:''',
                    style: TextStyle(
                      color: colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height*0.024,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: (){

                },
              )

                  :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
            })):
        Container(height: 0,width: 0,)) : Container(height: 0,width: 0,);
      }
    }
    if(notification.requesttype == 'meeting'){
      return notification.show == false ? Container(height: 0,width: 0,) : FutureBuilder<User>(
          future: callUser(notification.author),
          builder: (context, snapshotcsrr) {
            if (snapshotcsrr.hasError) print(snapshotcsrr.error);
            return snapshotcsrr.hasData ? (notification.clientnow? notification.profile == user.id ?
            InkWell(
              child:ListTile(   leading:  Icon(Icons.calendar_today,color: colordtmaintwo,),
                title: Text(
                  '${snapshotcsrr.data.username} $sentmeetingdetailsst \n $datest ${notification.date} ${notification.time}',

                  style: TextStyle(
                    color: colordtmaintwo,
                    fontSize: MediaQuery.of(context).size.height*0.024,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle:     Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.3 , height: MediaQuery.of(context).size.height*0.06,  child: ElevatedButton(
                        child: Text(acceptst),
                        onPressed: () {
                          setState(() {
                            notification.show = false;
                          });
                          CreateMeetingSchedule(user,notification.profile,notification.author, notification.item, notification.date, notification.time);
                          RemoveMeetingScheduleRequest(notification.id);
                          AcceptMeetingRequest(notification.profile,notification.author, notification, true, false, true);
                        }

                    ),
                    ),


                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.3 , height: MediaQuery.of(context).size.height*0.06,  child: ElevatedButton(
                      child: Text(denyst),
                      onPressed: () {
                        setState(() {
                          notification.show = false;
                        });
                        RemoveCalendarScheduleRequest(notification.id);
                        },


                    ),
                    ),

                  ],mainAxisAlignment: MainAxisAlignment.center,
                ),

              ),
            )
                : Container(height: 0,width: 0,) : Container(height:0,width:0)) :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
          });
    }
    return Container(height: 0,width: 0,);
  }

  // bool checkgroupmemberrequest(Group group,String userid){for(int i=0;i<group.groupmemberrequests.length;i++){if(group.groupmemberrequests[i].author == userid){return true;}}return false;}

  // String checkgroupmemberrequestst(Group group,String userid){for(int i=0;i<group.groupmemberrequests.length;i++){if(group.groupmemberrequests[i].author == userid){return group.groupmemberrequests[i].id;}}return '';}

  NotificationCategories(String categorieschoices) {

    if (categorieschoices == NotificationCategories2.All) {
      setState(() {
        notificationcategory = NotificationCategories2.All;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                HomeScreen(
                  user: user,
                ),
          ),
        );
      });
    }
    else if (categorieschoices == NotificationCategories2.Order) {
      setState(() {
        notificationcategory = NotificationCategories2.Order;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                HomeScreen(
                  user: user,
                ),
          ),
        );
      });
    }
    else if (categorieschoices  == NotificationCategories2.Request) {
      setState(() {
        notificationcategory = NotificationCategories2.Request;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                HomeScreen(
                  user: user,
                ),
          ),
        );
      });

    }
    else if (categorieschoices == NotificationCategories2.Notification) {
      setState(() {
        notificationcategory = NotificationCategories2.Notification;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                HomeScreen(
                  user: user,
                ),
          ),
        );
      });

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colordtmainone,
          actions: [
            PopupMenuButton<String>(
              onSelected: NotificationCategories,
              icon: Icon(Icons.format_list_bulleted,color: colordtmaintwo,size: MediaQuery.of(context).size.width*0.065,),
              itemBuilder: (BuildContext context){
                return NotificationCategories2.notificationchoices.map((String categories){
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
        body: FutureBuilder<dynamic>(

          future: fetchPostsfuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData ?
            NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!isLoading && scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  page = page+1;
                  _loadData();
                  setState(() {isLoading = true;});
                  return true;
                }},child: ListView.builder(
              itemCount: snapshot.data.length,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    if(notificationcategorywidget(snapshot.data[index])) Divider(color:colordtmaintwo),
                   if(notificationcategorywidget(snapshot.data[index])) NotificationType(user,snapshot.data[index]),
                  ],
                );
              },
            ) ,)
                : Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
          },
        )


    );
  }
}

class CalendarTTScreen extends StatefulWidget {
  final User user;
  final String date;
  final Notifications request;
  const CalendarTTScreen({Key key, this.user,this.request,this.date}) : super(key: key);
  @override
  CalendarTTScreenState createState() => CalendarTTScreenState(user:user,request:request,date:date);
}

class CalendarTTScreenState extends State<CalendarTTScreen> {
  final User user;
  final String date;
  final Notifications request;
  CalendarTTScreenState({Key key, this.user,this.date,this.request});
  final TextEditingController timeanddate= TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height:20),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(datetimeforappnst,style:TextStyle( color: colordtmaintwo,
                  fontSize: MediaQuery.of(context).size.height*0.025,
                  fontWeight: FontWeight.bold,)),],
              ),
              Divider(color: colordtmaintwo,),
              SizedBox(height:60),
              Row(
                  children: <Widget>[


                    Text(choosedatest,style:TextStyle(fontWeight:  FontWeight.w800,fontSize: 20)),

                    Expanded(
                        child: Divider()
                    ),
                  ]
              ),
            ListTile(
              title: Text(choosedatefromcalendarst, style:TextStyle(color:colordtmaintwo,fontSize:MediaQuery.of(context).size.height*0.02,),),
              trailing:   IconButton(
                icon: Icon(Icons.calendar_today_outlined),
                iconSize: 30.0,
                color: colordtmaintwo,
                onPressed: () {

                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DateChooseScreen(user: user,request: request,)));
                },
              ),
              subtitle:date != '' ? Text(date,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),) :Text(''),
            ),
              Row(
                  children: <Widget>[


                    Text(timest,style:TextStyle(fontWeight:  FontWeight.w800,fontSize: 20)),

                    Expanded(
                        child: Divider()
                    ),
                  ]
              ),
              ListTile(
                title:      TextFormField(

                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                  controller:       timeanddate ,
                  maxLength: 15,keyboardType: TextInputType.number,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: InputDecoration(

                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,

                    hintText: entertimeherest,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
                  ),
                ) ,
                trailing:   IconButton(
                  icon: Icon(Icons.timer),
                  iconSize: 30.0,
                  color: colordtmaintwo,
                  onPressed: () {

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DateChooseScreen(user: user,request: request,)));
                  },
                ),

              ),

              Divider(),

              SizedBox(height:40),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.3 , height: MediaQuery.of(context).size.height*0.06,  child: ElevatedButton(
                    child: Text(finishst),
                    onPressed: () {
                      RemoveCalendarScheduleRequest(request.id);
                      Future.delayed(new Duration(seconds:2), ()
                      {
                        CreateCalendarScheduleRequesttype2(user.id,request.author, request.item, date, timeanddate.text,true,false,false,request.link);
                      });
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user: user)));

                    },
                  ),
                  ),

                ],mainAxisAlignment: MainAxisAlignment.center,
              ),



              //
            ],
          ),
        ));
  }
}

class DateChooseScreen extends StatefulWidget {
  final User user;
  final Notifications request;
  const DateChooseScreen({Key key, this.user,this.request}) : super(key: key);
  @override
  DateChooseScreenState createState() => DateChooseScreenState(user:user,request:request);
}

class DateChooseScreenState extends State<DateChooseScreen> {
  final User user;
  final Notifications request;
  DateChooseScreenState({Key key, this.user,this.request});
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();


  @override
  Widget build(BuildContext context) {
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (date, events) {
        String date1 = '$date';
        String date2 = date1.substring(0,10);
        print(date2);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalendarTTScreen(user: user,date:date2,request: request,)));

      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
      CircleBorder(side: BorderSide(color: Colors.yellow)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: colordtmainthree,
      ),
      showHeader: false,selectedDayButtonColor: colordtmaintwo,
      todayTextStyle: TextStyle(
        color: colordtmainthree,
      ),
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(fontSize: 16, color: Colors.pinkAccent,),
      inactiveDaysTextStyle: TextStyle(color: Colors.tealAccent, fontSize: 16,),
      onCalendarChanged: (DateTime date) {this.setState(() {_targetDateTime = date;_currentMonth = DateFormat.yMMM().format(_targetDateTime);});},
      onDayLongPressed: (DateTime date) {print('long pressed date $date');},
    );

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //custom icon
              // This trailing comma makes auto-formatting nicer for build methods.
              //custom icon without header
              Container(
                margin: EdgeInsets.only(
                  top: 30.0,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: new Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                          _currentMonth,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        )),
                    ElevatedButton(
                      child: Text(previousst),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(
                              _targetDateTime.year, _targetDateTime.month - 1);
                          _currentMonth =
                              DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                    ),
                    ElevatedButton(
                      child: Text(nextst),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(
                              _targetDateTime.year, _targetDateTime.month + 1);
                          _currentMonth =
                              DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: _calendarCarouselNoHeader,
              ),


              //
            ],
          ),
        ));
  }
}

class RequestDetailsScreen extends StatefulWidget {
  final Notifications userproduct;
  final User user;  final User visiteduser;
  final String category;
  const RequestDetailsScreen({Key key,this.userproduct,this.visiteduser,this.user,this.category}) : super(key : key);

  @override
  RequestDetailsScreenState createState() => RequestDetailsScreenState(user : user,visiteduser:visiteduser,userproduct : userproduct,category:category);
}

class RequestDetailsScreenState extends State<RequestDetailsScreen> {
  final Notifications userproduct;
  final User user;  final User visiteduser;
  final String category;
   TextEditingController reason = TextEditingController(text:'');
  RequestDetailsScreenState({Key key, this.userproduct,this.visiteduser,this.user,this.category});
  int _column = 0;



  @override
  Widget build(BuildContext context) {

    return Scaffold(    appBar: new AppBar(
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
      body: Stack(
        children: <Widget>[

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colordtmainone,
                borderRadius: BorderRadius.only(
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:0.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return ListView(

                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[


                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[


                                    SizedBox(height:10),

                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),

                                      child: Text(
                                        '$servicenamest : ${userproduct.item}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),
                                    for(final item in userproduct.checkboxes)
                                      item.boolean == true ? Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context).size.width* 0.043,
                                          vertical: 0,
                                        ),
                                        child: Text(
                                          '${item.hint} : $yesst',
                                          style: TextStyle(
                                            fontSize:  MediaQuery.of(context).size.width*0.043,
                                            color:colordtmaintwo,
                                            fontWeight: FontWeight.w500,

                                          ),
                                        ),
                                      ) : Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context).size.width* 0.043,
                                          vertical: 0,
                                        ),
                                        child: Text(
                                          '${item.hint} : $nost',
                                          style: TextStyle(
                                            fontSize:  MediaQuery.of(context).size.width*0.043,
                                            color:colordtmaintwo,
                                            fontWeight: FontWeight.w500,

                                          ),
                                        ),
                                      ),
                                    for(final item in userproduct.forms)

                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context).size.width* 0.043,
                                          vertical: 0,
                                        ),
                                        child: Text(
                                          '${item.hint} : ${item.content}',
                                          style: TextStyle(
                                            fontSize:  MediaQuery.of(context).size.width*0.043,
                                            color:colordtmaintwo,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    for(final item in userproduct.images)
                                      InkWell(
                                        child: Column(

                                          children: <Widget>[
                                            SizedBox(
                                                width: double.infinity,
                                                height: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height * 0.5,


                                                child: Image.network(item.image == null ? 'https://st2.depositphotos.com/4111759/12123/v/600/depositphotos_121233262-stock-illustration-male-default-placeholder-avatar-profile.jpg' : item.image,
                                                  fit:BoxFit.cover,
                                                )
                                            ),

                                          ],

                                        ),
                                        onTap: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => ViewRequestImageScreen(
                                                  image: item.image
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    Padding(
                                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01 ,right: MediaQuery.of(context).size.width*0.01),
                                      child:
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.023 , vertical: MediaQuery.of(context).size.height*0.013),
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
                                        child:  Padding(
                                          padding: EdgeInsets.only(left : 8),
                                          child: TextFormField(
                                            style: TextStyle(color: colordtmaintwo),
                                            controller: reason,

                                            maxLength: 500,
                                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,

                                              hintText: explanationforacceptordenyst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
                                            ),
                                          ),
                                        ),
                                      ),

                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width*0.3 , height: MediaQuery.of(context).size.height*0.06,  child: ElevatedButton(
                                            child: Text(acceptst),
                                            onPressed: () {
                                              DeleteArticleRequest(userproduct.id);
                                              CreateUserServiceRequest(userproduct.profile, userproduct.author, true, false, true, reason.text, userproduct.item, null, null, null,userproduct.id);
                                              Navigator.push(context , MaterialPageRoute(builder: (_) => HomeScreen(user:user),),);

                                            }

                                        ),
                                        ),


                                        SizedBox(
                                          width: MediaQuery.of(context).size.width*0.3 , height: MediaQuery.of(context).size.height*0.06,  child: ElevatedButton(
                                          child: Text(denyst),
                                          onPressed: () {

                                                    DeleteArticleRequest(userproduct.id);
                                            CreateUserServiceRequest(userproduct.profile, userproduct.author, true, true, false, reason.text, userproduct.item, null, null, null,userproduct.link);
                                                   Navigator.push(context , MaterialPageRoute(builder: (_) => HomeScreen(user:user),),);
                                            },


                                        ),
                                        ),

                                      ],mainAxisAlignment: MainAxisAlignment.center,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );

  }
}

class BuyDetailsScreen extends StatefulWidget {
  final Notifications notifications;
  final User user;  final User visiteduser;
  final bool deny;
  final String category;
  final Article item;
  const BuyDetailsScreen({Key key,this.item,this.notifications,this.visiteduser,this.user,this.category,this.deny}) : super(key : key);

  @override
  BuyDetailsScreenState createState() => BuyDetailsScreenState(item:item,user : user,deny:deny,visiteduser:visiteduser,notifications : notifications,category:category);
}

class BuyDetailsScreenState extends State<BuyDetailsScreen> {
  final Notifications notifications;
  final User user;
  final User visiteduser;
  final bool deny;
  final String category;
  final Article item;

  BuyDetailsScreenState({Key key,this.item, this.notifications,this.visiteduser,this.user,this.deny,this.category});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: colordtmainone,
      body: Stack(
        children: <Widget>[

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colordtmainone,
                borderRadius: BorderRadius.only(
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:0.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return ListView(

                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[


                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[


                                    SizedBox(height: MediaQuery.of(context).size.height *0.03),


                                    ListTile(   leading  : Icon(Icons.phone,color: colordtmaintwo),
                                      title:Text(
                                        '$contactst : ${notifications.contactno}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.height*0.03,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),SizedBox(height:20),Divider(color:colordtmaintwo),
                                    ListTile(   leading  : Icon(Icons.location_on,color: colordtmaintwo),
                                      title:Text(
                                        '$addressst : ${notifications.deliveryaddress}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.height*0.03,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ), SizedBox(height:20),Divider(color:colordtmaintwo),
                                    ListTile(
                                      leading  : Icon(Icons.edit,color: colordtmaintwo),
                                      title:Text(
                                        '$specialrequestst : ${notifications.reason}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.height*0.03,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ), SizedBox(height:20),Divider(color:colordtmaintwo),
                                    ListTile(   leading  : Icon(Icons.person,color: colordtmaintwo),
                                      title:Text(
                                        '$clientprofilest ',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.height*0.03,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                      onTap: (){Navigator.push(context , MaterialPageRoute(builder: (_) => VisitedProfileScreen(user:user,visiteduser: visiteduser)));},
                                    ),
                                 SizedBox(height:20),Divider(color:colordtmaintwo),
                                    ListTile(   leading  : Icon(Icons.shopping_cart,color: colordtmaintwo),

                                      title:Text(
                                        '$itemdetailsst',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.height*0.03,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),onTap: (){
                                        Navigator.push(context , MaterialPageRoute(builder: (_) =>
                                            ArticleWidgetScreen(
                                              user:user,post: item,
                                            ),
                                        ),);
                                    },
                                    ),  SizedBox(height:20),Divider(color:colordtmaintwo),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );

  }
}

class RequestDenyDetailsScreen extends StatefulWidget {
  final Notifications userproduct;
  final User user;  final User visiteduser;
  final bool deny;
  final String category;
  const RequestDenyDetailsScreen({Key key,this.userproduct,this.visiteduser,this.user,this.category,this.deny}) : super(key : key);

  @override
  RequestDenyDetailsScreenState createState() => RequestDenyDetailsScreenState(user : user,deny:deny,visiteduser:visiteduser,userproduct : userproduct,category:category);
}

class RequestDenyDetailsScreenState extends State<RequestDenyDetailsScreen> {
  final Notifications userproduct;
  final User user;  final User visiteduser;
  final bool deny;
  final String category;
  RequestDenyDetailsScreenState({Key key, this.userproduct,this.visiteduser,this.user,this.deny,this.category});
  int _column = 0;


  @override
  Widget build(BuildContext context) {

    return Scaffold(    appBar: new AppBar(
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
      body: Stack(
        children: <Widget>[

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colordtmainone,
                borderRadius: BorderRadius.only(
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:0.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return ListView(

                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[


                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[


                                    SizedBox(height: MediaQuery.of(context).size.height *0.03),

                                    SizedBox(height:50),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        '$explanationst : ${userproduct.reason}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );

  }
}

class ViewRequestImageScreen extends StatefulWidget {
  final String image;
  const ViewRequestImageScreen({Key key, this.image}) : super(key: key);
  @override
  ViewRequestImageScreenState createState() => ViewRequestImageScreenState(image:image);
}

class ViewRequestImageScreenState extends State<ViewRequestImageScreen> {
  final String image;
  ViewRequestImageScreenState({Key key, this.image});


  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
          imageProvider: NetworkImage(image),
        )
    );
  }
}

class ItemDetailsScreen extends StatefulWidget {
  final Notifications notifications;
  final User user;  final User visiteduser;
  final bool deny;
  final String category;
  final Article item;

  const ItemDetailsScreen({Key key,this.item,this.notifications,this.visiteduser,this.user,this.category,this.deny}) : super(key : key);

  @override
  ItemDetailsScreenState createState() => ItemDetailsScreenState(user : user,deny:deny,visiteduser:visiteduser,notifications : notifications,category:category);
}

class ItemDetailsScreenState extends State<ItemDetailsScreen> {
  final Notifications notifications;
  final User user;
  final User visiteduser;
  final bool deny;
  final String category;
  final Article item;


  ItemDetailsScreenState({Key key,this.item, this.notifications,this.visiteduser,this.user,this.deny,this.category});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: colordtmainone,
      body: Stack(
        children: <Widget>[

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colordtmainone,
                borderRadius: BorderRadius.only(
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:0.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return ListView(

                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[


                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[


                                    SizedBox(height: MediaQuery.of(context).size.height *0.03),


                                    ListTile(   leading  : Icon(Icons.phone,color: colordtmaintwo),
                                      title:Text(
                                        '$contactst : ${notifications.contactno}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.height*0.03,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ), SizedBox(height:20),Divider(color:colordtmaintwo),
                                    ListTile(
                                      leading  : Icon(Icons.edit,color: colordtmaintwo),
                                      title:Text(
                                        '$specialrequestst : ${notifications.reason}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.height*0.03,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ), SizedBox(height:20),Divider(color:colordtmaintwo),
                                    ListTile(   leading  : Icon(Icons.person,color: colordtmaintwo),
                                      title:Text(
                                        '$clientprofilest ',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.height*0.03,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                      onTap: (){Navigator.push(context , MaterialPageRoute(builder: (_) => VisitedProfileScreen(user:user,visiteduser: visiteduser)));},
                                    ),
                                    SizedBox(height:20),Divider(color:colordtmaintwo),
                                    ListTile(   leading  : Icon(Icons.shopping_cart,color: colordtmaintwo),

                                      title:Text(
                                        '$itemdetailsst',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.height*0.03,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),onTap: (){
                                        Navigator.push(context , MaterialPageRoute(builder: (_) =>  ArticleWidgetScreen(
                                          user:user,post: item,ischosing:false
                                        ),),);

                                      },
                                    ),  SizedBox(height:20),Divider(color:colordtmaintwo),
                                    ListTile(   leading  : Icon(Icons.numbers,color: colordtmaintwo),
                                      title:Text(
                                        '$countst : ${notifications.count}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.height*0.03,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                       ),
                                    SizedBox(height:20),Divider(color:colordtmaintwo),
                                    ListTile(   leading  : Icon(Icons.numbers,color: colordtmaintwo),
                                      title:Text(
                                        'Choices/Seçimler',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.height*0.03,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                      onTap: (){Navigator.push(context , MaterialPageRoute(builder: (_) => RequestChoiceScreen(product:notifications)));},
                                    ),
                                    SizedBox(height:20),Divider(color:colordtmaintwo),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );

  }
}

class RequestChoiceScreen extends StatefulWidget {
  final Notifications product;
  const RequestChoiceScreen({Key key,this.product, }) : super(key: key);
  @override
  RequestChoiceScreenState createState() => RequestChoiceScreenState(product:product,);
}

class RequestChoiceScreenState extends State<RequestChoiceScreen> {
  final Notifications product;
  RequestChoiceScreenState({Key key,this.product,});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colordtmainone,
        actions: [

        ],
      ),
      backgroundColor: colordtmainone,
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          for (final item2 in product.choices)
            Column(
              children: [
                SizedBox(height:20),
                Row(
                  children: [
                    Text('''$categoryst: \n '''
                      ,style: TextStyle(
                        fontSize: MediaQuery
                            .of(context)
                            .size
                            .height * 0.03,fontWeight: FontWeight.bold, color: colordtmaintwo,),),
                    Text('''${item2.category.toString()} \n '''
                      ,style: TextStyle(
                        fontSize: MediaQuery
                            .of(context)
                            .size
                            .height * 0.03, color: colordtmaintwo,),),
                  ],
                ),
                Row(
                  children: [
                    Text('''$namest: \n '''
                      ,style: TextStyle(
                        fontSize: MediaQuery
                            .of(context)
                            .size
                            .height * 0.03,fontWeight: FontWeight.bold, color: colordtmaintwo,),),
                    Text('''${item2.choice.toString()} \n '''
                      ,style: TextStyle(
                        fontSize: MediaQuery
                            .of(context)
                            .size
                            .height * 0.03, color: colordtmaintwo,),),
                  ],
                ),
                Row(
                  children: [
                    Text('''$feest: \n '''
                      ,style: TextStyle(
                        fontSize: MediaQuery
                            .of(context)
                            .size
                            .height * 0.03,fontWeight: FontWeight.bold, color: colordtmaintwo,),),
                    Text('''${item2.price.toString()} \n '''
                      ,style: TextStyle(
                        fontSize: MediaQuery
                            .of(context)
                            .size
                            .height * 0.03, color: colordtmaintwo,),),
                  ],
                ),

                Divider(color: colordtmaintwo),

              ],),
        ],),);}}