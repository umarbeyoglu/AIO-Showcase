class ArticleLike {
  final String id;
  final String article;
  final String authorstring;
  final String timestamp;

  ArticleLike({this.id,this.article,this.timestamp,this.authorstring});


  factory  ArticleLike.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleLike(
      id: jsonMap['id'] as String,
      article: jsonMap['article'] as String,
      authorstring: jsonMap['author'] as String,
      timestamp:  jsonMap['timestamp'] as String,
    );
  }
}

class ArticleDislike {
  final String id;
  final String article;
  final String authorstring;
  final String timestamp;

  ArticleDislike({this.id,this.article,this.timestamp,this.authorstring});


  factory  ArticleDislike.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleDislike(
      id: jsonMap['id'] as String,
      article: jsonMap['article'] as String,
      authorstring: jsonMap['author'] as String,
      timestamp:  jsonMap['timestamp'] as String,
    );
  }
}

class UserLike {
  final String id;
  final String profile;
  final String author;
  final String timestamp;


  UserLike({this.id,this.author,this.timestamp,this.profile});


  factory  UserLike.fromJSON(Map<String, dynamic> jsonMap) {
    return  UserLike(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      profile:  jsonMap['profile'] as String,
      timestamp:  jsonMap['timestamp'] as String,
    );
  }



}

class UserDislike {
  final String id;
  final String profile;
  final String authorstring;
  final String timestamp;

  UserDislike({this.id,this.profile,this.timestamp,this.authorstring});


  factory  UserDislike.fromJSON(Map<String, dynamic> jsonMap) {
    return  UserDislike(
      id: jsonMap['id'] as String,
      profile: jsonMap['profile'] as String,
      authorstring: jsonMap['author'] as String,
      timestamp:  jsonMap['timestamp'] as String,
    );
  }
}



