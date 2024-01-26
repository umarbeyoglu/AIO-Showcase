import 'dart:math';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:ayhancarrental/screens/Authentication_Screen/authentication_login_screen.dart';
import 'package:ayhancarrental/screens/General/choice_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:csc_picker/csc_picker.dart';
import 'package:dio_http/dio_http.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ayhancarrental/models/Article_Model/article_tagged_user_model.dart';
import 'package:ayhancarrental/models/User_Model/user_calendar_schedule_model.dart';
import 'package:ayhancarrental/screens/General/comments_screen.dart';
import 'package:ayhancarrental/screens/General/home_screen.dart';
import 'package:ayhancarrental/screens/General/search_screen.dart';
import 'package:ayhancarrental/screens/Visited_Profile_Screen/visited_profile_screen.dart';
import 'models/Article_Model/article_comment_model.dart';
import 'models/Article_Model/article_like_model.dart';
import 'models/Article_Model/article_model.dart';
import 'models/Article_Model/article_tag_model.dart';
import 'models/User_Model/notification_model.dart';
import 'models/User_Model/user_block_model.dart';
import 'models/User_Model/user_bookmark_model.dart';
import 'models/User_Model/user_calendar_item_model.dart';
import 'models/User_Model/user_calendar_status_model.dart';
import 'models/User_Model/user_comment_model.dart';
import 'models/User_Model/user_follow_model.dart';
import 'models/User_Model/user_location_model.dart';
import 'models/User_Model/user_model.dart';
import 'models/User_Model/user_subuser_model.dart';
import 'models/User_Model/user_tags_model.dart';

import 'colors.dart';
import 'language.dart';
//'http://10.0.2.2:8000'
// 'http://192.168.1.107:8000'
// 'https://welpie.net'
const SERVER_IP = 'http://10.0.2.2:8000';


class ChoiceCategoryModel {
  TextEditingController title;
  List<ChoiceModel> choices = [];
  bool allchooseable = true;
  String type = '';
  ChoiceCategoryModel({this.title,this.type,});

  TextEditingController titlechange() {
    print(title.text);
    return title ?? TextEditingController(text: '');
  }
}

class ChoiceModel {
  TextEditingController item;
  TextEditingController price;
  ChoiceModel({this.item,this.price});

  TextEditingController hintchange() {
    print(item.text);
    return item ?? TextEditingController(text: '');
  }

  TextEditingController pricechange() {
    print(price.text);
    return price ?? TextEditingController(text: '');
  }
}

getFileSize(String filepath) async {
  var file = File(filepath);
  int bytes = await file.length();
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(1)) + ' ' + suffixes[i];
}

Future<bool> FileSizeLimitVideo(String filepath) async{
  String size1 = await getFileSize(filepath);

  List<String> size2 = size1.split(' ');
  double number = double.parse(size2.first.toString());
  String suffix = size2.last.toString();
  print('$suffix');
  print('$number');

  if(
  suffix == "MB" && number > 500.0
  ){ print('a');
    return true;
  }

  if(
      suffix == "GB" ||
      suffix == "GB" ||
      suffix == "TB" ||
      suffix == "PB" ||
      suffix == "EB" ||
      suffix == "ZB" ||
      suffix == "YB"
  ){ print('b');
    return true;
  }
  print('c');
  return false;
}

Future<bool> FileSizeLimitImage(String filepath) async{
  List<String> size2 = getFileSize(filepath).split(' ');
  double number = double.parse(size2.first);
  String suffix = size2.last;

  if(suffix == "MB" && number > 20){
    return true;
  }

  if(
  suffix == "GB" ||
      suffix == "GB" ||
      suffix == "TB" ||
      suffix == "PB" ||
      suffix == "EB" ||
      suffix == "ZB" ||
      suffix == "YB"
  ){
    return true;
  }
  return false;
}

bool iscyprus = false;
String globalvisiteduserid = '';
List<User> taggedusers = [];
List<ChoiceCategoryModel> choices = [];
List<DetailCategoryModel> detailcategories = [];
String createpersonprofiletype = 'P';
String languagest = 'EN';
String originalarticle = '';
String feedbackcategory = 'A';
String notificationcategory = 'All';
bool loadedimages = false;
List<Message> chats = [];
List<Message> messages = [];
List<User> globalusers = [];
String globaltoken = '';
String globaltoken2 = '';


bool searchbasedonlocation = false;

bool isuphdone = false;


String locationcountrygl = '-';
String locationstategl = '-';
String locationcitygl = '-';

List<String> dateschosenmain = [];
List<String> itemschosenmain = [];
List<String> timeschosenmain = [];
String tcmf = '';
String icmf = '';
String dcmr = '';
List<String> icmr = [];
String tcmr = '';

String YearNow(){
  String yearnow = DateTime.now().toString().substring(0,4);
  return '$yearnow';
}

String DateNow(){
  String yearnow = DateTime.now().toString().substring(0,4);
  String monthnow = DateTime.now().toString().substring(5,7);
  String daynow = DateTime.now().toString().substring(8,10);
  return '$yearnow-$monthnow-$daynow';
}

void DayNow(){
  String yearnow = DateTime.now().toString().substring(0,4);
  String monthnow = DateTime.now().toString().substring(5,7);
  String daynow = DateTime.now().toString().substring(8,10);
  String hournow = DateTime.now().toString().substring(11,13);
  String minutenow = DateTime.now().toString().substring(14,16);
  String secondnow = DateTime.now().toString().substring(17,19);
  return;
}


PercentageCalculator(int like,int dislike){
  double int1 = (like-dislike)/dislike ;
  double int2 = int1 * 100;
  return int2;
}


ChooseLocation(dynamic context){
  return iscyprus ?showDialog(

    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actions: [
          InkWell(
            child:Text(clearst,style:TextStyle(fontSize:25)),
            onTap:(){
              locationcountrygl = '-';
              locationstategl = '-';
              locationcitygl = '-';
              print('$locationcountrygl $locationstategl $locationcitygl');
              Navigator.pop(context);
            },
          ),
        ],
        title: Text(locationst),

        content: Column(
          children:[

            for (final item in cities)
          Padding(
            padding:EdgeInsets.only(top:20),
            child:    SizedBox(child: InkWell(
              child:Text(item),
              onTap: (){
                glcn = 'Cyprus';
                glst = 'Cyprus';
                glct = item;
                locationcountrygl = 'Cyprus';
                locationstategl = 'Cyprus';
                locationcitygl = item;
                print('$locationcountrygl $locationstategl $locationcitygl');
                Navigator.pop(context);
              },
            ),),
          ),
          ],
        ),
      );
    },
  ): showDialog(

    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actions: [
          ElevatedButton(child: Text('Done'),onPressed: (){
            Navigator.pop(context);
          })
        ],
        title: Text(locationst),
        insetPadding: EdgeInsets.symmetric(vertical: 150),

        content: CSCPicker(
          showStates: true,
          showCities: true,
          flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
          dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: colordtmainone,
              border: Border.all(color: Colors.grey.shade300, width: 1)),
          disabledDropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.grey.shade300,
              border: Border.all(color: Colors.grey.shade300, width: 1)),
          selectedItemStyle: TextStyle(color: colordtmaintwo, fontSize: 14,),
          dropdownHeadingStyle: TextStyle(color: colordtmaintwo, fontSize: 17, fontWeight: FontWeight.bold),
          dropdownItemStyle: TextStyle(color: colordtmaintwo,fontSize: 14, ),
          dropdownDialogRadius: 10.0,
          searchBarRadius: 10.0,
          onCountryChanged: (value) {
            glcn = value;
            locationcountrygl = value;},
          onStateChanged: (value) {locationstategl = value;
          glst = value;
          },
          onCityChanged: (value) {locationcitygl = value;
          glct = value;
          },
        ),);
    },
  );

}

String glcn = '';
String glst = '';
String glct = '';


UserData(String email,String password,) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("email", email);
  prefs.setString("password", password);
}

LocationData(bool iscyprus) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("iscyprus", iscyprus);
}

getLocationData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.getBool("iscyprus");
}

LanguageData(String language,bool languageset) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("language", language);
  prefs.setBool("languageset", languageset);

}

List<String> TagSuggestion(String tagfield){
  List<String> tagsentered = tagfield.toLowerCase().split(',');
  String tag = tagsentered.last.toLowerCase();

  for(int i1=0;i1<tagsentered.length;i1++){

    //check if size,brand is entered and eliminate them from the way
  }

  if(tag == ''){return [];}
  else return [];
}

List<String> LaptopSugg(String tag){
  List<String> laptopsizes = ['13 Inch','15 Inch','17 Inch'];
  List<String> laptopbrands = ['Samsung','Apple','HP'];
  if (tag == 'laptop'){return laptopsizes;}
  if (tag == '13 inch'){return laptopbrands;}
  if (tag == '15 inch'){return laptopbrands;}
  if (tag == '17 inch'){return laptopbrands;}
}


Future<Widget> SignInUser(String email, String password,bool check) async {
  isuphdone = false;
  User _user;

  if(check == false){
    return LoginScreen();
  }

  print('aa');
  WidgetsFlutterBinding.ensureInitialized();
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/auth/"),
    body: jsonEncode(<String, String>{
      'username': email,
      'password': password,
    }),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=utf-8'
    },
  );

  if (response.statusCode == 200) {

    var responseJson = json.decode(response.body);
    globaltoken = responseJson['token'];
    final http.Response response2 = await http.get(Uri.parse("$SERVER_IP/api/ownuser/"),
      headers: <String, String>{
        "Authorization" : "Token $globaltoken"
      },);
    if (response2.statusCode == 200) {
      var responseJson = jsonDecode(utf8.decode(response2.bodyBytes));
      _user = User.fromJSON(responseJson[0]);
         return HomeScreen(user:_user);

    }

  }

  else{
    return LoginScreen();
  }
}

Future<User> DeleteUserPublic(String id) async {
  final http.Response response = await http.delete(
      Uri.parse("$SERVER_IP/api/unusers/$id/"),
    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('User deleted successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<User> DeleteMessage(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/usermessages/$id/"),
    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('message deleted successfully');
  }

  else {
    throw new Exception(response.body);
  }
}



Future<User> DeleteUserPrivate(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/privateusers/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('User deleted successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

EditCartItemCount(CartItem cartitem,int count) async {


  try {


    FormData formData = new FormData.fromMap({
      'author': cartitem.author,
      'item': cartitem.item,
      'link': cartitem.link,
      'type': cartitem.type,
      'isfood' : cartitem.isfood,
      'foodbusinesstype' : cartitem.foodbusinesstype,
      'count': count,
      'price': cartitem.price,


    });
    Response response = await Dio().patch("$SERVER_IP/api/cartitems/${cartitem.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');



  } catch (e) {
    print('EU: $e');
  }

}



EditUserPriceRange(User user,String intensity,dynamic context) async {
  print(user.parent);

  try {



    FormData formData = new FormData.fromMap({
      'fullname' : user.full_name ,
      'locationcountry' : user.locationcountry ,
      'locationstate' : user.locationstate ,
      'locationcity' :  user.locationcity ,
      'phone_number' :  user.phone_number,
      'details' : user.details ,
      "business_type": user.business_type ,
      'calendar_type': user.calendar_type ,
      'pricerange':intensity,
      'businessstatus' : user.businessstatus,
      'gatewayname':user.gatewayName,
          'gatewaymerchantid':user.gatewayMerchantId,
          'merchantid':user.merchantId,
          'merchantname':user.merchantName,
      'issubusersallowed': user.issubusersallowed,
      'isprofileanon': user.isprofileanon,
      'public_profile': user.public_profile,
      'isdetailsprivate' : user.isdetailsprivate,
      'isnsfwallowed': user.isnsfwallowed ,
      'isnstlallowed': user.isnstlallowed ,
      'ishotel' : user.ishotel,
      'hotelclass' : user.hotelclass,
      'issensitiveallowed': user.issensitiveallowed ,
      'isspoilerallowed' : user.isspoilerallowed ,
      'calendar_ismultichoice' : user.calendar_ismultichoice,
      'intensity' : user.intensity,
      'wifiname': user.wifiname,
      'wifipassword' : user.wifipassword,
    });
    Response response = await Dio().patch("$SERVER_IP/api/ownuser/${user.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');

    locationcountrygl= '';
    locationstategl = '';
    locationcitygl = '';

  } catch (e) {
    print('EU: $e');
  }

}

EditUserBusinessType(User user,String businesstype) async {


  try {



    FormData formData = new FormData.fromMap({
      'fullname' : user.full_name ,
      'locationcountry' : user.locationcountry ,
      'locationstate' : user.locationstate ,
      'locationcity' :  user.locationcity ,
      'phone_number' :  user.phone_number,
      'details' : user.details ,
      'ishotel' : user.ishotel,
      'hotelclass' : user.hotelclass,
      "business_type": businesstype,
      'gatewayname':user.gatewayName,
      'gatewaymerchantid':user.gatewayMerchantId,
      'merchantid':user.merchantId,
      'merchantname':user.merchantName,
      'calendar_type': user.calendar_type ,
      'pricerange':user.pricerange,
      'businessstatus' : user.businessstatus,
      'wifiname': user.wifiname,
      'wifipassword' : user.wifipassword,
      'issubusersallowed': user.issubusersallowed,
      'isprofileanon': user.isprofileanon,
      'public_profile': user.public_profile,
      'isdetailsprivate' : user.isdetailsprivate,
      'isnsfwallowed': user.isnsfwallowed ,
      'isnstlallowed': user.isnstlallowed ,
      'issensitiveallowed': user.issensitiveallowed ,
      'isspoilerallowed' : user.isspoilerallowed ,
      'calendar_ismultichoice' : user.calendar_ismultichoice,
      'intensity' : user.intensity,

    });
    Response response = await Dio().patch("$SERVER_IP/api/ownuser/${user.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');

    locationcountrygl= '';
    locationstategl = '';
    locationcitygl = '';

  } catch (e) {
    print('EU: $e');
  }

}

EditUserBusinessStatus(User user,String intensity,dynamic context) async {


  try {



    FormData formData = new FormData.fromMap({
      'fullname' : user.full_name ,
      'ishotel' : user.ishotel,
      'hotelclass' : user.hotelclass,
      'locationcountry' : user.locationcountry ,
      'locationstate' : user.locationstate ,
      'locationcity' :  user.locationcity ,
      'phone_number' :  user.phone_number,
      'details' : user.details ,
      "business_type": user.business_type ,
      'gatewayname':user.gatewayName,
      'gatewaymerchantid':user.gatewayMerchantId,
      'merchantid':user.merchantId,
      'merchantname':user.merchantName,
      'calendar_type': user.calendar_type ,
      'pricerange':user.pricerange,
      'businessstatus' : intensity,
      'wifiname': user.wifiname,
      'wifipassword' : user.wifipassword,
      'issubusersallowed': user.issubusersallowed,
      'isprofileanon': user.isprofileanon,
      'public_profile': user.public_profile,
      'isdetailsprivate' : user.isdetailsprivate,
      'isnsfwallowed': user.isnsfwallowed ,
      'isnstlallowed': user.isnstlallowed ,
      'issensitiveallowed': user.issensitiveallowed ,
      'isspoilerallowed' : user.isspoilerallowed ,
      'calendar_ismultichoice' : user.calendar_ismultichoice,
      'intensity' : user.intensity,

    });
    Response response = await Dio().patch("$SERVER_IP/api/ownuser/${user.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');

    locationcountrygl= '';
    locationstategl = '';
    locationcitygl = '';

  } catch (e) {
    print('EU: $e');
  }

}

EditUserIntensity(User user,String intensity,dynamic context) async {
   print(user.parent);

   try {



    FormData formData = new FormData.fromMap({
      'fullname' : user.full_name ,
      'ishotel' : user.ishotel,
      'hotelclass' : user.hotelclass,
      'locationcountry' : user.locationcountry ,
      'locationstate' : user.locationstate ,
      'locationcity' :  user.locationcity ,
      'phone_number' :  user.phone_number,
      'details' : user.details ,
      "business_type": user.business_type ,
      'gatewayname':user.gatewayName,
      'gatewaymerchantid':user.gatewayMerchantId,
      'merchantid':user.merchantId,
      'merchantname':user.merchantName,
      'calendar_type': user.calendar_type ,
      'pricerange':user.pricerange,
      'businessstatus' : user.businessstatus,
      'wifiname': user.wifiname,
      'wifipassword' : user.wifipassword,
      'issubusersallowed': user.issubusersallowed,
      'isprofileanon': user.isprofileanon,
      'public_profile': user.public_profile,
      'isdetailsprivate' : user.isdetailsprivate,
      'isnsfwallowed': user.isnsfwallowed ,
      'isnstlallowed': user.isnstlallowed ,
      'issensitiveallowed': user.issensitiveallowed ,
      'isspoilerallowed' : user.isspoilerallowed ,
      'calendar_ismultichoice' : user.calendar_ismultichoice,
      'intensity' : intensity,

    });
    Response response = await Dio().patch("$SERVER_IP/api/ownuser/${user.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');

    locationcountrygl= '';
    locationstategl = '';
    locationcitygl = '';

  } catch (e) {
    print('EU: $e');
  }

}

EditUserCalendar(User user,String calendartype,bool ismultichoice) async {

  try {

    FormData formData = new FormData.fromMap({
      'fullname' : user.full_name ,
      'locationcountry' : user.locationcountry ,
      'locationstate' : user.locationstate ,
      'locationcity' :  user.locationcity ,
      'phone_number' :  user.phone_number,
      'details' : user.details ,
      'ishotel' : user.ishotel,
      'hotelclass' : user.hotelclass,
      "business_type": user.business_type ,
      'gatewayname':user.gatewayName,
      'gatewaymerchantid':user.gatewayMerchantId,
      'merchantid':user.merchantId,
      'merchantname':user.merchantName,
      'pricerange':user.pricerange,
      'businessstatus' : user.businessstatus,
      'issubusersallowed': user.issubusersallowed,
      'isprofileanon': user.isprofileanon,
      'public_profile': user.public_profile,
      'isdetailsprivate' : user.isdetailsprivate,
      'isnsfwallowed': user.isnsfwallowed ,
      'isnstlallowed': user.isnstlallowed ,
      'issensitiveallowed': user.issensitiveallowed ,
      'isspoilerallowed' : user.isspoilerallowed ,
      'calendar_type': calendartype ,
      'calendar_ismultichoice' : ismultichoice,
      'intensity' : user.intensity,
      'wifiname': user.wifiname,
      'wifipassword' : user.wifipassword,
    });
    Response response = await Dio().patch("$SERVER_IP/api/ownuser/${user.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');


    locationcountrygl= '';
    locationstategl = '';
    locationcitygl = '';
  } catch (e) {
    print('EU: $e');
  }

}

EditUser(String userid,String firstname,String locationcountry,String locationstate,String locationcity,String phone,String about,User user1,File image,List<String> tags,
    List<String> locationtags,List<String> phonetags,String gender,String calendartype,bool ismultichoice,String businesstype,
    bool nstl,bool nsfw,bool sensitive,bool spoiler,bool privatedetails,bool isprivate,bool allowsubusers,int hotelclass,bool ishotel) async {

   String imagename;



   imagename = image == null ? 'empty' : ( imagename = image.path.split('/').last);
  try {

    if(imagename == 'empty'){

      }
    else if(imagename !=  'empty')
      {
        FormData formDatee = new FormData.fromMap({
          'image' : await MultipartFile.fromFile(image.path, filename:imagename),
        });
         await Dio().patch("$SERVER_IP/api/ownuser/$userid/", data: formDatee,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} // set content-length},
         ));
      }

    FormData formData = new FormData.fromMap({
      'fullname' : firstname == 'null' ? user1.full_name : firstname,
      'locationcountry' : locationcountrygl == 'null' ? user1.locationcountry : locationcountrygl,
      'locationstate' : locationstategl == 'null' ? user1.locationstate : locationstategl,
      'locationcity' : locationcitygl == 'null' ? user1.locationcity : locationcitygl,
      'phone_number' : phone == 'null' ? user1.phone_number : phone,
      'details' : about == 'null' ? user1.details : about,
      "business_type": businesstype == 'null' ? user1.business_type : businesstype,
      'calendar_type': calendartype == 'null' ? user1.calendar_type : calendartype,
      'wifiname': user1.wifiname,
      'wifipassword' : user1.wifipassword,
      'issubusersallowed': allowsubusers,
      'isprofileanon': user1.isprofileanon,
      'public_profile': isprivate,
      'isdetailsprivate' : privatedetails,
      'isnsfwallowed': nsfw ,
      'isnstlallowed': nstl ,
      'issensitiveallowed': sensitive ,
      'isspoilerallowed' : spoiler ,
      'calendar_ismultichoice' : ismultichoice,
      'ishotel' : ishotel,
      'hotelclass' : hotelclass,

    });
    Response response = await Dio().patch("$SERVER_IP/api/ownuser/$userid/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');

    locationcountrygl= '';
    locationstategl = '';
    locationcitygl = '';

  } catch (e) {
    print('EU: $e');
  }

}

Future<Article> DeleteArticle(String id) async {
  final http.Response response = await http.delete(
      Uri.parse("$SERVER_IP/api/articles/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Post deleted successfully');
  }

  else {
    throw new Exception(response.body);
  }
}



//  'article' : '385395ec-dec8-472f-973f-b4f27755a658',
//       //'article' : 'a3fba233-5e52-4629-9390-9b6abaa24671',

CreatePostImage(String author,String article,File image) async {

  String imagename = '${author}_${image.path.split('/').last}';
  print(image.path.split('/').last);
  try {
    FormData formData = new FormData.fromMap({
      'article' : article,
      'image' : await MultipartFile.fromFile(image.path, filename:imagename),
    });

    Response response = await Dio().post("$SERVER_IP/api/articleimages/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} ));

    if(response.statusCode == 201){
      print('Created Image');
    }
    else{
     print(response.statusCode);
     print(response.data.toString());
    }

  } catch (e) {
    print(e);
  }
}








Future<ArticleComment> DeleteArticleComment(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/articlecomments/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Comment deleted successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

CreateUserComment(String author,String receiver,String content,String category) async {
  try {
    FormData formData = new FormData.fromMap({
      'author' : author,
      'profile' : receiver,
      'content' : content,
      'category' : category,
    });

    Response response = await Dio().post("$SERVER_IP/api/usercomments/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} ));
    print(response.toString());
  } catch (e) {
    print(e);
  }
}

Future<UserComment> DeleteUserComment(String id) async {
  final http.Response response = await http.delete(
      Uri.parse("$SERVER_IP/api/usercomments/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Feedback deleted successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<User> CreateMeetingScheduleRequest(String author,String profile,String date,String time,String link) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/requests/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'profile': profile,
      'date': date,
      'time': time,
      'link': link,
      'fullname' : '-',
      'clientnow' : false,
      'isdenied' : false,
      'isaccepted' : false,
      'requesttype' : 'meeting',
      'contact' : '-',
      'deliverydate' : '-',
      'deliveryaddress' : '-',
    }),
  );

  if (response.statusCode == 201) {
    print('Created meeting schedule request successfully');
  }


  else {
    throw new Exception(response.body);
  }
}

Future<List<MeetingStatus>> FetchOwnMeetingStatus(http.Client client,String userid,int page) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/meetingstatuses/?page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  return parsed["results"] != null ? new List<MeetingStatus>.from( parsed["results"].map((x) => MeetingStatus.fromJSON(x))) : List<MeetingStatus>();
}

Future<User> RemoveMeetingStatus(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/meetingstatuses/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Meeting status ${id} deleted Succesfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<User> CreateMeetingStatus(String author,User user,dynamic context) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/meetingstatuses/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'dates': dateschosenmain.join(),
      'items': icmf,
      'times': tcmf,
    }),
  );

  if (response.statusCode == 201) {
    print('Created meeting status successfully');
    final response = await http.get(Uri.parse("$SERVER_IP/api/meetingstatuses/?format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    List<MeetingStatus> item = parsed["results"] != null ? new List<MeetingStatus>.from( parsed["results"].map((x) => MeetingStatus.fromJSON(x))) : List<MeetingStatus>();
    user.meetingstatuses = item;
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user: user)));

  }


  else {
    throw new Exception(response.body);
  }
}


Future<User> CreateCalendarStatus(String author,User user,dynamic context) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/calendarstatuses/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'dates': dateschosenmain.join(),
      'items': icmf,
      'times': tcmf,
    }),
  );

  if (response.statusCode == 201) {
    print('Created calendar status successfully');
    final response = await http.get(Uri.parse("$SERVER_IP/api/calendarstatuses/?format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    List<CalendarStatus> item = parsed["results"] != null ? new List<CalendarStatus>.from( parsed["results"].map((x) => CalendarStatus.fromJSON(x))) : List<CalendarStatus>();
    user.calendarstatuses = item;
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user: user)));

  }


  else {
    throw new Exception(response.body);
  }
}

Future<User> CreateCalendarStatusCTT(String author,User user,dynamic context) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/calendarstatuses/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'items': icmf,
      'dates' : '-',
      'times' : '-',
    }),
  );

  if (response.statusCode == 201) {
    print('Created calendar status successfully');
    final response = await http.get(Uri.parse("$SERVER_IP/api/calendarstatuses/?format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    List<CalendarStatus> item =  parsed.map<CalendarStatus>((json) => CalendarStatus.fromJSON(json)).toList();
    user.calendarstatuses = item;
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user: user)));
  }


  else {
    throw new Exception(response.body);
  }
}












