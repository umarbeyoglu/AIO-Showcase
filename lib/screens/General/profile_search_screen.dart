import 'package:Welpie/language.dart';
import 'package:Welpie/models/Article_Model/article_model.dart';
import 'dart:async';
import 'package:Welpie/screens/General/reservation_screen.dart';
import 'package:Welpie/screens/General/search_screen.dart';
import 'package:Welpie/screens/User_Contact_Screen/profile_user_locations_screen.dart';
import 'package:Welpie/screens/User_Contact_Screen/profile_user_mails_screen.dart';
import 'package:Welpie/screens/User_Contact_Screen/profile_user_phones_screen.dart';
import 'package:Welpie/screens/Visited_Profile_Screen/visited_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:Welpie/models/User_Model/user_calendar_item_model.dart';
import 'package:Welpie/screens/Calendar_Screen/calendar_screen.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:Welpie/repository.dart';
import 'package:Welpie/models/User_Model/user_model.dart';
import '../../colors.dart';
import '../../models/User_Model/user_subuser_model.dart';
import '../../profile_user_product_screen.dart';
import '../Calendar_Screen/calendar_time_screen.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'item_widget_screen.dart';

bool priceactivated = false;
int pricelow = 0;
int pricehigh = 0;

bool isfirsttimeprofilesearch = false;

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

class Tagkeys {
  static final _tagStateKey4 = const Key('__TSK4__');
  static final _tagStateKey5 = const Key('__TSK5__');
}

String chosensearchtype = userst;
String chosensearchtype2 = '';


class ProfileSearchScreen extends StatefulWidget {
  final User user;
  final User visiteduser;
  const ProfileSearchScreen({Key key,this.visiteduser, this.user}) : super(key: key);

  @override
  ProfileSearchScreenState createState() => ProfileSearchScreenState(user: user,visiteduser:visiteduser,key:key);
}

class ProfileSearchScreenState extends State<ProfileSearchScreen> {
  final User user;
  final User visiteduser;
  ProfileSearchScreenState({Key key,this.visiteduser, this.user});
  bool searching = false;
  List<Article> _posts  = [];
  List<Article> _postsForDisplay  = [];
  List<ArticleCategory> _userproductcategories  = [];
  List<ArticleCategory> _userproductcategoriesForDisplay  = [];
  //List<Group> _groups  = [];
  // List<Group> _groupsForDisplay  = [];
  bool done1 = false;
  bool done2 = false;
  bool done3 = false;
  bool done4 = false;
  bool hidebar = false;
  bool done5 = false;
  bool done6 = false;
  bool done7 = false;
  bool done8 = false;
  bool done9 = false;
  String globaltxt = '';
  var _textfield = TextEditingController();
  int _column = 0;
  ScrollController _scrollController = ScrollController();
  int page = 1;
  Future fetchPostsfuture;
  bool isLoading = false;
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
    fetchPostsfuture = SearchArticlesInProfile(visiteduser.id,page,globaltxt,globaltxt.split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,false,'',user);
    if( restauranttypesearch == ''){
      restauranttypesearch = 'A';
    }
    super.initState();
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
  
  bool crowdlevel(String crowdlevel){
    if(searchcrowdness == ''){
      return true;
    }
    if(searchcrowdness == 'verybusy'){
      if(
      crowdlevel == 'verybusy'||
          crowdlevel == 'busy'||
          crowdlevel == 'normal'||
          crowdlevel == 'low'||
          crowdlevel == 'idle'
      ){
        return true;
      }
    }
    if(searchcrowdness == 'busy'){
      if(
      crowdlevel == 'busy'||
          crowdlevel == 'normal'||
          crowdlevel == 'low'||
          crowdlevel == 'idle'
      ){
        return true;
      }
    }
    if(searchcrowdness == 'normal'){
      if(
      crowdlevel == 'normal'||
          crowdlevel == 'low'||
          crowdlevel == 'idle'
      ){
        return true;
      }
    }
    if(searchcrowdness == 'low'){
      if(
      crowdlevel == 'low'||
          crowdlevel == 'idle'
      ){
        return true;
      }
    }
    if(searchcrowdness == 'idle'){
      if(
      crowdlevel == 'idle'
      ){
        return true;
      }
    }
    return false;
  }

  Future _loadmoreposts(String type) async {
    List<Article> postsinit = [];

    postsinit = await SearchArticlesInProfile(visiteduser.id,page,globaltxt,globaltxt.split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,false,type,user);
    setState(() {
      for(final item2 in postsinit)

        _postsForDisplay.add(item2);
      isLoading = false;
      return;
    });
  }

  Future _loadmorejobposts() async {
    List<Article> postsinit = [];
    postsinit = await SearchArticlesInProfile(visiteduser.id,page,globaltxt,globaltxt.split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,false,'',user);
    setState(() {
      for(final item2 in postsinit)

        _postsForDisplay.add(item2);
      isLoading = false;
      return;
    });
  }
  
  Future _loadmoreuserproductcategories() async {
    List<ArticleCategory> postsinit = [];
    postsinit = await SearchUserProductCategoriesNew2(page,globaltxt);
    setState(() {


      for(final item2 in postsinit)
        _userproductcategoriesForDisplay.add(item2);
      isLoading = false;
      return;
    });
  }


  Widget adviceswidget(){
    return  Tags(

      key: Tagkeys._tagStateKey4,
      columns: _column,
      itemCount: advices.length,
      itemBuilder: (i) {
        return ItemTags(
          key: Key(i.toString()),
          index: i,
          title: advices[i].toString(),
          color: Color(0xFFEEEEEE),
          activeColor: Color(0xFFEEEEEE),
          textColor: colordtmaintwo,
          textActiveColor: colordtmaintwo,
          textStyle: TextStyle(
            fontSize: MediaQuery
                .of(context)
                .size
                .height * 0.018, color: colordtmaintwo,),
        );
      },
    );
  }

