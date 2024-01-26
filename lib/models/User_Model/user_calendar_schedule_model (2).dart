import 'package:Welpie/models/User_Model/user_model.dart';
import 'package:Welpie/models/User_Model/user_tags_model.dart';

import 'notification_model.dart';

class CalendarSchedule {
  final String id;
  final String item;
  User profilefull;
  final String author;
  final String profile;
  final String time;
  final String date;

  CalendarSchedule({this.id,this.item,this.profilefull,this.author,this.date,this.profile,this.time});

  factory  CalendarSchedule.fromJSON(Map<String, dynamic> jsonMap) {
    return  CalendarSchedule(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      item: jsonMap['item'] as String,
      profile: jsonMap['profile'] as String,
      time: jsonMap['time'] as String,
      date: jsonMap['date'] as String,
    );
  }
}

class MeetingSchedule {
  final String id;
  User profilefull;
  final String author;
  final String profile;
  final String time;
  final String date;

  MeetingSchedule({this.id,this.profilefull,this.author,this.date,this.profile,this.time});

  factory  MeetingSchedule.fromJSON(Map<String, dynamic> jsonMap) {
    return  MeetingSchedule(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      profile: jsonMap['profile'] as String,
      time: jsonMap['time'] as String,
      date: jsonMap['date'] as String,
    );
  }
}

class MeetingStatus {
  final String id;
  final String dates;
  final String times;
  final String author;


  MeetingStatus({this.id, this.dates, this.times, this.author});


  factory MeetingStatus.fromJSON(Map<String, dynamic> jsonMap) {
    return MeetingStatus(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      times: jsonMap['times'] as String,
      dates: jsonMap['dates'] as String,
    );
  }
}

class ReservationDeactivationMonth {
  final String id;
  final String author;
  final String timestamp;

  final String enddate;
  final String startdate ;

  ReservationDeactivationMonth({this.id,this.enddate,this.timestamp,this.author,this.startdate });

  factory  ReservationDeactivationMonth.fromJSON(Map<String, dynamic> jsonMap) {
    return  ReservationDeactivationMonth(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      timestamp: jsonMap['timestamp'] as String,
      enddate: jsonMap['enddate'] as String,
      startdate: jsonMap['startdate'] as String,
    );
  }
}

class ReservationSchedule {
  final String id;
  final String reservation;
  User profilefull;
  final String author;
  final String profile;
  final String startdate;
  final String enddate;

  ReservationSchedule({this.id,this.reservation,this.profilefull,this.author,this.startdate,this.profile,this.enddate});

  factory  ReservationSchedule.fromJSON(Map<String, dynamic> jsonMap) {
    return  ReservationSchedule(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      reservation: jsonMap['reservation'] as String,
      profile: jsonMap['profile'] as String,
      enddate: jsonMap['enddate'] as String,
      startdate: jsonMap['startdate'] as String,
    );
  }
}


class RequestInit {
  final String id;
  final String item;
  final String author;
  final String reason;
  final String buycategory;
  final String profile;
  final String timestamp;
  final String fullname;
  final String time;
  final String contactno;
  final String deliveryaddress;
  final String link;
  final double price;
  final int count;
  //final String group;
  final String date;
  final String deliverydate;
  //final String product;
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


  RequestInit({
    // this.group,this.product,
    this.id,this.images,this.choices,this.contactno,this.count,this.price,this.deliverydate,this.fullname,this.deliveryaddress,this.link,this.buycategory,this.forms,this.isaccepted,this.reason,this.checkboxes,this.requesttype,this.timestamp,this.service,this.show,this.item,this.author,this.date,this.profile,this.time,this.clientnow,this.isdenied});


  factory  RequestInit.fromJSON(Map<String, dynamic> jsonMap) {
    return  RequestInit(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      buycategory: jsonMap['buycategory'] as String,
      item: jsonMap['item'] as String,
      link: jsonMap['link'] as String,
      count: jsonMap['count'] as int,
      price: jsonMap['price'] as double,
      contactno: jsonMap['contact'] as String,
      deliveryaddress: jsonMap['deliveryaddress'] as String,
      deliverydate: jsonMap['deliverydate'] as String,
      fullname: jsonMap['fullname'] as String,
      clientnow: jsonMap['clientnow'] as bool,
      isdenied: jsonMap['isdenied'] as bool,
      isaccepted: jsonMap['isaccepted'] as bool,
      profile: jsonMap['profile'] as String,
      service: jsonMap['service'] as String,
      timestamp: jsonMap['timestamp'] as String,
      reason: jsonMap['reason'] as String,
      //   group : jsonMap['group'] as String,
      //   product : jsonMap['product'] as String,
      requesttype:  jsonMap['requesttype'] as String,
      time: jsonMap['time'] as String,
      date: jsonMap['date'] as String,
      choices: jsonMap["requestchoices_set"] != null ? List<RequestItemChoice>.from( jsonMap["requestchoices_set"].map((x) => RequestItemChoice.fromJSON(x))) : [],
      images: jsonMap["requestimages_set"] != null ? List<RequestImage>.from( jsonMap["requestimages_set"].map((x) => RequestImage.fromJSON(x))) : [],
      forms: jsonMap["requestforms_set"] != null ? List<RequestForm>.from( jsonMap["requestforms_set"].map((x) => RequestForm.fromJSON(x))) : [],
      checkboxes: jsonMap["requestcheckboxes_set"] != null ? List<RequestCheckBox>.from( jsonMap["requestcheckboxes_set"].map((x) => RequestCheckBox.fromJSON(x))) : [],

    );
  }
}
