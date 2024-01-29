import 'dart:async';
import 'package:language.dart';
import 'package:models/User_Model/user_model.dart';
import 'package:repository.dart';
import 'package:screens/Calendar_Screen/calendar_time_screen.dart';
import 'package:screens/General/create_article_screen.dart';
import 'package:screens/General/item_widget_screen.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import '/models/Article_Model/article_model.dart';
import 'repository.dart';
import 'models/Article_Model/article_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

bool priceactivated = false;
int pricelow = 0;
int pricehigh = 0;

String searchday = '';
String searchpricerange = '';
String searchcrowdness = '';

String bedroomsearchgl= '';
String bathroomsearchgl= '';
String adultsearchgl= '';
String kidsearchgl= '';
String hotelclasssearchgl= '';

String searchdate = '';
String businesstypesearch = '';
String restauranttypesearch = 'A';
bool searchcategorytype = false;
String searchmny = '';
bool searchbydate = false;
bool searchadultkid = false;
bool searchbedbath = false;
bool searchhotelclass = false;

class Tagstatekeys {
  static final _tagStateKey1 = const Key('__TSK10__');
}

String chosensearchtype = userst;
String chosensearchtype2 = '';
String dettype = '';

String determinetype(){
  if(chosensearchtype == userproductsst){return 'UP';}
  if(chosensearchtype == postsst){return 'A';}
  if(chosensearchtype == groceryshoppingst){return 'UP';}
  if(chosensearchtype == foodsst){return 'UP';}
  if(chosensearchtype == eventsst){return 'CE';}
  if(chosensearchtype == appointmentsst){return 'CI';}
  if(chosensearchtype == reservationsst){return 'R';}
  if(chosensearchtype == jobapplicationsst){return 'A';}
  if(chosensearchtype == formsst){return 'US';}
  return '';
}


bool triggeruserproductupdate = false;

class UserProductScreen extends StatefulWidget {
  final User user;
  final User visiteduser;
  final String category;
  const UserProductScreen({Key key,this.user,this.visiteduser,this.category}) : super(key : key);

  @override
  UserProductScreenState createState() => UserProductScreenState(user: user,category: category,visiteduser:visiteduser );
}

class UserProductScreenState extends State<UserProductScreen> {
  final User user;
  final User visiteduser;
  final String category;
  UserProductScreenState({Key key,this.user,this.visiteduser,this.category});
  ScrollController _scrollController = ScrollController();
  int page = 1;
  List<Article> posts = [];
  Future fetchPostsfuture;
  bool isLoading = false;

  @override
  void initState() {
    if(visiteduser.id == user.id){
      setState(() {
        fetchPostsfuture =  FetchOwnArticlesAll(user.id, page, visiteduser, false, '', '', '');
      });   return;

    }
    isuserfollowed(user.id,visiteduser.id)..then((result){
      if(user.shouldshowuserinfo(visiteduser,result) == 'followed'){
        setState(() {
          fetchPostsfuture = FetchFollowedArticlesAll(user.id, page, visiteduser, false, '', '', '');
        });   return;

      }
      if(user.shouldshowuserinfo(visiteduser,result) == 'public'){
        setState(() {
          fetchPostsfuture = FetchPublicArticlesAll(user.id, page, visiteduser, false, '', '', '');
        });   return;

      }
    });

  }
  void initstatsproduct(Article article){
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
    if(visiteduser.id == user.id){
      FetchOwnArticlesAll(user.id, page, visiteduser, false, '', '', '')..then((result2){
        setState(() {
          for(final item2 in result2)
            posts.add(item2);
          isLoading = false;

        });   return;
      });
    }
    isuserfollowed(user.id,visiteduser.id)..then((result){
      if(user.shouldshowuserinfo(visiteduser,result) == 'followed'){
        FetchFollowedArticlesAll(user.id, page, visiteduser, false, '', '', '')..then((result2){
          setState(() {
            for(final item2 in result2)
              posts.add(item2);
            isLoading = false;

          });   return;
        });
      }
      if(user.shouldshowuserinfo(visiteduser,result) == 'public'){
        FetchPublicArticlesAll(user.id, page, visiteduser, false, '', '', '')..then((result2){
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

  Future<Null> refreshList() async {

    setState(() {});
  }

  bool ishiglighted(Article product){
    if(product.ishighlighted){
      if(category == highlightst){
        return true;
      }
      return false;
    }
    return false;
  }


  void init(){
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
              actions: [


              ],
              leading:  IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 30.0,
                color: colordtmaintwo,
                onPressed: () {
                  Navigator.pop(context,true);
                },
              ),
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

            return snapshotpost.hasData ?
            PageView.builder(
                onPageChanged: (indexpage){
                  if (indexpage + 1 == posts.length) {
                   setState(() {
                     page = page + 1;
                     _loadData();
                   });
                  }
                },
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                itemCount: posts.length,
                itemBuilder: (context,index){
                  initstatsproduct(posts[index]);
                  return posts[index].category == category ?
                  ArticleWidgetScreen(user:user,post:posts[index],ischosing:false)
                   : Container(height: 0,width: 0,);

                }) : Center(
              child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
              ),);},),
      ),

    );
  }
}


