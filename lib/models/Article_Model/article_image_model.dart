import 'package:flutter/cupertino.dart';

class ArticleImage {
  final String id;
  final String article;
  final String author;
  final String image;
  
  ArticleImage({this.id,this.author,this.article,this.image});

  factory  ArticleImage.fromJSON(Map<String, dynamic> jsonMap) {
    return  ArticleImage(
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