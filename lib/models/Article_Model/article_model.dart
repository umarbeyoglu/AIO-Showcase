import 'package:Welpie/models/Article_Model/article_image_model.dart';
import 'package:Welpie/models/Article_Model/article_tag_model.dart';
import 'package:Welpie/models/Article_Model/article_tagged_user_model.dart';
import 'package:Welpie/models/Article_Model/article_video_model.dart';
import 'package:Welpie/models/User_Model/user_model.dart';
import 'package:Welpie/screens/Profile_Screen/profile_image_screen.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

import '../../colors.dart';
import '../../repository.dart';
import 'article_shared_image_model.dart';
import 'article_shared_video_model.dart';

class Article{
  final String id;
  final String author;
  final String caption;
  final String timestamp;
  final String details;
  final String originalarticle;
  final String category;
  final String locationcountry;
  final String locationcity;
  final String locationstate;
  final String group;

  final bool hasImage;
  final String calendarattributetype;
  final int price;
final int likes;
final int dislikes;
final int views;
final int comments;

  final int adults;
  final int kids;
  final int bathrooms;
  final int bedrooms;
  final bool nsfw;
  final bool nstl;
  final bool pinned;

  final bool hideifoutofstock;
  final bool isforstay;
  final bool isquestion;
  final bool isimagerequired;
  final bool isbuyenabled;
  final bool allowstocks;
  final bool isdelivered;
  final bool ishighlighted;
  final bool isjobposting;
  final bool allowcomments;
  final bool anonymity;
  final bool sensitive;
  final bool spoiler;



  final String checkintime;
  final String checkouttime;
  final String productcondition;
  final String enddate;
  final String startdate;
  final String readtime;
  final String deliveredfromtime;
  final String deliveredtotime;
  final String specialinstructions;
  final String guide;
  final String pricecurrency;
  final String pricetype;


  List<ArticleDetailSpec> detailspecs = [];
  List<ArticleDetailRule> detailrules = [];
  List<ArticleDetailIncluded> detailincludeds = [];
  List<ArticleDetailCategory> detailcategories = [];
  List<ArticleAmenity> detailamenities = [];
  List<ArticleTravelLocation> travellocations = [];
  List<ArticleHighlight> highlights = [];
  List<ArticleActivity> activities = [];

  List<ArticleSharedImage> sharedimages = [];
  List<ArticleSharedVideo> sharedvideos = [];
  List<ArticleTag> tags = [];
  List<ArticleVideo> videos = [];
  List<ArticleTaggedUser> usertags = [];
  List<ArticleImage> images = [];
  List<ArticleChoice> choices = [];
  List<ArticleChoiceCategory> choicecategories = [];
  DateTime timestamp2 ;
  bool liked = false;
  bool liked2 = false;
  bool unliked = true;
  bool disliked = false;
  bool disliked2 = false;
  bool undisliked = true;
  bool interested = false;
  bool interested2 = false;
  bool uninterested = true;
  bool bookmarked = false;
  bool bookmarked2 = false;
  bool unbookmarked = true;
  bool isauthor = false;
  bool iscensorremoved = false;
  String censortype = '';
  int searchrelevancy = 0;
  bool dislikeresult = false;
  bool likeresult = false;
  String bookmarkidresult = '';
  bool bookmarkresult = false;

  bool hideifoutofstockinit = false;
  bool isforstayinit = false;
  bool isquestioninit = false;
  bool isimagerequiredinit = false;
  bool isbuyenabledinit = false;
  bool allowstocksinit = false;
  bool isdeliveredinit = false;
  bool ishighlightedinit = false;
  bool isjobpostinginit = false;
  bool allowcommentsinit = false;
  bool anonymityinit = false;
  bool sensitiveinit = false;
  bool spoilerinit = false;


  final String listcategory;

  List<ArticleCheckBox> checkboxes = [];
  List<ArticleForm> forms = [];
  final String type;
  final String date;


  final int stock;

  final String deliveryfee;
  final String etatime;