class UserFilterArticleScreen extends StatefulWidget {
  final User user;
  final User visiteduser;
  const UserFilterArticleScreen({Key key,this.user,this.visiteduser}) : super(key : key);

  @override
  UserFilterArticleScreenState createState() => UserFilterArticleScreenState(user: user,visiteduser:visiteduser );
}

class UserFilterArticleScreenState extends State<UserFilterArticleScreen> {
  final User user;
  final User visiteduser;
  UserFilterArticleScreenState({Key key,this.user,this.visiteduser});
  ScrollController _scrollController = ScrollController();
  int page = 1;
  List<Article> posts = [];
  Future fetchPostsfuture;
  bool isLoading = false;


  @override
  void initState() {
     dettype = determinetype();
     print('dettpye $dettype');
    if(visiteduser.id == user.id){
      setState(() {
        fetchPostsfuture =  FetchOwnArticlesFiltered(user.id, page, visiteduser, false, '', '', '',dettype);
      });   return;

    }
    isuserfollowed(user.id,visiteduser.id)..then((result){
      if(user.shouldshowuserinfo(visiteduser,result) == 'followed'){
        setState(() {
          fetchPostsfuture = FetchFollowedArticlesFiltered(user.id, page, visiteduser, false, '', '', '',dettype);
        });   return;

      }
      if(user.shouldshowuserinfo(visiteduser,result) == 'public'){
        setState(() {
          fetchPostsfuture = FetchPublicArticlesFiltered(user.id, page, visiteduser, false, '', '', '',dettype);
        });   return;

      }
    });

  }
  void initstatsproduct(Article article){
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
    if(visiteduser.id == user.id){
      FetchOwnArticlesFiltered(user.id, page, visiteduser, false, '', '', '',dettype)..then((result2){
        setState(() {
          for(final item2 in result2)
            posts.add(item2);
          isLoading = false;

        });   return;
      });
    }
    isuserfollowed(user.id,visiteduser.id)..then((result){
      if(user.shouldshowuserinfo(visiteduser,result) == 'followed'){
        FetchFollowedArticlesFiltered(user.id, page, visiteduser, false, '', '', '',dettype)..then((result2){
          setState(() {
            for(final item2 in result2)
              posts.add(item2);
            isLoading = false;

          });   return;
        });
      }
      if(user.shouldshowuserinfo(visiteduser,result) == 'public'){
        FetchPublicArticlesFiltered(user.id, page, visiteduser, false, '', '', '',dettype)..then((result2){
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

  Future<Null> refreshList() async {

    setState(() {});
  }



  void init(){
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
              actions: [

              ],
              leading:  IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 30.0,
                color: colordtmaintwo,
                onPressed: () {
                  Navigator.pop(context,true);
                },
              ),
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

            return snapshotpost.hasData ?
            PageView.builder(
                onPageChanged: (indexpage){
                  if (indexpage + 1 == posts.length) {
                    setState(() {
                      page = page + 1;
                      _loadData();
                    });
                  }
                },
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                itemCount: posts.length,
                itemBuilder: (context,index){
                  initstatsproduct(posts[index]);
                  return ArticleWidgetScreen(user:user,post:posts[index],ischosing:false);

                }) : Center(
              child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
              ),);},),
      ),

    );
  }
}

