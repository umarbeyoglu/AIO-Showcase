import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Welpie/repository.dart';
import 'package:Welpie/language.dart';
import 'package:Welpie/screens/General/home_screen.dart';
import 'package:Welpie/models/User_Model/user_model.dart';

import '../../colors.dart';
import 'first_time_merchant_screen.dart';

class FirstTimeBusinessScreen extends StatefulWidget {
  final User user;
  const FirstTimeBusinessScreen({Key key, this.user,}) : super(key: key);
  @override
  FirstTimeBusinessScreenState createState() => FirstTimeBusinessScreenState(user:user);
}

class FirstTimeBusinessScreenState extends State<FirstTimeBusinessScreen> with SingleTickerProviderStateMixin{
  final User user;

  FirstTimeBusinessScreenState({Key key, this.user});
  String createpersonprofiletype = 'P';
  String createpersongendertype = 'NB';
  User uniuser;
  bool approved = false;
  bool errortrue = false;
  bool termsandconditions = false;
  bool allowcalendar = false;
  File image;
  int signupcheck = 0;
  int signupcheck2 = 0;
  bool obscurepassword = true;
  final _formKey = GlobalKey<FormState>();
  final navigatorKey2 = GlobalKey<NavigatorState>();
  final TextEditingController _email= TextEditingController();
  final TextEditingController _password= TextEditingController();
  final TextEditingController _username= TextEditingController();
  final TextEditingController _firstname= TextEditingController();
  final TextEditingController _lastname= TextEditingController();
  final TextEditingController _location= TextEditingController();
  final TextEditingController _phonenumber = TextEditingController();
  final TextEditingController _businesstype = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  final TextEditingController tags = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  List<String> tagsfinal = [''];
  int _column = 0;
  String type = '';
  String type1 = '';
  String multiplechoice = '';
  bool groceryshop = false;
  bool restaurant = false;

  Future<User> refreshProfile() async {
    WidgetsFlutterBinding.ensureInitialized();
    final http.Response response = await http.get(Uri.parse("$SERVER_IP/api/ownuser/"),
      headers: <String, String>{"Authorization" : "Token ${globaltoken}"},
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      User mainuser = User.fromJSON(responseJson[0]);

      return Navigator.of(context).push(MaterialPageRoute(builder: (context) => FirstTimeMerchantScreen(user: mainuser)));
    }
  }