  Article({
    this.id,this.dislikes,this.date,this.type,this.isimagerequired,this.listcategory,this.timestamp2,this.locationcountry,this.locationcity,this.locationstate, this.usertags,this.isjobposting,this.sharedimages,this.hasImage,this.author,this.caption, this.category, this.timestamp, this.details, this.allowcomments, this.anonymity,
    this.images,this.forms,this.checkboxes,this.tags,this.liked,this.choices,this.choicecategories, this.bookmarked,this.comments, this.nsfw, this.sensitive,this.nstl,this.spoiler, this.pinned, this.price,this.originalarticle,this.group,
    this.likes, this.views,this.deliveryfee,this.etatime,this.isdelivered,this.ishighlighted,this.stock,this.allowstocks,this.isbuyenabled, this.calendarattributetype,this.videos,this.interested,this.uninterested,this.interested2,this.bookmarked2,this.unbookmarked,this.sharedvideos,
    this.adults, this.kids, this.bathrooms, this.bedrooms, this.hideifoutofstock,this.productcondition,
    this.isforstay, this.isquestion, this.checkintime, this.checkouttime, this.enddate, this.startdate, this.readtime, this.deliveredfromtime, this.deliveredtotime,
    this.specialinstructions, this.guide, this.pricecurrency, this.pricetype, this.detailspecs , this.detailrules ,
    this.detailincludeds , this.detailcategories , this.detailamenities , this.travellocations , this.highlights ,
    this.activities ,
  });


