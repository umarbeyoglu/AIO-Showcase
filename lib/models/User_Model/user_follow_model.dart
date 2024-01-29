class UserFollow {
  final String id;
  final String author;
  final String profile;
  final bool issilent;

  UserFollow({this.id, this.author, this.profile,this.issilent});

  factory UserFollow.fromJSON(Map<String, dynamic> jsonMap) {
    return  UserFollow(
      id: jsonMap['id'] as String,
      author:  jsonMap['author'] as String,
      profile: jsonMap['profile'] as String,
      issilent: jsonMap['issilent'] as bool,

    );
  }
}

class FollowingUserModel {
  final String id;
  final String author;
  final String profilestring;
  final bool issilent;

  FollowingUserModel({this.id, this.author, this.profilestring,this.issilent});

  factory FollowingUserModel.fromJSON(Map<String, dynamic> jsonMap) {
    return  FollowingUserModel(
      id: jsonMap['id'] as String,
      author:  jsonMap['author'] as String,
      profilestring: jsonMap['profile'] as String,
      issilent: jsonMap['issilent'] as bool,
    );
  }
}

class FollowersUserModel {
  final String id;
  final String profile;
  final String authorstring;
  final bool issilent;


  FollowersUserModel({this.id,this.authorstring,this.profile,this.issilent});


  factory  FollowersUserModel.fromJSON(Map<String, dynamic> jsonMap) {
    return  FollowersUserModel(
      id: jsonMap['id'] as String,
      authorstring: jsonMap['author'] as String,
      profile:  jsonMap['profile'] as String,
      issilent: jsonMap['issilent'] as bool,
    );
  }
}