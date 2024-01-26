
class CalendarTime {
  final String id;
  final String time;
  final String date;
  final String author;
  final bool allowstocks;
  final int stock;
  bool choseable = true;


  CalendarTime({this.id,this.time,this.stock,this.allowstocks,this.author,this.date,this.choseable});


  factory  CalendarTime.fromJSON(Map<String, dynamic> jsonMap) {
    return  CalendarTime(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      time: jsonMap['time'] as String,
      date: jsonMap['date'] as String,
      stock: jsonMap['stock'] as int,
      allowstocks: jsonMap['allowstocks'] as bool,
    );
  }



}