  factory Article.fromJSON(Map<String, dynamic> jsonMaparticle) {

    return Article(
      id: jsonMaparticle['id'] as String,
      caption: jsonMaparticle['caption'] as String,
      author: jsonMaparticle['author'] as String,
      timestamp: jsonMaparticle['timestamp'] as String,
      details: jsonMaparticle['details'] as String,
      productcondition: jsonMaparticle['productcondition'] as String,
      originalarticle: jsonMaparticle['originalarticle'] as String,
      hasImage: jsonMaparticle['hasImage'] as bool,
      stock: jsonMaparticle['stock'] as int,
      date: jsonMaparticle['date'] as String,
      isimagerequired: jsonMaparticle['isimagerequired'] as bool,
      allowstocks: jsonMaparticle['allowstocks'] as bool,
      isbuyenabled: jsonMaparticle['isbuyenabled'] as bool,
      allowcomments: jsonMaparticle['allowcomments'] as bool,
      anonymity: jsonMaparticle['anonymity'] as bool,
      nsfw: jsonMaparticle['nsfw'] as bool,
      nstl: jsonMaparticle['nstl'] as bool,
      isjobposting: jsonMaparticle['isjobposting'] as bool,
      category : jsonMaparticle['category'] as String,
      type : jsonMaparticle['type'] as String,
      sensitive: jsonMaparticle['sensitive'] as bool,
      spoiler: jsonMaparticle['spoiler'] as bool,
      pinned: jsonMaparticle['pinned'] as bool,
      price: jsonMaparticle['price'] as int,
      deliveryfee: jsonMaparticle['deliveryfee'] as String,
      etatime: jsonMaparticle['etatime'] as String,
      isdelivered: jsonMaparticle['isdelivered'] as bool,
      locationcountry: jsonMaparticle['locationcountry'] as String,
      locationcity: jsonMaparticle['locationcity'] as String,
      locationstate: jsonMaparticle['locationstate'] as String,
     likes: jsonMaparticle['likes'] as int,
     dislikes: jsonMaparticle['dislikes'] as int,
     views: jsonMaparticle['views'] as int,
      comments: jsonMaparticle['comments'] as int,


      hideifoutofstock: jsonMaparticle['hideifoutofstock'] as bool,
      isforstay: jsonMaparticle['isforstay'] as bool,
      isquestion: jsonMaparticle['isquestion'] as bool,
      checkintime: jsonMaparticle['checkintime'] as String,
      checkouttime: jsonMaparticle['checkouttime'] as String,
      startdate: jsonMaparticle['startdate'] as String,
      enddate: jsonMaparticle['enddate'] as String,
      readtime: jsonMaparticle['readtime'] as String,
      deliveredfromtime: jsonMaparticle['deliveredfromtime'] as String,
      deliveredtotime: jsonMaparticle['deliveredtotime'] as String,
      specialinstructions: jsonMaparticle['specialinstructions'] as String,
      guide: jsonMaparticle['guide'] as String,
      pricecurrency: jsonMaparticle['pricecurrency'] as String,
      pricetype: jsonMaparticle['pricetype'] as String,
      adults: jsonMaparticle['adults'] as int,
      kids: jsonMaparticle['kids'] as int,
      bedrooms: jsonMaparticle['bedrooms'] as int,
      bathrooms: jsonMaparticle['bathrooms'] as int,
      detailspecs: jsonMaparticle["articledetailspecs_set"] != null ? List<ArticleDetailSpec>.from( jsonMaparticle["articledetailspecs_set"].map((x) => ArticleDetailSpec.fromJSON(x))) : [],
      detailrules: jsonMaparticle["articledetailrules_set"] != null ? List<ArticleDetailRule>.from( jsonMaparticle["articledetailrules_set"].map((x) => ArticleDetailRule.fromJSON(x))) : [],
      detailincludeds: jsonMaparticle["articledetailincludeds_set"] != null ? List<ArticleDetailIncluded>.from( jsonMaparticle["articledetailincludeds_set"].map((x) => ArticleDetailIncluded.fromJSON(x))) : [],
      detailcategories: jsonMaparticle["articledetailcategories_set"] != null ? List<ArticleDetailCategory>.from( jsonMaparticle["articledetailcategories_set"].map((x) => ArticleDetailCategory.fromJSON(x))) : [],
      detailamenities: jsonMaparticle["articleamenities_set"] != null ? List<ArticleAmenity>.from( jsonMaparticle["articleamenities_set"].map((x) => ArticleAmenity.fromJSON(x))) : [],
      travellocations: jsonMaparticle["articletravellocations_set"] != null ? List<ArticleTravelLocation>.from( jsonMaparticle["articletravellocations_set"].map((x) => ArticleTravelLocation.fromJSON(x))) : [],
      highlights: jsonMaparticle["articlehighlights_set"] != null ? List<ArticleHighlight>.from( jsonMaparticle["articlehighlights_set"].map((x) => ArticleHighlight.fromJSON(x))) : [],
      activities: jsonMaparticle["articleactivities_set"] != null ? List<ArticleActivity>.from( jsonMaparticle["articleactivities_set"].map((x) => ArticleActivity.fromJSON(x))) : [],




      forms: jsonMaparticle["articleforms_set"] != null ? List<ArticleForm>.from( jsonMaparticle["articleforms_set"].map((x) => ArticleForm.fromJSON(x))) : [],
      checkboxes: jsonMaparticle["articlecheckboxes_set"] != null ? List<ArticleCheckBox>.from( jsonMaparticle["articlecheckboxes_set"].map((x) => ArticleCheckBox.fromJSON(x))) : [],
      images: jsonMaparticle["articleimages_set"] != null ? List<ArticleImage>.from( jsonMaparticle["articleimages_set"].map((x) => ArticleImage.fromJSON(x))) : [],
      sharedimages: jsonMaparticle["articlesharedimages_set"] != null ? List<ArticleSharedImage>.from( jsonMaparticle["articlesharedimages_set"].map((x) => ArticleSharedImage.fromJSON(x))) : [],
      sharedvideos: jsonMaparticle["articlesharedvideos_set"] != null ? List<ArticleSharedVideo>.from( jsonMaparticle["articlesharedvideos_set"].map((x) => ArticleSharedVideo.fromJSON(x))) : [],
      videos: jsonMaparticle["articlevideos_set"] != null ? List<ArticleVideo>.from( jsonMaparticle["articlevideos_set"].map((x) => ArticleVideo.fromJSON(x))) : [],
      tags:  jsonMaparticle["articletags_set"] != null ? List<ArticleTag>.from( jsonMaparticle["articletags_set"].map((x) => ArticleTag.fromJSON(x))) : [],
      usertags:  jsonMaparticle["articleusertags_set"] != null ? List<ArticleTaggedUser>.from( jsonMaparticle["articleusertags_set"].map((x) => ArticleTaggedUser.fromJSON(x))) : [],
      choices: jsonMaparticle["articlechoices_set"] != null ? List<ArticleChoice>.from( jsonMaparticle["articlechoices_set"].map((x) => ArticleChoice.fromJSON(x))) : [],
      choicecategories: jsonMaparticle["articlechoicecategories_set"] != null ? List<ArticleChoiceCategory>.from( jsonMaparticle["articlechoicecategories_set"].map((x) => ArticleChoiceCategory.fromJSON(x))) : [],

    );
  }

