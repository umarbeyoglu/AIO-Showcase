import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_app/models/User_Model/user_bookmark_model.dart';
import 'package:flutter_food_delivery_app/models/User_Model/user_calendar_schedule_model.dart';
import 'package:flutter_food_delivery_app/models/User_Model/user_calendar_status_model.dart';
import 'package:flutter_food_delivery_app/models/User_Model/user_tags_model.dart';
import 'package:intl/intl.dart';

import '../../colors.dart';
import '../../language.dart';
import '../../repository.dart';
import '../Article_Model/article_tag_model.dart';

class User {
  final String id;
  final String email;
  final bool online;
  final bool public_profile;
  final bool calendar_ismultichoice;
  final bool open_now;
  final bool isnsfwallowed;
  final bool isnstlallowed;
  final bool issensitiveallowed;
  final bool isspoilerallowed;
  final bool isprofileanon;
  final bool isdetailsprivate;

  final bool ishotel;
  final int hotelclass;

  final String business_type;
  final String username;
  final String parent;
  final String full_name;
  final String image;
  final int messagecount;
  final String phone_number;
  final String sign_up_date;
  final String last_login;
  final String birth_date;
  final String details;
  final String locationcountry;
  final String locationcity;
  final String gatewayName;
  final String gatewayMerchantId;
  final String merchantId;
  final String merchantName;

  String pricerange;
  String businessstatus;
  final String locationstate;
  String calendar_type;
  final String profile_type;
  String intensity;
  final bool issubusersallowed;
  final int following;
  final int followers;
  final int likes;
  final int dislikes;
  final int views;
  final int comments;
  final int subusers;
  List<Message> messagessent = [];
  List<UserOpeningHour> openinghours = [];
  List<Message> messagesreceived = [];
  List<Message> recentchats = [];
  List<RecentChat> recentchats2 = [];
  List<Message> relevantmessages = [];
  List<Message> fullchat = [];
  List<List<Message>> fullchat2 = [];
  final String wifipassword;
  final String wifiname;
  final bool doublebooking;
  final bool appointmentapproval;
  List<UserBookmark> bookmarks = [];
  List<CalendarSchedule> calendarschedules = [];
  List<CartItem> cartitems = [];
  List<CalendarStatus> calendarstatuses = [];
  List<MeetingSchedule> meetingschedules = [];
  List<MeetingStatus> meetingstatuses = [];
  List<ReservationSchedule> reservationschedules = [];
  List<ReservationDeactivationMonth> reservationdeactivationmonths = [];
  List<UserTag> tags = [];
//List<Recommend> recommends = [];
  bool allowimagetosee = false;
  bool ismaderequest = false;
  bool likeresult = false;
  bool dislikeresult = false;
  String followrequestid = '';
  //api&device token

  User({
    //this.recommends,
    this.openinghours,
    this.wifipassword,
    this.wifiname,
    this.doublebooking,
    this.appointmentapproval,
    this.meetingschedules,
    this.meetingstatuses,
    this.recentchats2,
    this.reservationdeactivationmonths,
    this.reservationschedules,
    this.cartitems,
    this.ishotel,
    this.hotelclass,
    this.id,
    this.email,
    this.pricerange,
    this.businessstatus,
    this.locationcountry,
    this.messagecount,
    this.locationcity,
    this.locationstate,
    this.isprofileanon,
    this.intensity,
    this.parent,
    this.business_type,
    this.likes,
    this.comments,
    this.views,
    this.dislikes,
    this.followers,
    this.following,
    this.bookmarks,
    this.tags,
    this.recentchats,
    this.relevantmessages,
    this.messagessent,
    this.messagesreceived,
    this.isdetailsprivate,
    this.isnsfwallowed,
    this.isnstlallowed,
    this.issensitiveallowed,
    this.isspoilerallowed,
    this.username,
    this.full_name,
    this.calendar_type,
    this.calendar_ismultichoice,
    this.image,
    this.issubusersallowed,
    this.phone_number,
    this.sign_up_date,
    this.last_login,
    this.online,
    this.public_profile,
    this.open_now,
    this.birth_date,
    this.details,
    this.gatewayName,
    this.gatewayMerchantId,
    this.merchantId,
    this.merchantName,
    this.profile_type,
    this.calendarschedules,
    this.calendarstatuses,
    this.subusers,
  });

