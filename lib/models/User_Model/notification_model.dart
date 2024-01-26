import 'package:untitled/models/User_Model/user_tags_model.dart';
import 'package:flutter/cupertino.dart';

class Notifications {
  //final String group;
  //final String product;
   String id;
   String author;
   String type;
   String profile;
   String item;
   String date;
   String deliverydate;
   String time;
   String reservation;
   String fullname;
   String buycategory;
   String userproduct;
   String userservice;
   String contactno;
   String deliveryaddress;
   int count;
   String link;
   String calendaritem;
   String calendarevent;
   String article;
   String reason;
   DateTime timestamp;
   final String service;
   final String requesttype;
   final bool clientnow;
   final bool isdenied;

   final bool isaccepted;
   List<RequestItemChoice> choices = [];
   List<RequestImage> images = [];
   List<RequestForm> forms = [];
   List<RequestCheckBox> checkboxes = [];
   bool show = true;

  Notifications({this.buycategory,this.count,this.choices,this.deliverydate,this.fullname,this.reservation,this.contactno,this.deliveryaddress,this.link,this.id,this.images,this.isaccepted,this.reason,this.forms,this.checkboxes,this.type,this.author,this.userservice,this.timestamp,this.userproduct,this.calendarevent,this.calendaritem,this.article,this.profile,this.requesttype,this.service,this.show,this.item,this.date,this.time,this.clientnow,this.isdenied});



}


class RequestForm {
  final String id;
  final String request;
  final String hint;
  final String content;

  RequestForm({this.id,this.content,this.request,this.hint});


  factory  RequestForm.fromJSON(Map<String, dynamic> jsonMap) {
    return  RequestForm(
      id: jsonMap['id'] as String,
      request: jsonMap['request'] as String,
      content: jsonMap['content'] as String,
      hint: jsonMap['hint'] as String,
    );
  }
}

class RequestCheckBox {
  final String id;
  final String request;
  final String hint;
  final bool boolean;

  RequestCheckBox({this.id,this.request,this.boolean,this.hint});

  factory  RequestCheckBox.fromJSON(Map<String, dynamic> jsonMap) {
    return  RequestCheckBox(
      id: jsonMap['id'] as String,
      request: jsonMap['request'] as String,
      boolean: jsonMap['boolean'] as bool,
      hint: jsonMap['hint'] as String,
    );
  }
}

class RequestImage {
  final String id;
  final String request;
  final String image;

  RequestImage({this.id,this.request,this.image});

  factory  RequestImage.fromJSON(Map<String, dynamic> jsonMap) {
    return  RequestImage (
      id: jsonMap['id'] as String,
      request: jsonMap['request'] as String,
      image: jsonMap['image'] as String,
    );
  }
  Image carouselimages(){
    if(image.isNotEmpty){
      return Image.network(image,fit: BoxFit.fitWidth,);
    }
    else if (image == null){
      return Image.network('https://t4.ftcdn.net/jpg/02/07/87/79/360_F_207877921_BtG6ZKAVvtLyc5GWpBNEIlIxsffTtWkv.jpg',fit: BoxFit.fitWidth,);
    }
  }
}
