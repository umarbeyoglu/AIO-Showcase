

class BoughtCheck {
  final String id;
  final String author;
  final String owner;
  final double price;
  final int count;
  final String item;
  final String link;
  final String type;
  final String category;
  final String contact;
  final String fullname;
  final String deliverydate;
  final String deliveryfee;
  final String deliveryaddress;
  List<RequestItemChoice> choices = [];


  BoughtCheck({this.id,this.author,this.owner,this.price,this.contact,
  this.count,this.item,this.link,this.type,this.category,this.deliveryfee,
  this.fullname,this.deliverydate,this.deliveryaddress,this.choices});


  factory  BoughtCheck.fromJSON(Map<String, dynamic> jsonMap) {
    return  BoughtCheck(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      owner: jsonMap['owner'] as String,
      price: jsonMap['price'] as double,
      count : jsonMap['count'] as int,
      item: jsonMap['item'] as String,
      link: jsonMap['link'] as String,
      type: jsonMap['type'] as String,
      category: jsonMap['category'] as String,
      contact: jsonMap['contact'] as String,
      fullname: jsonMap['fullname'] as String,
      deliverydate: jsonMap['deliverydate'] as String,
      deliveryfee: jsonMap['deliveryfee'] as String,
      deliveryaddress: jsonMap['deliveryaddress'] as String,
      choices: jsonMap["boughtitemchoices_set"] != null ? List<BoughtItemChoice>.from( jsonMap["boughtitemchoices_set"].map((x) => BoughtItemChoice.fromJSON(x))) : [],

    );
  }}

class Meme {
  final String id;
  final String picture;


  Meme({this.id,this.picture});


  factory  Meme.fromJSON(Map<String, dynamic> jsonMap) {
    return  Meme(
      id: jsonMap['id'] as String,
      picture: jsonMap['blank'] as String,
    );
  }}


class UserTag {
  final String id;
  final String tag;
  final String author;


  UserTag({this.id,this.tag,this.author});


  factory  UserTag.fromJSON(Map<String, dynamic> jsonMap) {
    return  UserTag(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      tag: jsonMap['tag'] as String,
    );
  }}

class UserMail {
  final String id;
  final String mail;
  final String author;


  UserMail({this.id,this.mail,this.author});


  factory  UserMail.fromJSON(Map<String, dynamic> jsonMap) {
    return  UserMail(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      mail: jsonMap['mail'] as String,
    );
  }
}



class CartItem {
  final String id;
  final String author;
  final String owner;
  final String item;
  final String link;
  final String type;
  final String timestamp;
  final bool isfood;
  final String foodbusinesstype;
  final int count;
  final double price;
  List<CartItemChoice> choices = [];
  int countnow = 1;

  CartItem({this.id,this.author,this.owner,this.isfood,this.foodbusinesstype,this.choices,this.price,this.count,this.item,this.link,this.type,this.timestamp});

  factory  CartItem.fromJSON(Map<String, dynamic> jsonMap) {
    return  CartItem(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      owner: jsonMap['owner'] as String,
      item: jsonMap['item'] as String,
      link: jsonMap['link'] as String,
      isfood: jsonMap['isfood'] as bool,
      foodbusinesstype: jsonMap['foodbusinesstype'] as String,
      type: jsonMap['type'] as String,
      count: jsonMap['count'] as int,
      price: jsonMap['price'] as double,
      timestamp: jsonMap['timestamp'] as String,
      choices: jsonMap["cartitemchoices_set"] != null ? List<CartItemChoice>.from( jsonMap["cartitemchoices_set"].map((x) => CartItemChoice.fromJSON(x))) : [],

    );
  }

 void IncreaseCount(){
    countnow = countnow + 1;
    return;
 }
}

class RequestItem {
  final String id;
  final String author;
  final String profile;
  final String item;
  final String link;
  final String type;
  final String timestamp;
  List<RequestItemChoice> choices = [];
  final int count;
  final int price;

  RequestItem({this.id,this.author,this.choices,this.profile,this.price,this.count,this.item,this.link,this.type,this.timestamp});

  factory  RequestItem.fromJSON(Map<String, dynamic> jsonMap) {
    return  RequestItem(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      profile: jsonMap['profile'] as String,
      item: jsonMap['item'] as String,
      link: jsonMap['link'] as String,
      type: jsonMap['type'] as String,
      count: jsonMap['count'] as int,
      price: jsonMap['price'] as int,
      choices: jsonMap["requestitemchoices_set"] != null ? List<RequestItemChoice>.from( jsonMap["requestitemchoices_set"].map((x) => RequestItemChoice.fromJSON(x))) : [],
      timestamp: jsonMap['timestamp'] as String,
    );
  }}

class CartItemChoice {
  final String id;
  final String item;
  final String choice;
  final String category;
  final String timestamp;
  final int price;

  CartItemChoice({this.id,this.choice,this.price,this.category,this.item,this.timestamp});

  factory  CartItemChoice.fromJSON(Map<String, dynamic> jsonMap) {
    return  CartItemChoice(
      id: jsonMap['id'] as String,
      item: jsonMap['item'] as String,
      choice: jsonMap['choice'] as String,
      category: jsonMap['category'] as String,
      price: jsonMap['price'] as int,
      timestamp: jsonMap['timestamp'] as String,
    );
  }}

class BoughtItemChoice {
  final String id;
  final String item;
  final String choice;
  final String category;
  final String timestamp;
  final int price;

  BoughtItemChoice({this.id,this.choice,this.price,this.category,this.item,this.timestamp});

  factory  BoughtItemChoice.fromJSON(Map<String, dynamic> jsonMap) {
    return  BoughtItemChoice(
      id: jsonMap['id'] as String,
      item: jsonMap['item'] as String,
      choice: jsonMap['choice'] as String,
      category: jsonMap['category'] as String,
      price: jsonMap['price'] as int,
      timestamp: jsonMap['timestamp'] as String,
    );
  }}

class RequestItemChoice {
  final String id;
  final String item;
  final String choice;
  final String category;
  final String timestamp;
  final int price;

  RequestItemChoice({this.id,this.choice,this.price,this.category,this.item,this.timestamp});

  factory  RequestItemChoice.fromJSON(Map<String, dynamic> jsonMap) {
    return  RequestItemChoice(
      id: jsonMap['id'] as String,
      item: jsonMap['item'] as String,
      choice: jsonMap['choice'] as String,
      category: jsonMap['category'] as String,
      price: jsonMap['price'] as int,
      timestamp: jsonMap['timestamp'] as String,
    );
  }}