  bool typechoice(String type){
    if(type == 'calendartype2'){return true;}
    if(type == 'calendartype3'){return true;}
    return false;
  }


  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: colordtmainone,
      key: _scaffoldKey,
      body: SingleChildScrollView(

        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: MediaQuery.of(context).size.width * 0.05,),

              ],),

            SizedBox(height: MediaQuery.of(context).size.height*0.04),
            Form(
              key: _formKey,
              child:   Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text(firsttimebusinessst,
                      style: TextStyle(
                        color:colordtmaintwo,
                        fontSize: MediaQuery.of(context).size.height*0.025,
                        fontWeight: FontWeight.bold,

                      ),),SizedBox(height:20),

                    CheckboxListTile(
                      title:  Text(groceryshopst,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                      value: groceryshop,
                      onChanged: (bool value) {
                        setState(() { groceryshop = value;
                        if(restaurant){restaurant = false;}
                        type1 = 'GroceryShopping';
                        });
                      },
                      secondary: const Icon(Icons.format_list_numbered),
                    ),
                    SizedBox(height:  MediaQuery.of(context).size.height*0.025),

                    CheckboxListTile(
                      title:  Text(restaurantst,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                      value: restaurant,
                      onChanged: (bool value) {
                        setState(() { restaurant = value;
                        if(groceryshop){groceryshop = false;}
                        type1 = 'Restaurant';
                        });
                      },
                      secondary: const Icon(Icons.format_list_numbered),
                    ),
                    SizedBox(height:  MediaQuery.of(context).size.height*0.025),

                    restaurant == true ?      SizedBox(
                      width:MediaQuery.of(context).size.width*0.4, height:MediaQuery.of(context).size.height*0.07,
                      child: ElevatedButton(
                        child: Text(allst, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                        onPressed: (){
                          setState(() {
                            type = 'A';
                          });
                        },
                      ),) : Container(height: 0,width: 0,),
                    restaurant == true ?   SizedBox(height:10): Container(height: 0,width: 0,),
                    restaurant == true ?     SizedBox(
                      width:MediaQuery.of(context).size.width*0.4, height:MediaQuery.of(context).size.height*0.07,
                      child: ElevatedButton(
                        child: Text(dineinst, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                        onPressed: (){
                          setState(() {
                            type = 'B';
                          });
                        },
                      ),): Container(height: 0,width: 0,),
                    restaurant == true ?   SizedBox(height:10): Container(height: 0,width: 0,),
                    restaurant == true ?     SizedBox(
                      width:MediaQuery.of(context).size.width*0.4, height:MediaQuery.of(context).size.height*0.07,
                      child: ElevatedButton(
                        child: Text(deliveryst, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                        onPressed: (){
                          setState(() {

                            type = 'C';
                          }); },
                      ),): Container(height: 0,width: 0,),
                    restaurant == true ?     SizedBox(
                      width:MediaQuery.of(context).size.width*0.4, height:MediaQuery.of(context).size.height*0.07,
                      child: ElevatedButton(
                        child: Text(pickupst, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),
                        onPressed: (){
                          setState(() {

                            type = 'D';
                          }); },
                      ),): Container(height: 0,width: 0,),
                    restaurant == true ?     SizedBox(height:30): Container(height: 0,width: 0,),
                    Padding(
                      padding: EdgeInsets.only(left: 25,right:2),
                      child: Text(firsttimebusinessexpst,
                        style: TextStyle(
                          color:colordtmaintwo,
                          fontSize: MediaQuery.of(context).size.height*0.025,
                          fontWeight: FontWeight.bold,

                        ),),
                    ),SizedBox(height:40),


                    SizedBox(height: MediaQuery.of(context).size.height*0.02),
                    Divider(color: colordtmaintwo),
                    ElevatedButton(
                      child: Text(donest, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                      onPressed: (){
                        if(type != ''){
                          if(type1 == 'Restaurant') EditUserBusinessType(user,'$type1|$type');
                          if(type1 == 'GroceryShopping') EditUserBusinessType(user,'$type1');}
                        Future.delayed(new Duration(seconds:1), () {refreshProfile();});
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: Text(skipst, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                          onPressed: (){

                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => FirstTimeMerchantScreen(user: user)));
                          },
                        ),SizedBox(width:  MediaQuery.of(context).size.width*0.025),
                        ElevatedButton(

                          child: Text(skipallst, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user: user)));
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.06),
                  ]
              ),
            ),


          ],
        ),

      ),

    );

  }

}

class EditBusinessScreen extends StatefulWidget {
  final User user;
  const EditBusinessScreen({Key key, this.user,}) : super(key: key);
  @override
  EditBusinessScreenState createState() => EditBusinessScreenState(user:user);
}

class EditBusinessScreenState extends State<FirstTimeBusinessScreen> with SingleTickerProviderStateMixin{
  final User user;

  EditBusinessScreenState({Key key, this.user});
  String createpersonprofiletype = 'P';
  String createpersongendertype = 'NB';
  User uniuser;
  bool approved = false;
  bool errortrue = false;
  bool termsandconditions = false;
  bool allowcalendar = false;
  File image;
  int signupcheck = 0;
  int signupcheck2 = 0;
  bool obscurepassword = true;
  final _formKey = GlobalKey<FormState>();
  final navigatorKey2 = GlobalKey<NavigatorState>();
  final TextEditingController tags = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  List<String> tagsfinal = [''];
  int _column = 0;
  String type = '';
  String type1 = '';
  String multiplechoice = '';
  bool groceryshop = false;
  bool restaurant = false;