Future<User> RemoveDeactivationMonth(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/reservationdeactivationmonths/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Calendar status ${id} deleted Succesfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<User> RemoveCalendarStatus(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/calendarstatuses/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Calendar status ${id} deleted Succesfully');
  }

  else {
    throw new Exception(response.body);
  }
}


Future<User> RemoveCalendarTime(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/calendartimes/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Calendar time ${id} deleted Succesfully');
  }

  else {
    throw new Exception(response.body);
  }
}



Future<User> RemoveCalendarScheduleRequest(String id) async {
  print(id);
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/requests/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
  );

  if (response.statusCode == 204) {
    print('Removed calendar schedule request $id successfully');
  }


  else {
    throw new Exception(response.body);
  }
}


Future<User> RemoveCalendarSchedule(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/calendarschedules/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
  );

  if (response.statusCode == 204) {
    print('Removed calendar schedule $id successfully');
  }


  else {
    throw new Exception(response.body);
  }
}
Future<User> RemoveMeetingSchedule(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/meetingschedules/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
  );

  if (response.statusCode == 204) {
    print('Removed calendar schedule $id successfully');
  }


  else {
    throw new Exception(response.body);
  }
}






Future<User> CreateCalendarSchedule(User user,String author,String profile,String item,String date,String time) async {
  print('Profile : $profile');
  print('You: $author');
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/calendarschedules/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'profile': profile,
      'date': date,
      'time': time,
      'item': item,
    }),
  );

  if (response.statusCode == 201) {
    print('Created calendar schedule request successfully');
  }


  else {
    throw new Exception(response.body);
  }
}

EditCalendarScheduleRequest(String id,String author,String profile,String item,String date,String time,bool clientnow,bool isdenied) async {
  print(author);
  print(profile);
  print(date);
  print(item);
  print(time);
  print(clientnow);
  print(isdenied);


  try {

    FormData formData = new FormData.fromMap({
    'author': author,
    'profile': profile,
    'date': date,
    'time': time,
    'item': item,
      'clientnow': clientnow,
      'isdenied': isdenied,
      'fullname' : '-',
      'group' : '',
      'link' : '-',
      'deliverydate' : '-',
      'requesttype' : 'calendar',
          'contact' : '-',
    'deliveryaddress' : '-',
    });


    Response response = await Dio().patch("$SERVER_IP/api/requests/$id/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} ));
    print(response.toString());
  } catch (e) {
    print(e);
  }
}

Future<User> CancelAppointment(String author,String profile,String item,String date,String time,String link) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/requests/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'profile': profile,
      'date': date,
      'time': time,
      'item': item,
      'link': link,
      'clientnow' : false,
      'isdenied' : false,
      'isaccepted' : false,
      'requesttype' : 'calendarcancel',
      'contact' : '-',
      'fullname' : '-',
      'deliverydate' : '-',
      'deliveryaddress' : '-',
    }),
  );

  if (response.statusCode == 201) {
    print('Created calendar schedule request successfully');
  }


  else {
    throw new Exception(response.body);
  }
}


Future<User> CreateCalendarScheduleRequest(String author,String profile,String item,String date,String time,String link) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/requests/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'profile': profile,
      'date': date,
      'time': time,
      'item': item,
      'link': link,
      'clientnow' : false,
      'isdenied' : false,
      'isaccepted' : false,
      'requesttype' : 'calendar',
    'contact' : '-',
      'fullname' : '-',
      'deliverydate' : '-',
    'deliveryaddress' : '-',
    }),
  );

  if (response.statusCode == 201) {
    print('Created calendar schedule request successfully');
  }


  else {
    throw new Exception(response.body);
  }
}

Future<User> CreateBuyNotification(CartItem cartitem,String author,String profile,String item,String date,String time,String link,String buycategory,String contactno,String deliveryaddress,String extra,String fullname,String deliverydate,String deliverytype,int count) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/requests/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'profile': profile,
      'date': date,
      'time': time,
      'item': item,
      'link' : link,
      'reason' : extra,
      'count': count,
      'price' : 0,
      'clientnow' : false,
      'isdenied' : false,
      'requesttype' : 'buy',
      'fullname' : fullname,
      'deliverydate' : deliverydate,
      'deliverytype' : deliverytype,
      'buycategory' :buycategory,
      'contact' : contactno,
      'deliveryaddress' : deliveryaddress,
    }),
  );

  if (response.statusCode == 201) {
    print('Created calendar schedule request successfully');
    String responseinit = response.toString();
    for(int i=0;i<cartitem.choices.length;i++){
      CreateRequestItemChoice(author, responseinit.substring(7,43), cartitem.choices[i].item, cartitem.choices[i].category, cartitem.choices[i].price);
    }
  }


  else {
    throw new Exception(response.body);
  }
}

Future<User> AcceptServiceRequest(String user1,String user2,bool clientnow,bool isdenied,bool isaccepted,String reason,String servicename,List<PickedFile> images,List<ArticleForm> forms,List<ArticleCheckBox> checkboxes) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/requests/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'profile': user2,
      'date': '-',
      'time': '-',
      'item': servicename,
      'link' : '-',
      'clientnow' : clientnow,
      'isdenied' : isdenied,
      'isaccepted' : isaccepted,
      'reason' : reason,
      'contact' : '-',
      'fullname' : '-',
      'deliveryaddress' : '-',
      'deliverydate' : '-',
      'requesttype' : 'userservice'
    }),
  );

  if (response.statusCode == 201) {
    print('Sent follow request to ${user2} successfully');
    String responseinit = response.body.toString();
    String itemid = responseinit.substring(7,43);

    for(int i=0;i<checkboxes.length;i++){
      print('entering');
      CreateUserServiceRequestCheckbox(itemid, checkboxes[i].hint, checkboxes[i].content);
    }
    for(int i=0;i<forms.length;i++){
      CreateUserServiceRequestForm(itemid, forms[i].hint, forms[i].content.text);
    }
    for(int i=0;i<images.length;i++){
      CreateUserServiceRequestImage(user1, itemid, File(images[i].path));
    }

  }


  else {
    throw new Exception(response.body);
  }
}


Future<User> CreateUserServiceRequestForm(String request,String hint,String content) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/requestforms/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'request': request,
      'hint': hint,
      'content': content,
    }),
  );

  if (response.statusCode == 201) {
    print('Request form $content created successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<User> CreateUserServiceRequestCheckbox(String request,String hint,bool boolean) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/requestcheckboxes/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{

      'request': request,
      'hint': hint,
      'boolean': boolean,
    }),
  );

  if (response.statusCode == 201) {
    print('Request checkbox $boolean created successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

CreateUserServiceRequestImage(String author,String request,File image) async {
  String imagename = '${author}_${image.path.split('/').last}';

  try {
    FormData formData = new FormData.fromMap({
      'request' : request,
      'image' : await MultipartFile.fromFile(image.path, filename:imagename),
    });

    Response response = await Dio().post("$SERVER_IP/api/requestimages/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} ));

    if(response.statusCode == 201){
      print('Created Image');
    }
    else{
      print(response.statusCode);
      print(response.data.toString());
    }

  } catch (e) {
    print(e);
  }
}

Future<User> AcceptItemRequest(String author,String profile,String item,String date,String time,bool clientnow,bool link) async {

  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/requests/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'profile': profile,
      'date': date,
      'time': time,
      'item': item,
      'link' : link,
      'reason' : '-',
      'clientnow' : clientnow,
      'isdenied' : false,
      'isaccepted' : true,
      'buycategory' : '-',
      'fullname' : '-',
      'requesttype' : 'calendar',
      'contact' : '-',
      'deliverydate' : '-',
      'deliveryaddress' : '-',
    }),
  );

  if (response.statusCode == 201) {
    print('Created calendar schedule request successfully');
  }


  else {
    print(response.body);
    //throw new Exception(response.body);
  }
}

Future<User> AcceptCalendarRequest(String user1,String user2,Notifications notif,bool clientnow,bool isdenied,bool isaccepted) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/requests/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'profile': user2,
      'date': notif.date,
      'time': notif.time,
      'item': notif.item,
      'link' : notif.link,
      'clientnow' : true,
      'isdenied' : false,
      'isaccepted' : true,
      'reason' : '-',
      'fullname' : '-',
      'deliverydate' : '-',
      'requesttype' : 'calendar',
      'contact' : '-',
      'deliveryaddress' : '-',
    }),
  );

  if (response.statusCode == 201) {
    print('Sent follow request to ${user2} successfully');
    String responseinit = response.body.toString();
    String itemid = responseinit.substring(7,43);



  }


  else {
    throw new Exception(response.body);
  }
}


Future<User> CreateCalendarScheduleRequesttype3(String author,String profile,String item,String date,String time,bool clientnow,bool isdenied,bool isaccepted,String link) async {

  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/requests/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'profile': profile,
      'date': date,
      'time': time,
      'item': item,
      'link' : link,
      'reason' : '-',
      'clientnow' : clientnow,
      'isdenied' : isdenied,
      'isaccepted': isaccepted,
      'requesttype' : 'calendar',
      'contact' : '-',
      'fullname' : '-',
      'deliverydate' : '-',
      'deliveryaddress' : '-',
    }),
  );

  if (response.statusCode == 201) {
    print('Created calendar schedule request successfully');
  }


  else {
   throw new Exception(response.body);
  }
}

Future<User> CreateMeetingRequest(String author,String profile) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/requests/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'profile': profile,
      'date': '-',
      'time': '-',
      'item': '-',
      'link' : '-',
      'clientnow' : false,
      'isdenied' : false,
      'isaccepted' : false,
      'requesttype' : 'meeting',
      'contact' : '-',
      'fullname' : '-',
      'deliverydate' : '-',
      'deliveryaddress' : '-',
    }),
  );

  if (response.statusCode == 201) {
    print('Created calendar schedule request successfully');
  }


  else {
    throw new Exception(response.body);
  }
}


Future<User> CreateCalendarScheduleRequesttype2(String author,String profile,String item,String date,String time,bool clientnow,bool isdenied,bool isaccepted,String link) async {

  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/requests/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'profile': profile,
      'date': date,
          'time': time,
           'item': item,
      'link' : '-',
            'reason' : '-',
            'clientnow' : clientnow,
            'isdenied' : isdenied,
      'isaccepted': isaccepted,
            'requesttype' : 'calendar',
      'contact' : '-',
      'fullname' : '-',
      'deliverydate' : '-',
      'deliveryaddress' : '-',
    }),
  );

  if (response.statusCode == 201) {
    print('Created calendar schedule request successfully');
  }


  else {
    print(response.body);
    //throw new Exception(response.body);
  }
}

Future<User> CreateCalendarScheduleRequestCTT(String author,String profile,String item) async {
  print('item: $item');

  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/requests/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'profile': profile,
      'date': '-',
      'time': '-',
      'item': item,
      'link' : '-',
      'clientnow' : false,
      'isdenied' : false,
      'isaccepted' : false,
      'requesttype' : 'calendar',
      'contact' : '-',
      'fullname' : '-',
      'deliverydate' : '-',
      'deliveryaddress' : '-',
    }),
  );

  if (response.statusCode == 201) {
    print('Created calendar schedule request successfully');
  }


  else {
    throw new Exception(response.body);
  }
}

Future<User> CreateCalendarDate(String author,String date) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/calendardates/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'date': date,
    }),
  );

  if (response.statusCode == 201) {
    print('Created calendar date $date successfully');
  }


  else {
    throw new Exception(response.body);
  }
}







Future<User> CreateCalendarTime(String author,String time) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/calendartimes/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'date' : '-',
      'time': time,
    }),
  );

  if (response.statusCode == 201) {
    print('Created calendar time $time successfully');
  }


  else {
    throw new Exception(response.body);
  }
}
Future<User> FollowUserRequest(String user1,String user2) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/requests/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'profile': user2,
      'date': '-',
      'time': '-',
      'item': '-',
      'link' : '-',
      'clientnow' : false,
      'isdenied' : false,
      'requesttype' : 'follow',
      'contact' : '-',
      'deliverydate' : '-',
      'fullname' : '-',
      'deliveryaddress' : '-',
    }),
  );

  if (response.statusCode == 201) {
    print('Sent follow request to ${user2} successfully');
  }


  else {
    throw new Exception(response.body);
  }
}

