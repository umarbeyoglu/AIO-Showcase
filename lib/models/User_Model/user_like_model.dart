
class UserView {
  final String id;
  final String profile;
  final String author;


  UserView({this.id,this.author,this.profile});


  factory  UserView.fromJSON(Map<String, dynamic> jsonMap) {
    return  UserView(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      profile:  jsonMap['profile'] as String,
    );
  }



}