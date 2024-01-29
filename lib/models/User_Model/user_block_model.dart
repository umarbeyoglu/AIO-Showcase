class UserBlock {
  final String id;
  final String profile;
  final String author;


  UserBlock({this.id,this.author,this.profile});


  factory  UserBlock.fromJSON(Map<String, dynamic> jsonMap) {
    return  UserBlock(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      profile:  jsonMap['profile'] as String,
    );
  }
}