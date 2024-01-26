

class UserBookmark {
  final String id;
  final String author;
  final String article;

  UserBookmark({this.id,this.author,this.article});

  factory  UserBookmark.fromJSON(Map<String, dynamic> jsonMap) {
    return  UserBookmark(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      article: jsonMap['article'] as String,
    );
  }



}