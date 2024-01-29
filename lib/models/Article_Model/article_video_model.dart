class ArticleVideo {
  final String id;
  final String article;
  final String video;
  final String author;


  ArticleVideo({this.id,this.article,this.author,this.video});


  factory  ArticleVideo.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleVideo(
      id: jsonMap['id'] as String,
      article: jsonMap['article'] as String,
      author: jsonMap['author'] as String,
      video: jsonMap['video'] as String,
    );
  }
}
