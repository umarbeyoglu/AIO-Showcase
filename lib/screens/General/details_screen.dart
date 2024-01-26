import 'dart:io';
import 'package:Welpie/language.dart';
import 'package:Welpie/models/User_Model/user_calendar_item_model.dart';
import 'package:Welpie/models/User_Model/user_model.dart';
import 'package:Welpie/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../colors.dart';
import '../../models/Article_Model/article_model.dart';
import '../../models/Article_Model/article_tagged_user_model.dart';
import 'home_screen.dart';



class Tagstatekeys {
  static final _tagStateKey1 = const Key('__TSK1__');
  static final _tagStateKey2 = const Key('__TSK2__');
}

class DetailsScreen extends StatefulWidget {
  final Article article;
  final User user;
  final String details;
  final List<String> articletags;
  final List<ArticleTaggedUser> usertags;
  const DetailsScreen({Key key,this.user,this.usertags,this.articletags,this.details,this.article}) : super(key : key);

  @override
  DetailsScreenState createState() => DetailsScreenState(user : user,articletags:articletags,article:article,usertags:usertags,details:details);
}

class DetailsScreenState extends State<DetailsScreen> {
  final Article article;
  final String details;
  final User user;
  final List<String> articletags;
  final List<ArticleTaggedUser> usertags;
  DetailsScreenState({Key key, this.user,this.article,this.usertags,this.articletags,this.details});
  int _column = 0;
  int _column2 = 0;
  bool activnull = false;



  @override
  Future<User> callUser(String userid) async {
    Future<User> _user = FetchUser(userid);
    return _user;
  }

