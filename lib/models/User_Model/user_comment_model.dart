import 'package:intl/intl.dart';

import '../../repository.dart';

class UserComment {
  final String id;
  final String author;
  final String profile;
  final String content;
  final String category;
  final String timestamp;
  final int likes;
  final int dislikes;
  bool liked = false;
  bool liked2 = false;
  bool unliked = true;
  bool disliked = false;
  bool disliked2 = false;
  bool undisliked = true;
  bool dislikeresult = false;
  bool likeresult = false;
  UserComment({this.likes,this.dislikes,this.id,this.author,this.profile,this.content,this.timestamp,this.category});

  factory  UserComment.fromJSON(Map<String, dynamic> jsonMap) {
    return  UserComment(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      profile: jsonMap['profile'] as String,
      content: jsonMap['content'] as String,
      category: jsonMap['category'] as String,
      timestamp: jsonMap['timestamp'] as String,
      likes: jsonMap['likes'] as int,
      dislikes: jsonMap['dislikes'] as int,
    );
  }

  DateTime formatDate() {
    final formatter = DateFormat("yyyy-MM-ddThh:mm:ss");
    final dateTimeFromStr = formatter.parse(timestamp);
    return dateTimeFromStr;
  }
  bool articleliked(String userid,bool liked,bool unliked,bool condition) {
    bool like1 = false;
    if (author == userid){return true;}
    if (liked == true){return true;}
    if (liked2 == true){return true;}
    if (unliked == true && likeresult == false){return false;}
    if(likeresult){return true;}
    return like1;
  }

  void articleunlikeprocess(String userid,String condition) {

    UnlikeUserComment(condition);
    liked2 = false;
    liked = false;
    unliked = true;
    likeresult = false;
  }

  bool articledisliked(String userid,bool disliked,bool undisliked,bool condition) {
    bool like1 = false;

    if (author == userid){return true;}
    if (disliked == true){return true;}
    if (disliked2 == true){return true;}
    if (undisliked == true && dislikeresult == false){return false;}
    if(likeresult){return true;}
    return like1;
  }

  void articleundislikeprocess(String userid,String condition) {

    UndislikeUserComment(condition);
    disliked2 = false;
    disliked = false;
    undisliked = true;
    dislikeresult = false;
  }
}

class UserCommentLike {
  final String id;
  final String profile;
  final String author;
  final String timestamp;


  UserCommentLike({this.id,this.author,this.timestamp,this.profile});


  factory  UserCommentLike.fromJSON(Map<String, dynamic> jsonMap) {
    return  UserCommentLike(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      profile:  jsonMap['profile'] as String,
      timestamp:  jsonMap['timestamp'] as String,
    );
  }



}

class UserCommentDislike {
  final String id;
  final String profile;
  final String authorstring;
  final String timestamp;

  UserCommentDislike({this.id,this.profile,this.timestamp,this.authorstring});


  factory  UserCommentDislike.fromJSON(Map<String, dynamic> jsonMap) {
    return  UserCommentDislike(
      id: jsonMap['id'] as String,
      profile: jsonMap['profile'] as String,
      authorstring: jsonMap['author'] as String,
      timestamp:  jsonMap['timestamp'] as String,
    );
  }
}