  DateTime formatDate() {
    final formatter = DateFormat("yyyy-MM-ddThh:mm:ss");
    final dateTimeFromStr = formatter.parse(timestamp);
      return dateTimeFromStr;
  }

  bool islocationnull(){
    if(locationcountry == null){return true;}
    return false;
  }

  void initeditbool(){
    hideifoutofstockinit = hideifoutofstock ;
    isforstayinit = isforstay ;
    isquestioninit = isquestion ;
    isimagerequiredinit = isimagerequired ;
    isbuyenabledinit = isbuyenabled ;
    allowstocksinit = allowstocks ;
    isdeliveredinit = isdelivered ;
    ishighlightedinit = ishighlighted ;
    isjobpostinginit = isjobposting ;
    allowcommentsinit = allowcomments ;
    anonymityinit = anonymity ;
    sensitiveinit = sensitive ;
    spoilerinit = spoiler ;
    return;
  }

  bool isclipsatt(){
    if (hasImage) {return true;}
    if (category == 'A') {return true;}
    if (category == 'E') {return true;}
    if (category == 'F') {return true;}
   return false;
  }


  @override
  operator ==(o) => o.id == id && o.caption == caption;

  @override
  int get hashCode => hashValues(id,caption);

  bool removecensor(){
    iscensorremoved = true;
  }

  List<String> tagsnew(){
    List<String> tags2 = [];
    for(int i=0;i<tags.length;i++){
      tags2.add(tags[i].tag);
    }
    return tags2;
  }

  String location(){
    if(locationstate == '' &&
        locationcountry == '' &&
        locationcity == ''
    ){return '';}
    if(locationcity == '-' && locationstate == '-' && locationcountry == '-'){
      return '';
    }
    if(locationstate == '-' && locationcity == '-'){
      return '$locationcountry';
    }
    if(locationcity == '-'){
      return '$locationcountry,$locationstate';
    }
    if(locationcity == null && locationstate == null && locationcountry == null){
      return '';
    }
    if(locationstate == null && locationcity == null){
      return '$locationcountry';
    }
    if(locationcity == null){
      return '$locationcountry,$locationstate';
    }

    if(locationcountry == locationstate && locationcity == null){
      return '$locationcountry';
    }
    if(locationcountry == locationstate && locationcity == '-'){
      return '$locationcountry';
    }
    if(locationcountry == locationstate){
      return '$locationcity,$locationcountry';
    }
    if(iscyprus == true){
      return '$locationcity,$locationcountry';
    }
    if(iscyprus == false){
      if(locationstate == '-' &&
          locationcountry == '-' &&
          locationcity == '-'
      ){return '';}

      return '$locationcity,$locationstate,$locationcountry';
    }


  }

