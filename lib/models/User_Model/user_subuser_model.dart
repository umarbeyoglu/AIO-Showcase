import 'package:untitled/models/User_Model/user_tags_model.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

import '../../colors.dart';
import '../../repository.dart';
import '../../screens/Profile_Screen/profile_image_screen.dart';


class UserPhone {
  final String id;
  final String phone;
  final String phonename;
  final bool iswp;
  final String author;


  UserPhone({this.id,this.author,this.phonename,this.phone,this.iswp});


  factory  UserPhone.fromJSON(Map<String, dynamic> jsonMap) {
    return  UserPhone(
      id: jsonMap['id'] as String,
      phone: jsonMap['phone'] as String,
      iswp: jsonMap['iswp'] as bool,
      phonename: jsonMap['phonename'] as String,
      author: jsonMap['author'] as String,
    );
  }



}