Future<User> CreateUserServiceRequest(String user1,String user2,bool clientnow,bool isdenied,bool isaccepted,String reason,String servicename,List<PickedFile> images,List<ArticleForm> forms,List<ArticleCheckBox> checkboxes,String link) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/requests/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'profile': user2,
      'date': '-',
      'time': '-',
      'item': servicename,
      'link' : link,
      'clientnow' : clientnow,
      'isdenied' : isdenied,
      'isaccepted' : isaccepted,
      'reason' : reason,
      'requesttype' : 'userservice',
      'contact' : '-',
      'fullname' : '-',
      'deliverydate' : '-',
      'deliveryaddress' : '-',
    }),
  );

  if (response.statusCode == 201) {
    print('Sent follow request to ${user2} successfully');
    String responseinit = response.body.toString();
    String itemid = responseinit.substring(7,43);

    for(int i=0;i<checkboxes.length;i++){
      print('entering');
      CreateUserServiceRequestCheckbox(itemid, checkboxes[i].hint, checkboxes[i].content);
    }
    for(int i=0;i<forms.length;i++){
      CreateUserServiceRequestForm(itemid, forms[i].hint, forms[i].content.text);
    }
    for(int i=0;i<images.length;i++){
      FileSizeLimitImage(images[i].path)..then((value){
        if(value){print('File too big to upload!');
        return;}
        if(value == false){      CreateUserServiceRequestImage(user1, itemid, File(images[i].path));}
      });

    }

  }


  else {
    throw new Exception(response.body);
  }
}

Future<User> FollowUserSilent(String id,bool bool,String author,String profile) async {
  print(bool);
  final http.Response response = await http.patch(
    Uri.parse("$SERVER_IP/api/userfollows/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'issilent': bool,
      'author' : author,
      'profile' : profile,
    }),
  );

  if (response.statusCode == 201) {
    print('$id follow issilent is $bool successfully');
  }


  else {
    throw new Exception(response.body);
  }
}

Future<User> FollowUser(String user1,String user2) async {
  final http.Response response = await http.post(
      Uri.parse("$SERVER_IP/api/userfollows/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'profile': user2,
      'issilent' : false,
    }),
  );

  if (response.statusCode == 201) {
    print('${user2} followed successfully');
  }


  else {
    throw new Exception(response.body);
  }
}

Future<User> RateUser(String user1,String user2,int rating) async {
  print('entering');
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/userratings/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'profile': user2,
      'rating': rating,
    }),
  );

  if (response.statusCode == 201) {
    print('${user2} rated successfully');
  }


  else {
    throw new Exception(response.body);
  }
}


Future<User> BlockUser(String user1,String user2) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/userblocks/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'profile': user2,
    }),
  );

  if (response.statusCode == 201) {
    print('${user2} blocked successfully');
  }


  else {
    throw new Exception(response.body);
  }
}



Future<User> UnfollowUser(String id) async {
  final http.Response response = await http.delete(
      Uri.parse("$SERVER_IP/api/userfollows/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('${id} Unfollowed Succesfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<User> CancelFollowRequest(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/requests/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Cancelled follow request from user ${id} Succesfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<User> UnblockUser(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/userblocks/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('${id} unblocked Succesfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<User> ViewUser(String user1,String user2) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/userviews/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'profile': user2,
    }),
  );

  if (response.statusCode == 201) {
    print('User viewed successfully');
  }

  else {
    throw new Exception(response.body);
  }
}


Future<User> ConfirmUser(String user1,String user2) async {
  final http.Response response = await http.post(
      Uri.parse("$SERVER_IP/api/userconfirms/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'profile': user2,
    }),
  );

  if (response.statusCode == 201) {
    print('User confirmed successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<User> UnconfirmUser(String id) async {
  final http.Response response = await http.delete(
      Uri.parse("$SERVER_IP/api/userconfirms/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('User unconfirmed successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<Article> ViewArticle(String user,String article) async {
  final http.Response response = await http.post(
      Uri.parse("$SERVER_IP/api/articleviews/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user,
      'article': article,
    }),
  );

  if (response.statusCode == 201) {
    print('Post seen successfully');
  }

  else {
    throw new Exception(response.body);
  }
}


Future<User> BookmarkArticle(String user1,String article) async {

  final http.Response response = await http.post(
    Uri.parse( "$SERVER_IP/api/articlebookmarks/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'article': article,
    }),
  );

  if (response.statusCode == 201) {
    print('Post bookmarked successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<User> InterestedinArticle(String user1,String article) async {

  final http.Response response = await http.post(
    Uri.parse( "$SERVER_IP/api/articleinterests/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'article': article,
    }),
  );

  if (response.statusCode == 201) {
    print('Post interested successfully');
  }

  else {
    throw new Exception(response.body);
  }
}



Future<User> LikeArticle(String user1,String article) async {

  final http.Response response = await http.post(
      Uri.parse( "$SERVER_IP/api/articlelikes/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'article': article,
    }),
  );

  if (response.statusCode == 201) {
    print('Post liked successfully');
  }

  else {
    throw new Exception(response.body);
  }
}
Future<User> UnlikeArticle(String id) async {
  final http.Response response = await http.delete(
      Uri.parse("$SERVER_IP/api/articleunlikes/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Post unliked successfully');
  }

  else {
    throw new Exception(response.body);
  }
}
Future<User> DislikeArticle(String user1,String article) async {
  print(user1);
  print(article);

  final http.Response response = await http.post(
    Uri.parse( "$SERVER_IP/api/articledislikes/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'article': article,
    }),
  );

  if (response.statusCode == 201) {
    print('Post disliked successfully');
  }

  else {
    print(response.body);
  }
}
Future<User> UndislikeArticle(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/articleundislikes/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Post undisliked successfully');
  }

  else {
    throw new Exception(response.body);
  }
}


Future<User> LikeUser(String user1,String user2) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/userlikes/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'profile': user2,
    }),
  );

  if (response.statusCode == 201) {
    print('User liked successfully');
  }

  else {
    throw new Exception(response.body);
  }
}
Future<User> UnlikeUser(String id) async {
  final http.Response response = await http.delete(
    Uri.parse( "$SERVER_IP/api/userunlikes/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('User unliked successfully');
  }
  else {
    throw new Exception(response.body);
  }
}
Future<User> DislikeUser(String user1,String user2) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/userdislikes/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'profile': user2,
    }),
  );

  if (response.statusCode == 201) {
    print('User disliked successfully');
  }

  else {
    throw new Exception(response.body);
  }
}
Future<User> UndislikeUser(String id) async {
  final http.Response response = await http.delete(
    Uri.parse( "$SERVER_IP/api/userundislikes/$id/"),
    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
  );
  if (response.statusCode == 204) {
    print('User undisliked successfully');
  }
  else {
    throw new Exception(response.body);
  }
}







Future<User> LikeArticleComment(String user1,String article) async {

  final http.Response response = await http.post(
    Uri.parse( "$SERVER_IP/api/articlecommentlikes/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'article': article,
    }),
  );

  if (response.statusCode == 201) {
    print('Post liked successfully');
  }

  else {
    throw new Exception(response.body);
  }
}
Future<User> UnlikeArticleComment(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/articlecommentunlikes/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Post unliked successfully');
  }

  else {
    throw new Exception(response.body);
  }
}
Future<User> DislikeArticleComment(String user1,String article) async {
  print(user1);
  print(article);

  final http.Response response = await http.post(
    Uri.parse( "$SERVER_IP/api/articlecommentdislikes/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'article': article,
    }),
  );

  if (response.statusCode == 201) {
    print('Post disliked successfully');
  }

  else {
    print(response.body);
  }
}
Future<User> UndislikeArticleComment(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/articlecommentundislikes/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Post undisliked successfully');
  }

  else {
    throw new Exception(response.body);
  }
}


Future<User> LikeUserComment(String user1,String user2) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/usercommentlikes/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'profile': user2,
    }),
  );

  if (response.statusCode == 201) {
    print('User liked successfully');
  }

  else {
    throw new Exception(response.body);
  }
}
Future<User> UnlikeUserComment(String id) async {
  final http.Response response = await http.delete(
    Uri.parse( "$SERVER_IP/api/usercommentunlikes/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('User unliked successfully');
  }
  else {
    throw new Exception(response.body);
  }
}
Future<User> DislikeUserComment(String user1,String user2) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/usercommentdislikes/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'profile': user2,
    }),
  );

  if (response.statusCode == 201) {
    print('User disliked successfully');
  }

  else {
    throw new Exception(response.body);
  }
}
Future<User> UndislikeUserComment(String id) async {
  final http.Response response = await http.delete(
    Uri.parse( "$SERVER_IP/api/usercommentundislikes/$id/"),
    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
  );
  if (response.statusCode == 204) {
    print('User undisliked successfully');
  }
  else {
    throw new Exception(response.body);
  }
}

Future<User> UnbookmarkArticle(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/articlebookmarks/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Post unbookmarked successfully');
  }

  else {
    throw new Exception(response.body);
  }
}






Future<User> CreateUserTags(String tag,String author) async {
  final http.Response response = await http.post(
      Uri.parse("$SERVER_IP/api/usertags/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'tag': tag,
      'author': author,
    }),
  );

  if (response.statusCode == 201) {
    print('User tag $tag created successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<User> CreateUserLocations(String location,String author) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/userlocations/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'location': location,
      'author': author,
    }),
  );

  if (response.statusCode == 201) {
    print('User location $location created successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<User> CreateUserMail(String mail,String author) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/usermails/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'mail': mail,
      'author': author,
    }),
  );

  if (response.statusCode == 201) {
    print('User mail $mail created successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<User> CreateUserPhones(String phone,String author,bool iswp) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/userphones/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'phone': phone,
      'author': author,
      'iswp' : iswp,
    }),
  );

  if (response.statusCode == 201) {
    print('User phone $phone created successfully');
  }

  else {
    throw new Exception(response.body);
  }
}




Future<UserTag> DeleteCartItemChoices(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/cartitemchoices/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Cart Item choice Deleted Successfully');
  }

  else {
    throw new Exception(response.body);
  }
}


Future<UserTag> DeleteCartItems(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/cartitems/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Cart Item Deleted Successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<UserTag> DeleteUserTags(String id) async {
  final http.Response response = await http.delete(
      Uri.parse("$SERVER_IP/api/usertags/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('User Tag Deleted Successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<UserTag> DeleteUserPhone(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/userphones/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('User phone Deleted Successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<UserTag> DeleteUserMail(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/usermails/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('User mail Deleted Successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<UserTag> DeleteUserLocation(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/userlocations/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('User Location Deleted Successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<UserTag> DeleteUserPhones(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/userphones/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('User Phone Deleted Successfully');
  }

  else {
    throw new Exception(response.body);
  }
}


Future<User> CreateReport(String author,String profile,String article,String issue) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/userreports/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'profile': profile,
      'article': article == '' ? '' : article,
      'content' : issue,
    }),
  );

  if (response.statusCode == 201) {
    print('User report created');
  }

  else {
    throw new Exception(response.body);
  }
}






Future<User> FetchUserPrivate(String userid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/unusers/$userid/?format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
  return User.fromJSON(responseJson);
}

Future<User> FetchUser(String userid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/unusers/$userid/?format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
  return User.fromJSON(responseJson);
}

Future<int> FetchUserMC() async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/usermessagecount/?format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
  return UserMC.fromJSON(responseJson[0]).messagecount2 + UserMC.fromJSON(responseJson[0]).messagecount;
}



Future<User> FetchPublicUser(String userid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/publicusers/$userid/?format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
  return User.fromJSON(responseJson);
}

Future<User> FetchFollowedUser(String userid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/followedusers/$userid/?format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
  return User.fromJSON(responseJson);
}









Future<Widget> FetchPublicUserNav(User muser,String userid,dynamic context) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/publicusers/$userid/?format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
  return Navigator.push(context, MaterialPageRoute(builder: (_) => VisitedProfileScreen(user:muser,visiteduserid: '', visiteduser: User.fromJSON(responseJson),)),);
}

Future<Widget> FetchFollowedUserNav(User muser,String userid,dynamic context) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/followedusers/$userid/?format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
  return Navigator.push(context, MaterialPageRoute(builder: (_) => VisitedProfileScreen(user:muser,visiteduserid: '', visiteduser: User.fromJSON(responseJson),)),);
}


Future<Article> FetchArticle(String postid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/articles/$postid/?format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
  return Article.fromJSON(responseJson);
}

Future<Article> FetchOwnArticle(String postid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/fetcharticles/$postid/?format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
  return Article.fromJSON(responseJson);
}


Future<List<Meme>> FetchMemes() async {
  final response = await http.get(Uri.parse("https://api.memegen.link/templates") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8'},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  print(parsed);
  return  parsed.map<Meme>((json) => Meme.fromJSON(json)).toList();

}


Future<List<User>> RegisteringCheck() async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/registeringcheck/?format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8'},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  return parsed.map<User>((json) => User.fromJSON(json)).toList();
}

Future<List<User>> FetchRegisteredUsers() async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/registeredusers/?format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8'},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  return parsed.map<User>((json) => User.fromJSON(json)).toList();
}





Future<List<User>> FetchTagusers(String text,int page) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/tagusers/?search=${text}&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  return parsed["results"] != null ? new List<User>.from( parsed["results"].map((x) => User.fromJSON(x))) : List<User>();
}


Future<Widget> FetchArticleNavg(User user,dynamic context,String id) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/articles/$id/?format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  Article item =  Article.fromJSON(parsed);
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CommentsScreen(user: user,post:item)));
}








