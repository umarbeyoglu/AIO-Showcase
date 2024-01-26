class UserConfirm {
  final String id;
  final String profile;
  final String author;


  UserConfirm({this.id,this.author,this.profile});


  factory  UserConfirm.fromJSON(Map<String, dynamic> jsonMap) {
    return  UserConfirm(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      profile: jsonMap['profile'] as String,
    );
  }



}