class UserFilterCategoryScreen extends StatefulWidget {
  final User user;
  final User visiteduser;
  final bool isarticlecreate;
  const UserFilterCategoryScreen({Key key,this.isarticlecreate,this.user,this.visiteduser}) : super(key : key);

  @override
  UserFilterCategoryScreenState createState() => UserFilterCategoryScreenState(user: user,isarticlecreate:isarticlecreate,visiteduser:visiteduser );
}

class UserFilterCategoryScreenState extends State<UserFilterCategoryScreen> {
  final User user;
  final User visiteduser;
  final bool isarticlecreate;
  UserFilterCategoryScreenState({Key key,this.user,this.isarticlecreate,this.visiteduser});
  ScrollController _scrollController = ScrollController();
  int page = 1;
  List<ArticleCategory> posts = [];
  Future fetchPostsfuture;
  bool isLoading = false;

  @override
  void initState() {

    if(visiteduser.id == user.id){
      setState(() {
        fetchPostsfuture =  FetchOwnUserProductCategory(user.id,page);
      });   return;

    }
    isuserfollowed(user.id,visiteduser.id)..then((result){
      if(user.shouldshowuserinfo(visiteduser,result) == 'followed'){

        setState(() { fetchPostsfuture = FetchFollowedUserProductCategory(visiteduser.id,page);});   return;

      }
      if(user.shouldshowuserinfo(visiteduser,result) == 'public'){

        setState(() {    fetchPostsfuture = FetchPublicUserProductCategory(visiteduser.id,page);});   return;

      }
    });

  }

  Future _loadData() async {
    if(visiteduser.id == user.id){
      FetchOwnUserProductCategory(user.id,page)..then((result){
        setState(() {
          for(final item2 in result)
            posts.add(item2);
          isLoading = false;

        });   return;
      });
    }
    isuserfollowed(user.id,visiteduser.id)..then((result){
      if(user.shouldshowuserinfo(visiteduser,result) == 'followed'){
        FetchFollowedUserProductCategory(visiteduser.id,page)..then((result2){
          setState(() {
            for(final item2 in result2)
              posts.add(item2);
            isLoading = false;

          });   return;
        });
      }
      if(user.shouldshowuserinfo(visiteduser,result) == 'public'){
        FetchPublicUserProductCategory(visiteduser.id,page)..then((result2){
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

  Future<Null> refreshList() async {

    setState(() {});
  }



  void init(){
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
actions: [
  IconButton(
    icon: Icon(Icons.delete),
    iconSize: 30.0,
    color: colordtmaintwo,
    onPressed: () {
      articlecreatecategory = '';
      Navigator.pop(context);
    },
  ),
],
              leading:  IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 30.0,
                color: colordtmaintwo,
                onPressed: () {
                  Navigator.pop(context,true);
                },
              ),
              toolbarHeight: 50,
              expandedHeight: 50,
              forceElevated: innerBoxIsScrolled,
            ),
          ];
        },
        body: FutureBuilder<List<ArticleCategory>>(
          future: fetchPostsfuture,

          builder: (context, snapshotpost) {
            if (snapshotpost.hasError) print(snapshotpost.error);
            posts = snapshotpost.data;

            return snapshotpost.hasData ?
            PageView.builder(
                onPageChanged: (indexpage){
                  if (indexpage + 1 == posts.length) {
                    setState(() {
                      page = page + 1;
                      _loadData();
                    });
                  }
                },
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                itemCount: posts.length,
                itemBuilder: (context,index){
                  return Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          InkWell(
                            child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(posts[index].image?.isEmpty ?? true ? 'https://www.theladders.com/wp-content/uploads/shopping_190514.jpg' : posts[index].image),
                            ),
                            onTap:(){
                            if(isarticlecreate){
                              articlecreatecategory = posts[index].category;
                              Navigator.pop(context);
                            }
                            if(isarticlecreate == false){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => UserProductScreen(
                                      user:user,visiteduser:visiteduser,
                                      category:posts[index].id,
                                    )
                                ),
                              );
                            }
                            },
                            onLongPress: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DeleteThingScreen(
                                      category:'UPC',
                                      id:posts[index].id,
                                    )
                                ),
                              ).then((value) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) => super.widget));
                              });
                            },
                          ),

                          Positioned(
                            bottom: 0,
                            left: 10,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  posts[index].category,
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  );

                }) : Center(
              child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
              ),);},),
      ),

    );
  }
}