  Future<User> refreshProfile() async {
    WidgetsFlutterBinding.ensureInitialized();
    final http.Response response = await http.get(Uri.parse("$SERVER_IP/api/ownuser/"),
      headers: <String, String>{"Authorization" : "Token ${globaltoken}"},
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      User mainuser = User.fromJSON(responseJson[0]);

      return Navigator.of(context).push(MaterialPageRoute(builder: (context) => FirstTimeMerchantScreen(user: mainuser)));
    }
  }

  bool typechoice(String type){
    if(type == 'calendartype2'){return true;}
    if(type == 'calendartype3'){return true;}
    return false;
  }


  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: colordtmainone,
      key: _scaffoldKey,
      body: SingleChildScrollView(

        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: MediaQuery.of(context).size.width * 0.05,),

              ],),

            SizedBox(height: MediaQuery.of(context).size.height*0.04),
            Form(
              key: _formKey,
              child:   Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[



                    CheckboxListTile(
                      title:  Text(groceryshopst,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                      value: groceryshop,
                      onChanged: (bool value) {
                        setState(() { groceryshop = value;
                        if(restaurant){restaurant = false;}
                        type1 = 'GroceryShopping';
                        });
                      },
                      secondary: const Icon(Icons.format_list_numbered),
                    ),
                    SizedBox(height:  MediaQuery.of(context).size.height*0.025),

                    CheckboxListTile(
                      title:  Text(restaurantst,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                      value: restaurant,
                      onChanged: (bool value) {
                        setState(() { restaurant = value;
                        if(groceryshop){groceryshop = false;}
                        type1 = 'Restaurant';
                        });
                      },
                      secondary: const Icon(Icons.format_list_numbered),
                    ),
                    SizedBox(height:  MediaQuery.of(context).size.height*0.025),

                    restaurant == true ?      SizedBox(
                      width:MediaQuery.of(context).size.width*0.4, height:MediaQuery.of(context).size.height*0.07,
                      child: ElevatedButton(
                        child: Text(allst, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                        onPressed: (){
                          setState(() {
                            type = 'A';
                          });
                        },
                      ),) : Container(height: 0,width: 0,),
                    restaurant == true ?   SizedBox(height:10): Container(height: 0,width: 0,),
                    restaurant == true ?     SizedBox(
                      width:MediaQuery.of(context).size.width*0.4, height:MediaQuery.of(context).size.height*0.07,
                      child: ElevatedButton(
                        child: Text(dineinst, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                        onPressed: (){
                          setState(() {
                            type = 'B';
                          });
                        },
                      ),): Container(height: 0,width: 0,),
                    restaurant == true ?   SizedBox(height:10): Container(height: 0,width: 0,),
                    restaurant == true ?     SizedBox(
                      width:MediaQuery.of(context).size.width*0.4, height:MediaQuery.of(context).size.height*0.07,
                      child: ElevatedButton(
                        child: Text(deliveryst, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                        onPressed: (){
                          setState(() {

                            type = 'C';
                          }); },
                      ),): Container(height: 0,width: 0,),
                    restaurant == true ?     SizedBox(
                      width:MediaQuery.of(context).size.width*0.4, height:MediaQuery.of(context).size.height*0.07,
                      child: ElevatedButton(
                        child: Text(pickupst, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                        onPressed: (){
                          setState(() {

                            type = 'D';
                          }); },
                      ),): Container(height: 0,width: 0,),
                    restaurant == true ?     SizedBox(height:30): Container(height: 0,width: 0,),



                    SizedBox(height: MediaQuery.of(context).size.height*0.02),
                    Divider(color: colordtmaintwo),
                    ElevatedButton(
                      child: Text(donest, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                      onPressed: (){
                        if(type != ''){
                          if(type1 == 'Restaurant') EditUserBusinessType(user,'$type1|$type');
                          if(type1 == 'GroceryShopping') EditUserBusinessType(user,'$type1');}
                        Future.delayed(new Duration(seconds:1), () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user: user)));
                        });
                      },
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*0.06),
                  ]
              ),
            ),


          ],
        ),

      ),

    );

  }

}
