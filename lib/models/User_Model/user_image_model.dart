class UserImage {
  final String id;
  final String image;
  final String author;


  UserImage({this.id,this.image,this.author});


  factory  UserImage.fromJSON(Map<String, dynamic> jsonMap) {
    return  UserImage(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      image: jsonMap['image'] as String,
    );
  }



}