  initdetailspecs(){
    print('${article.detailcategories.length} ${article.detailspecs.length}');
    for(int i=0;i<article.detailcategories.length;i++){
    for(int i2=0;i2<article.detailspecs.length;i2++) {
      if(article.detailcategories[i].category == article.detailspecs[i2].category){
      //  article.detailcategories[i].specs2.add(article.detailspecs[i2]);
      }
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    initdetailspecs();
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
                          padding: EdgeInsets.only(
                              bottom: mediaQuery.size.height - mediaQuery.size.height / 1.1 +
                                  16.0),
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[


                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    SizedBox(height: MediaQuery.of(context).size.height *0.03),

                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        '$pricecurrencyst: ${article.pricecurrency}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        '$deliverytimest: ${article.deliveredfromtime}-${article.deliveredtotime}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        '$deliverytimest: ${article.deliveredfromtime}-${article.deliveredtotime}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        '$bedroomsst: ${article.bedrooms}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        '$bathroomsst: ${article.bathrooms}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        '$adultsst: ${article.adults}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        '$kidsst: ${article.kids}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),


                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        '$checkintimest: ${article.checkintime}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        '$checkouttimest: ${article.checkouttime}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        '$startdatest: ${article.startdate}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        '$enddatest: ${article.enddate}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        details,
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        '$specialinstructionsst : ${article.specialinstructions}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        '$guidest : ${article.guide}',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),

                                    for(final item in article.detailcategories)
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context).size.width* 0.043,
                                          vertical: 0,
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              '-${item.category.toUpperCase()}',
                                              style: TextStyle(
                                                fontSize:  MediaQuery.of(context).size.width*0.043,
                                                color:colordtmaintwo,
                                                fontWeight: FontWeight.bold,

                                              ),
                                            ),
                                          //  for(final item2 in item.specs2)Text('-${item2.spec}', style: TextStyle(fontSize:  MediaQuery.of(context).size.width*0.043, color:colordtmaintwo, fontWeight: FontWeight.w500,),),
                                            SizedBox(height: MediaQuery.of(context).size.height *0.03),
                                          ],
                                        ),
                                      ),
                                    SizedBox(height: MediaQuery.of(context).size.height *0.03),




                                    if( article.activities?.isNotEmpty)   Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        '$activitiesst :',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),
                                    if(article.activities?.isNotEmpty)
                                      for(final item in article.activities)
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context).size.width* 0.043,
                                            vertical: 0,
                                          ),
                                          child: Text(
                                            item.activity,
                                            style: TextStyle(
                                              fontSize:  MediaQuery.of(context).size.width*0.043,
                                              color:colordtmaintwo,
                                              fontWeight: FontWeight.w500,

                                            ),
                                          ),
                                        ),
                                    SizedBox(height: MediaQuery.of(context).size.height *0.03),

                                    if(article.detailincludeds.isNotEmpty)   Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        '$includedst :',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),
                        for(final item in article.detailincludeds)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width* 0.043,
                              vertical: 0,
                            ),
                            child: Text(
                              item.included,
                              style: TextStyle(
                                fontSize:  MediaQuery.of(context).size.width*0.043,
                                color:colordtmaintwo,
                                fontWeight: FontWeight.w500,

                              ),
                            ),
                          ),
                                    SizedBox(height: MediaQuery.of(context).size.height *0.03),

                                    if(article.detailrules.isNotEmpty)   Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        '$rulesst :',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),
                        for(final item in article.detailrules)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width* 0.043,
                              vertical: 0,
                            ),
                            child: Text(
                              item.rule,
                              style: TextStyle(
                                fontSize:  MediaQuery.of(context).size.width*0.043,
                                color:colordtmaintwo,
                                fontWeight: FontWeight.w500,

                              ),
                            ),
                          ),
                                    SizedBox(height: MediaQuery.of(context).size.height *0.03),

                                    if(article.detailamenities.isNotEmpty)   Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        '$amenitiesst :',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),
                                        for(final item in article.detailamenities)
                                           Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width* 0.043,
                              vertical: 0,
                            ),
                            child: Text(
                              item.amenity,
                              style: TextStyle(
                                fontSize:  MediaQuery.of(context).size.width*0.043,
                                color:colordtmaintwo,
                                fontWeight: FontWeight.w500,

                              ),
                            ),
                          ),
                                    SizedBox(height: MediaQuery.of(context).size.height *0.03),

                                    if(article.highlights.isNotEmpty)   Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        '$highlightsst :',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),
                        for(final item in article.highlights)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width* 0.043,
                              vertical: 0,
                            ),
                            child: Text(
                              item.highlight,
                              style: TextStyle(
                                fontSize:  MediaQuery.of(context).size.width*0.043,
                                color:colordtmaintwo,
                                fontWeight: FontWeight.w500,

                              ),
                            ),
                          ),
                                    SizedBox(height: MediaQuery.of(context).size.height *0.03),

                                    if(article.travellocations.isNotEmpty)   Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width* 0.043,
                                        vertical: 0,
                                      ),
                                      child: Text(
                                        '$travellocationsst :',
                                        style: TextStyle(
                                          fontSize:  MediaQuery.of(context).size.width*0.043,
                                          color:colordtmaintwo,
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),
                        for(final item in article.travellocations)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width* 0.043,
                              vertical: 0,
                            ),
                            child: Text(
                              item.location,
                              style: TextStyle(
                                fontSize:  MediaQuery.of(context).size.width*0.043,
                                color:colordtmaintwo,
                                fontWeight: FontWeight.w500,

                              ),
                            ),
                          ),
                                    SizedBox(height: MediaQuery.of(context).size.height *0.03),

                        SizedBox(height: MediaQuery.of(context).size.height *0.03),
                                    Tags(
                                      key: Tagstatekeys._tagStateKey1,
                                      columns: _column ,
                                      runAlignment: WrapAlignment.center,
                                      itemCount: articletags.length,
                                      itemBuilder: (i) {
                                        return ItemTags(
                                          key: Key(i.toString()),
                                          index: i,
                                          title: articletags[i].toString(),
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
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height *0.03),
                                    Tags(

                                      key: Tagstatekeys._tagStateKey2,
                                      columns: _column2,
                                      itemCount: usertags.length,
                                      itemBuilder: (i) {
                                        return ItemTags(
                                          key: Key(i.toString()),
                                          index: i,
                                          title: '@${usertags[i].username.toString()}',
                                          color: Color(0xFFEEEEEE),
                                          activeColor: Color(0xFFEEEEEE),

                                          onPressed: (item) {
                                            NavgListPublic(user, usertags[i].profile, context);
                                          },
                                          textColor: colordtmaintwo,
                                          textActiveColor: colordtmaintwo,
                                          textStyle: TextStyle(
                                            fontSize: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.018, color: colordtmaintwo,),
                                        );
                                      },
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

class UserServiceFormScreen extends StatefulWidget {
  final Article userproduct;
  final User user;
  final User visiteduser;
  final String category;

  const UserServiceFormScreen(
      {Key key, this.userproduct, this.visiteduser, this.user, this.category})
      : super(key: key);

  @override
  UserServiceFormScreenState createState() => UserServiceFormScreenState(
      user: user,
      visiteduser: visiteduser,
      userproduct: userproduct,
      category: category);
}

class UserServiceFormScreenState extends State<UserServiceFormScreen> {
  final Article userproduct;
  final User user;
  final User visiteduser;
  final String category;

  UserServiceFormScreenState(
      {Key key, this.userproduct, this.visiteduser, this.user, this.category});

  int _column = 0;
  List<String> items = [];
  List<TextEditingController> checkboxes = [];
  List<TextEditingController> forms = [];
  bool isimagerequired = false;
  String itemchosen1 = '';
  final TextEditingController price = TextEditingController();
  final TextEditingController item = TextEditingController();
  final TextEditingController details = TextEditingController();
  List<PickedFile> _imageFileList;
  final ImagePicker _picker = ImagePicker();
  dynamic _pickImageError;
  bool isVideo = false;
  VideoPlayerController _controller;
  VideoPlayerController _toBeDisposed;
  final TextEditingController tags = TextEditingController();
  List<String> tagsfinal = [''];
  List<File> pickedimages;
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();
  File video;
  bool disablecomments = false;

  bool likeresult = false;
  bool dislikeresult = false;



  void ischosen(String itemchosen) {
    for (int i = 0; i < items.length; i++) {
      if (items[i] == itemchosen) {
        items.removeAt(i);
        return;
      }
    }
    items.add(itemchosen);
    return;
  }

  void _onImageButtonPressed(ImageSource source,
      {BuildContext context, bool isMultiImage = false}) async {
    if (_controller != null) {
      await _controller.setVolume(0.0);
    }
    if (isMultiImage) {
      try {
        final pickedFileList = await _picker.getMultiImage(
          imageQuality: 60,
        );
        setState(() {
          _imageFileList = pickedFileList;
          for (int i = 0; i < _imageFileList.length; i++) {
            pickedimages.add(File(_imageFileList[i].path));
          }
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
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


                                    for (final item in userproduct.checkboxes)
                                      CheckboxListTile(
                                        title: Text(item.hint,
                                            style: TextStyle(
                                              color: colordtmaintwo,
                                              fontWeight: FontWeight.bold,)),
                                        value: item.initializecontent(false,true),
                                        onChanged: (bool value) {
                                          setState(() {
                                            item.initializecontent(value,false);
                                          });
                                        },

                                      ),
                                    for (final item in userproduct.forms)
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.01,
                                            right: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.01),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.023,
                                              vertical: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.013),
                                          decoration: BoxDecoration(
                                            color: colordtmainone,
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                spreadRadius: 1,
                                                blurRadius: 7,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 8),
                                            child: TextFormField(
                                              style: TextStyle(
                                                color: colordtmaintwo,    fontWeight: FontWeight.bold,),
                                              controller: item.content,
                                              maxLength: 500,
                                              onChanged: (value){

                                              },
                                              maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                InputBorder.none,
                                                hintText: item.hint,hintMaxLines: 500,
                                                hintStyle: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: colordtmaintwo),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    SizedBox(height: 20),
                                    userproduct.isimagerequired ? Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(chooseimagesst),
                                        IconButton(
                                          color: colordtmaintwo,
                                          onPressed: () {
                                            isVideo = false;

                                            _onImageButtonPressed(
                                              ImageSource.gallery,
                                              context: context,
                                              isMultiImage: true,
                                            );
                                          },
                                          tooltip:
                                          'Pick Multiple Image from gallery',
                                          icon: Icon(Icons.photo_library),
                                        ),
                                      ],
                                    ) : Container(height: 0,width: 0,),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width *
                                              0.3,
                                          height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                          child: ElevatedButton(
                                              child: Text(sendst),
                                              onPressed: () {
                                                print(userproduct.id);
                                                CreateUserServiceRequest(
                                                    user.id,
                                                    visiteduser.id,
                                                    false,
                                                    false,
                                                    false,
                                                    '',
                                                    userproduct.caption,
                                                    _imageFileList,
                                                    userproduct.forms,
                                                    userproduct.checkboxes,userproduct.id);
                                                Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen(user: user),),);
                                              }),
                                        ),
                                      ],
                                    ), SizedBox(height: 20),
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