  Widget SearchScreen(){
    if(searchcategorytype){
      print('enterr');
      setState(() {
        page = 1;
      });

      return Scaffold(
        backgroundColor: colordtmainone,
        body:
        NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!isLoading && scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                _loadmoreuserproductcategories();
                setState(() {isLoading = true;});
                return true;
              }},child:    ListView.builder(
          itemBuilder: (context, index) {
            return index == 0 ? _searchBar() : searching == false ? Container(height: 0,width: 0,) : _listItemUserProductCategory(index-1);},
          itemCount: _userproductcategoriesForDisplay.length+1,
        )),

      );
    }
    if(chosensearchtype == postst){
      setState(() {
        page = 1;
      });




      return  Scaffold(
        backgroundColor: colordtmainone,
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              if (hidebar == false)SliverAppBar(
                floating: true,
                elevation: 10.0,
                backgroundColor: colordtmainone,
                title:Form(
                  child:TextFormField(
                    style: TextStyle(color: colordtmaintwo),
                    controller:_textfield,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      suffixIcon:  IconButton(
                        icon: Icon(
                          Icons.reorder,
                          color: colordtmaintwo,
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SearchFilterScreen(
                                )
                            ),
                          );
                        },
                      ),
                      icon: IconButton(
                        icon: Icon(Icons.search),
                        color:colordtmaintwo,
                        onPressed: () {
                          setState(() {
                            hidebar = true;
                          });
                        },
                      ),
                    ),
                    onChanged: (_textfield) {
                      setState(() {
                        globaltxt = _textfield.toLowerCase();
                        List<String> advicetags = _textfield.toLowerCase().split(',');
                        advices = TagSuggestion(advicetags.last.toLowerCase());
                      });
                      _textfield == '' ? setState(() {searching = false; }) : setState(() {searching = true;});

                      //  else  if (chosensearchtype == groupsearchst) {setState(() {if(tagsearch){_groupsForDisplay = _groups.where((groupa){return doSearch(_textfield.toLowerCase().split(','),groupa.searchgrouptags(),groupa.origgrouptags(groupa),true);}).toList();}
                      //      if(tagsearch == false){_groupsForDisplay = _groups.where((group) {if(group.name.toLowerCase().contains(_textfield.toLowerCase())){group.name.toLowerCase().contains(_textfield.toLowerCase());};if(doSearch(_textfield.toLowerCase().split(','),group.searchgrouptags(),group.origgrouptags(group),true)){doSearch(_textfield.toLowerCase().split(','),group.searchgrouptags(),group.origgrouptags(group),true);};return false;}).toList();}});}
                       if (chosensearchtype == postst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,0,0,false,false,false,'A',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                         
                        });

                      }
                      else if (chosensearchtype == userproductsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'UP',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == userservicesst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'US',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});  });
                      }
                      else if (chosensearchtype == calendareventsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'CE',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == reservationsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'R',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == calendaritemsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'CI',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                    },
                  ),
                ),
                toolbarHeight: 50,
                expandedHeight: 50,
                forceElevated: innerBoxIsScrolled,
              ),
              if (hidebar == true)SliverAppBar(
                floating: true,
                elevation: 0,
                backgroundColor: colordtmainone,
                toolbarHeight: 0,
                expandedHeight: 0,
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
          body:  PageView.builder(
            onPageChanged: (indexpage){
              if (indexpage + 1 == _postsForDisplay.length) {
                page = page +1;
                _loadmoreposts('A');
              }
            },
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {

              return  _listItemPost(index);},
            itemCount: _postsForDisplay.length,
          ),
        ),
      );
    }
    if(chosensearchtype == offersst){
      setState(() {
        page = 1;
      });




      return  Scaffold(
        backgroundColor: colordtmainone,
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              if (hidebar == false)SliverAppBar(
                floating: true,
                elevation: 10.0,
                backgroundColor: colordtmainone,
                title:Form(
                  child:TextFormField(
                    style: TextStyle(color: colordtmaintwo),
                    controller:_textfield,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      suffixIcon:  IconButton(
                        icon: Icon(
                          Icons.reorder,
                          color: colordtmaintwo,
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SearchFilterScreen(
                                )
                            ),
                          );
                        },
                      ),
                      icon: IconButton(
                        icon: Icon(Icons.search),
                        color:colordtmaintwo,
                        onPressed: () {
                          setState(() {
                            hidebar = true;
                          });
                        },
                      ),
                    ),
                    onChanged: (_textfield) {
                      setState(() {
                        globaltxt = _textfield.toLowerCase();
                        List<String> advicetags = _textfield.toLowerCase().split(',');
                        advices = TagSuggestion(advicetags.last.toLowerCase());
                      });
                      _textfield == '' ? setState(() {searching = false; }) : setState(() {searching = true;});

                      //  else  if (chosensearchtype == groupsearchst) {setState(() {if(tagsearch){_groupsForDisplay = _groups.where((groupa){return doSearch(_textfield.toLowerCase().split(','),groupa.searchgrouptags(),groupa.origgrouptags(groupa),true);}).toList();}
                      //      if(tagsearch == false){_groupsForDisplay = _groups.where((group) {if(group.name.toLowerCase().contains(_textfield.toLowerCase())){group.name.toLowerCase().contains(_textfield.toLowerCase());};if(doSearch(_textfield.toLowerCase().split(','),group.searchgrouptags(),group.origgrouptags(group),true)){doSearch(_textfield.toLowerCase().split(','),group.searchgrouptags(),group.origgrouptags(group),true);};return false;}).toList();}});}
                      if (chosensearchtype == offersst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,0,0,false,false,false,'OFFER',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});

                        });

                      }
                      if (chosensearchtype == postst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,0,0,false,false,false,'A',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});

                        });

                      }
                      else if (chosensearchtype == userproductsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'UP',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == userservicesst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'US',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});  });
                      }
                      else if (chosensearchtype == calendareventsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'CE',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == reservationsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'R',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == calendaritemsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'CI',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                    },
                  ),
                ),
                toolbarHeight: 50,
                expandedHeight: 50,
                forceElevated: innerBoxIsScrolled,
              ),
              if (hidebar == true)SliverAppBar(
                floating: true,
                elevation: 0,
                backgroundColor: colordtmainone,
                toolbarHeight: 0,
                expandedHeight: 0,
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
          body:  PageView.builder(
            onPageChanged: (indexpage){
              if (indexpage + 1 == _postsForDisplay.length) {
                page = page +1;
                _loadmoreposts('OFFER');
              }
            },
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {

              return  _listItemPost(index);},
            itemCount: _postsForDisplay.length,
          ),
        ),
      );
    }
    if(chosensearchtype == jobpostingst){
      setState(() {
        page = 1;
      });




      return Scaffold(
        backgroundColor: colordtmainone,
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              if (hidebar == false)SliverAppBar(
                floating: true,
                elevation: 10.0,
                backgroundColor: colordtmainone,
                title:Form(
                  child:TextFormField(
                    style: TextStyle(color: colordtmaintwo),
                    controller:_textfield,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      suffixIcon:  IconButton(
                        icon: Icon(
                          Icons.reorder,
                          color: colordtmaintwo,
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SearchFilterScreen(
                                )
                            ),
                          );
                        },
                      ),
                      icon: IconButton(
                        icon: Icon(Icons.search),
                        color:colordtmaintwo,
                        onPressed: () {
                          setState(() {
                            hidebar = true;
                          });
                        },
                      ),
                    ),
                    onChanged: (_textfield) {
                      setState(() {
                        globaltxt = _textfield.toLowerCase();
                        List<String> advicetags = _textfield.toLowerCase().split(',');
                        advices = TagSuggestion(advicetags.last.toLowerCase());
                      });
                      _textfield == '' ? setState(() {searching = false; }) : setState(() {searching = true;});
                   if (chosensearchtype == postst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,0,0,false,false,false,'A',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });

                      }
                      else if (chosensearchtype == userproductsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'UP',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == userservicesst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'US',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});  });
                      }
                      else if (chosensearchtype == calendareventsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'CE',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == calendaritemsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'CI',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                    },
                  ),
                ),
                toolbarHeight: 50,
                expandedHeight: 50,
                forceElevated: innerBoxIsScrolled,
              ),
              if (hidebar == true)SliverAppBar(
                floating: true,
                elevation: 0,
                backgroundColor: colordtmainone,
                toolbarHeight: 0,
                expandedHeight: 0,
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
          body:  PageView.builder(
            onPageChanged: (indexpage){
              if (indexpage + 1 == _postsForDisplay.length) {
                page = page +1;
                _loadmorejobposts();
              }
            },
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {

              return  _listItemjobPost(index);},
            itemCount: _postsForDisplay.length,
          ),
        ),
      );
    }
    if(chosensearchtype == calendaritemsst){
      setState(() {
        page = 1;
      });



      return Scaffold(
        backgroundColor: colordtmainone,
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              if (hidebar == false)SliverAppBar(
                floating: true,
                elevation: 10.0,
                backgroundColor: colordtmainone,
                title:Form(
                  child:TextFormField(
                    style: TextStyle(color: colordtmaintwo),
                    controller:_textfield,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      suffixIcon:  IconButton(
                        icon: Icon(
                          Icons.reorder,
                          color: colordtmaintwo,
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SearchFilterScreen(
                                )
                            ),
                          );
                        },
                      ),
                      icon: IconButton(
                        icon: Icon(Icons.search),
                        color:colordtmaintwo,
                        onPressed: () {
                          setState(() {
                            hidebar = true;
                          });
                        },
                      ),
                    ),
                    onChanged: (_textfield) {
                      bool donesearch = false;
                      setState(() {
                        globaltxt = _textfield.toLowerCase();
                        List<String> advicetags = _textfield.toLowerCase().split(',');
                        advices = TagSuggestion(advicetags.last.toLowerCase());
                      });
                      _textfield == '' ? setState(() {searching = false; }) : setState(() {searching = true;});
                     if (chosensearchtype == postst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,0,0,false,false,false,'A',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });

                      }
                      else if (chosensearchtype == userproductsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'UP',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == userservicesst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'US',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});}); });
                      }
                      else if (chosensearchtype == calendareventsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'CE',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == calendaritemsst) {
                        print(donesearch);

                        setState((){
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'CI',user).then((value) {setState(() {
                            _posts.addAll(value);
                            _postsForDisplay = _posts;


                            ;});});
                          donesearch = true;
                        });
                      }
                    },
                  ),
                ),
                toolbarHeight: 50,
                expandedHeight: 50,
                forceElevated: innerBoxIsScrolled,
              ),
              if (hidebar == true)SliverAppBar(
                floating: true,
                elevation: 0,
                backgroundColor: colordtmainone,
                toolbarHeight: 0,
                expandedHeight: 0,
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
          body:  PageView.builder(
            onPageChanged: (indexpage){
              if (indexpage + 1 == _postsForDisplay.length) {
                page = page +1;
                _loadmoreposts('CI');
              }
            },
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return  _listItemCalendarItem(index);},
            itemCount: _postsForDisplay.length,
          ),
        ),
      );
    }
    if(chosensearchtype == calendareventsst){
      setState(() {
        page = 1;
      });


      return Scaffold(
        backgroundColor: colordtmainone,
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              if (hidebar == false
              )SliverAppBar(
                floating: true,
                elevation: 10.0,
                backgroundColor: colordtmainone,
                title:Form(
                  child:TextFormField(
                    style: TextStyle(color: colordtmaintwo),
                    controller:_textfield,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      suffixIcon:  IconButton(
                        icon: Icon(
                          Icons.reorder,
                          color: colordtmaintwo,
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SearchFilterScreen(
                                )
                            ),
                          );
                        },
                      ),
                      icon: IconButton(
                        icon: Icon(Icons.search),
                        color:colordtmaintwo,
                        onPressed: () {
                          setState(() {
                            hidebar = true;
                          });
                        },
                      ),
                    ),
                    onChanged: (_textfield) {
                      setState(() {
                        globaltxt = _textfield.toLowerCase();
                        List<String> advicetags = _textfield.toLowerCase().split(',');
                        advices = TagSuggestion(advicetags.last.toLowerCase());
                      });
                      _textfield == '' ? setState(() {searching = false; }) : setState(() {searching = true;});
                     if (chosensearchtype == postst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,0,0,false,false,false,'A',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });

                      }
                      else if (chosensearchtype == userproductsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'UP',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == userservicesst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'US',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});}); });
                      }
                      else if (chosensearchtype == calendareventsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'CE',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == calendaritemsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'CI',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                    },
                  ),
                ),
                toolbarHeight: 50,
                expandedHeight: 50,
                forceElevated: innerBoxIsScrolled,
              ),
              if (hidebar == true)SliverAppBar(
                floating: true,
                elevation: 0,
                backgroundColor: colordtmainone,
                toolbarHeight: 0,
                expandedHeight: 0,
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
          body:  PageView.builder(
            onPageChanged: (indexpage){
              if (indexpage + 1 == _postsForDisplay.length) {
                page = page +1;
                _loadmoreposts('CE');
              }
            },
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {

              return  _listItemCalendarEvent(index);},
            itemCount: _postsForDisplay.length,
          ),
        ),
      );
    }
    if(chosensearchtype == reservationsst){
      setState(() {
        page = 1;
      });


      return Scaffold(
        backgroundColor: colordtmainone,
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              if (hidebar == false
              )SliverAppBar(
                floating: true,
                elevation: 10.0,
                backgroundColor: colordtmainone,
                title:Form(
                  child:TextFormField(
                    style: TextStyle(color: colordtmaintwo),
                    controller:_textfield,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      suffixIcon:  IconButton(
                        icon: Icon(
                          Icons.reorder,
                          color: colordtmaintwo,
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SearchFilterScreen(
                                )
                            ),
                          );
                        },
                      ),
                      icon: IconButton(
                        icon: Icon(Icons.search),
                        color:colordtmaintwo,
                        onPressed: () {
                          setState(() {
                            hidebar = true;
                          });
                        },
                      ),
                    ),
                    onChanged: (_textfield) {
                      setState(() {
                        globaltxt = _textfield.toLowerCase();
                        List<String> advicetags = _textfield.toLowerCase().split(',');
                        advices = TagSuggestion(advicetags.last.toLowerCase());
                      });
                      _textfield == '' ? setState(() {searching = false; }) : setState(() {searching = true;});
                      if (chosensearchtype == reservationsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'R',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                     if (chosensearchtype == postst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,0,0,false,false,
                              false,'',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });

                      }
                      else if (chosensearchtype == userproductsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,
                              priceactivated,true,'UP',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == userservicesst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,
                              searchbasedonlocation,priceactivated,true,'US',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});}); });
                      }
                      else if (chosensearchtype == calendareventsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,
                              searchbasedonlocation,priceactivated,true,'CE',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == calendaritemsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,
                              searchbasedonlocation,priceactivated,true,'CI',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                    },
                  ),
                ),
                toolbarHeight: 50,
                expandedHeight: 50,
                forceElevated: innerBoxIsScrolled,
              ),
              if (hidebar == true)SliverAppBar(
                floating: true,
                elevation: 0,
                backgroundColor: colordtmainone,
                toolbarHeight: 0,
                expandedHeight: 0,
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
          body:  PageView.builder(
            onPageChanged: (indexpage){
              if (indexpage + 1 == _postsForDisplay.length) {
                page = page +1;
                _loadmoreposts('R');
              }
            },
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {

              return  _listItemReservation(index);},
            itemCount: _postsForDisplay.length,
          ),
        ),
      );
    }
    if(chosensearchtype == userservicesst){
      setState(() {
        page = 1;
      });

      return  Scaffold(
        backgroundColor: colordtmainone,
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              if (hidebar == false)SliverAppBar(
                floating: true,
                elevation: 10.0,
                backgroundColor: colordtmainone,
                leading:Container(height:0,width:0),
                title:Form(
                  child:TextFormField(
                    style: TextStyle(color: colordtmaintwo),
                    controller:_textfield,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      suffixIcon:  IconButton(
                        icon: Icon(
                          Icons.reorder,
                          color: colordtmaintwo,
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SearchFilterScreen(
                                )
                            ),
                          );
                        },
                      ),
                      icon: IconButton(
                        icon: Icon(Icons.search),
                        color:colordtmaintwo,
                        onPressed: () {
                          setState(() {
                            hidebar = true;
                          });
                        },
                      ),
                    ),
                    onChanged: (_textfield) {
                      setState(() {
                        globaltxt = _textfield.toLowerCase();
                        List<String> advicetags = _textfield.toLowerCase().split(',');
                        advices = TagSuggestion(advicetags.last.toLowerCase());
                      });
                      _textfield == '' ? setState(() {searching = false; }) : setState(() {searching = true;});
                       if (chosensearchtype == postst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,0,0,false,false,false,'A',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });

                      }
                      else if (chosensearchtype == userproductsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,
                              searchbasedonlocation,priceactivated,true,'UP',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == userservicesst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,
                              searchbasedonlocation,priceactivated,true,'US',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == calendareventsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),
                              tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'CE',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == calendaritemsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),
                              tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'CI',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                    },
                  ),
                ),
                toolbarHeight: 50,
                expandedHeight: 50,
                forceElevated: innerBoxIsScrolled,
              ),
              if (hidebar == true)SliverAppBar(
                floating: true,
                elevation: 0,
                backgroundColor: colordtmainone,
                toolbarHeight: 0,
                expandedHeight: 0,
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
          body:  PageView.builder(
            onPageChanged: (indexpage){
              if (indexpage + 1 == _postsForDisplay.length) {
                page = page +1;
                _loadmoreposts('US');
              }
            },
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {

              return  _listItemUserService(index);},
            itemCount: _postsForDisplay.length,
          ),
        ),
      );
    }
    if(chosensearchtype == userproductsst){
      setState(() {
        page = 1;
      });


      return Scaffold(
        backgroundColor: colordtmainone,
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              if (hidebar == false)SliverAppBar(
                floating: true,
                elevation: 10.0,
                backgroundColor: colordtmainone,
                title:Form(
                  child:TextFormField(
                    style: TextStyle(color: colordtmaintwo),
                    controller:_textfield,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      suffixIcon:  IconButton(
                        icon: Icon(
                          Icons.reorder,
                          color: colordtmaintwo,
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SearchFilterScreen(
                                )
                            ),
                          );
                        },
                      ),
                      icon: IconButton(
                        icon: Icon(Icons.search),
                        color:colordtmaintwo,
                        onPressed: () {
                          setState(() {
                            hidebar = true;
                          });
                        },
                      ),
                    ),
                    onChanged: (_textfield) {
                      setState(() {
                        globaltxt = _textfield.toLowerCase();
                        List<String> advicetags = _textfield.toLowerCase().split(',');
                        advices = TagSuggestion(advicetags.last.toLowerCase());
                      });
                      _textfield == '' ? setState(() {searching = false; }) : setState(() {searching = true;});
                    if (chosensearchtype == postst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),
                              tagsearch,0,0,false,false,false,'A',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });

                      }
                      else if (chosensearchtype == userproductsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),
                              tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'UP',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == userservicesst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),
                              tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'US',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});}); });
                      }
                      else if (chosensearchtype == calendareventsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),
                              tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'CE',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == calendaritemsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),
                              tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'CI',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                    },
                  ),
                ),
                toolbarHeight: 50,
                expandedHeight: 50,
                forceElevated: innerBoxIsScrolled,
              ),
              if (hidebar == true)SliverAppBar(
                floating: true,
                elevation: 0,
                backgroundColor: colordtmainone,
                toolbarHeight: 0,
                expandedHeight: 0,
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
          body:  PageView.builder(
            onPageChanged: (indexpage){
              if (indexpage + 1 == _postsForDisplay.length) {
                page = page +1;
                _loadmoreposts('UP');
              }
            },
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {

              return  _listItemUserProduct(index);},
            itemCount: _postsForDisplay.length,
          ),
        ),
      );
    }
    if(chosensearchtype == foodsst&& searchcategorytype == false){
      setState(() {
        page = 1;
      });


      return Scaffold(
        backgroundColor: colordtmainone,
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              if (hidebar == false)SliverAppBar(
                floating: true,
                elevation: 10.0,
                backgroundColor: colordtmainone,
                title:Form(
                  child:TextFormField(
                    style: TextStyle(color: colordtmaintwo),
                    controller:_textfield,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      suffixIcon:  IconButton(
                        icon: Icon(
                          Icons.reorder,
                          color: colordtmaintwo,
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SearchFilterScreen(
                                )
                            ),
                          );
                        },
                      ),
                      icon: IconButton(
                        icon: Icon(Icons.search),
                        color:colordtmaintwo,
                        onPressed: () {
                          setState(() {
                            hidebar = true;
                          });
                        },
                      ),
                    ),
                    onChanged: (_textfield) {
                      setState(() {
                        globaltxt = _textfield.toLowerCase();
                        List<String> advicetags = _textfield.toLowerCase().split(',');
                        advices = TagSuggestion(advicetags.last.toLowerCase());
                      });
                      _textfield == '' ? setState(() {searching = false; }) : setState(() {searching = true;});
                    if (chosensearchtype == postst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),
                              _textfield.toLowerCase().split(','),tagsearch,0,0,false,false,false,'A',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });

                      }
                      else if (chosensearchtype == foodsst && searchcategorytype == false) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),
                              _textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'UP',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == foodsst && searchcategorytype) {
                        setState(() {
                          _userproductcategories = [];
                          _userproductcategoriesForDisplay = [];
                          SearchUserProductCategoriesNew2(page,_textfield.toLowerCase()).then((value) {setState(() {_userproductcategories.addAll(value);_userproductcategoriesForDisplay = _userproductcategories;});});
                        });
                      }
                      else if (chosensearchtype == userproductsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),
                              _textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'UP',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == userservicesst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),
                              _textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'US',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});}); });
                      }
                      else if (chosensearchtype == calendareventsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),
                              _textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'CE',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == calendaritemsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),
                              _textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'CI',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                    },
                  ),
                ),
                toolbarHeight: 50,
                expandedHeight: 50,
                forceElevated: innerBoxIsScrolled,
              ),
              if (hidebar == true)SliverAppBar(
                floating: true,
                elevation: 0,
                backgroundColor: colordtmainone,
                toolbarHeight: 0,
                expandedHeight: 0,
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
          body:  PageView.builder(
            onPageChanged: (indexpage){
              if (indexpage + 1 == _postsForDisplay.length) {
                page = page +1;
                _loadmoreposts('UP');
              }
            },
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {

              return  _listItemUserProduct(index);},
            itemCount: _postsForDisplay.length,
          ),
        ),
      );
    }
    if(chosensearchtype == foodsst && searchcategorytype){
      setState(() {
        page = 1;
      });

      return Scaffold(
        backgroundColor: colordtmainone,
        body:
        NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!isLoading && scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                _loadmoreuserproductcategories();
                setState(() {isLoading = true;});
                return true;
              }},child:    ListView.builder(
          itemBuilder: (context, index) {
            return index == 0 ? _searchBar() : searching == false ? Container(height: 0,width: 0,) : _listItemUserProductCategory(index-1);},
          itemCount: _userproductcategoriesForDisplay.length+1,
        )),

      );
    }
    if(chosensearchtype == groceryshoppingst&& searchcategorytype == false){
      setState(() {
        page = 1;
      });


      return Scaffold(
        backgroundColor: colordtmainone,
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              if (hidebar == false)SliverAppBar(
                floating: true,
                elevation: 10.0,
                backgroundColor: colordtmainone,
                title:Form(
                  child:TextFormField(
                    style: TextStyle(color: colordtmaintwo),
                    controller:_textfield,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      suffixIcon:  IconButton(
                        icon: Icon(
                          Icons.reorder,
                          color: colordtmaintwo,
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SearchFilterScreen(
                                )
                            ),
                          );
                        },
                      ),
                      icon: IconButton(
                        icon: Icon(Icons.search),
                        color:colordtmaintwo,
                        onPressed: () {
                          setState(() {
                            hidebar = true;
                          });
                        },
                      ),
                    ),
                    onChanged: (_textfield) {
                      setState(() {
                        globaltxt = _textfield.toLowerCase();
                        List<String> advicetags = _textfield.toLowerCase().split(',');
                        advices = TagSuggestion(advicetags.last.toLowerCase());
                      });
                      _textfield == '' ? setState(() {searching = false; }) : setState(() {searching = true;});
                      if (searchcategorytype) {
                        setState(() {
                          _userproductcategories = [];
                          _userproductcategoriesForDisplay = [];
                          SearchUserProductCategoriesNew2(page,_textfield.toLowerCase()).then((value) {setState(() {_userproductcategories.addAll(value);_userproductcategoriesForDisplay = _userproductcategories;});});
                        });
                      }
                  if (chosensearchtype == postst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,0,0,false,false
                              ,false,'',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });

                      }
                      else if (chosensearchtype == groceryshoppingst && searchcategorytype == false) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,
                              pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'UP',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == groceryshoppingst && searchcategorytype) {
                        setState(() {
                          _userproductcategories = [];
                          _userproductcategoriesForDisplay = [];
                          SearchUserProductCategoriesNew2(page,_textfield.toLowerCase()).then((value) {setState(() {_userproductcategories.addAll(value);_userproductcategoriesForDisplay = _userproductcategories;});});
                        });
                      }
                      else if (chosensearchtype == userproductsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,
                              searchbasedonlocation,priceactivated,true,'UP',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == userservicesst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),
                              tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'US',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});}); });
                      }
                      else if (chosensearchtype == calendareventsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),
                              tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'CE',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                      else if (chosensearchtype == calendaritemsst) {
                        setState(() {
                          _posts = [];
                          _postsForDisplay = [];
                          SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),
                              tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'CI',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                        });
                      }
                    },
                  ),
                ),
                toolbarHeight: 50,
                expandedHeight: 50,
                forceElevated: innerBoxIsScrolled,
              ),
              if (hidebar == true)SliverAppBar(
                floating: true,
                elevation: 0,
                backgroundColor: colordtmainone,
                toolbarHeight: 0,
                expandedHeight: 0,
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
          body:  PageView.builder(
            onPageChanged: (indexpage){
              if (indexpage + 1 == _postsForDisplay.length) {
                page = page +1;
                _loadmoreposts('UP');
              }
            },
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {

              return  _listItemUserProduct(index);},
            itemCount: _postsForDisplay.length,
          ),
        ),
      );
    }
    if(chosensearchtype == groceryshoppingst && searchcategorytype){
      setState(() {
        page = 1;
      });

      return Scaffold(
        backgroundColor: colordtmainone,
        body:
        NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!isLoading && scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                _loadmoreuserproductcategories();
                setState(() {isLoading = true;});
                return true;
              }},child:    ListView.builder(
          itemBuilder: (context, index) {
            return index == 0 ? _searchBar() : searching == false ? Container(height: 0,width: 0,) : _listItemUserProductCategory(index-1);},
          itemCount: _userproductcategoriesForDisplay.length+1,
        )),

      );
    }
    //  if(chosensearchtype == groupsearchst){
    //   if(done5 == false){done5 = true;SearchGroups().then((value) {setState(() {_groups.addAll(value);_groupsForDisplay = _groups;});});}
    //      return  Scaffold(  backgroundColor: colordtmainone, body:  ListView.builder(itemBuilder: (context, index) {return index == 0 ? _searchBar() : searching == false ? Container(height: 0,width: 0,) : _listItemGroup(index-1);}, itemCount: _groupsForDisplay.length+1,));}
  }

  List<String> TagSuggestion(String tag){
    String laptop = 'laptop';
    String laptopsize13inch = '13 inch';
    String laptopsize15inch = '15 inch';
    String laptopsize17inch = '17 inch';

    List<String> laptopsizes = ['13 Inch','15 Inch','17 Inch'];
    List<String> laptopbrands = ['Samsung','Apple','HP','Lenovo'];

    if (tag == laptop){return laptopsizes;}
    if (tag == laptopsize13inch){return laptopbrands;}
    if (tag == laptopsize15inch){return laptopbrands;}
    if (tag == laptopsize17inch){return laptopbrands;}
    else return [];
  }

  init(){
    if( locationcountrygl != ''){searchbasedonlocation = true;}
    if( locationcountrygl == ''){searchbasedonlocation = false;}
  }

  _searchBar(){
    init();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child:
      Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 0, vertical:   MediaQuery.of(context).size.width*0.015),
            decoration: BoxDecoration(
              color: colordtmainone,
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.015),
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
              padding: EdgeInsets.only(left :  MediaQuery.of(context).size.width*0.015),
              child:Form(
                child:TextFormField(
                  style: TextStyle(color: colordtmaintwo),
                  controller:_textfield,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    suffixIcon:  IconButton(
                      icon: Icon(
                        Icons.reorder,
                        color: colordtmaintwo,
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => SearchFilterScreen(
                              )
                          ),
                        );
                      },
                    ),
                    icon: Icon(
                      Icons.search,
                      color: colordtmaintwo,
                    ),
                  ),
                  onChanged: (_textfield) {
                    setState(() {
                      globaltxt = _textfield.toLowerCase();
                      List<String> advicetags = _textfield.toLowerCase().split(',');
                      advices = TagSuggestion(advicetags.last.toLowerCase());
                    });
                    _textfield == '' ? setState(() {searching = false; }) : setState(() {searching = true;});
                    //  else  if (chosensearchtype == groupsearchst) {setState(() {if(tagsearch){_groupsForDisplay = _groups.where((groupa){return doSearch(_textfield.toLowerCase().split(','),groupa.searchgrouptags(),groupa.origgrouptags(groupa),true);}).toList();}
                    //      if(tagsearch == false){_groupsForDisplay = _groups.where((group) {if(group.name.toLowerCase().contains(_textfield.toLowerCase())){group.name.toLowerCase().contains(_textfield.toLowerCase());};if(doSearch(_textfield.toLowerCase().split(','),group.searchgrouptags(),group.origgrouptags(group),true)){doSearch(_textfield.toLowerCase().split(','),group.searchgrouptags(),group.origgrouptags(group),true);};return false;}).toList();}});}
                    if (searchcategorytype) {
                      setState(() {
                        _userproductcategories = [];
                        _userproductcategoriesForDisplay = [];
                        SearchUserProductCategoriesNew2(page,_textfield.toLowerCase()).then((value) {setState(() {_userproductcategories.addAll(value);_userproductcategoriesForDisplay = _userproductcategories;});});
                      });
                    }
               if (chosensearchtype == postst) {
                      setState(() {
                        _posts = [];
                        _postsForDisplay = [];
                        SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,
                            searchbasedonlocation,priceactivated,false,'',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                      });

                    }
                    if (chosensearchtype == offersst) {
                      setState(() {
                        _posts = [];
                        _postsForDisplay = [];
                        SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow,pricehigh,
                            searchbasedonlocation,priceactivated,false,'OFFER',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                      });

                    }
                    else if (chosensearchtype == groceryshoppingst && searchcategorytype == false) {
                      setState(() {
                        _posts = [];
                        _postsForDisplay = [];
                        SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,pricelow
                            ,pricehigh,searchbasedonlocation,priceactivated,true,'UP',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                      });
                    }
                    else if (chosensearchtype == groceryshoppingst && searchcategorytype) {
                      setState(() {
                        _userproductcategories = [];
                        _userproductcategoriesForDisplay = [];
                        SearchUserProductCategoriesNew2(page,_textfield.toLowerCase(),).then((value) {setState(() {_userproductcategories.addAll(value);_userproductcategoriesForDisplay = _userproductcategories;});});
                      });
                    }
                    else if (chosensearchtype == userservicesst) {
                      setState(() {
                        _posts = [];
                        _postsForDisplay = [];
                        SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),
                            tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'US',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});  });
                    }
                    else if (chosensearchtype == calendareventsst) {
                      setState(() {
                        _posts = [];
                        _postsForDisplay = [];
                        SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),
                            tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'CE',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                      });
                    }
                    else if (chosensearchtype == reservationsst) {
                      setState(() {
                        _posts = [];
                        _postsForDisplay = [];
                        SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),
                            tagsearch,pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'R',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                      });
                    }
                    else if (chosensearchtype == calendaritemsst) {
                      setState(() {
                        _posts = [];
                        _postsForDisplay = [];
                        SearchArticlesInProfile(visiteduser.id,page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,
                            pricelow,pricehigh,searchbasedonlocation,priceactivated,true,'CI',user).then((value) {setState(() {_posts.addAll(value);_postsForDisplay = _posts;});});
                      });
                    }
                  },
                ),
              ),
            ),
          ),
          SizedBox(height:10),
          Tags(
              key: Tagstatekeys._tagStateKey1,
              columns: _column,
              itemCount: advices.length,
              itemBuilder: (i) {
                return ItemTags(
                  key: Key(i.toString()),
                  index: i,
                  onPressed: (tags){
                    setState(() {
                      _textfield.text = '${_textfield.text},${advices[i].toString()}';
                    });
                  },
                  title: advices[i].toString(),
                  color: Color(0xFFEEEEEE),
                  activeColor: Color(0xFFEEEEEE),
                  textActiveColor: colordtmaintwo,
                  textStyle: TextStyle(
                    fontSize: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02, color: colordtmaintwo,),
                );}),
        ],
      ),

    );
  }

  _listItemUserProductCategory(index) {


    bool cond(User owner){
      //  if(crowdlevel(owner.intensity) == false){return false;}

      if(owner.business_type == null || owner.business_type == ''){

        return false;}


      if(chosensearchtype == groceryshoppingst && owner.business_type.substring(0,15) == 'GroceryShopping') {

        return true;
      }
      if(chosensearchtype == groceryshoppingst && owner.business_type.substring(0,15) == 'GroceryShopping') {

        return true;
      }
      if(chosensearchtype == foodsst && owner.business_type.substring(0,10) == 'Restaurant' && restauranttypesearch == 'A'){
        return true;
      }

      if(chosensearchtype == foodsst && owner.business_type.substring(0,10) == 'Restaurant'
          && restauranttypesearch == owner.business_type.substring(11,12)
      ) {

        return true;
      }

      return false;
    }

    return FutureBuilder<User>(
        future: callUser(_userproductcategoriesForDisplay[index].author),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData ?
          (cond(snapshot.data) ? Center(
            child: Container(
              height: MediaQuery.of(context).size.height*0.3,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  InkWell(
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(_userproductcategoriesForDisplay[index].image?.isEmpty ?? true ? 'https://www.theladders.com/wp-content/uploads/shopping_190514.jpg' : _userproductcategoriesForDisplay[index].image),
                    ),
                    onTap:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => UserProductScreen(
                              user:user,
                              category:_userproductcategoriesForDisplay[index].id,
                            )
                        ),
                      );
                    },
                    onLongPress: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DeleteThingScreen(
                              category:'UPC',
                              id:_userproductcategoriesForDisplay[index].id,
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
                          _userproductcategoriesForDisplay[index].category,
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

          ) : Container(width:0,height:0) ) :
          Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
        });

  }
  
  _listItemReservation(index) {
    bool cond(User owner){
      if(crowdlevel(owner.intensity) == false) {return false;}
      if(searchhotelclass && owner.hotelclass < int.parse(hotelclasssearchgl)) {return false;}
      if(searchbasedonlocation){if(checklocationvalidity(_postsForDisplay[index].locationcountry,_postsForDisplay[index].locationstate,_postsForDisplay[index].locationcity) == false) {return false;}}
      if(searchbedbath && (   _postsForDisplay[index].bedrooms < int.parse(bedroomsearchgl) || _postsForDisplay[index].bathrooms < int.parse(bathroomsearchgl))){return false;}
      if(searchadultkid && (_postsForDisplay[index].adults < int.parse(adultsearchgl) || _postsForDisplay[index].kids < int.parse(kidsearchgl))) {return false;}
      if(checklocationvalidity(_postsForDisplay[index].locationcountry,_postsForDisplay[index].locationstate,_postsForDisplay[index].locationcity) == false) {return false;}
      if(priceactivated){if(_postsForDisplay[index].price> pricehigh){return false;}if(_postsForDisplay[index].price < pricelow ){return false;}}
      if(searchbydate){if(searchdate != _postsForDisplay[index].date){return false;}}
      return true;
    }

    return FutureBuilder<User>(
        future: callUser(_postsForDisplay[index].author),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData ?
          (cond(snapshot.data) ? ArticleWidgetScreen(user:user,post:_postsForDisplay[index],ischosing:false) : Container(width:0,height:0) ) :
          Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
        });
  }

  _listItemUserService(index) {
    bool cond(User owner){
      if(crowdlevel(owner.intensity) == false) {return false;}
      if(searchbasedonlocation){if(checklocationvalidity(_postsForDisplay[index].locationcountry,_postsForDisplay[index].locationstate,_postsForDisplay[index].locationcity) == false) {return false;}}
      if(searchbedbath && (   _postsForDisplay[index].bedrooms < int.parse(bedroomsearchgl) || _postsForDisplay[index].bathrooms < int.parse(bathroomsearchgl))){return false;}
      if(searchadultkid && (_postsForDisplay[index].adults < int.parse(adultsearchgl) || _postsForDisplay[index].kids < int.parse(kidsearchgl))) {return false;}
      if(checklocationvalidity(_postsForDisplay[index].locationcountry,_postsForDisplay[index].locationstate,_postsForDisplay[index].locationcity) == false) {return false;}
      if(priceactivated){if(_postsForDisplay[index].price> pricehigh){return false;}if(_postsForDisplay[index].price < pricelow ){return false;}}
      if(searchbydate){if(searchdate != _postsForDisplay[index].date){return false;}}
      return true;
    }


    return FutureBuilder<User>(
        future: callUser(_postsForDisplay[index].author),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData ?
          (cond(snapshot.data) ? ArticleWidgetScreen(user:user,post:_postsForDisplay[index],ischosing:false) : Container(width:0,height:0) ) :
          Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
        });
  }

  _listItemCalendarEvent(index) {
    bool cond(User owner){
      if(crowdlevel(owner.intensity) == false) {return false;}
      if(searchbasedonlocation){if(checklocationvalidity(_postsForDisplay[index].locationcountry,_postsForDisplay[index].locationstate,_postsForDisplay[index].locationcity) == false) {return false;}}
      if(searchbedbath && (   _postsForDisplay[index].bedrooms < int.parse(bedroomsearchgl) || _postsForDisplay[index].bathrooms < int.parse(bathroomsearchgl))){return false;}
      if(searchadultkid && (_postsForDisplay[index].adults < int.parse(adultsearchgl) || _postsForDisplay[index].kids < int.parse(kidsearchgl))) {return false;}
      if(checklocationvalidity(_postsForDisplay[index].locationcountry,_postsForDisplay[index].locationstate,_postsForDisplay[index].locationcity) == false) {return false;}
      if(priceactivated){if(_postsForDisplay[index].price> pricehigh){return false;}if(_postsForDisplay[index].price < pricelow ){return false;}}
      if(searchbydate){if(searchdate != _postsForDisplay[index].date){return false;}}
      return true;
    }

    return FutureBuilder<User>(
        future: callUser(_postsForDisplay[index].author),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData ?
          (cond(snapshot.data) ? ArticleWidgetScreen(user:user,post:_postsForDisplay[index],ischosing:false) : Container(width:0,height:0) ) :
          Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
        });
  }

  _listItemUserProduct(index) {
    bool cond(User owner){

      if(crowdlevel(owner.intensity) == false) {return false;}
      if(searchbasedonlocation){if(checklocationvalidity(_postsForDisplay[index].locationcountry,_postsForDisplay[index].locationstate,_postsForDisplay[index].locationcity) == false) {return false;}}
      if(searchbedbath && (   _postsForDisplay[index].bedrooms < int.parse(bedroomsearchgl) || _postsForDisplay[index].bathrooms < int.parse(bathroomsearchgl))){print('remove');return false;}
      if(searchadultkid && (_postsForDisplay[index].adults < int.parse(adultsearchgl) || _postsForDisplay[index].kids < int.parse(kidsearchgl))) {return false;}
      if(checklocationvalidity(_postsForDisplay[index].locationcountry,_postsForDisplay[index].locationstate,_postsForDisplay[index].locationcity) == false) {return false;}
      if(priceactivated){if(_postsForDisplay[index].price> pricehigh){return false;}if(_postsForDisplay[index].price < pricelow ){return false;}}
      if(searchbydate){if(searchdate != _postsForDisplay[index].date){return false;}}

      if(chosensearchtype == groceryshoppingst && owner.business_type.substring(0,15) == 'GroceryShopping') {

        return true;
      }
      if(chosensearchtype == groceryshoppingst && owner.business_type.substring(0,15) == 'GroceryShopping') {

        return true;
      }
      if(chosensearchtype == foodsst && owner.business_type.substring(0,10) == 'Restaurant' && restauranttypesearch == 'A'){
        return true;
      }

      if(chosensearchtype == foodsst && owner.business_type.substring(0,10) == 'Restaurant'
          && restauranttypesearch == owner.business_type.substring(11,12)
      ) {

        return true;
      }
      if(chosensearchtype == userproductsst) {
        return true;
      }
      if(owner.business_type == null || owner.business_type == ''){

        return false;
      }
      return false;
    }

    return FutureBuilder<User>(
        future: callUser(_postsForDisplay[index].author),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData ?
          (cond(snapshot.data) ? ArticleWidgetScreen(user:user,post:_postsForDisplay[index],ischosing:false) : Container(width:0,height:0) ) :
          Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
        });

  }

  _listItemPost(index) {

    return ArticleWidgetScreen(user:user,post:_postsForDisplay[index],ischosing:false);
  }

  _listItemjobPost(index) {

    return _postsForDisplay[index].isjobposting == true ? ArticleWidgetScreen(user:user,post:_postsForDisplay[index],ischosing:false) : Container(height: 0,width: 0,);
  }

  _listItemCalendarItem(index) {
    //
    bool cond(User owner){
      if(crowdlevel(owner.intensity) == false) {return false;}
      if(searchbasedonlocation){if(checklocationvalidity(_postsForDisplay[index].locationcountry,_postsForDisplay[index].locationstate,_postsForDisplay[index].locationcity) == false) {return false;}}
      if(searchbedbath && (   _postsForDisplay[index].bedrooms < int.parse(bedroomsearchgl) || _postsForDisplay[index].bathrooms < int.parse(bathroomsearchgl))){return false;}
      if(searchadultkid && (_postsForDisplay[index].adults < int.parse(adultsearchgl) || _postsForDisplay[index].kids < int.parse(kidsearchgl))) {return false;}
      if(checklocationvalidity(_postsForDisplay[index].locationcountry,_postsForDisplay[index].locationstate,_postsForDisplay[index].locationcity) == false) {return false;}
      if(priceactivated){if(_postsForDisplay[index].price> pricehigh){return false;}if(_postsForDisplay[index].price < pricelow ){return false;}}
      if(searchbydate){if(searchdate != _postsForDisplay[index].date){return false;}}
      return true;
    }

    return FutureBuilder<User>(
        future: callUser(_postsForDisplay[index].author),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData ?
          (cond(snapshot.data) ? ArticleWidgetScreen(user:user,post:_postsForDisplay[index],ischosing:false
            ,dayhere: searchday,mnyhere: searchmny,
          ) : Container(width:0,height:0) ) :
          Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
        });
  }

  @override
  Future<User> callUser(String userid) async {
    Future<User> _user = FetchPublicUser(userid);
    return _user;
  }


  @override
  Widget build(BuildContext context) {return SearchScreen();}


}

