class ArticleView {
  final String id;
  final String article;
  final String authorstring;


  ArticleView({this.id,this.article,this.authorstring});


  factory  ArticleView.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleView(
      id: jsonMap['id'] as String,
      article: jsonMap['article'] as String,
      authorstring: jsonMap['author'] as String,
    );
  }
}