GotoProfile(User user,String visiteduserid,dynamic context) async{
  final response = await http.get(Uri.parse("$SERVER_IP/api/publicusers/$visiteduserid/?format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => VisitedProfileScreen(user: user,visiteduserid: '',visiteduser:User.fromJSON(responseJson))));

}

GotoProfileFetch(User user,String visiteduserid,dynamic context) async{
  final response = await http.get(Uri.parse("$SERVER_IP/api/publicusers/$visiteduserid/?format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  var responseJson = jsonDecode(utf8.decode(response.bodyBytes));

  return User.fromJSON(responseJson);
}


SortArticles(List<Article> articles,String sorttype){
  List<Article> newarticles = [];
  // Postuploaddate(anytime,lasthour,today,this-[week,month,year],all time)
  //int parse (price) function
 if(sorttype == 'time'){
   for(int i=0;i<articles.length;i++){
     final formatter = DateFormat("yyyy-MM-dd hh:mm:ss");
     final dateTimeFromStr = formatter.parse(articles[i].timestamp);
     articles[i].timestamp2 = dateTimeFromStr;
     return articles.sort((a, b) => a.timestamp2.compareTo(b.timestamp2));
   }
 }
 if(sorttype == 'like'){
   return articles.sort((a, b) => a.likes.compareTo(b.likes));
 }
  if(sorttype == 'view'){
    return articles.sort((a, b) => a.views.compareTo(b.views));
  }


}







EditUserWifi(User user,String wifiname,String wifipassword) async {
  print(user.parent);

  try {
    FormData formData = new FormData.fromMap({
      'fullname' : user.full_name ,
      'locationcountry' : user.locationcountry ,
      'locationstate' : user.locationstate ,
      'locationcity' :  user.locationcity ,
      'phone_number' :  user.phone_number,
      'details' : user.details ,
      "business_type": user.business_type ,
      'gatewayname':user.gatewayName,
      'gatewaymerchantid':user.gatewayMerchantId,
      'merchantid':user.merchantId,
      'merchantname':user.merchantName,
      'calendar_type': user.calendar_type ,
      'pricerange':user.pricerange,
      'businessstatus' : user.businessstatus,
      'issubusersallowed': user.issubusersallowed,
      'isprofileanon': user.isprofileanon,
      'public_profile': user.public_profile,
      'isdetailsprivate' : user.isdetailsprivate,
      'isnsfwallowed': user.isnsfwallowed ,
      'isnstlallowed': user.isnstlallowed ,
      'issensitiveallowed': user.issensitiveallowed ,
      'isspoilerallowed' : user.isspoilerallowed ,
      'calendar_ismultichoice' : user.calendar_ismultichoice,
      'intensity' : user.intensity,
      'wifiname': wifiname,
      'wifipassword' : wifipassword,
    });
    Response response = await Dio().patch("$SERVER_IP/api/ownuser/${user.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');

    locationcountrygl= '';
    locationstategl = '';
    locationcitygl = '';

  } catch (e) {
    print('EU: $e');
  }

}



EditUserHotel(User user,bool ishotel,int hotelclass) async {


  try {
    FormData formData = new FormData.fromMap({
      'fullname' : user.full_name ,
      'locationcountry' : user.locationcountry ,
      'locationstate' : user.locationstate ,
      'locationcity' :  user.locationcity ,
      'phone_number' :  user.phone_number,
      'details' : user.details ,
      "business_type": user.business_type ,
      'gatewayname':user.gatewayName,
      'gatewaymerchantid':user.gatewayMerchantId,
      'merchantid':user.merchantId,
      'merchantname':user.merchantName,
      'calendar_type': user.calendar_type ,
      'pricerange':user.pricerange,
      'businessstatus' : user.businessstatus,
      'issubusersallowed': user.issubusersallowed,
      'isprofileanon': user.isprofileanon,
      'public_profile': user.public_profile,
      'isdetailsprivate' : user.isdetailsprivate,
      'isnsfwallowed': user.isnsfwallowed ,
      'isnstlallowed': user.isnstlallowed ,
      'issensitiveallowed': user.issensitiveallowed ,
      'isspoilerallowed' : user.isspoilerallowed ,
      'calendar_ismultichoice' : user.calendar_ismultichoice,
      'intensity' : user.intensity,
      'wifiname': user.wifiname,
      'wifipassword' :user.wifipassword,
      'ishotel' : ishotel,
      'hotelclass' : hotelclass,
    });
    Response response = await Dio().patch("$SERVER_IP/api/ownuser/${user.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');

    locationcountrygl= '';
    locationstategl = '';
    locationcitygl = '';

  } catch (e) {
    print('EU: $e');
  }

}


EditUserMerchantInfo(User user,String intensity,String gatewayName,String gatewayMerchantId,String merchantId,String merchantName) async {
  print(user.parent);

  try {
    FormData formData = new FormData.fromMap({
      'fullname' : user.full_name ,
      'locationcountry' : user.locationcountry ,
      'locationstate' : user.locationstate ,
      'locationcity' :  user.locationcity ,
      'phone_number' :  user.phone_number,
      'details' : user.details ,
      "business_type": user.business_type ,
      'gatewayname':'-',
      'gatewaymerchantid':'-',
      'ishotel' : user.ishotel,
      'hotelclass' : user.hotelclass,
      'merchantid':merchantId,
      'wifiname':user.wifiname,
      'wifipassword' : user.wifipassword,
      'merchantname':merchantName,
      'calendar_type': user.calendar_type ,
      'pricerange':user.pricerange,
      'businessstatus' : user.businessstatus,
      'issubusersallowed': user.issubusersallowed,
      'isprofileanon': user.isprofileanon,
      'public_profile': user.public_profile,
      'isdetailsprivate' : user.isdetailsprivate,
      'isnsfwallowed': user.isnsfwallowed ,
      'isnstlallowed': user.isnstlallowed ,
      'issensitiveallowed': user.issensitiveallowed ,
      'isspoilerallowed' : user.isspoilerallowed ,
      'calendar_ismultichoice' : user.calendar_ismultichoice,
      'intensity' : user.intensity,
    });
    Response response = await Dio().patch("$SERVER_IP/api/ownuser/${user.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');

    locationcountrygl= '';
    locationstategl = '';
    locationcitygl = '';

  } catch (e) {
    print('EU: $e');
  }

}

EditUserBio(User user,String intensity) async {
  print(user.parent);

  try {



    FormData formData = new FormData.fromMap({
      'fullname' : user.full_name ,
      'locationcountry' : user.locationcountry ,
      'locationstate' : user.locationstate ,
      'locationcity' :  user.locationcity ,
      'phone_number' :  user.phone_number,
      'details' : intensity ,
      'ishotel' : user.ishotel,
      'hotelclass' : user.hotelclass,
      "business_type": user.business_type ,
      'gatewayname':user.gatewayName,
      'gatewaymerchantid':user.gatewayMerchantId,
      'merchantid':user.merchantId,
      'merchantname':user.merchantName,
      'calendar_type': user.calendar_type ,
      'pricerange':user.pricerange,
      'businessstatus' : user.businessstatus,
      'wifiname':user.wifiname,
      'wifipassword' : user.wifipassword,
      'issubusersallowed': user.issubusersallowed,
      'isprofileanon': user.isprofileanon,
      'public_profile': user.public_profile,
      'isdetailsprivate' : user.isdetailsprivate,
      'isnsfwallowed': user.isnsfwallowed ,
      'isnstlallowed': user.isnstlallowed ,
      'issensitiveallowed': user.issensitiveallowed ,
      'isspoilerallowed' : user.isspoilerallowed ,
      'calendar_ismultichoice' : user.calendar_ismultichoice,
      'intensity' : user.intensity,

    });
    Response response = await Dio().patch("$SERVER_IP/api/ownuser/${user.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');

    locationcountrygl= '';
    locationstategl = '';
    locationcitygl = '';

  } catch (e) {
    print('EU: $e');
  }

}

EditUserLocation(User user) async {
  print(user.parent);

  try {



    FormData formData = new FormData.fromMap({
      'fullname' : user.full_name ,
      'locationcountry' : glcn ,
      'locationstate' : glst ,
      'locationcity' :  glct ,
      'ishotel' : user.ishotel,
      'hotelclass' : user.hotelclass,
      'phone_number' :  user.phone_number,
      'details' : user.details ,
      "business_type": user.business_type ,
      'wifiname': user.wifiname,
      'wifipassword' : user.wifipassword,
      'calendar_type': user.calendar_type ,
      'pricerange':user.pricerange,
      'businessstatus' : user.businessstatus,
      'gatewayname':user.gatewayName,
      'gatewaymerchantid':user.gatewayMerchantId,
      'merchantid':user.merchantId,
      'merchantname':user.merchantName,
      'issubusersallowed': user.issubusersallowed,
      'isprofileanon': user.isprofileanon,
      'public_profile': user.public_profile,
      'isdetailsprivate' : user.isdetailsprivate,
      'isnsfwallowed': user.isnsfwallowed ,
      'isnstlallowed': user.isnstlallowed ,
      'issensitiveallowed': user.issensitiveallowed ,
      'isspoilerallowed' : user.isspoilerallowed ,
      'calendar_ismultichoice' : user.calendar_ismultichoice,
      'intensity' : user.intensity,
      'wifiname':user.wifiname,
      'wifipassword' : user.wifipassword,
    });
    Response response = await Dio().patch("$SERVER_IP/api/ownuser/${user.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');

    locationcountrygl= '';
    locationstategl = '';
    locationcitygl = '';

  } catch (e) {
    print('EU: $e');
  }

}

EditUserName(User user,String intensity) async {
  print(user.parent);

  try {



    FormData formData = new FormData.fromMap({
      'fullname' : intensity ,
      'locationcountry' : user.locationcountry ,
            'locationstate' : user.locationstate ,
              'locationcity' :  user.locationcity ,
              'phone_number' :  user.phone_number,
               'details' : user.details ,
      'ishotel' : user.ishotel,
      'hotelclass' : user.hotelclass,
                "business_type": user.business_type ,
      'gatewayname':user.gatewayName,
      'gatewaymerchantid':user.gatewayMerchantId,
      'merchantid':user.merchantId,
      'merchantname':user.merchantName,
                'calendar_type': user.calendar_type ,
                'pricerange':user.pricerange,
                'businessstatus' : user.businessstatus,
      'wifiname': user.wifiname,
      'wifipassword' : user.wifipassword,
              'issubusersallowed': user.issubusersallowed,
             'isprofileanon': user.isprofileanon,
             'public_profile': user.public_profile,
             'isdetailsprivate' : user.isdetailsprivate,
             'isnsfwallowed': user.isnsfwallowed ,
              'isnstlallowed': user.isnstlallowed ,
              'issensitiveallowed': user.issensitiveallowed ,
              'isspoilerallowed' : user.isspoilerallowed ,
            'calendar_ismultichoice' : user.calendar_ismultichoice,
            'intensity' : user.intensity,

    });
    Response response = await Dio().patch("$SERVER_IP/api/ownuser/${user.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');

    locationcountrygl= '';
    locationstategl = '';
    locationcitygl = '';

  } catch (e) {
    print('EU: $e');
  }

}

EditUserPhone(User user,int intensity) async {
  print(user.parent);

  try {



    FormData formData = new FormData.fromMap({
      'fullname' : user.full_name ,
      'locationcountry' : user.locationcountry ,
      'locationstate' : user.locationstate ,
      'locationcity' :  user.locationcity ,
      'phone_number' :  intensity,
      'ishotel' : user.ishotel,
      'hotelclass' : user.hotelclass,
      'details' : user.details ,
      "business_type": user.business_type ,
      'wifiname': user.wifiname,
      'wifipassword' : user.wifipassword,
      'calendar_type': user.calendar_type ,
      'pricerange':user.pricerange,
      'businessstatus' : user.businessstatus,
      'gatewayname':user.gatewayName,
      'gatewaymerchantid':user.gatewayMerchantId,
      'merchantid':user.merchantId,
      'merchantname':user.merchantName,
      'issubusersallowed': user.issubusersallowed,
      'isprofileanon': user.isprofileanon,
      'public_profile': user.public_profile,
      'isdetailsprivate' : user.isdetailsprivate,
      'isnsfwallowed': user.isnsfwallowed ,
      'isnstlallowed': user.isnstlallowed ,
      'issensitiveallowed': user.issensitiveallowed ,
      'isspoilerallowed' : user.isspoilerallowed ,
      'calendar_ismultichoice' : user.calendar_ismultichoice,
      'intensity' : user.intensity,

    });
    Response response = await Dio().patch("$SERVER_IP/api/ownuser/${user.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');

    locationcountrygl= '';
    locationstategl = '';
    locationcitygl = '';

  } catch (e) {
    print('EU: $e');
  }

}

EditUserPublicProfile(User user,bool intensity) async {
  print(user.parent);

  try {



    FormData formData = new FormData.fromMap({
      'fullname' : user.full_name ,
      'locationcountry' : user.locationcountry ,
      'locationstate' : user.locationstate ,
      'locationcity' :  user.locationcity ,
      'phone_number' :  user.phone_number,
      'details' : user.details ,
      'ishotel' : user.ishotel,
      'hotelclass' : user.hotelclass,
      "business_type": user.business_type ,
      'calendar_type': user.calendar_type ,
      'pricerange':user.pricerange,
      'businessstatus' : user.businessstatus,
      'gatewayname':user.gatewayName,
      'wifiname': user.wifiname,
      'wifipassword' : user.wifipassword,
      'gatewaymerchantid':user.gatewayMerchantId,
      'merchantid':user.merchantId,
      'merchantname':user.merchantName,
      'issubusersallowed': user.issubusersallowed,
      'isprofileanon': user.isprofileanon,
      'public_profile': intensity,
      'isdetailsprivate' : user.isdetailsprivate,
      'isnsfwallowed': user.isnsfwallowed ,
      'isnstlallowed': user.isnstlallowed ,
      'issensitiveallowed': user.issensitiveallowed ,
      'isspoilerallowed' : user.isspoilerallowed ,
      'calendar_ismultichoice' : user.calendar_ismultichoice,
      'intensity' : user.intensity,

    });
    Response response = await Dio().patch("$SERVER_IP/api/ownuser/${user.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');

    locationcountrygl= '';
    locationstategl = '';
    locationcitygl = '';

  } catch (e) {
    print('EU: $e');
  }

}


Future<Widget> NavgListPublic(User user,String visiteduserid,dynamic context) async {
  print(visiteduserid);
  final response = await http.get(Uri.parse("$SERVER_IP/api/publicusers/${visiteduserid}/?format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  if(response.statusCode != 200){NavgListFollowed(user, visiteduserid, context);}
  if(response.statusCode == 200){
    var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    User item =  User.fromJSON(responseJson);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VisitedProfileScreen(
          user: user,visiteduser: item,visiteduserid: '',
        ),
      ),
    );
  }


}

Future<Widget> NavgListFollowed(User user,String visiteduserid,dynamic context) async {

  final response = await http.get(Uri.parse("$SERVER_IP/api/followedusers/${visiteduserid}/?format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  if(response.statusCode != 200){NavgListPrivate(user, visiteduserid, context);}
  if(response.statusCode == 200){
    var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    User item =  User.fromJSON(responseJson);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VisitedProfileScreen(
          user: user,visiteduser: item,visiteduserid: '',
        ),
      ),
    );
  }


}
Future<Widget> NavgListPrivate(User user,String visiteduserid,dynamic context) async {

  final response = await http.get(Uri.parse("$SERVER_IP/api/privateusers/${visiteduserid}/?format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  if(response.statusCode == 200){
    var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    User item =  User.fromJSON(responseJson);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VisitedProfileScreen(
          user: user,visiteduser: item,visiteduserid: '',
        ),
      ),
    );
  }

}


Future<List<Notifications>> FetchNotificationNew(User user,int page) async {
  List<Notifications> finalnotifications = [];
  bool isstandarduserdone = false;
  bool hassubusers = false;
  if(isstandarduserdone == false){


    final response3 = await http.get(Uri.parse("$SERVER_IP/api/articlecomments/?page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed3 = jsonDecode(utf8.decode(response3.bodyBytes));
    List<ArticleComment>  notification3 = parsed3["results"] != null ? new List<ArticleComment>.from( parsed3["results"].map((x) => ArticleComment.fromJSON(x))) : List<ArticleComment>();
    for(int i=0;i<notification3.length;i++){
      final DateTime tempDate = new DateFormat("yyyy-MM-ddThh:mm:ss").parse(notification3[i].timestamp);
      Notifications a1 =  Notifications(timestamp: tempDate,id: notification3[i].id,author:notification3[i].authorstring,article:notification3[i].article,type : 'ArticleComment');
      finalnotifications.add(a1);
    }

    final response4 = await http.get(Uri.parse("$SERVER_IP/api/usercomments/?page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed4 = jsonDecode(utf8.decode(response4.bodyBytes));
    List<UserComment>  notification4 = parsed4["results"] != null ? new List<UserComment>.from( parsed4["results"].map((x) => UserComment.fromJSON(x))) : List<UserComment>();

    for(int i=0;i<notification4.length;i++){
      final DateTime tempDate = new DateFormat("yyyy-MM-ddThh:mm:ss").parse(notification4[i].timestamp);
      Notifications a1 =  Notifications(timestamp: tempDate,id: notification4[i].id,author:notification4[i].author,profile:notification4[i].profile,type : 'UserComment');
      finalnotifications.add(a1);
    }

    final response10 = await http.get(Uri.parse("$SERVER_IP/api/usertaggedarticles/?page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed10 = jsonDecode(utf8.decode(response10.bodyBytes));
    List<ArticleTaggedUser>  notification10 = parsed10["results"] != null ? new List<ArticleTaggedUser>.from( parsed10["results"].map((x) => ArticleTaggedUser.fromJSON(x))) : List<ArticleTaggedUser>();

    for(int i=0;i<notification10.length;i++){
      final DateTime tempDate = new DateFormat("yyyy-MM-ddThh:mm:ss").parse(notification10[i].timestamp);
      Notifications a1 =  Notifications(timestamp: tempDate,id: notification10[i].id,author:notification10[i].author,article:notification10[i].article,type : 'UserTaggedArticle');
      finalnotifications.add(a1);
    }

    final response9 = await http.get(Uri.parse("$SERVER_IP/api/requests/?page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed9 = jsonDecode(utf8.decode(response9.bodyBytes));
    List<RequestInit>  notification9 = parsed9["results"] != null ? new List<RequestInit>.from( parsed9["results"].map((x) => RequestInit.fromJSON(x))) : List<RequestInit>();
    for(int i=0;i<notification9.length;i++){
      final DateTime tempDate = new DateFormat("yyyy-MM-ddThh:mm:ss").parse(notification9[i].timestamp);
      Notifications a1 =  Notifications(timestamp: tempDate,
        id: notification9[i].id,
        author:notification9[i].author,
        profile:notification9[i].profile,
        choices:notification9[i].choices,
        userservice:notification9[i].service,
        buycategory: notification9[i].buycategory,
        link:notification9[i].link,  contactno:notification9[i].contactno,
        deliveryaddress:notification9[i].deliveryaddress,
        fullname:notification9[i].fullname,
        deliverydate:notification9[i].deliverydate,
        type : 'Request',item:notification9[i].item,time:notification9[i].time,
        date:notification9[i].date,service:notification9[i].service,requesttype:notification9[i].requesttype,
        clientnow:notification9[i].clientnow,isdenied:notification9[i].isdenied,images:notification9[i].images,
        forms:notification9[i].forms,checkboxes:notification9[i].checkboxes,isaccepted: notification9[i].isaccepted,
        reason:notification9[i].reason,
      );
      finalnotifications.add(a1);
    }

    finalnotifications.sort((b, a) => a.timestamp.compareTo(b.timestamp));
    isstandarduserdone = true;
  }



  return finalnotifications;
}



String newtags(List<String> tags){
  String tag = '';
  for(int i=0;i<tags.length;i++){
    tag = '${tag}search=${tags[i]}';
    if(i <tags.length){
      tag = '$tag&';
    }
  }
  return tag;
}


bool checklocationvalidity(String country,String state,String city){
  if(locationcountrygl == '-'){return true;}
  if(locationcountrygl == ''){return true;}
  if(country != locationcountrygl){return false;}
  if(state != locationstategl){
    if(locationstategl == '-'){return true;}
    if(locationstategl == ''){return true;}
    return false;}
  if(city != locationcitygl){
    if(locationcitygl == '-'){return true;}
    if(locationcitygl == ''){return true;}
    return false;}
  return true;
}

Future<List<CartItem>> FetchCartItems(int page) async {
  final response2 = await http.get(Uri.parse("$SERVER_IP/api/cartitems/?page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed2 = jsonDecode(utf8.decode(response2.bodyBytes));
  return parsed2["results"] != null ? new List<CartItem>.from( parsed2["results"].map((x) => CartItem.fromJSON(x))) : List<CartItem>();
}

Future<List<Article>> FetchArticles(int page) async {
  final response2 = await http.get(Uri.parse("$SERVER_IP/api/articles/?page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed2 = jsonDecode(utf8.decode(response2.bodyBytes));
  return parsed2["results"] != null ? new List<Article>.from( parsed2["results"].map((x) => Article.fromJSON(x))) : List<Article>();
}

Future<List<ReservationDeactivationMonth>> FetchOwnReservationDeactivationMonths(int page) async {
  final response2 = await http.get(Uri.parse("$SERVER_IP/api/reservationdeactivationmonths/?format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed2 = jsonDecode(utf8.decode(response2.bodyBytes));
  return  parsed2["results"] != null ? new List<ReservationDeactivationMonth>.from( parsed2["results"].map((x) => ReservationDeactivationMonth.fromJSON(x))) : List<ReservationDeactivationMonth>();
}


Future<List<CalendarStatus>> FetchOwnCalendarStatuses(int page) async {
  final response2 = await http.get(Uri.parse("$SERVER_IP/api/calendarstatuses/?format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed2 = jsonDecode(utf8.decode(response2.bodyBytes));
  return parsed2.map<CalendarStatus>((json) => CalendarStatus.fromJSON(json)).toList();
}

Future<List<CalendarSchedule>> FetchOwnCalendarSchedules(int page) async {
  final response2 = await http.get(Uri.parse("$SERVER_IP/api/calendarschedules/?format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed2 = jsonDecode(utf8.decode(response2.bodyBytes));
  return parsed2.map<CalendarSchedule>((json) => CalendarSchedule.fromJSON(json)).toList();
}

SearchUsers(int page) async {
  List<User> usersfinal = [];



  final response = await http.get(Uri.parse("$SERVER_IP/api/publicusers/?page=$page&search=&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<User> users = parsed["results"] != null ? new List<User>.from( parsed["results"].map((x) => User.fromJSON(x))) : List<User>();


  return usersfinal.toSet().toList();

}



SearchUsersNew2(int page,String searchfield,List<String> tags,bool tagsearch,bool searchbasedonlocation) async {
  List<User> usersfinal = [];
  if(tagsearch){searchfield = newtags(tags);}


  final response = await http.get(Uri.parse("$SERVER_IP/api/publicusers/?page=$page&search=$searchfield&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<User> users = parsed["results"] != null ? new List<User>.from( parsed["results"].map((x) => User.fromJSON(x))) : List<User>();
  final response2 = await http.get(Uri.parse("$SERVER_IP/api/privateusers/?page=$page&search=$searchfield&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed2 = jsonDecode(utf8.decode(response2.bodyBytes));
  List<User> users2 = parsed2["results"] != null ? new List<User>.from( parsed2["results"].map((x) => User.fromJSON(x))) : List<User>();

  usersfinal.addAll(users);
  usersfinal.addAll(users2);
  if(searchbasedonlocation){
    for(int i=0;i<usersfinal.length;i++){
      if(checklocationvalidity(usersfinal[i].locationcountry,usersfinal[i].locationstate,usersfinal[i].locationcity) == false)
      {usersfinal.removeAt(i);break;}
    }
  }


  return usersfinal.toSet().toList();

}

bool doesitembelong(User calendarowner,String calendaritem){

  if(calendarowner.calendar_type == 'calendartype2'){

    return true;
  }

  for(int i=0;i<calendarowner.calendarstatuses.length;i++){

    String mny = calendarowner.calendarstatuses[i].dates.substring(0,7);
    String daysinit = calendarowner.calendarstatuses[i].dates.substring(8);
    if(searchmny == mny){

      List<String> days = daysinit.split(',');

      for(int i3=0;i3<days.length;i3++){
        if(days[i3] == searchday){

          List<String> inititems = calendarowner.calendarstatuses[i].items.split(',');
          for(int i2=0;i2<inititems.length;i2++) {
            if(inititems[i2] == calendaritem){

              return true;
            }
          }


        }
      }
    }
  }

  return false;
}


SearchArticlesNew2(int page,String searchfield,List<String> tags,bool tagsearch,int pl,int ph,bool searchbasedonlocation,bool priceactivated,bool isitem,String type,User user) async {
  List<Article> articlesfinal = [];
  if(tagsearch){searchfield = newtags(tags);}

  final response = await http.get(Uri.parse("$SERVER_IP/api/publicarticles/?page=$page&type=$type&search=$searchfield&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<Article> users = parsed["results"] != null ? new List<Article>.from( parsed["results"].map((x) => Article.fromJSON(x))) : List<Article>();
  final response2 = await http.get(Uri.parse("$SERVER_IP/api/articles/?page=$page&type=$type&search=$searchfield&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed2 = jsonDecode(utf8.decode(response2.bodyBytes));
  List<Article> users2 = parsed2["results"] != null ? new List<Article>.from( parsed2["results"].map((x) => Article.fromJSON(x))) : List<Article>();

  articlesfinal.addAll(users);
  articlesfinal.addAll(users2);




  if(type == 'CI'){
    return items(articlesfinal,user);
  }

  return articlesfinal.toSet().toList();
}

SearchArticlesInProfile(String author,int page,String searchfield,List<String> tags,bool tagsearch,int pl,int ph,bool searchbasedonlocation,bool priceactivated,bool isitem,String type,User user) async {
  List<Article> articlesfinal = [];
  if(tagsearch){searchfield = newtags(tags);}
  print('entering');
  final response = await http.get(Uri.parse("$SERVER_IP/api/publicarticles/?page=$page&type=$type&author=$author&search=$searchfield&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<Article> users = parsed["results"] != null ? new List<Article>.from( parsed["results"].map((x) => Article.fromJSON(x))) : List<Article>();
  final response2 = await http.get(Uri.parse("$SERVER_IP/api/articles/?page=$page&type=$type&author=$author&search=$searchfield&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed2 = jsonDecode(utf8.decode(response2.bodyBytes));
  List<Article> users2 = parsed2["results"] != null ? new List<Article>.from( parsed2["results"].map((x) => Article.fromJSON(x))) : List<Article>();

  articlesfinal.addAll(users);
  articlesfinal.addAll(users2);




    for(int i=0;i<articlesfinal.length;i++){

      if(searchbasedonlocation){
        if(checklocationvalidity(articlesfinal[i].locationcountry,articlesfinal[i].locationstate,articlesfinal[i].locationcity) == false)
        {articlesfinal.removeAt(i);break;}}



  if(articlesfinal[i].author != author){articlesfinal.removeAt(i);break;}
      if(checklocationvalidity(articlesfinal[i].locationcountry,articlesfinal[i].locationstate,articlesfinal[i].locationcity) == false)
      {articlesfinal.removeAt(i);break;}
      if(priceactivated){
        if(articlesfinal[i].price> ph){articlesfinal.removeAt(i); break;}
        if(articlesfinal[i].price < pl ){articlesfinal.removeAt(i);break;}
      }
      if(searchbydate){
        if(searchdate != articlesfinal[i].date){

          articlesfinal.removeAt(i);break;
        }
      }
    }




  if(type == 'CI'){
    return items(articlesfinal,user);
  }

  return articlesfinal.toSet().toList();
}






Future<List<Article>> items(List<Article> itemsinit, User user) async {
  if (searchbydate) {
    for (int i = 0; i < itemsinit.length; i++) {
      final res = await FetchUser(itemsinit[i].author);
      final result = await isuserfollowed(user.id, res.id);
      if (user.shouldshowuserinfo(res, result) == 'public') {
        final res23 = await FetchPublicUser(res.id);
        if (doesitembelong(res23, itemsinit[i].caption) == false) {
          itemsinit.removeAt(i);
        }
      }
    }
  }

  return itemsinit;
}






Future<List<ArticleComment>> FetchOwnArticleComments(http.Client client,String userid,int page) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/articlecomments/?article=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  return parsed["results"] != null ? new List<ArticleComment>.from( parsed["results"].map((x) => ArticleComment.fromJSON(x))) : List<ArticleComment>();
}


Future<List<UserComment>> FetchOwnUserComments(http.Client client,String userid,int page) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/usercomments/?profile=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  return parsed["results"] != null ? new List<UserComment>.from( parsed["results"].map((x) => UserComment.fromJSON(x))) : List<UserComment>();
}
















  Future<List<ArticleComment>> FetchOwnFollowedArticleComments(http.Client client,String userid,int page) async {
    final response = await http.get(Uri.parse("$SERVER_IP/api/followedarticlecomments/?article=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    return parsed["results"] != null ? new List<ArticleComment>.from( parsed["results"].map((x) => ArticleComment.fromJSON(x))) : List<ArticleComment>();
  }

  Future<List<ArticleComment>> FetchPublicArticleComments(http.Client client,String userid,int page) async {
    final response = await http.get(Uri.parse("$SERVER_IP/api/publicarticlecomments/?article=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    return parsed["results"] != null ? new List<ArticleComment>.from( parsed["results"].map((x) => ArticleComment.fromJSON(x))) : List<ArticleComment>();
  }


  Future<List<UserComment>> FetchFollowedUserComments(http.Client client,String userid,int page) async {
    final response = await http.get(Uri.parse("$SERVER_IP/api/followedusercomments/?profile=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    return parsed["results"] != null ? new List<UserComment>.from( parsed["results"].map((x) => UserComment.fromJSON(x))) : List<UserComment>();
  }

  Future<List<UserComment>> FetchPublicUserComments(http.Client client,String userid,int page) async {
    final response = await http.get(Uri.parse("$SERVER_IP/api/publicusercomments/?profile=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    return parsed["results"] != null ? new List<UserComment>.from( parsed["results"].map((x) => UserComment.fromJSON(x))) : List<UserComment>();
  }









  Future<List<UserFollow>> FetchUserFollowings(http.Client client,String userid,int page) async {
    final response = await http.get(Uri.parse("$SERVER_IP/api/userfollowings/?profile=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    return parsed["results"] != null ? new List<UserFollow>.from( parsed["results"].map((x) => UserFollow.fromJSON(x))) : List<UserFollow>();
  }

  Future<List<UserFollow>> FetchUserFolloweds(http.Client client,String userid,int page) async {
    final response = await http.get(Uri.parse("$SERVER_IP/api/userfolloweds/?author=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    return parsed["results"] != null ? new List<UserFollow>.from( parsed["results"].map((x) => UserFollow.fromJSON(x))) : List<UserFollow>();
  }


  Future<List<Article>> FetchVisitedProfileFollowedArticles(http.Client client,String userid,int page) async {
    final response = await http.get(Uri.parse("$SERVER_IP/api/articles/?search=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    List<Article> articles = parsed["results"] != null ? new List<Article>.from( parsed["results"].map((x) => Article.fromJSON(x))) : List<Article>();
   return articles;
}

  Future<List<Article>> FetchVisitedProfilePublicArticles(http.Client client,String userid,int page) async {
    final response = await http.get(Uri.parse("$SERVER_IP/api/publicarticles/?search=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    List<Article> articles = parsed["results"] != null ? new List<Article>.from( parsed["results"].map((x) => Article.fromJSON(x))) : List<Article>();
    return articles; }

  Future<List<UserFollow>> FetchFollowedUserFollowings(http.Client client,String userid,int page) async {
    final response = await http.get(Uri.parse("$SERVER_IP/api/followedfollowings/?profile=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));

    return parsed["results"] != null ? new List<UserFollow>.from( parsed["results"].map((x) => UserFollow.fromJSON(x))) : List<UserFollow>();
  }


  Future<List<UserFollow>> FetchFollowedUserFolloweds(http.Client client,String userid,int page) async {
    final response = await http.get(Uri.parse("$SERVER_IP/api/followedfolloweds/?author=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));

    return parsed["results"] != null ? new List<UserFollow>.from( parsed["results"].map((x) => UserFollow.fromJSON(x))) : List<UserFollow>();
  }

  Future<List<UserFollow>> FetchPublicUserFolloweds(http.Client client,String userid,int page) async {
    final response = await http.get(Uri.parse("$SERVER_IP/api/publicfolloweds/?author=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));

    return parsed["results"] != null ? new List<UserFollow>.from( parsed["results"].map((x) => UserFollow.fromJSON(x))) : List<UserFollow>();
  }

Future<List<UserFollow>> FetchPublicUserFollowings(http.Client client,String userid,int page) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/publicfollowings/?profile=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));

  return parsed["results"] != null ? new List<UserFollow>.from( parsed["results"].map((x) => UserFollow.fromJSON(x))) : List<UserFollow>();
}



bool doesitembelongtocal(String calendaritem,User calendarowner,String mnyinit,String day){
  print(calendaritem);
  print(day);
  for(int i=0;i<calendarowner.calendarstatuses.length;i++){
    String mny = calendarowner.calendarstatuses[i].dates.substring(0,7);
    String daysinit = calendarowner.calendarstatuses[i].dates.substring(8);
    if(mnyinit == mny){
      List<String> days = daysinit.split(',');

      for(int i3=0;i3<days.length;i3++){
        if(days[i3] == day){
          List<String> inititems = calendarowner.calendarstatuses[i].items.split(',');
          for(int i2=0;i2<inititems.length;i2++) {
            if(inititems[i2] == calendaritem){
              return true;
            }}}}}}
  return false;
}






  Future<List<CalendarTime>> FetchFollowedCalendarTime(http.Client client,String userid,int page) async {
    final response = await http.get(Uri.parse("$SERVER_IP/api/followedcalendartimes/?author=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    List<CalendarTime> times = parsed["results"] != null ? new List<CalendarTime>.from( parsed["results"].map((x) => CalendarTime.fromJSON(x))) : List<CalendarTime>();
    return times;
}


  Future<List<CalendarTime>> FetchPublicCalendarTime(http.Client client,String userid,int page) async {
    final response = await http.get(Uri.parse("$SERVER_IP/api/publiccalendartimes/?author=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    return parsed["results"] != null ? new List<CalendarTime>.from( parsed["results"].map((x) => CalendarTime.fromJSON(x))) : List<CalendarTime>();
  }

  Future<List<CalendarTime>> FetchOwnCalendarTime(http.Client client,String userid,int page) async {
    final response = await http.get(Uri.parse("$SERVER_IP/api/calendartimes/?page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    return parsed["results"] != null ? new List<CalendarTime>.from( parsed["results"].map((x) => CalendarTime.fromJSON(x))) : List<CalendarTime>();
  }

  Future<List<CalendarStatus>> FetchOwnCalendarStatus(http.Client client,String userid,int page) async {
    final response = await http.get(Uri.parse("$SERVER_IP/api/calendarstatuses/?page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    return parsed["results"] != null ? new List<CalendarStatus>.from( parsed["results"].map((x) => CalendarStatus.fromJSON(x))) : List<CalendarStatus>();
  }

  Future<List<UserBookmark>> FetchOwnBookmark(http.Client client,String userid,int page) async {
    final response = await http.get(Uri.parse("$SERVER_IP/api/articlebookmarks/?page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    return parsed["results"] != null ? new List<UserBookmark>.from( parsed["results"].map((x) => UserBookmark.fromJSON(x))) : List<UserBookmark>();
  }

  Future<List<UserBlock>> FetchOwnBlockedUsers(http.Client client,String userid,int page) async {
    final response = await http.get(Uri.parse("$SERVER_IP/api/userblocks/?page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    return parsed["results"] != null ? new List<UserBlock>.from( parsed["results"].map((x) => UserBlock.fromJSON(x))) : List<UserBlock>();
  }






  Future<List<UserPhone>> FetchFollowedUserPhone(http.Client client,String userid,int page) async {
    final response = await http.get(Uri.parse("$SERVER_IP/api/followeduserphones/?author=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    final parsed = jsonDecode(utf8.decode(response.bodyBytes));
    List<UserPhone> phones =  parsed["results"] != null ? new List<UserPhone>.from( parsed["results"].map((x) => UserPhone.fromJSON(x))) : List<UserPhone>();
 for(final item in phones){
   print(item.id);
   print(item.phone);
 }
    return phones;
  }


  Future<List<UserPhone>> FetchPublicUserPhone(http.Client client,String userid,int page) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/publicuserphones/?author=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<UserPhone> phones = parsed["results"] != null ? new List<UserPhone>.from( parsed["results"].map((x) => UserPhone.fromJSON(x))) : List<UserPhone>();
  for(final item in phones){
    print(item.id);
    print(item.phone);
  }
  return phones;
  }

  Future<List<UserPhone>> FetchOwnUserPhone(http.Client client,String userid,int page) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/userphones/?page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<UserPhone> phones =  parsed["results"] != null ? new List<UserPhone>.from( parsed["results"].map((x) => UserPhone.fromJSON(x))) : List<UserPhone>();
  for(final item in phones){
    print(item.id);
    print(item.phone);
  }
  return phones;
  }


  Future<List<UserMail>> FetchFollowedUserMail(http.Client client,String userid,int page) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/followedusermails/?author=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  return parsed["results"] != null ? new List<UserMail>.from( parsed["results"].map((x) => UserMail.fromJSON(x))) : List<UserMail>();
  }


  Future<List<UserMail>> FetchPublicUserMail(http.Client client,String userid,int page) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/publicusermails/?author=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  return parsed["results"] != null ? new List<UserMail>.from( parsed["results"].map((x) => UserMail.fromJSON(x))) : List<UserMail>();
  }

  Future<List<UserMail>> FetchOwnUserMail(http.Client client,String userid,int page) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/usermails/?page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  return parsed["results"] != null ? new List<UserMail>.from( parsed["results"].map((x) => UserMail.fromJSON(x))) : List<UserMail>();
  }


  Future<List<UserLocation>> FetchFollowedUserLocation(http.Client client,String userid,int page) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/followeduserlocations/?author=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  return parsed["results"] != null ? new List<UserLocation>.from( parsed["results"].map((x) => UserLocation.fromJSON(x))) : List<UserLocation>();
  }


  Future<List<UserLocation>> FetchPublicUserLocation(http.Client client,String userid,int page) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/publicuserlocations/?author=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  return parsed["results"] != null ? new List<UserLocation>.from( parsed["results"].map((x) => UserLocation.fromJSON(x))) : List<UserLocation>();
  }

  Future<List<UserLocation>> FetchOwnUserLocation(http.Client client,String userid,int page) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/userlocations/?page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  return parsed["results"] != null ? new List<UserLocation>.from( parsed["results"].map((x) => UserLocation.fromJSON(x))) : List<UserLocation>();
  }

Future<List<Article>> FetchOwnArticlesAll(String userid,int page,User calendarowner,bool typetwo,String mnyinit,String day,String dayfull,) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/fetcharticles/?page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<Article> finalarticles = parsed["results"] != null ? new List<Article>.from( parsed["results"].map((x) => Article.fromJSON(x))) : List<Article>();
  for(int i = 0;i<finalarticles.length;i++){
    print(finalarticles[i].type);
    if(finalarticles[i].hideifoutofstock && finalarticles[i].stock > 1){finalarticles.removeAt(i);}
    if(finalarticles[i].type == 'CI' || finalarticles[i].type == 'CalendarItem'){
      if(typetwo == false){
        if(doesitembelongtocal(finalarticles[i].caption,calendarowner, mnyinit,day) == false){finalarticles.removeAt(i);}
      }
    }
    if(finalarticles[i].type == 'CE' || finalarticles[i].type == 'CalendarEvent'){
      if(dayfull != '' && dayfull != finalarticles[i].date){finalarticles.removeAt(i);}
    }
  }
  return finalarticles;
}


Future<List<Article>> FetchOwnArticles(String userid,int page,User calendarowner,bool typetwo,String mnyinit,String day,String dayfull,String type) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/fetcharticles/?page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<Article> finalarticles = parsed["results"] != null ? new List<Article>.from( parsed["results"].map((x) => Article.fromJSON(x))) : List<Article>();
   for(int i = 0;i<finalarticles.length;i++){
     print(finalarticles[i].type);
     if(finalarticles[i].hideifoutofstock && finalarticles[i].stock > 1){finalarticles.removeAt(i);}
     if(finalarticles[i].type == 'CI' || finalarticles[i].type == 'CalendarItem'){
       if(typetwo == false){
       if(doesitembelongtocal(finalarticles[i].caption,calendarowner, mnyinit,day) == false){finalarticles.removeAt(i);}
         }
     }
     if(finalarticles[i].type == 'CE' || finalarticles[i].type == 'CalendarEvent'){
       if(dayfull != '' && dayfull != finalarticles[i].date){finalarticles.removeAt(i);}
     }
   }
   return finalarticles;
}

Future<List<Article>> FetchOwnArticlesFiltered(String userid,int page,User calendarowner,bool typetwo,String mnyinit,String day,String dayfull,String type) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/fetcharticles/?page=$page&type=$type&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  print(parsed);
  List<Article> finalarticles = parsed["results"] != null ? new List<Article>.from( parsed["results"].map((x) => Article.fromJSON(x))) : List<Article>();
  for(int i = 0;i<finalarticles.length;i++){
    if(finalarticles[i].hideifoutofstock && finalarticles[i].stock > 1){finalarticles.removeAt(i);}

    if(finalarticles[i].type == 'CE' || finalarticles[i].type == 'CalendarEvent'){
      if(dayfull != '' && dayfull != finalarticles[i].date){finalarticles.removeAt(i);}
    }
  }
  print('fel ${finalarticles.length}');
  return finalarticles;
}


Future<List<Article>> FetchFollowedArticles(String userid,int page,User calendarowner,bool typetwo,String mnyinit,String day,String dayfull,String type) async {
  print('a');
  final response = await http.get(Uri.parse("$SERVER_IP/api/articles/?page=$page&type=$type&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));

  List<Article> finalarticles= parsed["results"] != null ? new List<Article>.from( parsed["results"].map((x) => Article.fromJSON(x))) : List<Article>();




  for(int i = 0;i<finalarticles.length;i++){
    if(finalarticles[i].hideifoutofstock && finalarticles[i].stock > 1){finalarticles.removeAt(i);}
    if(finalarticles[i].type == 'CI' || finalarticles[i].type == 'CalendarItem'){
      if(typetwo == false){
        if(doesitembelongtocal(finalarticles[i].caption,calendarowner, mnyinit,day) == false){finalarticles.removeAt(i);}
      }
    }
    if(finalarticles[i].type == 'CE' || finalarticles[i].type == 'CalendarEvent'){
      if(dayfull != '' && dayfull != finalarticles[i].date){finalarticles.removeAt(i);}
    }
    isarticleliked(userid, finalarticles[i].id)..then((result) {finalarticles[i].likeresult = result;});
    isarticledisliked(userid, finalarticles[i].id)..then((result) {finalarticles[i].dislikeresult = result;});
    isarticlebookmarked(userid, finalarticles[i].id)..then((result) {finalarticles[i].bookmarkresult = result;});
    articlebookmarkid(userid, finalarticles[i].id)..then((result) {finalarticles[i].bookmarkidresult = result;});
  }

  return finalarticles;
}

Future<List<Article>> FetchPublicArticles(String userid,int page,User calendarowner,bool typetwo,String mnyinit,String day,String dayfull,String type) async {

  final response = await http.get(Uri.parse("$SERVER_IP/api/publicarticles/?page=$page&type=$type&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));

  List<Article> finalarticles= parsed["results"] != null ? new List<Article>.from( parsed["results"].map((x) => Article.fromJSON(x))) : List<Article>();
  for(int i = 0;i<finalarticles.length;i++){
    if(finalarticles[i].hideifoutofstock && finalarticles[i].stock > 1){finalarticles.removeAt(i);}
    if(finalarticles[i].type == 'CI' || finalarticles[i].type == 'CalendarItem'){
      if(typetwo == false){
        if(doesitembelongtocal(finalarticles[i].caption,calendarowner, mnyinit,day) == false){finalarticles.removeAt(i);}
      }
    }
    if(finalarticles[i].type == 'CE' || finalarticles[i].type == 'CalendarEvent'){
      if(dayfull != '' && dayfull != finalarticles[i].date){finalarticles.removeAt(i);}
    }

    isarticleliked(userid, finalarticles[i].id)..then((result) {finalarticles[i].likeresult = result;});
    isarticledisliked(userid, finalarticles[i].id)..then((result) {finalarticles[i].dislikeresult = result;});
    isarticlebookmarked(userid, finalarticles[i].id)..then((result) {finalarticles[i].bookmarkresult = result;});
    articlebookmarkid(userid, finalarticles[i].id)..then((result) {finalarticles[i].bookmarkidresult = result;});
  }

  return finalarticles;
}

Future<List<Article>> FetchFollowedArticlesFiltered(String userid,int page,User calendarowner,bool typetwo,String mnyinit,String day,String dayfull,String type) async {
  print('a');
  final response = await http.get(Uri.parse("$SERVER_IP/api/articles/?page=$page&type=$type&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));

  List<Article> finalarticles= parsed["results"] != null ? new List<Article>.from( parsed["results"].map((x) => Article.fromJSON(x))) : List<Article>();





  for(int i = 0;i<finalarticles.length;i++){
    if(finalarticles[i].hideifoutofstock && finalarticles[i].stock < 1){finalarticles.removeAt(i);}
    isarticleliked(userid, finalarticles[i].id)..then((result) {finalarticles[i].likeresult = result;});
    isarticledisliked(userid, finalarticles[i].id)..then((result) {finalarticles[i].dislikeresult = result;});
    isarticlebookmarked(userid, finalarticles[i].id)..then((result) {finalarticles[i].bookmarkresult = result;});
    articlebookmarkid(userid, finalarticles[i].id)..then((result) {finalarticles[i].bookmarkidresult = result;});
  }
  print('fel ${finalarticles.length}');
  return finalarticles;
}

Future<List<Article>> FetchPublicArticlesFiltered(String userid,int page,User calendarowner,bool typetwo,String mnyinit,String day,String dayfull,String type) async {

  final response = await http.get(Uri.parse("$SERVER_IP/api/publicarticles/?page=$page&type=$type&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));

  List<Article> finalarticles= parsed["results"] != null ? new List<Article>.from( parsed["results"].map((x) => Article.fromJSON(x))) : List<Article>();
  for(int i = 0;i<finalarticles.length;i++){
    if(finalarticles[i].hideifoutofstock && finalarticles[i].stock < 1){finalarticles.removeAt(i);}
    isarticleliked(userid, finalarticles[i].id)..then((result) {finalarticles[i].likeresult = result;});
    isarticledisliked(userid, finalarticles[i].id)..then((result) {finalarticles[i].dislikeresult = result;});
    isarticlebookmarked(userid, finalarticles[i].id)..then((result) {finalarticles[i].bookmarkresult = result;});
    articlebookmarkid(userid, finalarticles[i].id)..then((result) {finalarticles[i].bookmarkidresult = result;});
  }
  print('fel ${finalarticles.length}');
  return finalarticles;
}



Future<List<Article>> FetchFollowedArticlesAll(String userid,int page,User calendarowner,bool typetwo,String mnyinit,String day,String dayfull) async {
  print('a');
  final response = await http.get(Uri.parse("$SERVER_IP/api/articles/?page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));

  List<Article> finalarticles= parsed["results"] != null ? new List<Article>.from( parsed["results"].map((x) => Article.fromJSON(x))) : List<Article>();


  for(int i = 0;i<finalarticles.length;i++){
    if(finalarticles[i].hideifoutofstock && finalarticles[i].stock < 1){print('a');finalarticles.removeAt(i);}
    isarticleliked(userid, finalarticles[i].id)..then((result) {print('aa');finalarticles[i].likeresult = result;});
    isarticledisliked(userid, finalarticles[i].id)..then((result) {print('b');finalarticles[i].dislikeresult = result;});
    isarticlebookmarked(userid, finalarticles[i].id)..then((result) {print('d');finalarticles[i].bookmarkresult = result;});
    articlebookmarkid(userid, finalarticles[i].id)..then((result) {print('c');finalarticles[i].bookmarkidresult = result;});
  }
  print(finalarticles.length);
  return finalarticles;
}

Future<List<Article>> FetchPublicArticlesAll(String userid,int page,User calendarowner,bool typetwo,String mnyinit,String day,String dayfull) async {

  final response = await http.get(Uri.parse("$SERVER_IP/api/publicarticles/?page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));

  List<Article> finalarticles= parsed["results"] != null ? new List<Article>.from( parsed["results"].map((x) => Article.fromJSON(x))) : List<Article>();
  for(int i = 0;i<finalarticles.length;i++){
    if(finalarticles[i].hideifoutofstock && finalarticles[i].stock < 1){finalarticles.removeAt(i);}
    isarticleliked(userid, finalarticles[i].id)..then((result) {
      finalarticles[i].likeresult = result;});
    isarticledisliked(userid, finalarticles[i].id)..then((result) {finalarticles[i].dislikeresult = result;});
    isarticlebookmarked(userid, finalarticles[i].id)..then((result) {finalarticles[i].bookmarkresult = result;});
    articlebookmarkid(userid, finalarticles[i].id)..then((result) {finalarticles[i].bookmarkidresult = result;});
  }
  return finalarticles;
}



Future<bool> isuserliked(String authorid,String profileid) async {
  print("$SERVER_IP/api/userunlikes/?author=$authorid&profile=$profileid");
  final response = await http.get(Uri.parse("$SERVER_IP/api/userunlikes/?author=$authorid&profile=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<UserLike> users = parsed["results"] != null ? new List<UserLike>.from( parsed["results"].map((x) => UserLike.fromJSON(x))) : List<UserLike>();
  if(users.isNotEmpty){
  if(authorid == users.first.author &&  profileid == users.first.profile){
  return true;
  }}
  return false;
}


Future<String> userlikeid(String authorid,String profileid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/userunlikes/?author=$authorid&profile=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<UserLike> users = parsed["results"] != null ? new List<UserLike>.from( parsed["results"].map((x) => UserLike.fromJSON(x))) : List<UserLike>();
  if(users.isNotEmpty){
  if(authorid == users.first.author &&  profileid == users.first.profile){
    print(users.first.id);
  return users.first.id;
  }}
  return '';
}

Future<bool> isuserdisliked(String authorid,String profileid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/userundislikes/?author=$authorid&profile=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<UserDislike> users = parsed["results"] != null ? new List<UserDislike>.from( parsed["results"].map((x) => UserDislike.fromJSON(x))) : List<UserDislike>();
  if(users.isNotEmpty){
  if(authorid == users.first.authorstring &&  profileid == users.first.profile){
  return true;
  }}
  return false;
}


Future<String> userdislikeid(String authorid,String profileid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/userundislikes/?author=$authorid&profile=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<UserDislike> users = parsed["results"] != null ? new List<UserDislike>.from( parsed["results"].map((x) => UserDislike.fromJSON(x))) : List<UserDislike>();
  if(users.isNotEmpty){
  if(authorid == users.first.authorstring &&  profileid == users.first.profile){
    print(users.first.id);
  return users.first.id;
  }}
  return '';
}
Future<bool> isarticleliked(String authorid,String profileid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/articleunlikes/?author=$authorid&article=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  print('aa : $parsed');
  List<ArticleLike> users = parsed["results"] != null ? new List<ArticleLike>.from( parsed["results"].map((x) => ArticleLike.fromJSON(x))) : List<ArticleLike>();
  if(users.isNotEmpty){
  if(authorid == users.first.authorstring &&  profileid == users.first.article){
  return true;
  }

  }
  return false;
}

Future<String> articlelikeid(String authorid,String profileid) async {

  final response = await http.get(Uri.parse("$SERVER_IP/api/articleunlikes/?author=$authorid&article=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<ArticleLike> users = parsed["results"] != null ? new List<ArticleLike>.from( parsed["results"].map((x) => ArticleLike.fromJSON(x))) : List<ArticleLike>();
  if(users.isNotEmpty){
  if(authorid == users.first.authorstring &&  profileid == users.first.article){
  return users.first.id;
  }
  }
return '';
}


Future<bool> isarticledisliked(String authorid,String profileid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/articleundislikes/?author=$authorid&article=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<ArticleDislike> users = parsed["results"] != null ? new List<ArticleDislike>.from( parsed["results"].map((x) => ArticleDislike.fromJSON(x))) : List<ArticleDislike>();
  if(users.isNotEmpty){
  if(authorid == users.first.authorstring &&  profileid == users.first.article){
  return true;
  }
  }
return false;
}


Future<String> articledislikeid(String authorid,String profileid) async {

  final response = await http.get(Uri.parse("$SERVER_IP/api/articleundislikes/?author=$authorid&article=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<ArticleDislike> users = parsed["results"] != null ? new List<ArticleDislike>.from( parsed["results"].map((x) => ArticleDislike.fromJSON(x))) : List<ArticleDislike>();
  if(users.isNotEmpty){
  if(authorid == users.first.authorstring &&  profileid == users.first.article){
  return users.first.id;
  }}
return '';
}

Future<bool> isuserfollowedsilently(String authorid,String profileid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/userfollows/?author=$authorid&profile=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<UserFollow> users = parsed["results"] != null ? new List<UserFollow>.from( parsed["results"].map((x) => UserFollow.fromJSON(x))) : List<UserFollow>();

  if(users.isNotEmpty){
    print('here2');
  print(users.first.issilent);
    if(authorid == users.first.author &&  profileid == users.first.profile && users.first.issilent){
      return true;
    }}
  return false;
}

Future<bool> isuserfollowed(String authorid,String profileid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/userfollows/?author=$authorid&profile=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<UserFollow> users = parsed["results"] != null ? new List<UserFollow>.from( parsed["results"].map((x) => UserFollow.fromJSON(x))) : List<UserFollow>();
  if(users.isNotEmpty){
    if(authorid == users.first.author &&  profileid == users.first.profile){
      print('jj');
      return true;
    }}
  return false;
}

Future<bool> isuserfollowrequested(String authorid,String profileid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/requests/?author=$authorid&profile=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<RequestInit> users = parsed["results"] != null ? new List<RequestInit>.from( parsed["results"].map((x) => RequestInit.fromJSON(x))) : List<RequestInit>();
  if(users.isNotEmpty){
    if(authorid == users.first.author &&  profileid == users.first.profile){
      if(users.first.requesttype == 'follow'){
        return true;}
    }}
  return false;
}

Future<String> userfollowrequestid(String authorid,String profileid) async {

  final response = await http.get(Uri.parse("$SERVER_IP/api/requests/?author=$authorid&profile=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<RequestInit> users = parsed["results"] != null ? new List<RequestInit>.from( parsed["results"].map((x) => RequestInit.fromJSON(x))) : List<RequestInit>();
  if(users.isNotEmpty) {
    if(authorid == users.first.author &&  profileid == users.first.profile){
      if(users.first.requesttype == 'follow'){
        return users.first.id;}
    }}
  return '';
}

Future<String> userfollowid(String authorid,String profileid) async {
  print('$SERVER_IP/api/userfollows/?author=$authorid&profile=$profileid&format=json');
  final response = await http.get(Uri.parse("$SERVER_IP/api/userfollows/?author=$authorid&profile=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<UserFollow> users = parsed["results"] != null ? new List<UserFollow>.from( parsed["results"].map((x) => UserFollow.fromJSON(x))) : List<UserFollow>();
  if(users.isNotEmpty){
    if(authorid == users.first.author &&  profileid == users.first.profile){
      return users.first.id;
    }}
  return '';
}


Future<bool> isarticlebookmarked(String authorid,String profileid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/articlebookmarks/?author=$authorid&article=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<UserBookmark> users = parsed["results"] != null ? new List<UserBookmark>.from( parsed["results"].map((x) => UserBookmark.fromJSON(x))) : List<UserBookmark>();
  if(users.isNotEmpty){
  if(authorid == users.first.author &&  profileid == users.first.article){
  return true;
  }
  }
return false;
}


Future<String> articlebookmarkid(String authorid,String profileid) async {
  print("$SERVER_IP/api/articlebookmarks/?author=$authorid&article=$profileid");
  final response = await http.get(Uri.parse("$SERVER_IP/api/articlebookmarks/?article=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<UserBookmark> users = parsed["results"] != null ? new List<UserBookmark>.from( parsed["results"].map((x) => UserBookmark.fromJSON(x))) : List<UserBookmark>();
  if(users.isNotEmpty){
  if(authorid == users.first.author &&  profileid == users.first.article){
    print('zzz');
  return users.first.id;
  }}
  return '';
}

















Future<bool> isusercommentliked(String authorid,String profileid) async {
  print("$SERVER_IP/api/usercommentunlikes/?author=$authorid&profile=$profileid");
  final response = await http.get(Uri.parse("$SERVER_IP/api/usercommentunlikes/?author=$authorid&profile=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<UserCommentLike> users = parsed["results"] != null ? new List<UserCommentLike>.from( parsed["results"].map((x) => UserCommentLike.fromJSON(x))) : List<UserCommentLike>();
  if(users.isNotEmpty){
    if(authorid == users.first.author &&  profileid == users.first.profile){
      return true;
    }}
  return false;
}


Future<String> usercommentlikeid(String authorid,String profileid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/usercommentunlikes/?author=$authorid&profile=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<UserCommentLike> users = parsed["results"] != null ? new List<UserCommentLike>.from( parsed["results"].map((x) => UserCommentLike.fromJSON(x))) : List<UserCommentLike>();
  if(users.isNotEmpty){
    if(authorid == users.first.author &&  profileid == users.first.profile){
      print(users.first.id);
      return users.first.id;
    }}
  return '';
}

Future<bool> isusercommentdisliked(String authorid,String profileid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/usercommentundislikes/?author=$authorid&profile=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<UserCommentDislike> users = parsed["results"] != null ? new List<UserCommentDislike>.from( parsed["results"].map((x) => UserCommentDislike.fromJSON(x))) : List<UserCommentDislike>();
  if(users.isNotEmpty){
    if(authorid == users.first.authorstring &&  profileid == users.first.profile){
      return true;
    }}
  return false;
}


Future<String> usercommentdislikeid(String authorid,String profileid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/usercommentundislikes/?author=$authorid&profile=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<UserCommentDislike> users = parsed["results"] != null ? new List<UserCommentDislike>.from( parsed["results"].map((x) => UserCommentDislike.fromJSON(x))) : List<UserCommentDislike>();
  if(users.isNotEmpty){
    if(authorid == users.first.authorstring &&  profileid == users.first.profile){
      print(users.first.id);
      return users.first.id;
    }}
  return '';
}
Future<bool> isarticlecommentliked(String authorid,String profileid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/articlecommentunlikes/?author=$authorid&article=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  print('aa : $parsed');
  List<ArticleCommentLike> users = parsed["results"] != null ? new List<ArticleCommentLike>.from( parsed["results"].map((x) => ArticleCommentLike.fromJSON(x))) : List<ArticleCommentLike>();
  if(users.isNotEmpty){
    if(authorid == users.first.authorstring &&  profileid == users.first.article){
      return true;
    }

  }
  return false;
}

Future<String> articlecommentlikeid(String authorid,String profileid) async {

  final response = await http.get(Uri.parse("$SERVER_IP/api/articlecommentunlikes/?author=$authorid&article=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<ArticleCommentLike> users = parsed["results"] != null ? new List<ArticleCommentLike>.from( parsed["results"].map((x) => ArticleCommentLike.fromJSON(x))) : List<ArticleCommentLike>();
  if(users.isNotEmpty){
    if(authorid == users.first.authorstring &&  profileid == users.first.article){
      return users.first.id;
    }
  }
  return '';
}


Future<bool> isarticlecommentdisliked(String authorid,String profileid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/articlecommentundislikes/?author=$authorid&article=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<ArticleCommentDislike> users = parsed["results"] != null ? new List<ArticleCommentDislike>.from( parsed["results"].map((x) => ArticleCommentDislike.fromJSON(x))) : List<ArticleCommentDislike>();
  if(users.isNotEmpty){
    if(authorid == users.first.authorstring &&  profileid == users.first.article){
      return true;
    }
  }
  return false;
}


Future<String> articlecommentdislikeid(String authorid,String profileid) async {

  final response = await http.get(Uri.parse("$SERVER_IP/api/articlecommentundislikes/?author=$authorid&article=$profileid&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  List<ArticleCommentDislike> users = parsed["results"] != null ? new List<ArticleCommentDislike>.from( parsed["results"].map((x) => ArticleCommentDislike.fromJSON(x))) : List<ArticleCommentDislike>();
  if(users.isNotEmpty){
    if(authorid == users.first.authorstring &&  profileid == users.first.article){
      return users.first.id;
    }}
  return '';
}





Future<String> CreateBoughtCheck(CartItem product,String author,String owner,double price,int count,String item,String link,String type,
    String category,String contact,String fullname,String deliverydate,String deliverytype,double deliveryfee,String deliveryaddress,String specialrequest,String deliverytime) async {
   print('$category $item $deliverytime');

  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/boughtchecks/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author':author,
      'owner':owner,
      'price':price,
      'count':count,
      'item':item,
      'link':link,
      'type':type,
      'category':category,
      'contact':contact,
      'fullname':fullname,
      'deliverydate':deliverydate,
      'deliverytype':deliverytype,
      'deliverytime':deliverytime,
      'deliveryfee':deliveryfee,
      'deliveryaddress':deliveryaddress ,
      'specialrequest' : specialrequest,
    }),
  );

  if (response.statusCode == 201) {
    print('User bought item $item created successfully');
    String responseinit = response.body.toString();
    String productid = responseinit.substring(7,43);
    for(int i=0;i<product.choices.length;i++){
      CreateBoughtItemChoice(author,productid , product.choices[i].choice, product.choices[i].category, product.choices[i].price);
    }
  }

  else {
    throw new Exception(response.body);
  }
}




Future<String> CreateCartItem(Article product,String author,String profile,String item,String link,String type,int count,int price,double deliveryfee) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/usercartitems/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'item': item,
      'link': link,
      'owner' : profile,
      'type': type,
      'count': count,
      'price': price + deliveryfee,
    }),
  );

  if (response.statusCode == 201) {
    print('User cart item $item created successfully');
    String responseinit = response.toString();
    for(int i=0;i<product.choices.length;i++){
      if(product.choices[i].ischosen){
        CreateCartItemChoice(author, responseinit.substring(7,43), product.choices[i].item, product.choices[i].category, int.parse(product.choices[i].price));
      }
    }
     }

  else {
    throw new Exception(response.body);
  }
}

Future<User> CreateBoughtItemChoice(String author,String item,String choice,String category,int price) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/boughtitemchoices/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'item': item,
      'choice': choice,
      'category': category,
      'price': price,
    }),
  );

  if (response.statusCode == 201) {
    print('User cart item choice $choice created successfully');
  }

  else {
    throw new Exception(response.body);
  }
}


Future<User> CreateCartItemChoice(String author,String item,String choice,String category,int price) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/usercartitemchoices/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'item': item,
      'choice': choice,
      'category': category,
      'price': price,
    }),
  );

  if (response.statusCode == 201) {
    print('User cart item choice $choice created successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<User> CreateRequestItemChoice(String author,String item,String choice,String category,int price) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/requestitemchoices/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'request': item,
      'choice': choice,
      'category': category,
      'price': price,
    }),
  );

  if (response.statusCode == 201) {
    print('Request item choice $choice created successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<User> DeleteCartItem(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/cartitems/$id/"),
    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('User cart item deleted successfully');
  }

  else {
    throw new Exception(response.body);
  }
}
Future<User> DeleteRequestItem(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/requestitems/$id/"),
    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('request item deleted successfully');
  }

  else {
    throw new Exception(response.body);
  }
}
Future<User> DeleteCartItemChoice(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/cartitemchoices/$id/"),
    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('cart item choice deleted successfully');
  }

  else {
    throw new Exception(response.body);
  }
}
Future<User> DeleteRequestItemChoice(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/requestitemchoices/$id/"),
    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('requestitemchoices deleted successfully');
  }

  else {
    throw new Exception(response.body);
  }
}



Future<User> CreateMeetingSchedule(User user,String author,String profile,String item,String date,String time) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/meetingschedules/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'profile': profile,
      'date': date,
      'time': time,
    }),
  );

  if (response.statusCode == 201) {
    print('Created meeting schedule request successfully');
  }


  else {
    throw new Exception(response.body);
  }
}

Future<User> RemoveMeetingScheduleRequest(String id) async {
  print(id);
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/requests/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
  );

  if (response.statusCode == 204) {
    print('Removed meeting schedule request $id successfully');
  }


  else {
    throw new Exception(response.body);
  }
}

Future<User> AcceptMeetingRequest(String user1,String user2,Notifications notif,bool clientnow,bool isdenied,bool isaccepted) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/requests/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'profile': user2,
      'date': notif.date,
      'time': notif.time,
      'item': '-',
      'link' : '-',
      'fullname' : '-',
      'clientnow' : true,
      'isdenied' : false,
      'isaccepted' : true,
      'reason' : '-',
      'deliverydate' : '-',
      'requesttype' : 'meeting',
      'contact' : '-',
      'deliveryaddress' : '-',
    }),
  );

  if (response.statusCode == 201) {
    print('Sent meeting request to ${user2} successfully');

  }


  else {
    throw new Exception(response.body);
  }
}


Future<User> AcceptReservationRequest(String user1,String user2,Notifications notif,bool clientnow,bool isdenied,bool isaccepted) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/requests/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'profile': user2,
      'date': notif.date,
      'time': notif.time,
      'item': notif.item,
      'link' : notif.link,
      'clientnow' : true,
      'isdenied' : false,
      'isaccepted' : true,
      'reason' : '-',
      'requesttype' : 'reservation',
      'contact' : '-',
      'deliveryaddress' : '-',
    }),
  );

  if (response.statusCode == 201) {
    print('Sent follow request to ${user2} successfully');
    String responseinit = response.body.toString();
    String itemid = responseinit.substring(7,43);



  }


  else {
    throw new Exception(response.body);
  }
}
Future<User> AcceptReservationScheduleRequest(String user1,String user2,Notifications notif,bool clientnow,bool isdenied,bool isaccepted) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/requests/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': user1,
      'profile': user2,
      'date': notif.date,
      'time': '-',
      'item': notif.item,
      'link' : notif.link,
      'clientnow' : true,
      'isdenied' : false,
      'isaccepted' : true,
      'reason' : '-',
      'requesttype' : 'reservation',
      'contact' : '-',
      'deliveryaddress' : '-',
    }),
  );

  if (response.statusCode == 201) {
    print('Sent follow request to ${user2} successfully');
  }


  else {
    throw new Exception(response.body);
  }
}
HighlightUserProduct(User user,Article userproduct,bool highlight) async {


  try {

    FormData formData = new FormData.fromMap({
      'author' : user.id,
      'category' : userproduct.category,
      'article':userproduct.caption ,
      'price':  userproduct.price ,
      'details':userproduct.details ,
      'ishighlighted' : highlight,
      'locationcountry':userproduct.locationcountry ,
      'locationstate': userproduct.locationstate,
      'locationcity':userproduct.locationcity,

    });
    Response response = await Dio().patch("$SERVER_IP/api/articles/${userproduct.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );



    print('RD: ${response.data.toString()}');



  } catch (e) {
    print('EU: $e');
  }

}
UnHighlightUserProduct(User user,Article userproduct,bool highlight) async {


  try {

    FormData formData = new FormData.fromMap({
      'author' : user.id,
      'category' : userproduct.category,
      'article':userproduct.caption ,
      'price':  userproduct.price ,
      'details':userproduct.details ,
      'ishighlighted' : highlight,
      'locationcountry':userproduct.locationcountry ,
      'locationstate': userproduct.locationstate,
      'locationcity':userproduct.locationcity,

    });
    Response response = await Dio().patch("$SERVER_IP/api/articles/${userproduct.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );



    print('RD: ${response.data.toString()}');



  } catch (e) {
    print('EU: $e');
  }

}
Future<Article> FetchPublicArticle(http.Client client,String userid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/publicarticles/$userid/?format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
  return Article.fromJSON(responseJson);
}

Future<Article> FetchFollowedArticle(http.Client client,String userid) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/articles/$userid/?format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
  return Article.fromJSON(responseJson);
}

Future<List<ArticleCategory>> FetchFollowedUserProductCategory(String userid,int page) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/followedarticlecategories/?author=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  return parsed["results"] != null ? new List<ArticleCategory>.from( parsed["results"].map((x) => ArticleCategory.fromJSON(x))) : List<ArticleCategory>();
}
Future<List<ArticleCategory>> FetchPublicUserProductCategory(String userid,int page) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/publicarticlecategories/?author=$userid&page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  return parsed["results"] != null ? new List<ArticleCategory>.from( parsed["results"].map((x) => ArticleCategory.fromJSON(x))) : List<ArticleCategory>();
}
Future<List<ArticleCategory>> FetchOwnUserProductCategory(String userid,int page) async {
  final response = await http.get(Uri.parse("$SERVER_IP/api/articlecategories/?page=$page&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  return parsed["results"] != null ? new List<ArticleCategory>.from( parsed["results"].map((x) => ArticleCategory.fromJSON(x))) : List<ArticleCategory>();
}






SearchUserProductCategoriesNew2(int page,String searchfield) async {

  List<ArticleCategory> articlesfinal = [];
  final response = await http.get(Uri.parse("$SERVER_IP/api/searchpublicarticlecategories/?page=$page&search=$searchfield&format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed = jsonDecode(utf8.decode(response.bodyBytes));
  print(parsed);
  List<ArticleCategory> users = parsed["results"] != null ? new List<ArticleCategory>.from( parsed["results"].map((x) => ArticleCategory.fromJSON(x))) : List<ArticleCategory>();
  final response2 = await http.get(Uri.parse("$SERVER_IP/api/searchfollowedarticlecategories/?page=$page&search=$searchfield&format=json") ,headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
  final parsed2 = jsonDecode(utf8.decode(response2.bodyBytes));
  List<ArticleCategory> users2 = parsed2["results"] != null ? new List<ArticleCategory>.from( parsed2["results"].map((x) => ArticleCategory.fromJSON(x))) : List<ArticleCategory>();


  articlesfinal.addAll(users);
  articlesfinal.addAll(users2);

  return articlesfinal.toSet().toList();
}








Future<User> CreateReservationScheduleRequest(String author,String profile,String item,String startdate,String enddate) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/requests/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'profile': profile,
      'date': '$startdate-$enddate',
      'time': '-',
      'item': item,
      'link': item,
      'clientnow' : false,
      'isdenied' : false,
      'isaccepted' : false,
      'requesttype' : 'reservation',
      'contact' : '-',
      'deliveryaddress' : '-',
      'fullname' : '-',
      'reason' : '-',
      'deliverydate' : '-',
    }),
  );

  if (response.statusCode == 201) {
    print('Created calendar schedule request successfully');
  }


  else {
    throw new Exception(response.body);
  }
}

Future<User> CreateReservationSchedule(User user,String author,String profile,String item,String startdate,String enddate) async {
  print('Profile : $profile');
  print('You: $author');
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/reservationschedules/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'profile': profile,
      'startdate': startdate.substring(0,10),
      'enddate': startdate.substring(11,21),
      'time': '-',
      'link': item,
      'reservation': item,
    }),
  );

  if (response.statusCode == 201) {
    print('Created calendar schedule request successfully');
  }


  else {
    throw new Exception(response.body);
  }
}

Future<User> CreateReservationDeactivationMonth(String author,String startdate,String enddate) async {

  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/reservationdeactivationmonths/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'startdate': startdate,
      'enddate': enddate,
      'time': '-',
    }),
  );

  if (response.statusCode == 201) {
    print('Created res. deac. month successfully');
  }


  else {
    throw new Exception(response.body);
  }
}





Future<User> DeleteArticleRequest(String id) async {
  print(id);
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/requests/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
  );

  if (response.statusCode == 204) {
    print('Removed user service request $id successfully');
  }


  else {
    throw new Exception(response.body);
  }
}

Future<User> RemoveReservationScheduleRequest(String id) async {
  print(id);
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/requests/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
  );

  if (response.statusCode == 204) {
    print('Removed reservation schedule request $id successfully');
  }


  else {
    throw new Exception(response.body);
  }
}
Future<User> RemoveReservationSchedule(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/reservationschedules/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
  );

  if (response.statusCode == 204) {
    print('Removed reservation schedule $id successfully');
  }


  else {
    throw new Exception(response.body);
  }
}


CreateArticle(User user,String caption,String details, bool disablecomments,
    bool anonymity,bool sensitive,bool spoiler,String tags,List<PickedFile> images,List<User> taggedusers,
  bool isshared,String originalpost,File video,bool isjobposting, String category,int price,bool isbuyenabled,
    int stock, bool isdelivered,int deliveryfee,String etatime,bool allowstocks,
    bool isimagerequired,List<FormModel> forms,List<CheckBoxModel> checkboxes,String type,bool  hideifoutofstock,
    bool  isforstay , bool isquestion, String  checkintime, String checkouttime , String  startdate, String   enddate,
    String readtime , String  deliveredfromtime, String deliveredtotime , String  specialinstructions ,
    String  guide , String  pricecurrency , String pricetype , int adults , int  kids , int  bedrooms , int  bathrooms
    ,List<ActivityModel> activities,List<HighlightModel> highlights,List<TravelLocationModel> travellocations,
    List<AmenityModel> amenities,List<DetailCategoryModel> detailcategories,List<DetailSpecModel> detailspecs,
    List<DetailIncludedModel> detailincludeds,List<DetailRuleModel> detailrules,String productcondition,
    String cedate) async {
  print('b: ${highlights.length}');
  String price = '';




  if(images == null){images = [];}

  bool hasImage;
  List<String> tags1 = tags.split(',');
  caption = caption == '' ? '-' : caption;



  try {
    FormData formData = new FormData.fromMap({
      'author' : user.id.toString(),
      'locationcountry' :  locationcountrygl,
      'locationstate' :  locationstategl,
      'locationcity' : locationcitygl,
      'caption' : caption,
      'isimagerequired' : isimagerequired,
      'details': details,
      'originalarticle' : isshared ?originalpost : '',
      'category' : category,
      'type' : type,
      'date' : cedate,
      'hasImage' : hasImage,
      'isjobposting' : isjobposting,
      'allowcomments' : disablecomments,
      'anonymity': anonymity,
      'sensitive' : sensitive,
      'spoiler' : spoiler,
      'ishighlighted' : false,
      'price':price,
      'isbuyenabled' : isbuyenabled,
      'isdelivered':isdelivered,
      'deliveryfee':deliveryfee,
      'etatime':etatime,
      'allowstocks':allowstocks,
      'stock':stock,
      'hideifoutofstock' :  hideifoutofstock,
      'isforstay' : isforstay ,
      'isquestion' :  isquestion,
      'checkintime' :  checkintime,
      'checkouttime' : checkouttime ,
      'startdate' :  startdate,
      'enddate' :  enddate,
      'readtime' : readtime ,
      'deliveredfromtime' :  deliveredfromtime,
      'deliveredtotime' : deliveredtotime ,
      'specialinstructions' : specialinstructions ,
      'guide' : guide ,
      'pricecurrency' : pricecurrency ,
      'pricetype' : pricetype ,
      'adults' : adults ,
      'kids' : kids ,
      'bedrooms' : bedrooms ,
      'bathrooms' : bathrooms ,
      'productcondition' : isstringnull(productcondition) ? '-' : productcondition ,
      'time' : '-',
      'date' : '-',
          });

// bool

    Response response = await Dio().post("$SERVER_IP/api/articlecreate/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} ));

    String articleid = response.toString().substring(7,43);
    print('c: ${highlights.length}');

    for (int i = 0; i < activities.length; i++)
    {

      CreateArticleActivity(articleid,activities[i].item.text,'');}

    for (int i = 0; i < highlights.length; i++)
    {
      print('1: ${highlights.length}');
      CreateArticleHighlight(articleid,highlights[i].item.text);}

    print('2 ${travellocations.length}');
    for (int i = 0; i < travellocations.length; i++)
    {CreateArticleTravelLocation(articleid,travellocations[i].item.text);}

    print('3 ${amenities.length}');
    for (int i = 0; i < amenities.length; i++)
    {CreateArticleAmenity(articleid,amenities[i].item.text);}

    print('3 ${detailcategories.length}');
    for (int i = 0; i < detailcategories.length; i++)
    {CreateArticleDetailCategory(articleid,detailcategories[i].item.text);
    for (int j = 0; j < detailcategories[i].detailspecs.length; j++)
    {CreateArticleDetailSpec(articleid,detailcategories[i].item.text,detailcategories[i].detailspecs[j].item.text);}

    }


    print('5 ${detailincludeds.length}');
    for (int i = 0; i < detailincludeds.length; i++)
    {CreateArticleDetailIncluded(articleid,detailincludeds[i].item.text);}

    print('6 ${detailrules.length}');
    for (int i = 0; i < detailrules.length; i++)
    {CreateArticleDetailRule(articleid,detailrules[i].item.text);}

    print('7 ${forms.length}');
    for (int i = 0; i < forms.length; i++)
    {CreateUserServiceForms(user.id,articleid,forms[i].hint.text);}

    print('8');
    for (int i = 0; i < checkboxes.length; i++)
    {CreateUserServiceCheckBox(user.id,articleid,checkboxes[i].hint.text);}

    print('9');
    for (int i = 0; i < taggedusers.length; i++)
    {CreateArticleUserTags(user.id,articleid,taggedusers[i].id,taggedusers[i].username);}

    print('10');
    for (int i = 0; i < 10; i++) {if (tags1[i] != ""){CreateArticleTags(user.id,articleid,tags1[i]);}}


    print('11');
    for (int i = 0; i < choices.length; i++)
    {CreateUserProductChoiceCategory(articleid, choices[i]);}
    choices = [];

    print('12');
    for (int i = 0; i < images.length; i++)
    {
      FileSizeLimitImage(images[i].path)..then((value){
        if(value){print('File too big to upload!');
        return;}
        if(value == false){
          CreatePostImage(user.id,articleid,File(images[i].path));
        }
      });
    }


    FileSizeLimitVideo(video.path)..then((value){
      if(value){print('File too big to upload!');
      return;}
      if(value == false){
        CreateArticleVideo(user.id, articleid, video);
      }
    });






    locationcountrygl= '';
    locationstategl = '';
    locationcitygl = '';
  } catch (e) {
    print(e);
  }
}


EditArticle(
    String caption,String details, String tags,List<User> usertags, Article post1, int stock, int deliveryfee,
    String etatime,int price, bool disablecomments,bool anonymity,bool isbuyenabled,bool isdelivered, bool sensitive,
    bool spoiler,bool allowstocks,bool isimagerequired,bool  hideifoutofstock,
    bool  isforstay , bool isquestion, String  checkintime, String checkouttime , String  startdate, String   enddate,
    String readtime , String  deliveredfromtime, String deliveredtotime , String  specialinstructions ,
    String  guide , String  pricecurrency , String pricetype , int adults , int  kids , int  bedrooms , int  bathrooms,String productcondition) async {


  for (int i = 0; i < choices.length; i++)
  {CreateUserProductChoiceCategory(post1.id, choices[i]);}

  for (int i = 0; i < post1.choicecategories.length; i++)
  {
    for (int j = 0; j < post1.choicecategories[i].choices.length; j++)
    {
      CreateUserProductChoice(post1.id, post1.choicecategories[i].category, post1.choicecategories[i].choices[j].item.text, int.parse(post1.choicecategories[i].choices[j].price.text),
          false, false, 0);
    }

  }


  for (int i = 0; i < detailcategories.length; i++)
  {CreateArticleDetailCategory(post1.id, detailcategories[i].item.text);}

  for (int i = 0; i < post1.detailcategories.length; i++)
  {
    for (int j = 0; j < post1.detailspecs.length; j++)
    {
      CreateArticleDetailSpec(post1.id, post1.detailcategories[i].category, post1.detailcategories[i].specs[j].item.text);
    }

  }



  List<String> tags1 = tags.split(',');
  try {

    if(tags1.isNotEmpty){
      for (int i = 0; i < tags1.length; i++)
      {CreateArticleTags(post1.author,post1.id,tags1[i]);}
    }
    FormData formData = new FormData.fromMap({
      'author' : post1.author,
      'locationcountry' : locationcountrygl == 'null' ? post1.locationcountry : locationcountrygl,
      'locationstate' : locationstategl == 'null' ? post1.locationstate : locationstategl,
      'locationcity' : locationcitygl == 'null' ? post1.locationcity : locationcitygl,
      'caption' : caption == '' ? post1.caption : caption,
      'details': details == '' ? post1.details : details,
      'productcondition': productcondition == '' ? post1.productcondition : productcondition,
      'hideifoutofstock': hideifoutofstock,
      'isforstay' : false,
      'isquestion' : false,
      'checkintime': checkintime == '' ? post1.checkintime : checkintime,
      'checkouttime' :checkouttime == '' ? post1.checkouttime : checkouttime,
      'startdate':startdate == '' ? post1.startdate : startdate,
      'enddate':enddate== '' ? post1.enddate :enddate ,
      'readtime' :readtime == '' ? post1.readtime :readtime,
      'deliveredfromtime':deliveredfromtime == '' ? post1.deliveredfromtime :deliveredfromtime,
      'deliveredtotime' :deliveredtotime == '' ? post1.deliveredtotime :deliveredtotime,
      'specialinstructions' :specialinstructions == '' ? post1.specialinstructions :specialinstructions,
      'guide' :guide == '' ? post1.guide :guide,
      'pricecurrency' : pricecurrency == '' ? post1.pricecurrency  : pricecurrency,
      'pricetype' : '-',
      'adults' : adults,
      'kids' : kids,
      'bedrooms' : bedrooms,
      'bathrooms' : bathrooms,
      'allowcomments':disablecomments,
      'anonymity': anonymity,
      'price':   price,
      'sensitive': sensitive,
      'spoiler':  spoiler,
      'isbuyenabled': isbuyenabled,
      'stock':stock == -1 ? post1.stock : stock,
      'isdelivered':isbuyenabled,
      'deliveryfee':deliveryfee == -1 ? post1.price : stock,
      'etatime':etatime == '' ? post1.etatime : etatime,
      'allowstocks':isbuyenabled,
      'isimagerequired' : isbuyenabled,
    });

    for(int i=0;i<usertags.length;i++){
      CreateArticleUserTags(post1.author,post1.id, usertags[i].id, usertags[i].username);
    }


    Response response = await Dio().patch("$SERVER_IP/api/fetcharticles/${post1.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} ));
    print(response.toString());
    locationcountrygl= '';
    locationstategl = '';
    locationcitygl = '';
  } catch (e) {
    print(e);
  }
}






Future<ArticleComment> DeleteArticleChoiceCategory(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/articlechoicecategories/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('calendareventchoicecategories deleted successfully');
  }

  else {
    throw new Exception(response.body);
  }
}
Future<ArticleComment> DeleteArticleChoice(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/articlechoices/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('calendareventchoices deleted successfully');
  }

  else {
    throw new Exception(response.body);
  }
}
Future<User> DeleteArticleForm(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/articleforms/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('User service form $id deleted successfully');
  }

  else {
    throw new Exception(response.body);
  }
}
Future<User> DeleteArticleCheckbox(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/articlecheckboxes/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('User service checkbox $id deleted successfully');
  }

  else {
    throw new Exception(response.body);
  }
}
Future<User> DeleteArticleCategory(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/articlecategories/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('User service category $id deleted successfully');
  }

  else {
    throw new Exception(response.body);
  }
}


Future<ArticleTag> DeleteArticleTags(String id) async {
  final http.Response response = await http.delete(
    Uri.parse( "$SERVER_IP/api/articletags/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Post tag deleted successfully');
  }
  else {
    throw new Exception(response.body);
  }
}

Future<ArticleTag> DeleteArticleUserTags(String id) async {
  final http.Response response = await http.delete(
    Uri.parse( "$SERVER_IP/api/articleusertags/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Post user tag deleted successfully');
  }
  else {
    throw new Exception(response.body);
  }
}

Future<User> DeleteUserServiceCategory(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("$SERVER_IP/api/articlecategories/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('User service category $id deleted successfully');
  }

  else {
    throw new Exception(response.body);
  }
}




CreateArticleVideo(String author,String article,File video) async {

  String videoname = '${author}_${video.path.split('/').last}';


  try {



    FormData formData = new FormData.fromMap({
      'author': author,
      'article' : article.toString(),
      'video' : await MultipartFile.fromFile(video.path, filename:videoname),
    });

    await Dio().post("$SERVER_IP/api/articlevideos/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} ));

  } catch (e) {
    print(e);
  }
}


Future<ArticleTaggedUser> CreateArticleUserTags(String author,String article,String profile,String username) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/articleusertags/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'article': article,
      'author': author,
      'profile': profile,
      'username' : username,
    }),
  );

  if (response.statusCode == 201) {
    print('$username tagged in article $article successfully');
  }


  else {
    throw new Exception(response.body);
  }
}


CreateArticleComment(String author,String article,String content) async {
  try {
    FormData formData = new FormData.fromMap({
      'author' : author,
      'article' : article,
      'content' : content,
      'category' : 'A',
    });

    await Dio().post("$SERVER_IP/api/articlecomments/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} ));

  } catch (e) {
    print(e);
  }
}

Future<ArticleTag> CreateArticleTags(String author,String article,String tag) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/articletags/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'tag': tag,
      'author': author,
      'article': article,
    }),
  );

  if (response.statusCode == 201) {
    print('Article tag $tag created');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<User> CreateArticleReport(String author,String article,String issue) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/articlereports/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'article': article,
      'content' : issue,
    }),
  );

  if (response.statusCode == 201) {
    print('Article report created');
  }

  else {
    throw new Exception(response.body);
  }
}


CreateUserServiceForms(String author,String article,String hint) async {

  try {
    FormData formData = new FormData.fromMap({
      'article' : article,
      'hint' : hint,
    });

    await Dio().post("$SERVER_IP/api/articleforms/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} ));

  }catch (e) {
    print(e);
  }
}
CreateUserServiceCheckBox(String author,String userproduct,String checkbox) async {


  try {
    FormData formData = new FormData.fromMap({
      'article' : userproduct,
      'hint' : checkbox,
    });

    Response response = await Dio().post("$SERVER_IP/api/articlecheckboxes/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} ));

    if(response.statusCode == 201){
    }
    else{
      print(response.statusCode);
      print(response.data.toString());
    }

  } catch (e) {
    print(e);
  }
}

CreateUserProductChoiceCategory(String userproduct,ChoiceCategoryModel cat) async {
  print(cat.title.text);
  try {
    FormData formData = new FormData.fromMap({
      'article' : userproduct,
      'category' : cat.title.text,
      'image' : null,
    });

    Response response =  await Dio().post("$SERVER_IP/api/articlechoicecategories/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} ));

    for(int i=0;i<cat.choices.length;i++){
      int pricefinal = cat.choices[i].price.text == '' ? 0 : int.parse(cat.choices[i].price.text);
      CreateUserProductChoice(userproduct,cat.title.text,cat.choices[i].item.text,pricefinal,false,false,0);
    }

  }catch (e) {
    print('a1');
    print(e);
  }
}
CreateUserProductChoice(String userproduct,String category,String item,int price,bool isbuyenabled,bool allowstocks,int stock) async {
  print('${userproduct} ');
  try {
    FormData formData = new FormData.fromMap({
      'category' : category,
      'item' : item,
      'article': userproduct,
      'price' : price.toString(),
      'isbuyenabled' : false,
      'allowstocks' :false,
      'stock' : 0,
      'image' : null,
    });

    await Dio().post("$SERVER_IP/api/articlechoices/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} ));

  }catch (e) {
    print('a2');
    print(e);
  }
}


CreateUserProductCategory(String category,String author,File image) async {
  String imagename;

  if(image?.path != null){
     imagename = '${author}_${image.path.split('/').last}';
  }

  try {
    FormData formData = new FormData.fromMap({
      'author' : author,
      'category': category,
      'image' : await MultipartFile.fromFile(image.path, filename:imagename),
    });

    Response response = await Dio().post("$SERVER_IP/api/articlecategories/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} ));

    if(response.statusCode == 201){
      print('Created Image');
    }
    else{
      print(response.statusCode);
      print(response.data.toString());
    }

  } catch (e) {
    print(e);
  }
}


EditReservationChoiceCategory(ArticleChoiceCategory category,bool isallchooseable) async {


  try {


    FormData formData = new FormData.fromMap({
      'article' : category.userproduct,
      'category' : category.category,
      'allchooseable' : isallchooseable,


    });
    Response response = await Dio().patch("$SERVER_IP/api/articlechoicecategories/${category.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');



  } catch (e) {
    print('EU: $e');
  }

}

EditUserProductChoiceCategory(ArticleChoiceCategory category,bool isallchooseable) async {


  try {


    FormData formData = new FormData.fromMap({
      'article' : category.userproduct,
      'category' : category.category,
      'allchooseable' : isallchooseable,


    });
    Response response = await Dio().patch("$SERVER_IP/api/articlechoicecategories/${category.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');



  } catch (e) {
    print('EU: $e');
  }

}

EditUserServiceCheckBox(User user,String service,ArticleCheckBox checkbox) async {


  try {
    FormData formData = new FormData.fromMap({
      'article' :service,
      'hint':checkbox.edithint.text ,
    });
    Response response = await Dio().patch("$SERVER_IP/api/articlecheckboxes/${checkbox.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');

  } catch (e) {
    print('EU: $e');
  }

}

EditUserServiceForm(User user,String service,ArticleForm checkbox) async {


  try {
    FormData formData = new FormData.fromMap({
      'article':service,
      'hint': checkbox.edithint.text,
    });
    Response response = await Dio().patch("$SERVER_IP/api/articleforms/${checkbox.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');

  } catch (e) {
    print('EU: $e');
  }

}


EditArticleActivity(User user,String service,ArticleActivity checkbox) async {


  try {
    FormData formData = new FormData.fromMap({
      'article':service,
      'activity': checkbox.edithint.text,
    });
    Response response = await Dio().patch("$SERVER_IP/api/articleactivities/${checkbox.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');

  } catch (e) {
    print('EU: $e');
  }

}

EditArticleDetailIncluded(User user,String service,ArticleDetailIncluded checkbox) async {


  try {
    FormData formData = new FormData.fromMap({
      'article':service,
      'included': checkbox.edithint.text,
    });
    Response response = await Dio().patch("$SERVER_IP/api/articledetailincludeds/${checkbox.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');

  } catch (e) {
    print('EU: $e');
  }

}

EditArticleRule(User user,String service,ArticleDetailRule checkbox) async {


  try {
    FormData formData = new FormData.fromMap({
      'article':service,
      'rule': checkbox.edithint.text,
    });
    Response response = await Dio().patch("$SERVER_IP/api/articledetailrules/${checkbox.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');

  } catch (e) {
    print('EU: $e');
  }

}

EditArticleAmenity(User user,String service,ArticleAmenity checkbox) async {


  try {
    FormData formData = new FormData.fromMap({
      'article':service,
      'amenity': checkbox.edithint.text,
    });
    Response response = await Dio().patch("$SERVER_IP/api/articleamenities/${checkbox.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');

  } catch (e) {
    print('EU: $e');
  }

}

EditArticleHighlight(User user,String service,ArticleHighlight checkbox) async {


  try {
    FormData formData = new FormData.fromMap({
      'article':service,
      'highlight': checkbox.edithint.text,
    });
    Response response = await Dio().patch("$SERVER_IP/api/articlehighlights/${checkbox.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');

  } catch (e) {
    print('EU: $e');
  }

}

EditArticleLocation(User user,String service,ArticleTravelLocation checkbox) async {


  try {
    FormData formData = new FormData.fromMap({
      'article':service,
      'location': checkbox.edithint.text,
    });
    Response response = await Dio().patch("$SERVER_IP/api/articletravellocations/${checkbox.id}/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} )// set content-length},
    );

    print('RD: ${response.data.toString()}');

  } catch (e) {
    print('EU: $e');
  }

}


Future<ArticleTag> CreateArticleActivity(String article,String activity,String starttime) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/articleactivities/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'starttime': starttime,
      'activity': activity,
      'article': article,
    }),
  );

  if (response.statusCode == 201) {
    print('Created successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<ArticleTag> DeleteArticleActivity(String id) async {
  final http.Response response = await http.delete(
    Uri.parse( "$SERVER_IP/api/articleactivities/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Post tag deleted successfully');
  }
  else {
    throw new Exception(response.body);
  }
}

Future<ArticleTag> CreateArticleHighlight(String article,String highlight) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/articlehighlights/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'highlight': highlight,
      'article': article,
    }),
  );

  if (response.statusCode == 201) {
    print('Created successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<ArticleTag> DeleteArticleHighlight(String id) async {
  final http.Response response = await http.delete(
    Uri.parse( "$SERVER_IP/api/articlehighlights/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Post tag deleted successfully');
  }
  else {
    throw new Exception(response.body);
  }
}

Future<ArticleTag> CreateArticleTravelLocation(String article,String location) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/articletravellocations/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'location': location,
      'article': article,
    }),
  );

  if (response.statusCode == 201) {
    print('Created successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<ArticleTag> DeleteArticleTravelLocation(String id) async {
  final http.Response response = await http.delete(
    Uri.parse( "$SERVER_IP/api/articletravellocations/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Post tag deleted successfully');
  }
  else {
    throw new Exception(response.body);
  }
}

Future<ArticleTag> CreateArticleAmenity(String article,String amenity) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/articleamenities/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'amenity': amenity,
      'article': article,
    }),
  );

  if (response.statusCode == 201) {
    print('Created successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<ArticleTag> DeleteArticleAmenity(String id) async {
  final http.Response response = await http.delete(
    Uri.parse( "$SERVER_IP/api/articleamenities/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Post tag deleted successfully');
  }
  else {
    throw new Exception(response.body);
  }
}

Future<String> CreateArticleDetailCategory(String article,String category) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/articledetailcategories/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'category': category,
      'article': article,
    }),
  );

  if (response.statusCode == 201) {
    print('Created successfully');
    return response.body.toString().substring(7,43);
  }

  else {
    throw new Exception(response.body);
  }
}

Future<ArticleTag> DeleteArticleDetailCategory(String id) async {
  final http.Response response = await http.delete(
    Uri.parse( "$SERVER_IP/api/articleamenities/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Post tag deleted successfully');
  }
  else {
    throw new Exception(response.body);
  }
}

Future<ArticleTag> CreateArticleDetailSpec(String article,String category,String spec) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/articledetailspecs/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'category': category,
      'spec': spec,
      'article': article,
    }),
  );

  if (response.statusCode == 201) {
    print('Created successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<ArticleTag> DeleteArticleDetailSpec(String id) async {
  final http.Response response = await http.delete(
    Uri.parse( "$SERVER_IP/api/articleamenities/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Post tag deleted successfully');
  }
  else {
    throw new Exception(response.body);
  }
}

Future<ArticleTag> CreateArticleDetailIncluded(String article,String included) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/articledetailincludeds/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'included': included,
      'article': article,
    }),
  );

  if (response.statusCode == 201) {
    print('Created successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<ArticleTag> DeleteArticleDetailIncluded(String id) async {
  final http.Response response = await http.delete(
    Uri.parse( "$SERVER_IP/api/articledetailincludeds/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Post tag deleted successfully');
  }
  else {
    throw new Exception(response.body);
  }
}

Future<ArticleTag> CreateArticleDetailRule(String article,String rule) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/articledetailrules/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'rule': rule,
      'article': article,
    }),
  );

  if (response.statusCode == 201) {
    print('Created successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<ArticleTag> DeleteArticleDetailRule(String id) async {
  final http.Response response = await http.delete(
    Uri.parse( "$SERVER_IP/api/articledetailrules/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Post tag deleted successfully');
  }
  else {
    throw new Exception(response.body);
  }
}

Future<ArticleTag> CreateUserOpeningHour(String author,String weekday,String fromhour,String tohour,bool isalwaysopen,bool ispermanentlyclosed) async {
  final http.Response response = await http.post(
    Uri.parse("$SERVER_IP/api/useropeninghours/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'weekday': weekday,
      'fromhour': fromhour,
      'tohour': tohour,
      'isalwaysopen': isalwaysopen,
      'ispermanentlyclosed': ispermanentlyclosed,
    }),
  );

  if (response.statusCode == 201) {
    print('Created successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<ArticleTag> EditUserOpeningHour(UserOpeningHour uoh,String author,String weekday,String fromhour,String tohour,bool isalwaysopen,bool ispermanentlyclosed) async {
  final http.Response response = await http.patch(
    Uri.parse("$SERVER_IP/api/useropeninghours/${uoh.id}/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},
    body: jsonEncode(<String, dynamic>{
      'author': author,
      'weekday': weekday,
      'fromhour': fromhour,
      'tohour': tohour,
      'isalwaysopen': isalwaysopen,
      'ispermanentlyclosed': ispermanentlyclosed,
    }),
  );

  if (response.statusCode == 201) {
    print('Created successfully');
  }

  else {
    throw new Exception(response.body);
  }
}

Future<ArticleTag> DeleteUserOpeningHour(String id) async {
  final http.Response response = await http.delete(
    Uri.parse( "$SERVER_IP/api/useropeninghours/$id/"),

    headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},

  );

  if (response.statusCode == 204) {
    print('Post tag deleted successfully');
  }
  else {
    throw new Exception(response.body);
  }
}
