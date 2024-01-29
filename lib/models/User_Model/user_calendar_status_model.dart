class CalendarStatus {
  final String id;
  final String items;
  final String dates;
  final String times;
  final String author;


  CalendarStatus({this.id,this.items,this.dates,this.times,this.author});

  factory  CalendarStatus.fromJSON(Map<String, dynamic> jsonMap) {
    return  CalendarStatus(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      items: jsonMap['items'] as String,
      times: jsonMap['times'] as String,
      dates: jsonMap['dates'] as String,
    );
  }



}