class ProfileSearchFilterScreen extends StatefulWidget {
  final User user;
  final User visiteduser;
  const ProfileSearchFilterScreen({Key key,this.visiteduser, this.user}) : super(key: key);

  @override
  ProfileSearchFilterScreenState createState() => ProfileSearchFilterScreenState(user: user,visiteduser:visiteduser,key:key);
}

class ProfileSearchFilterScreenState extends State<ProfileSearchFilterScreen> {
  final User user;
  final User visiteduser;
  ProfileSearchFilterScreenState({Key key,this.user,this.visiteduser,});
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


  var _textfield = TextEditingController();
  var pricelowinit = TextEditingController();
  var pricehighinit = TextEditingController();
  int _column = 0;

  var bedroominit= TextEditingController(text:'-');
  var bathroominit= TextEditingController(text:'-');
  var adultinit= TextEditingController(text:'-');
  var kidinit= TextEditingController(text:'-');
  var hotelclassinit= TextEditingController(text:'-');

  List<String> advices = [];
  List<String> matchedtags = [];
  List<String> excludedtags = [];
  bool tagsearch = false;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  List<User> searchusers = [];

  Widget chosensearchtypecrowdness(){
    if(chosensearchtype == calendaritemsst){
      return ListTile(
        title: Text(crowdnesssearchst, style:TextStyle(color:colordtmaintwo,fontWeight:FontWeight.bold,fontSize:MediaQuery.of(context).size.height*0.02,),),
        trailing:   IconButton(
          icon: Icon(Icons.calendar_today_outlined),
          iconSize: 30.0,
          color: colordtmaintwo,
          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChangeStatusScreen(
                  user: user,
                ),
              ),
            );
          },
        ),
      );
    }
    else if(chosensearchtype == calendareventsst){
      return ListTile(
        title: Text(crowdnesssearchst, style:TextStyle(color:colordtmaintwo,fontWeight:FontWeight.bold,fontSize:MediaQuery.of(context).size.height*0.02,),),
        trailing:   IconButton(
          icon: Icon(Icons.calendar_today_outlined),
          iconSize: 30.0,
          color: colordtmaintwo,
          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChangeStatusScreen(
                  user: user,
                ),
              ),
            );
          },
        ),
      );
    }
    else if(chosensearchtype == userproductsst){
      return ListTile(
        title: Text(crowdnesssearchst, style:TextStyle(color:colordtmaintwo,fontWeight:FontWeight.bold,fontSize:MediaQuery.of(context).size.height*0.02,),),
        trailing:   IconButton(
          icon: Icon(Icons.calendar_today_outlined),
          iconSize: 30.0,
          color: colordtmaintwo,
          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChangeStatusScreen(
                  user: user,
                ),
              ),
            );
          },
        ),
      );
    }
    else if(chosensearchtype == foodsst && searchcategorytype == false){
      return ListTile(
        title: Text(crowdnesssearchst, style:TextStyle(color:colordtmaintwo,fontWeight:FontWeight.bold,fontSize:MediaQuery.of(context).size.height*0.02,),),
        trailing:   IconButton(
          icon: Icon(Icons.calendar_today_outlined),
          iconSize: 30.0,
          color: colordtmaintwo,
          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChangeStatusScreen(
                  user: user,
                ),
              ),
            );
          },
        ),
      );
    }
    else if(chosensearchtype == groceryshoppingst && searchcategorytype == false){
      return ListTile(
        title: Text(crowdnesssearchst, style:TextStyle(color:colordtmaintwo,fontWeight:FontWeight.bold,fontSize:MediaQuery.of(context).size.height*0.02,),),
        trailing:   IconButton(
          icon: Icon(Icons.calendar_today_outlined),
          iconSize: 30.0,
          color: colordtmaintwo,
          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChangeStatusScreen(
                  user: user,
                ),
              ),
            );
          },
        ),
      );
    }
    return Container(height: 0,width: 0,);
  }

  Widget chosensearchtypeprice(){
    if(chosensearchtype == calendaritemsst){
      return Row(
        children: <Widget>[
          Flexible(
            child: TextFormField(

              style: TextStyle(color: colordtmaintwo),
              controller:  pricelowinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: minimumst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ) ,
          ),
          Flexible(
            child: TextFormField(
              style: TextStyle(color: colordtmaintwo),
              controller:  pricehighinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: maximumst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ),
          ),
        ],
      );
    }
    else if(chosensearchtype == calendareventsst){
      return Row(
        children: <Widget>[



          Flexible(
            child: TextFormField(

              style: TextStyle(color: colordtmaintwo),
              controller:  pricelowinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: minimumst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ) ,
          ),
          Flexible(
            child: TextFormField(
              style: TextStyle(color: colordtmaintwo),
              controller:  pricehighinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: maximumst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ),
          ),
        ],
      );
    }
    else if(chosensearchtype == userproductsst){
      return Row(
        children: <Widget>[



          Flexible(
            child: TextFormField(

              style: TextStyle(color: colordtmaintwo),
              controller:  pricelowinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: minimumst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ) ,
          ),
          Flexible(
            child: TextFormField(
              style: TextStyle(color: colordtmaintwo),
              controller:  pricehighinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: maximumst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ),
          ),
        ],
      );
    }
    else if(chosensearchtype == reservationsst){
      return Row(
        children: <Widget>[



          Flexible(
            child: TextFormField(

              style: TextStyle(color: colordtmaintwo),
              controller:  pricelowinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: minimumst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ) ,
          ),
          Flexible(
            child: TextFormField(
              style: TextStyle(color: colordtmaintwo),
              controller:  pricehighinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: maximumst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ),
          ),
        ],
      );
    }
    else if(chosensearchtype == userservicesst){
      return Row(
        children: <Widget>[



          Flexible(
            child: TextFormField(

              style: TextStyle(color: colordtmaintwo),
              controller:  pricelowinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: minimumst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ) ,
          ),
          Flexible(
            child: TextFormField(
              style: TextStyle(color: colordtmaintwo),
              controller:  pricehighinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: maximumst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ),
          ),
        ],
      );
    }
    else if(chosensearchtype == foodsst && searchcategorytype == false){
      return Row(
        children: <Widget>[



          Flexible(
            child: TextFormField(

              style: TextStyle(color: colordtmaintwo),
              controller:  pricelowinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: minimumst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ) ,
          ),
          Flexible(
            child: TextFormField(
              style: TextStyle(color: colordtmaintwo),
              controller:  pricehighinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: maximumst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ),
          ),
        ],
      );
    }
    else if(chosensearchtype == groceryshoppingst && searchcategorytype == false){
      return Row(
        children: <Widget>[



          Flexible(
            child: TextFormField(

              style: TextStyle(color: colordtmaintwo),
              controller:  pricelowinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: minimumst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ) ,
          ),
          Flexible(
            child: TextFormField(
              style: TextStyle(color: colordtmaintwo),
              controller:  pricehighinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: maximumst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ),
          ),
        ],
      );
    }
    return Container(height: 0,width: 0,);
  }

  Widget chosensearchtypehotelclass(){

    if(chosensearchtype == reservationsst){
      return Row(
        children: <Widget>[
          Flexible(
            child: TextFormField(

              style: TextStyle(color: colordtmaintwo),
              controller:  hotelclassinit ,
              maxLength: 1,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: hotelclassst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ) ,
          ),
        ],
      );
    }

    return Container(height: 0,width: 0,);
  }

  Widget chosensearchtyperealestate(){
    if(chosensearchtype == userproductsst){
      return Row(
        children: <Widget>[
          Flexible(
            child: TextFormField(

              style: TextStyle(color: colordtmaintwo),
              controller:  bedroominit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: bedroomsst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ) ,
          ),
          Flexible(
            child: TextFormField(
              style: TextStyle(color: colordtmaintwo),
              controller:  bathroominit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: bathroomsst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ),
          ),
        ],
      );
    }
    else if(chosensearchtype == reservationsst){
      return Row(
        children: <Widget>[
          Flexible(
            child: TextFormField(

              style: TextStyle(color: colordtmaintwo),
              controller:  bedroominit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: bedroomsst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ) ,
          ),
          Flexible(
            child: TextFormField(
              style: TextStyle(color: colordtmaintwo),
              controller:  bathroominit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: bathroomsst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ),
          ),
        ],
      );
    }

    return Container(height: 0,width: 0,);
  }

  Widget chosensearchtypeadultskids(){
    if(chosensearchtype == calendaritemsst){
      return Row(
        children: <Widget>[
          Flexible(
            child: TextFormField(

              style: TextStyle(color: colordtmaintwo),
              controller:  adultinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: adultsst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ) ,
          ),
          Flexible(
            child: TextFormField(
              style: TextStyle(color: colordtmaintwo),
              controller:  kidinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: kidsst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ),
          ),
        ],
      );
    }
    else if(chosensearchtype == calendareventsst){
      return Row(
        children: <Widget>[
          Flexible(
            child: TextFormField(

              style: TextStyle(color: colordtmaintwo),
              controller:  adultinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: adultsst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ) ,
          ),
          Flexible(
            child: TextFormField(
              style: TextStyle(color: colordtmaintwo),
              controller:  kidinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: kidsst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ),
          ),
        ],
      );
    }
    else if(chosensearchtype == userproductsst){
      return Row(
        children: <Widget>[
          Flexible(
            child: TextFormField(

              style: TextStyle(color: colordtmaintwo),
              controller:  adultinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: adultsst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ) ,
          ),
          Flexible(
            child: TextFormField(
              style: TextStyle(color: colordtmaintwo),
              controller:  kidinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: kidsst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ),
          ),
        ],
      );
    }
    else if(chosensearchtype == reservationsst){
      return Row(
        children: <Widget>[
          Flexible(
            child: TextFormField(

              style: TextStyle(color: colordtmaintwo),
              controller:  adultinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: adultsst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ) ,
          ),
          Flexible(
            child: TextFormField(
              style: TextStyle(color: colordtmaintwo),
              controller:  kidinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: kidsst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ),
          ),
        ],
      );
    }
    else if(chosensearchtype == userservicesst){
      return Row(
        children: <Widget>[
          Flexible(
            child: TextFormField(

              style: TextStyle(color: colordtmaintwo),
              controller:  adultinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: adultsst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ) ,
          ),
          Flexible(
            child: TextFormField(
              style: TextStyle(color: colordtmaintwo),
              controller:  kidinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: kidsst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ),
          ),
        ],
      );
    }
    else if(chosensearchtype == foodsst && searchcategorytype == false){
      return Row(
        children: <Widget>[
          Flexible(
            child: TextFormField(

              style: TextStyle(color: colordtmaintwo),
              controller:  adultinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: adultsst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ) ,
          ),
          Flexible(
            child: TextFormField(
              style: TextStyle(color: colordtmaintwo),
              controller:  kidinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: kidsst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ),
          ),
        ],
      );
    }
    else if(chosensearchtype == groceryshoppingst && searchcategorytype == false){
      return Row(
        children: <Widget>[
          Flexible(
            child: TextFormField(

              style: TextStyle(color: colordtmaintwo),
              controller:  adultinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: adultsst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ) ,
          ),
          Flexible(
            child: TextFormField(
              style: TextStyle(color: colordtmaintwo),
              controller:  kidinit ,
              maxLength: 15,keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,

                hintText: kidsst,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
              ),
            ),
          ),
        ],
      );
    }
    return Container(height: 0,width: 0,);
  }

  Widget chosensearchtypedate(){

    if(chosensearchtype == calendaritemsst){
      return ListTile(
        title: Text(choosedatest, style:TextStyle(color:colordtmaintwo,fontWeight:FontWeight.bold,fontSize:MediaQuery.of(context).size.height*0.02,),),
        trailing:   IconButton(
          icon: Icon(Icons.calendar_today_outlined),
          iconSize: 30.0,
          color: colordtmaintwo,
          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CalendarSearch(
                  user: user,
                ),
              ),
            );
          },
        ),
      );

    }
    else if(chosensearchtype == calendareventsst){

      return ListTile(
        title: Text(choosedatest, style:TextStyle(color:colordtmaintwo,fontSize:MediaQuery.of(context).size.height*0.02,),),
        trailing:   IconButton(
          icon: Icon(Icons.calendar_today_outlined),
          iconSize: 30.0,
          color: colordtmaintwo,
          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CalendarSearch(
                  user: user,
                ),
              ),
            );
          },
        ),
      );
    }

    return Container(height: 0,width: 0,);
  }

  Widget chosensearchtyperestaurant(){

    if(chosensearchtype == businessst && chosensearchtype2 == restaurantst){
      return ListTile(
        title: Text(chooserestauranttypest, style:TextStyle(color:colordtmaintwo,fontWeight:FontWeight.bold,fontSize:MediaQuery.of(context).size.height*0.02,),),
        trailing:   IconButton(
          icon: Icon(Icons.fastfood_sharp),
          iconSize: 30.0,
          color: colordtmaintwo,
          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SearchRestaurantTypeScreen(
                  user: user,category: '',
                ),
              ),
            );
          },
        ),
      );

    }
    if(chosensearchtype == foodsst){
      return ListTile(
        title: Text(chooserestauranttypest, style:TextStyle(color:colordtmaintwo,fontWeight:FontWeight.bold,fontSize:MediaQuery.of(context).size.height*0.02,),),
        trailing:   IconButton(
          icon: Icon(Icons.fastfood_sharp),
          iconSize: 30.0,
          color: colordtmaintwo,
          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SearchRestaurantTypeScreen(
                  user: user,category: '',
                ),
              ),
            );
          },
        ),
      );

    }

    return Container(height: 0,width: 0,);
  }

  Widget chosensearchtypecategory(){

    if(chosensearchtype == foodsst ||chosensearchtype == groceryshoppingst){
      return CheckboxListTile(
        title:  Text(choosebycataloguest,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.bold)),
        value: searchcategorytype, onChanged: (bool value) {
        setState(() {
          searchcategorytype = value;
        });},);
    }
    return Container(height: 0,width: 0,);
  }


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
                if(chosensearchtype == foodsst || chosensearchtype2 == restaurantst)  Row(
                    children: <Widget>[


                      Text(restauranttypest,style:TextStyle(fontWeight:  FontWeight.bold,fontSize: 20)),

                      Expanded(
                          child: Divider()
                      ),


                    ]
                ),
                chosensearchtyperestaurant(),

                if(chosensearchtype == foodsst || chosensearchtype2 == groceryshoppingst)  Row(
                    children: <Widget>[


                      Text(bycataloguest,style:TextStyle(fontWeight:  FontWeight.bold,fontSize: 20)),

                      Expanded(
                          child: Divider()
                      ),


                    ]
                ),
                chosensearchtypecategory(),

                if(chosensearchtype == calendaritemsst || chosensearchtype == calendareventsst)  Row(
                    children: <Widget>[


                      Text(date2st,style:TextStyle(fontWeight:  FontWeight.bold,fontSize: 20)),

                      Expanded(
                          child: Divider()
                      ),


                    ]
                ),
                chosensearchtypedate(),

                if(chosensearchtype == calendaritemsst ||  chosensearchtype == calendareventsst  || chosensearchtype == groceryshoppingst|| chosensearchtype == userproductsst ||  chosensearchtype == foodsst)
                  Row(
                      children: <Widget>[


                        Text(crowdnessst,style:TextStyle(fontWeight:  FontWeight.bold,fontSize: 20)),

                        Expanded(
                            child: Divider()
                        ),
                      ]
                  ),
                chosensearchtypecrowdness(),

                if(chosensearchtype == calendaritemsst || chosensearchtype == reservationsst || chosensearchtype == calendareventsst  || chosensearchtype == groceryshoppingst|| chosensearchtype == userproductsst || chosensearchtype == userservicesst || chosensearchtype == foodsst)
                  Row(
                      children: <Widget>[


                        Text(adultsandkidsst,style:TextStyle(fontWeight:  FontWeight.bold,fontSize: 20)),

                        Expanded(
                            child: Divider()
                        ),
                      ]
                  ),
                chosensearchtypeadultskids(),

                if( chosensearchtype == reservationsst)
                  Row(
                      children: <Widget>[


                        Text(hotelclassst,style:TextStyle(fontWeight:  FontWeight.bold,fontSize: 20)),

                        Expanded(
                            child: Divider()
                        ),
                      ]
                  ),
                chosensearchtypehotelclass(),

                if( chosensearchtype == reservationsst || chosensearchtype == userproductsst)
                  Row(
                      children: <Widget>[


                        Text(bedroomsandbathroomsst,style:TextStyle(fontWeight:  FontWeight.bold,fontSize: 20)),

                        Expanded(
                            child: Divider()
                        ),
                      ]
                  ),
                chosensearchtyperealestate(),

                if(chosensearchtype == calendaritemsst || chosensearchtype == reservationsst || chosensearchtype == calendareventsst  || chosensearchtype == groceryshoppingst|| chosensearchtype == userproductsst || chosensearchtype == userservicesst || chosensearchtype == foodsst)
                  Row(
                      children: <Widget>[


                        Text(pricest,style:TextStyle(fontWeight:  FontWeight.bold,fontSize: 20)),

                        Expanded(
                            child: Divider()
                        ),
                      ]
                  ),
                chosensearchtypeprice(),

                Row(
                    children: <Widget>[


                      Text(locationst,style:TextStyle(fontWeight:  FontWeight.bold,fontSize: 20)),

                      Expanded(
                          child: Divider()
                      ),
                    ]
                ),
                ListTile(
                  title: Text(chooselocationst, style:TextStyle(color:colordtmaintwo,fontSize:MediaQuery.of(context).size.height*0.02,),),
                  trailing:   IconButton(
                    icon: Icon(Icons.location_on),
                    iconSize: 30.0,
                    color: colordtmaintwo,
                    onPressed: () {

                      ChooseLocation(context);
                    },
                  ),
                ),


                SizedBox(height:50),
                SizedBox(

                  width:MediaQuery.of(context).size.width*0.4 ,height:MediaQuery.of(context).size.height*0.06,
                  child: ElevatedButton(
                    child: Text(donest,
                      style:TextStyle(
                        fontSize:MediaQuery.of(context).size.height*0.025,
                      ),),

                    onPressed: (){
                      if(isstringnullsearch(searchdate) == false){
                        searchbydate = true;
                      }
                      if(isstringnullsearch(searchdate)){
                        searchbydate = false;
                      }
                      if(isstringnullsearch(adultinit.text) == false){
                        searchadultkid = true;

                        adultsearchgl = adultinit.text;
                        kidsearchgl = kidinit.text;
                      }
                      if(isstringnullsearch(adultinit.text)){
                        searchadultkid = false;
                      }
                      if(isstringnullsearch(bedroominit.text) == false){
                        searchbedbath = true;
                        bedroomsearchgl = bedroominit.text;
                        bathroomsearchgl = bathroominit.text;
                      }
                      if(isstringnullsearch(bedroominit.text)){
                        searchbedbath = false;
                      }
                      if(isstringnullsearch(hotelclassinit.text) == false){
                        searchhotelclass = true;
                        hotelclasssearchgl = hotelclassinit.text;
                      }
                      if(isstringnullsearch(hotelclassinit.text)){
                        searchhotelclass = false;
                      }
                      if(isstringnullsearch(pricelowinit.text) == false && isstringnullsearch(pricehighinit.text) == false){
                        priceactivated = true;
                        pricelow = int.parse(pricelowinit.text);
                        pricehigh = int.parse(pricehighinit.text);
                      }
                      if(isstringnullsearch(pricelowinit.text) && isstringnullsearch(pricehighinit.text)){
                        priceactivated = false;
                        pricelow = 0;
                        pricehigh = 0;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProfileSearchScreen(
                              user:user,visiteduser: visiteduser,
                            )
                        ),
                      );

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