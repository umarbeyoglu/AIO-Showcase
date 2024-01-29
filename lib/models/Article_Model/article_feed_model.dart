import 'article_model.dart';
import 'article_model.dart';

class Feed{
  int count;
  String next;
  String previous;
  List<Article> posts;
  Feed({this.count,this.next,this.previous,this.posts});

  factory Feed.fromJson(Map<String, dynamic> json,categorycon) {
    if (json["results"] != null) {
      var results= json["results"] as List;
      List<Article> _results= results.map((list) => Article.fromJSON(list)).toList();
      List<Article> posts = _results.where((i) => i.category == categorycon).toList();
      return Feed(
          posts: posts,
          count: json["count"] as int,
          previous: json["previous"] as String,
          next: json["next"] as String
      );
    }
    return null;
  }
}