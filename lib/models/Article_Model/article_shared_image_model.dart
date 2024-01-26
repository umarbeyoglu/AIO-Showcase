import 'package:flutter/cupertino.dart';

class ArticleSharedImage {
  final String id;
  final String author;
  final String article;
  final String image;


  ArticleSharedImage({this.id,this.author,this.article,this.image});


  factory  ArticleSharedImage.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleSharedImage(
      id: jsonMap['id'] as String,
      article: jsonMap['article'] as String,
      author: jsonMap['author'] as String,
      image: jsonMap['image'] as String,
    );
  }
  Image carouselimages(){
    if(image.isNotEmpty){
      return Image.network(image,fit: BoxFit.fitWidth,);
    }
    else if (image == null){
      return Image.network('https://t4.ftcdn.net/jpg/02/07/87/79/360_F_207877921_BtG6ZKAVvtLyc5GWpBNEIlIxsffTtWkv.jpg',fit: BoxFit.fitWidth,);
    }
  }
}