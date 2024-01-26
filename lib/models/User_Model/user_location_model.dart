class UserLocation {
  final String id;
  final String location;
  final String locationname;
  final String author;


  UserLocation({this.id,this.location,this.locationname,this.author});


  factory  UserLocation.fromJSON(Map<String, dynamic> jsonMap) {
    return  UserLocation(
      id: jsonMap['id'] as String,
      author: jsonMap['author'] as String,
      location: jsonMap['location'] as String,
      locationname: jsonMap['locationname'] as String,
    );
  }



}