class ProfileSearchFilter2Screen extends StatefulWidget {
  final User user;
  final User visiteduser;
  const ProfileSearchFilter2Screen({Key key, this.user,this.visiteduser}) : super(key: key);

  @override
  ProfileSearchFilter2ScreenState createState() => ProfileSearchFilter2ScreenState(user: user,visiteduser:visiteduser,key:key);
}

class ProfileSearchFilter2ScreenState extends State<ProfileSearchFilter2Screen> {
  final User user;
  final User visiteduser;
  ProfileSearchFilter2ScreenState({Key key,this.visiteduser, this.user});
  bool searching = false;
  bool done1 = false;
  bool done2 = false;
  bool done3 = false;
  bool done4 = false;
  bool done5 = false;
  bool done6 = false;

  bool searchtypeuser = false;
  bool searchtypebusiness = false;
  bool searchtypepost = false;
  bool searchtypefood = false;
  bool searchtypejobann = false;
  bool searchtypeevent = false;
  bool searchtypeapp = false;
  bool searchtypegrocery = false;
  bool searchtypereservation = false;
  bool searchtypegroceryshop = false;
  bool searchtyperestaurant = false;
  bool searchtypeoffer = false;

  bool searchtypeproduct = false;
  bool searchtypeforms = false;

  List<String> advices = [];
  List<String> matchedtags = [];
  List<String> excludedtags = [];
  bool tagsearch = false;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  List<User> searchusers = [];



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colordtmainone,
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                    Text(searchthingsst,
                      style: TextStyle(
                        color:colordtmaintwo,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,

                      ),),
                  ],),
                SizedBox(height:40),
                SizedBox(height:15),
                CheckboxListTile(
                  title:  Text(productsst,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.bold)),
                  value: searchtypeproduct, onChanged: (bool value) {setState(() { searchtypeuser = !value;
                chosensearchtype = userproductsst;    chosensearchtype2 = '';
                searchtypeuser = !value;searchtypeoffer = !value;
                searchtyperestaurant = !value;
                searchtypereservation = !value;
                searchtypegroceryshop = !value;
                searchtypepost = !value;
                searchtypejobann = !value;
                searchtypeevent = !value;
                searchtypeapp = !value;
                searchtypebusiness = !value;
                searchtypeproduct = value;
                searchtypegrocery = !value;
                searchtypeforms = !value;
                searchtypefood = !value;
                print(chosensearchtype); });},),
                CheckboxListTile(
                  title:  Text(postsst,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.bold)),
                  value: searchtypepost, onChanged: (bool value) {setState(() {
                  chosensearchtype = postst;    chosensearchtype2 = '';
                  searchtypeuser = !value;searchtypeoffer = !value;
                  searchtyperestaurant = !value;
                  searchtypereservation = !value;
                  searchtypepost = value;
                  searchtypejobann = !value;
                  searchtypeevent = !value;
                  searchtypeapp = !value;
                  searchtypebusiness = !value;
                  searchtypeproduct = !value;
                  searchtypegrocery = !value;
                  searchtypeforms = !value;
                  searchtypefood = !value;
                  print(chosensearchtype); });},),
                CheckboxListTile(
                  title:  Text(offersst,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.bold)),
                  value: searchtypeoffer, onChanged: (bool value) {setState(() {
                  chosensearchtype = offersst;    chosensearchtype2 = '';

                  searchtypeoffer = value;
                  searchtypeuser = !value;
                  searchtyperestaurant = !value;
                  searchtypereservation = !value;
                  searchtypepost = !value;
                  searchtypejobann = !value;
                  searchtypeevent = !value;
                  searchtypeapp = !value;
                  searchtypebusiness = !value;
                  searchtypeproduct = !value;
                  searchtypegrocery = !value;
                  searchtypeforms = !value;
                  searchtypefood = !value;
                  print(chosensearchtype); });},),
                CheckboxListTile(
                  title:  Text(groceryshoppingst,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.bold)),
                  value: searchtypegrocery, onChanged: (bool value) {setState(() {
                  searchtypeuser = !value;
                  chosensearchtype = groceryshoppingst;    chosensearchtype2 = '';
                  searchtypereservation = !value;
                  searchtypeuser = !value;searchtypeoffer = !value;
                  searchtyperestaurant = !value;

                  searchtypepost = !value;
                  searchtypejobann = !value;
                  searchtypeevent = !value;
                  searchtypeapp = !value;
                  searchtypebusiness = !value;
                  searchtypeproduct = !value;
                  searchtypegroceryshop = !value;
                  searchtypegrocery = value;
                  searchtypeforms = !value;
                  searchtypefood = !value;
                  print(chosensearchtype); });},),
                CheckboxListTile(
                  title:  Text(foodsst,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.bold)),
                  value: searchtypefood, onChanged: (bool value) {setState(() {

                  chosensearchtype = foodsst;    chosensearchtype2 = '';
                  searchtypeuser = !value;searchtypereservation = !value;
                  searchtyperestaurant = !value;searchtypeoffer = !value;
                  searchtypegroceryshop = !value;
                  searchtypepost = !value;
                  searchtypejobann = !value;
                  searchtypeevent = !value;
                  searchtypeapp = !value;
                  searchtypebusiness = !value;
                  searchtypeproduct = !value;
                  searchtypegrocery = !value;
                  searchtypeforms = !value;
                  searchtypefood = value;

                  print(chosensearchtype); });},),
                CheckboxListTile(
                  title:  Text(eventsst,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.bold)),
                  value: searchtypeevent, onChanged: (bool value) {setState(() { searchtypeuser = !value;

                chosensearchtype = calendareventsst;    chosensearchtype2 = '';
                searchtypeuser = !value;searchtypereservation = !value;
                searchtyperestaurant = !value;
                searchtypegroceryshop = !value;searchtypeoffer = !value;
                searchtypepost = !value;
                searchtypejobann = !value;
                searchtypeevent = value;
                searchtypeapp = !value;
                searchtypebusiness = !value;
                searchtypeproduct = !value;
                searchtypegrocery = !value;
                searchtypeforms = !value;
                searchtypefood = !value;     print(chosensearchtype); });},),
                CheckboxListTile(
                  title:  Text(appointmentsst,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.bold)),
                  value: searchtypeapp, onChanged: (bool value) {setState(() {
                  chosensearchtype = calendaritemsst;    chosensearchtype2 = '';
                  searchtypeuser = !value;searchtypereservation = !value;
                  searchtyperestaurant = !value;searchtypeoffer = !value;
                  searchtypegroceryshop = !value;
                  searchtypepost = !value;
                  searchtypejobann = !value;
                  searchtypeevent = !value;
                  searchtypeapp = value;
                  searchtypebusiness = !value;
                  searchtypeproduct = !value;
                  searchtypegrocery = !value;
                  searchtypeforms = !value;
                  searchtypefood = !value;   print(chosensearchtype); });},),
                CheckboxListTile(
                  title:  Text(reservationsst,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.bold)),
                  value: searchtypereservation, onChanged: (bool value) {setState(() {searchtypeuser = !value;
                chosensearchtype = reservationsst;    chosensearchtype2 = '';
                searchtypeuser = !value;searchtypeoffer = !value;
                searchtypereservation = value;
                searchtyperestaurant = !value;
                searchtypegroceryshop = !value;
                searchtypepost = !value;
                searchtypejobann = !value;
                searchtypeevent = !value;
                searchtypeapp = !value;
                searchtypebusiness = !value;
                searchtypeproduct = !value;
                searchtypegrocery = !value;
                searchtypeforms = !value;
                searchtypefood = !value;       print(chosensearchtype);});},),
                CheckboxListTile(
                  title:  Text(jobapplicationsst,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.bold)),
                  value: searchtypejobann, onChanged: (bool value) {setState(() {
                  chosensearchtype = jobpostingst;    chosensearchtype2 = '';
                  searchtypeuser = !value;searchtypeoffer = !value;
                  searchtyperestaurant = !value;
                  searchtypereservation = !value;
                  searchtypepost = !value;
                  searchtypejobann = value;
                  searchtypeevent = !value;
                  searchtypeapp = !value;
                  searchtypebusiness = !value;
                  searchtypeproduct = !value;
                  searchtypegrocery = !value;
                  searchtypeforms = !value;
                  searchtypefood = !value;    print(chosensearchtype); });},),
                CheckboxListTile(
                  title:  Text(formsst,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.bold)),
                  value: searchtypeforms, onChanged: (bool value) {setState(() {searchtypeuser = !value;
                chosensearchtype = userservicesst;    chosensearchtype2 = '';
                searchtypeuser = !value;   searchtypereservation = !value;
                searchtyperestaurant = !value;searchtypeoffer = !value;
                searchtypegroceryshop = !value;
                searchtypepost = !value;
                searchtypejobann = !value;
                searchtypeevent = !value;
                searchtypeapp = !value;
                searchtypebusiness = !value;
                searchtypeproduct = !value;
                searchtypegrocery = !value;
                searchtypeforms = value;
                searchtypefood = !value;       print(chosensearchtype);});},),
              CheckboxListTile(
                title:  Text(userproductcategoriesst,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.bold)),
                value: searchcategorytype, onChanged: (bool value) {
                setState(() {
                  searchcategorytype = value;
                  searchtypeuser = !value;searchtypeoffer = !value;
                  searchtypereservation = !value;
                  searchtyperestaurant = !value;
                  searchtypegroceryshop = !value;
                  searchtypepost = !value;
                  searchtypejobann = !value;
                  searchtypeevent = !value;
                  searchtypeapp = !value;
                  searchtypebusiness = !value;
                  searchtypeproduct = !value;
                  searchtypegrocery = !value;
                  searchtypeforms = !value;
                  searchtypefood = !value;
                });},),

                SizedBox(height:50),
                SizedBox(

                  width:MediaQuery.of(context).size.width*0.4 ,height:MediaQuery.of(context).size.height*0.06,
                  child: ElevatedButton(
                    child: Text(donest,
                      style:TextStyle(
                        fontSize:MediaQuery.of(context).size.height*0.025,
                      ),),
                    onPressed: (){
                      print(searchcategorytype);
                      if(searchcategorytype){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserFilterCategoryScreen(user: user,isarticlecreate:false,visiteduser:visiteduser)));
                      }
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserFilterArticleScreen(user: user,visiteduser:visiteduser)));

                    },
                  ),
                ),
                SizedBox(height:200),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