  Widget clipsatt(dynamic context){
    if(isvideo()){return Chewie(
      controller: ChewieController(
        videoPlayerController:  VideoPlayerController.network(
         videos.first.video,
        ),
        aspectRatio:9/16,
        autoInitialize: true,
        autoPlay: true,
        looping: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              'Error-Hata',
              style: TextStyle(color: colordtmainone),
            ),
          );
        },
      ),
    );}
    if(category == 'D'){
      return Column(
        children: [
    Padding(
      padding: EdgeInsets.only(left:10,right:55,top:35) ,
      child: Text(
        caption == '-' ? '': caption,
        style: TextStyle(
            color: colordtmainone,
            fontSize:20,
            fontWeight: FontWeight.w500),
      ),
    ),
        ],
      );
    }
    return Carousel(
      images: images.map((article)=>article.carouselimages()).toList()
      ,autoplay: false, defaultImage: NetworkImage('https://t4.ftcdn.net/jpg/02/07/87/79/360_F_207877921_BtG6ZKAVvtLyc5GWpBNEIlIxsffTtWkv.jpg'),

      dotPosition: DotPosition.bottomCenter,onImageTap: (index){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      ViewImageScreen(
                                                         image:images[index].image,
                                                      ),
                                                ),
                                              );
                                            },
      dotSize: 5,
    );
  }

  bool isvideo() {
    if (category == 'E') {

      return true;
    }
    if (category == 'F') {
      return true;
    }
return false;
  }

  bool isoriginalarticlefunc(){
    if( originalarticle == ''){return false;}
    if( originalarticle == 'null'){return false;}
    if( originalarticle == null){return false;}
    return true;
  }

  bool iscensored(User user){
    if(iscensorremoved){
      return false;
    }
    if(nsfw){
      if(user.isnsfwallowed){
        return false;
      }
      censortype = 'nsfw';
      return true;
    }
    if(nstl){
      if(user.isnsfwallowed){
        return false;
      }
      censortype = 'nstl';
      return true;
    }
    if(sensitive){
      if(user.issensitiveallowed){
        return false;
      }
      censortype = 'sensitive';
      return true;
    }
    if(spoiler){
      if(user.isspoilerallowed){
        return false;
      }
      censortype = 'spoiler';
      return true;
    }
    return false;
  }


  bool iscensoredbookmark(User user,bool examplebool){
    if(examplebool){return false;}
    if(iscensorremoved){
      return false;
    }
    if(nsfw){
      if(user.isnsfwallowed){
        return false;
      }
      censortype = 'nsfw';
      return true;
    }
    if(nstl){
      if(user.isnsfwallowed){
        return false;
      }
      censortype = 'nstl';
      return true;
    }
    if(sensitive){
      if(user.issensitiveallowed){
        return false;
      }
      censortype = 'sensitive';
      return true;
    }
    if(spoiler){
      if(user.isspoilerallowed){
        return false;
      }
      censortype = 'spoiler';
      return true;
    }
    return false;
  }

  void articleunbookmarkprocess(String userid,Article article1,User user,String condition) {
    if(author == user.id){return;}
    if(author == userid){return;}
    UnbookmarkArticle(condition);
    article1.bookmarked2 = false;
    article1.bookmarked = false;
    article1.unbookmarked = true;
    article1.bookmarkresult = false;
  }

  bool articleliked(String userid,bool liked,bool unliked,bool condition) {
    bool like1 = false;
    if (author == userid){return true;}
    if (liked == true){return true;}
    if (liked2 == true){return true;}
    if (unliked == true && likeresult ==false){return false;}
    if(likeresult){return true;}
    return like1;
  }



  void articleunlikeprocess(String userid,Article article1,String condition) {

    UnlikeArticle(condition);
    article1.liked2 = false;
    article1.liked = false;
    article1.unliked = true;
    article1.likeresult = false;
  }

  bool articledisliked(String userid,bool disliked,bool undisliked,bool condition) {
    bool like1 = false;

    if (author == userid){return true;}
    if (disliked == true){return true;}
    if (disliked2 == true){return true;}
      if (undisliked == true && dislikeresult ==false){return false;}
    if(dislikeresult){return true;}
    return like1;
  }

  void articleundislikeprocess(String userid,Article article1,String condition) {

    UndislikeArticle(condition);
    article1.disliked2 = false;
    article1.disliked = false;
    article1.undisliked = true;
    article1.dislikeresult = false;
  }


  bool areposttagsnull(){
    if(tags == []){return true;}
    if(tags == null){return true;}
    if(tags == 'null'){return true;}
    if(tags == ''){return true;}
    return false;
  }

  bool articlebookmarked(String userid,bool bookmarked,bool unbookmarked,User user) {
    if(author == user.id){return true;}
    if(author == userid){return true;}
    bool bookmark1;
    if (bookmarked == true){return true;}
    if (bookmarked2 == true){return true;}
    if (unbookmarked == true&&bookmarkresult == false){return false;}
    if (bookmarkresult){return true;}
    for(int index = 0; index <user.bookmarks.length; index++) {
      bookmark1 =  userid == user.bookmarks[index].author ? true : false;
      if(bookmark1 == true){
        return true;}
    }
    return bookmark1;
  }


  bool isauthorfunc(String userid,String authorid) {
   // if (isgroup == true){for(int index = 0; index < 1; index++) {}}
    return userid == authorid ? true : false;
  }









}

class ArticleChoice {
  final String id;
  final String category;
  final String timestamp;
  final String image;
  final String item;
  final bool isbuyenabled;
  final bool allowstocks;
  final int stock;
  final String price;
  bool isnew = false;
  bool ischosen = false;

  ArticleChoice({
    this.id,this.category,this.price,
    this.timestamp,this.image,
    this.item,this.isbuyenabled,
    this.allowstocks,this.stock,
  });