  factory User.fromJSON(Map<String, dynamic> jsonMap) {
    return User(
      id: jsonMap['id'] as String,
      email: jsonMap['email'] as String,
      online: jsonMap['online'] as bool,
      isprofileanon: jsonMap['isprofileanon'] as bool,
      isnsfwallowed: jsonMap['isnsfwallowed'] as bool,
      isdetailsprivate: jsonMap['isdetailsprivate'] as bool,
      gatewayName: jsonMap['gatewayname'] as String,
      gatewayMerchantId: jsonMap['gatewaymerchantid'] as String,
      merchantId: jsonMap['merchantid'] as String,
      merchantName: jsonMap['merchantname'] as String,
      isnstlallowed: jsonMap['isnstlallowed'] as bool,
      issensitiveallowed: jsonMap['issensitiveallowed'] as bool,
      isspoilerallowed: jsonMap['isspoilerallowed'] as bool,
      calendar_type: jsonMap['calendar_type'] as String,
      public_profile: jsonMap['public_profile'] as bool,
      wifipassword: jsonMap['wifipassword'] as String,
      wifiname: jsonMap['wifiname'] as String,
      doublebooking: jsonMap['doublebooking'] as bool,
      appointmentapproval: jsonMap['appointmentapproval'] as bool,
      open_now: jsonMap['open_now'] as bool,
      calendar_ismultichoice: jsonMap['calendar_ismultichoice'] as bool,
      username: jsonMap['username'] as String,
      details: jsonMap['details'] as String,
      pricerange: jsonMap['pricerange'] as String,
      businessstatus: jsonMap['businessstatus'] as String,
      business_type: jsonMap['business_type'] as String,
      parent: jsonMap['parent'] as String,
      full_name: jsonMap['fullname'] as String,
      image: jsonMap['image'] as String,
      phone_number: jsonMap['phone_number'] as String,
      sign_up_date: jsonMap['sign_up_date'] as String,
      last_login: jsonMap['last_login'] as String,
      birth_date: jsonMap['birth_date'] as String,
      profile_type: jsonMap['user_type'] as String,
      issubusersallowed: jsonMap['issubusersallowed'] as bool,
      ishotel: jsonMap['ishotel'] as bool,
      hotelclass: jsonMap['hotelclass'] as int,
      locationcountry: jsonMap['locationcountry'] as String,
      locationcity: jsonMap['locationcity'] as String,
      locationstate: jsonMap['locationstate'] as String,
      intensity: jsonMap['intensity'] as String,
      following: jsonMap['following'] as int,
      followers: jsonMap['followers'] as int,
      likes: jsonMap['likes'] as int,
      dislikes: jsonMap['dislikes'] as int,
      views: jsonMap['views'] as int,
      comments: jsonMap['comments'] as int,
      subusers: jsonMap['subusers'] as int,
      bookmarks: jsonMap["userbookmarks_set"] != null
          ? List<UserBookmark>.from(
              jsonMap["userbookmarks_set"].map((x) => UserBookmark.fromJSON(x)))
          : [],
      tags: jsonMap["usertags_set"] != null
          ? List<UserTag>.from(
              jsonMap["usertags_set"].map((x) => UserTag.fromJSON(x)))
          : [],
      calendarschedules: jsonMap["calendarschedules_set"] != null
          ? List<CalendarSchedule>.from(jsonMap["calendarschedules_set"]
              .map((x) => CalendarSchedule.fromJSON(x)))
          : [],
      calendarstatuses: jsonMap["calendarstatuses_set"] != null
          ? List<CalendarStatus>.from(jsonMap["calendarstatuses_set"]
              .map((x) => CalendarStatus.fromJSON(x)))
          : [],
      messagessent: jsonMap["usermessages_set"] != null
          ? List<Message>.from(
              jsonMap["usermessages_set"].map((x) => Message.fromJSON(x)))
          : [],
      messagesreceived: jsonMap["usermessages"] != null
          ? List<Message>.from(
              jsonMap["usermessages"].map((x) => Message.fromJSON(x)))
          : [],
      reservationdeactivationmonths:
          jsonMap["reservationdeactivationmonths_set"] != null
              ? List<ReservationDeactivationMonth>.from(
                  jsonMap["reservationdeactivationmonths_set"]
                      .map((x) => ReservationDeactivationMonth.fromJSON(x)))
              : [],
      reservationschedules: jsonMap["reservationschedules_set"] != null
          ? List<ReservationSchedule>.from(jsonMap["reservationschedules_set"]
              .map((x) => ReservationSchedule.fromJSON(x)))
          : [],
      meetingschedules: jsonMap["meetingschedules_set"] != null
          ? List<MeetingSchedule>.from(jsonMap["meetingschedules_set"]
              .map((x) => MeetingSchedule.fromJSON(x)))
          : [],
      meetingstatuses: jsonMap["meetingstatuses_set"] != null
          ? List<MeetingStatus>.from(jsonMap["meetingstatuses_set"]
              .map((x) => MeetingStatus.fromJSON(x)))
          : [],
      cartitems: jsonMap["cartitems_set"] != null
          ? List<CartItem>.from(
              jsonMap["cartitems_set"].map((x) => CartItem.fromJSON(x)))
          : [],
      openinghours: jsonMap["useropeninghours_set"] != null
          ? List<UserOpeningHour>.from(jsonMap["useropeninghours_set"]
              .map((x) => UserOpeningHour.fromJSON(x)))
          : [],
    );
  }

