



class UserPhone {
  final String id;
  final String phone;
  final String phonename;
  final bool iswp;
  final String author;


  UserPhone({this.id,this.author,this.phonename,this.phone,this.iswp});


  factory  UserPhone.fromJSON(Map<String, dynamic> jsonMap) {
    return  UserPhone(
      id: jsonMap['id'] as String,
      phone: jsonMap['phone'] as String,
      iswp: jsonMap['iswp'] as bool,
      phonename: jsonMap['phonename'] as String,
      author: jsonMap['author'] as String,
    );
  }



}





