import 'package:flutter/cupertino.dart';

import '../../screens/General/choice_screen.dart';

class ArticleTag {
  final String id;
  final String article;
  final String author;
  final String tag;


  ArticleTag({this.id,this.article,this.author,this.tag});


  factory  ArticleTag.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleTag(
      id: jsonMap['id'] as String,
      article: jsonMap['article'] as String,
      author: jsonMap['author'] as String,
      tag: jsonMap['tag'] as String,
    );
  }
}

class ArticleActivity {
  final String id;
  final String article;
  final String activity;
  final String starttime;
  bool firsttime = false;
  bool firsttime2 = false;
  bool notshow = false;
  TextEditingController edithint;
  TextEditingController edithint2;
  final TextEditingController content = TextEditingController(text:'');
  final TextEditingController content2 = TextEditingController(text:'');

  String checkhintchange() {
    edithint =  edithint = edithint ?? TextEditingController(text: activity);
    if(edithint.text == activity){

      return activity;
    }

    return edithint.text ;
  }

  TextEditingController hintchange() {
    if(firsttime == false){
      firsttime = true;
      return edithint ?? TextEditingController(text: activity);
    }
    return edithint;
  }

  String checkhint2change() {
    edithint2 =  edithint2 = edithint2 ?? TextEditingController(text: starttime);
    if(edithint2.text == starttime){

      return starttime;
    }

    return edithint2.text ;
  }

  TextEditingController hint2change() {
    if(firsttime2 == false){
      firsttime2 = true;
      return edithint2 ?? TextEditingController(text: starttime);
    }
    return edithint2;
  }

  ArticleActivity({this.id,this.article,this.starttime,this.activity,this.firsttime2,this.firsttime,this.notshow,
    this.edithint2
  });


  factory  ArticleActivity.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleActivity(
      id: jsonMap['id'] as String,
      article: jsonMap['article'] as String,
      activity: jsonMap['activity'] as String,
      starttime: jsonMap['starttime'] as String,
    );
  }

}

class ArticleHighlight {
  final String id;
  final String article;
  final String highlight;
  bool firsttime = false;
  bool firsttime2 = false;
  bool notshow = false;
  TextEditingController edithint;
  final TextEditingController content = TextEditingController(text:'');

  String checkhintchange() {
    edithint =  edithint = edithint ?? TextEditingController(text: highlight);
    if(edithint.text == highlight){

      return highlight;
    }

    return edithint.text ;
  }

  TextEditingController hintchange() {
    if(firsttime == false){
      firsttime = true;
      return edithint ?? TextEditingController(text: highlight);
    }
    return edithint;
  }


  ArticleHighlight({this.id,this.article,this.highlight,this.firsttime,this.notshow});


  factory  ArticleHighlight.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleHighlight(
      id: jsonMap['id'] as String,
      article: jsonMap['article'] as String,
      highlight: jsonMap['highlight'] as String,
    );
  }
}

class ArticleTravelLocation {
  final String id;
  final String article;
  final String location;
  bool firsttime = false;
  bool notshow = false;
  TextEditingController edithint;
  final TextEditingController content = TextEditingController(text:'');

  String checkhintchange() {
    edithint =  edithint = edithint ?? TextEditingController(text: location);
    if(edithint.text == location){

      return location;
    }

    return edithint.text ;
  }

  TextEditingController hintchange() {
    if(firsttime == false){
      firsttime = true;
      return edithint ?? TextEditingController(text: location);
    }
    return edithint;
  }


  ArticleTravelLocation({this.id,this.article,this.location,this.firsttime,this.notshow});


  factory  ArticleTravelLocation.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleTravelLocation(
      id: jsonMap['id'] as String,
      article: jsonMap['article'] as String,
      location: jsonMap['location'] as String,
    );
  }
}

class ArticleAmenity {
  final String id;
  final String article;
  final String amenity;

  bool firsttime = false;
  bool notshow = false;
  TextEditingController edithint;
  final TextEditingController content = TextEditingController(text:'');

