class ArticleTaggedUser {
  final String id;
  final String article;
  final String profile;
  final String author;
  final String username;
  final String timestamp;


  ArticleTaggedUser({this.id,this.article,this.timestamp,this.author,this.profile,this.username});


  factory  ArticleTaggedUser.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleTaggedUser(
      id: jsonMap['id'] as String,
      article: jsonMap['article'] as String,
      profile: jsonMap['profile'] as String,
      author: jsonMap['author'] as String,
      timestamp: jsonMap['timestamp'] as String,
      username: jsonMap['username'] as String,
    );
  }
}