  factory  ArticleChoice.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleChoice(
      id: jsonMap['id'] as String,
      category: jsonMap['category'] as String,
      timestamp: jsonMap['timestamp'] as String,
      image: jsonMap['image'] as String,
      item: jsonMap['item'] as String,
      price: jsonMap['price'] as String,
      stock: jsonMap['stock'] as int,
      allowstocks: jsonMap['allowstocks'] as bool,
      isbuyenabled: jsonMap['isbuyenabled'] as bool,
    );
  }



}
class ArticleChoiceCategory {
  final String id;
  final String category;
  final String timestamp;
  final String image;final
  bool allchooseable;
  final String userproduct;
  bool isnew = false;
  bool ischanged = false;
  bool firsttime = false;
  bool val = false;
  List<ChoiceModel> choices = [];




  ArticleChoiceCategory({this.id,this.allchooseable,this.category,this.userproduct, this.timestamp,this.image,});

  factory  ArticleChoiceCategory.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleChoiceCategory(
      id: jsonMap['id'] as String,
      category: jsonMap['category'] as String,
      timestamp: jsonMap['timestamp'] as String,
      image: jsonMap['image'] as String, allchooseable: jsonMap['allchooseable'] as bool,
      userproduct: jsonMap['userproduct'] as String,
    );}


}
class ArticleCategory {
  final String id;
  final String category;
  final String author;
  final String image;
  bool removed = false;
  ArticleCategory({this.author,this.id,this.image,this.category});


  factory  ArticleCategory.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleCategory (
      id: jsonMap['id'] as String,
      category: jsonMap['category'] as String,
      image: jsonMap['image'] as String,
      author: jsonMap['author'] as String,
    );
  }
  ImageProvider<Object> isimage(){
    if(image != null){
      return NetworkImage(image);
    }
    if(image == null){
      return NetworkImage(
          'https://st2.depositphotos.com/4111759/12123/v/600/depositphotos_121233262-stock-illustration-male-default-placeholder-avatar-profile.jpg');
    }

    return NetworkImage(
        'https://st2.depositphotos.com/4111759/12123/v/600/depositphotos_121233262-stock-illustration-male-default-placeholder-avatar-profile.jpg');
  }

}
class ArticleForm {
  final String id;
  final String service;
  final String author;
  final String hint;
  bool firsttime = false;
  bool notshow = false;
  TextEditingController edithint;
  final TextEditingController content = TextEditingController();

  String checkhintchange() {
    edithint =  edithint = edithint ?? TextEditingController(text: hint);
    if(edithint.text == hint){

      return hint;
    }

    return edithint.text ;
  }

  TextEditingController hintchange() {
    if(firsttime == false){
      firsttime = true;
      return edithint ?? TextEditingController(text: hint);
    }
    return edithint;
  }


  ArticleForm({this.id,this.service,this.author,this.hint,this.edithint});



  void onchanged(String value){
    if(content.text!= ''){
      content.text = value;
    }
  }

  factory  ArticleForm.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleForm(
      id: jsonMap['id'] as String,
      service: jsonMap['userservice'] as String,
      author: jsonMap['author'] as String,
      hint: jsonMap['hint'] as String,
    );
  }
}
class ArticleCheckBox {
  final String id;
  final String service;
  final String author;
  final String hint;
  bool notshow = false;
  bool firsttime = false;
  TextEditingController edithint;
  bool content = false;

  ArticleCheckBox({this.id,this.service,this.author,this.hint,this.edithint});

  TextEditingController hintchange() {
    if(firsttime == false){
      firsttime = true;
      return edithint ?? TextEditingController(text: hint);
    }
    return edithint;
  }

  String checkhintchange() {
    edithint =  edithint ?? TextEditingController(text: hint);
    if(edithint.text == hint){
      return hint;
    }
    return edithint.text ;
  }

  bool initializecontent(bool value,bool isthis){

    if(isthis == true){
      return content;
    }
    if(firsttime == false){
      firsttime = true;
      bool content = false;
      return content;
    }
    content = value;
    return content;
  }

  factory  ArticleCheckBox.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleCheckBox(
      id: jsonMap['id'] as String,
      service: jsonMap['userservice'] as String,
      author: jsonMap['author'] as String,
      hint: jsonMap['hint'] as String,

    );
  }
}