  ImageProvider<Object> isimage() {
    if (image != null) {
      return NetworkImage(image);
    }
    if (image == null) {
      return NetworkImage(
          'https://st2.depositphotos.com/4111759/12123/v/600/depositphotos_121233262-stock-illustration-male-default-placeholder-avatar-profile.jpg');
    }

    return NetworkImage(
        'https://st2.depositphotos.com/4111759/12123/v/600/depositphotos_121233262-stock-illustration-male-default-placeholder-avatar-profile.jpg');
  }

  @override
  operator ==(o) => o.id == id && o.username == username;

  @override
  int get hashCode => hashValues(id, username);

  bool hasparent() {
    if (parent == '') {
      return false;
    }
    if (parent == 'null') {
      return false;
    }
    if (parent == null) {
      return false;
    }
    return true;
  }

  String location() {
    if (locationstate == '' && locationcountry == '' && locationcity == '') {
      return '';
    }
    if (locationcity == '-' && locationstate == '-' && locationcountry == '-') {
      return '';
    }
    if (locationstate == '-' && locationcity == '-') {
      return '$locationcountry';
    }
    if (locationcity == '-') {
      return '$locationcountry,$locationstate';
    }
    if (locationcity == null &&
        locationstate == null &&
        locationcountry == null) {
      return '';
    }
    if (locationstate == null && locationcity == null) {
      return '$locationcountry';
    }
    if (locationcity == null) {
      return '$locationcountry,$locationstate';
    }

    if (locationcountry == locationstate && locationcity == null) {
      return '$locationcountry';
    }
    if (locationcountry == locationstate && locationcity == '-') {
      return '$locationcountry';
    }
    if (locationcountry == locationstate) {
      return '$locationcity,$locationcountry';
    }
    if (iscyprus == true) {
      return '$locationcity,$locationcountry';
    }
    if (iscyprus == false) {
      if (locationstate == '-' &&
          locationcountry == '-' &&
          locationcity == '-') {
        return '';
      }

      return '$locationcity,$locationstate,$locationcountry';
    }
  }

  String shouldshowuserinfo(User user, bool condition) {
    if (condition) {
      return 'followed';
    }
    if (user.public_profile == null) {
      return 'null';
    }
    if (user.public_profile) {
      return 'public';
    }
    return 'null';
  }

  bool isfollowingprofile(String userid, bool condition) {
    if (condition) {
      return true;
    }
    return false;
  }

  bool subuseratt(String parentid) {
    if (parent != parentid) {
      return false;
    }
    if (isprofileanon) {
      return false;
    }
    return true;
  }