  String checkhintchange() {
    edithint =  edithint = edithint ?? TextEditingController(text: amenity);
    if(edithint.text == amenity){

      return amenity;
    }

    return edithint.text ;
  }

  TextEditingController hintchange() {
    if(firsttime == false){
      firsttime = true;
      return edithint ?? TextEditingController(text: amenity);
    }
    return edithint;
  }

  ArticleAmenity({this.id,this.article,this.amenity,this.firsttime,this.notshow});


  factory  ArticleAmenity.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleAmenity(
      id: jsonMap['id'] as String,
      article: jsonMap['article'] as String,
      amenity: jsonMap['amenity'] as String,
    );
  }
}

class ArticleDetailCategory {
  final String id;
  final String article;
  final String category;
  List<DetailSpecModel> specs = [];
  List<ArticleDetailSpec> specs2 = [];

  ArticleDetailCategory({this.id,this.article,this.category,this.specs2,this.specs,});


  factory  ArticleDetailCategory.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleDetailCategory(
      id: jsonMap['id'] as String,
      article: jsonMap['article'] as String,
      category: jsonMap['category'] as String,
    );
  }
}

class ArticleDetailSpec {
  final String id;
  final String article;
  final String category;
  final String spec;


  ArticleDetailSpec({this.id,this.article,this.category,this.spec});


  factory  ArticleDetailSpec.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleDetailSpec(
      id: jsonMap['id'] as String,
      article: jsonMap['article'] as String,
      category: jsonMap['category'] as String,
      spec: jsonMap['spec'] as String,
    );
  }
}

class ArticleDetailIncluded {
  final String id;
  final String article;
  final String included;
  bool firsttime = false;
  bool notshow = false;
  TextEditingController edithint;
  final TextEditingController content = TextEditingController(text:'');

  String checkhintchange() {
    edithint =  edithint = edithint ?? TextEditingController(text: included);
    if(edithint.text == included){

      return included;
    }

    return edithint.text ;
  }

  TextEditingController hintchange() {
    if(firsttime == false){
      firsttime = true;
      return edithint ?? TextEditingController(text: included);
    }
    return edithint;
  }

  ArticleDetailIncluded({this.id,this.article,this.included,this.firsttime,this.notshow});


  factory  ArticleDetailIncluded.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleDetailIncluded(
      id: jsonMap['id'] as String,
      article: jsonMap['article'] as String,
      included: jsonMap['included'] as String,
    );
  }
}

class ArticleDetailRule {
  final String id;
  final String article;
  final String rule;

  bool firsttime = false;
  bool notshow = false;
  TextEditingController edithint;
  final TextEditingController content = TextEditingController(text:'');

  String checkhintchange() {
    edithint =  edithint = edithint ?? TextEditingController(text: rule);
    if(edithint.text == rule){

      return rule;
    }

    return edithint.text ;
  }

  TextEditingController hintchange() {
    if(firsttime == false){
      firsttime = true;
      return edithint ?? TextEditingController(text: rule);
    }
    return edithint;
  }

  ArticleDetailRule({this.id,this.article,this.rule,this.firsttime,this.notshow});


  factory  ArticleDetailRule.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleDetailRule(
      id: jsonMap['id'] as String,
      article: jsonMap['article'] as String,
      rule: jsonMap['rule'] as String,
    );
  }
}

class UserOpeningHour {
  final String id;
  final String author;
  final String weekday;
  final String fromhour;
  final String tohour;
  final bool isalwaysopen;
  final bool ispermanentlyclosed;


  UserOpeningHour({this.id,this.author,this.weekday,this.fromhour,
  this.tohour,this.isalwaysopen,this.ispermanentlyclosed});


  factory  UserOpeningHour.fromJSON(Map<String, dynamic> jsonMap) {
    return  UserOpeningHour(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      weekday: jsonMap['weekday'] as String,
      fromhour: jsonMap['fromhour'] as String,
      tohour: jsonMap['tohour'] as String,
      isalwaysopen: jsonMap['isalwaysopen'] as bool,
      ispermanentlyclosed: jsonMap['ispermanentlyclosed'] as bool,



    );
  }
}