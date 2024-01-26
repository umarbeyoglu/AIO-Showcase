

class ArticleSharedVideo {
  final String id;
  final String author;
  final String article;
  final String video;


  ArticleSharedVideo({this.id,this.author,this.article,this.video});


  factory  ArticleSharedVideo.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleSharedVideo(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      article: jsonMap['article'] as String,
      video: jsonMap['video'] as String,
    );
  }

}