  Widget intensityfuncicon2(dynamic context) {
    if (intensity == 'verybusy') {
      return Text(
        '$intensityst : $verybusyst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    if (intensity == 'busy') {
      return Text(
        '$intensityst : $busyst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    if (intensity == 'normal') {
      return Text(
        '$intensityst : $normalst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    if (intensity == 'idle') {
      return Text(
        '$intensityst : $idlest',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
      return Text(idlest);
    }
    if (intensity == 'quiet') {
      return Text(
        '$intensityst : $quietst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    return Container(height: 0, width: 0);
  }

  Widget pricerangefuncicon2(dynamic context) {
    if (pricerange == 'premium') {
      return Text(
        '$pricerangest : $premiumst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    if (pricerange == 'high') {
      return Text(
        '$pricerangest : $highst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    if (pricerange == 'standard') {
      return Text(
        '$pricerangest : $standardst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    if (pricerange == 'low') {
      return Text(
        '$pricerangest : $lowst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    return Container(height: 0, width: 0);
  }

  Widget businessstatusfuncicon2(dynamic context) {
    if (businessstatus == 'oas') {
      return Text(
        '$businessstatusst : $operatingasusualst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    if (businessstatus == 'sc') {
      return Text(
        '$businessstatusst : $underservicechangesst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    if (businessstatus == 'tc') {
      return Text(
        '$businessstatusst : $temporarilyclosedst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    if (businessstatus == 'fc') {
      return Text(
        '$businessstatusst : $permanentlyclosedst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    return Container(height: 0, width: 0);
  }

  String businessstatusfuncicontext() {
    if (businessstatus == 'oas') {
      return operatingasusualst;
    }
    if (businessstatus == 'sc') {
      return underservicechangesst;
    }
    if (businessstatus == 'tc') {
      return temporarilyclosedst;
    }
    if (businessstatus == 'fc') {
      return permanentlyclosedst;
    }
    return unspecifiedst;
  }

  String intensityfuncicontext() {
    if (intensity == 'verybusy') {
      return verybusyst;
    }
    if (intensity == 'busy') {
      return busyst;
    }
    if (intensity == 'normal') {
      return normalst;
    }
    if (intensity == 'idle') {
      return idlest;
    }
    if (intensity == 'quiet') {
      return quietst;
    }
    return unspecifiedst;
  }

  String pricerangefuncicontext() {
    if (pricerange == 'premium') {
      return premiumst;
    }
    if (pricerange == 'high') {
      return highst;
    }
    if (pricerange == 'standard') {
      return standardst;
    }
    if (pricerange == 'low') {
      return lowst;
    }
    return unspecifiedst;
  }

  Widget intensityfuncicon(dynamic context) {
    if (intensity == 'verybusy') {
      return Text(
        '$intensityst : $verybusyst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    if (intensity == 'busy') {
      return Text(
        '$intensityst : $busyst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    if (intensity == 'normal') {
      return Text(
        '$intensityst : $normalst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    if (intensity == 'idle') {
      return Text(
        '$intensityst : $idlest',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
      return Text(idlest);
    }
    if (intensity == 'quiet') {
      return Text(
        '$intensityst : $quietst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    return Text(
      '$intensityst : $unspecifiedst',
      style: TextStyle(
        color: colordtmaintwo,
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.of(context).size.height * 0.026,
      ),
    );
  }

  Widget pricerangefuncicon(dynamic context) {
    if (pricerange == 'premium') {
      return Text(
        '$pricerangest : $premiumst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    if (pricerange == 'high') {
      return Text(
        '$pricerangest : $highst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    if (pricerange == 'standard') {
      return Text(
        '$pricerangest : $standardst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    if (pricerange == 'low') {
      return Text(
        '$pricerangest : $lowst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    return Text(
      '$pricerangest : $unspecifiedst',
      style: TextStyle(
        color: colordtmaintwo,
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.of(context).size.height * 0.026,
      ),
    );
  }

  Widget businessstatusfuncicon(dynamic context) {
    if (businessstatus == 'oas') {
      return Text(
        '$businessstatusst : $operatingasusualst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    if (businessstatus == 'sc') {
      return Text(
        '$businessstatusst : $underservicechangesst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    if (businessstatus == 'tc') {
      return Text(
        '$businessstatusst : $temporarilyclosedst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    if (businessstatus == 'fc') {
      return Text(
        '$businessstatusst : $permanentlyclosedst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    if (businessstatus == '') {
      return Text(
        '$businessstatusst : $unspecifiedst',
        style: TextStyle(
          color: colordtmaintwo,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.026,
        ),
      );
    }
    return Text(unspecifiedst);
  }

  bool isfollowedprofile(User visiteduser, User user, bool followed2,
      bool unfollowed, bool condition1, bool condition2) {
    bool isfollowed = false;

    if (followed2 == true) {
      return true;
    }
    if (unfollowed == true) {
      return false;
    }

    if (condition1) {
      ismaderequest = true;
      return false;
    }
    if (condition2) {
      return true;
    }
    return isfollowed;
  }

  void followrequest(User user, User visiteduser) {
    FollowUserRequest(user.id, visiteduser.id);
    ismaderequest = true;
    return;
  }

  bool ismaderequestfunc(
      User user, User visiteduser, bool condition1, String condition2) {
    if (ismaderequest) {
      return true;
    }

    if (condition1) {
      followrequestid = condition2;
      ismaderequest = true;
      return true;
    }
    return false;
  }

  void cancelfollowrequest() {
    CancelFollowRequest(followrequestid);
    ismaderequest = false;
    return;
  }

  String profileimage() {
    return image;
  }

  bool islikedprofile(
      User visiteduser, User user, bool liked2, bool unliked, bool condition) {
    print('lr : $likeresult');
    bool isliked = false;
    if (liked2) {
      return true;
    }
    if (unliked && likeresult == false) {
      return false;
    }
    if (likeresult) {
      return true;
    }

    return isliked;
  }

  bool isdislikedprofile(User visiteduser, User user, bool disliked2,
      bool undisliked, bool condition) {
    bool isliked = false;
    if (disliked2 == true) {
      return true;
    }
    if (undisliked == true && dislikeresult == false) {
      return false;
    }
    if (dislikeresult) {
      return true;
    }

    return isliked;
  }
}

class UserMC {
  final String id;
  final int messagecount;
  final int messagecount2;
  //api&device token
  UserMC({this.id, this.messagecount, this.messagecount2});

  factory UserMC.fromJSON(Map<String, dynamic> jsonMap) {
    return UserMC(
      id: jsonMap['id'] as String,
      messagecount2: jsonMap['usermessages_set'] as int,
      messagecount: jsonMap['usermessages'] as int,
    );
  }
}

class RecentChat {
  final String id;
  String guest;
  List<Message> messages = [];
  DateTime time;
  String timestamp;
  RecentChat({this.id, this.guest, this.timestamp, this.time});

  String lastmessage() {
    if (messages.isNotEmpty) {
      return messages.last.content;
    }
    if (messages.isEmpty) {
      return '';
    }
    if (messages ?? true) {
      return '';
    }
  }

  void argumentt() {
    messages.forEach((item) {
      final formatter = DateFormat("yyyy-MM-ddThh:mm:ss");
      item.time = formatter.parse(item.timestamp);
    });
    messages.sort((b, a) => a.time.compareTo(b.time));
  }
}

class Message {
  final String id;
  final String authorinit;
  final String profileinit;
  DateTime time;
  final String
      timestamp; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String content;
  bool skip = false;
  bool ifitsyou = false;
  bool marked = false;

  Message({
    this.ifitsyou,
    this.id,
    this.time,
    this.authorinit,
    this.profileinit,
    this.content,
    this.timestamp,
    this.marked,
  });

  factory Message.fromJSON(Map<String, dynamic> jsonMap) {
    return Message(
      id: jsonMap['id'] as String,
      authorinit: jsonMap['author'] as String,
      profileinit: jsonMap['profile'] as String,
      content: jsonMap['content'] as String,
      timestamp: jsonMap['timestamp'] as String,
    );
  }

  DateTime formatDate() {
    final formatter = DateFormat("yyyy-MM-ddThh:mm:ss");
    final dateTimeFromStr = formatter.parse(timestamp);
    return dateTimeFromStr;
  }
}
