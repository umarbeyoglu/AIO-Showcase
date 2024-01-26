import 'package:intl/intl.dart';

import '../../repository.dart';



class ArticleComment {
  final String id;
  final String authorstring;
  final String article;
  final String parent;
  final String content;
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
  ArticleComment({this.likes,this.dislikes,this.id,this.authorstring,this.article,this.parent,this.content,this.timestamp});


  factory  ArticleComment.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleComment(
      id: jsonMap['id'] as String,
      authorstring: jsonMap['author'] as String,
      article: jsonMap['article'] as String,
      parent: jsonMap['parent'] as String,
      content: jsonMap['content'] as String,
      timestamp: jsonMap['timestamp'] as String,      likes: jsonMap['likes'] as int,
      dislikes: jsonMap['dislikes'] as int,
    );
  }

  bool articleliked(String userid,bool liked,bool unliked,bool condition) {
    bool like1 = false;
    if (authorstring == userid){return true;}
    if (liked == true){return true;}
    if (liked2 == true){return true;}
    if (unliked == true && likeresult == false){return false;}
    if(likeresult){return true;}
    return like1;
  }

  void articleunlikeprocess(String userid,String condition) {

    UnlikeArticleComment(condition);
    liked2 = false;
    liked = false;
    unliked = true;
    likeresult = false;
  }

  bool articledisliked(String userid,bool disliked,bool undisliked,bool condition) {
    bool like1 = false;

    if (authorstring == userid){return true;}
    if (disliked == true){return true;}
    if (disliked2 == true){return true;}
    if (undisliked == true && dislikeresult == false){return false;}
    if(likeresult){return true;}
    return like1;
  }

  void articleundislikeprocess(String userid,String condition) {

    UndislikeArticleComment(condition);
    disliked2 = false;
    disliked = false;
    undisliked = true;
    dislikeresult = false;
  }

  DateTime formatDate() {
    final formatter = DateFormat("yyyy-MM-ddThh:mm:ss");
    final dateTimeFromStr = formatter.parse(timestamp);
    return dateTimeFromStr;
  }
}

class ArticleCommentLike {
  final String id;
  final String article;
  final String authorstring;
  final String timestamp;

  ArticleCommentLike({this.id,this.article,this.timestamp,this.authorstring});


  factory  ArticleCommentLike.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleCommentLike(
      id: jsonMap['id'] as String,
      article: jsonMap['article'] as String,
      authorstring: jsonMap['author'] as String,
      timestamp:  jsonMap['timestamp'] as String,
    );
  }
}

class ArticleCommentDislike {
  final String id;
  final String article;
  final String authorstring;
  final String timestamp;

  ArticleCommentDislike({this.id,this.article,this.timestamp,this.authorstring});


  factory  ArticleCommentDislike.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleCommentDislike(
      id: jsonMap['id'] as String,
      article: jsonMap['article'] as String,
      authorstring: jsonMap['author'] as String,
      timestamp:  jsonMap['timestamp'] as String,
    );
  }
}




