
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:Welpie/main.dart';
import 'dart:convert';
import 'package:Welpie/repository.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:Welpie/language.dart';
import 'package:Welpie/screens/General/home_screen.dart';
import 'package:Welpie/models/User_Model/user_model.dart';

import '../../colors.dart';
import '../First_Time_Screen/edit_hotel_screen.dart';

class Tagstatekeys {
  static final _tagStateKey1 = const Key('__TSK1__');
  static final _tagStateKey2 = const Key('__TSK2__');
}

class EditUserScreen extends StatefulWidget {
  final User user;
  final User masteruser;
  const EditUserScreen({Key key, this.user,this.masteruser}) : super(key: key);

  @override
  EditUserScreenState createState() => EditUserScreenState(user: user,masteruser:masteruser);
}

class EditUserScreenState extends State<EditUserScreen> with SingleTickerProviderStateMixin {
  final User user;
  final User masteruser;
  EditUserScreenState({Key key, this.user,this.masteruser});



  File image1a;

  bool val1 = false;
  bool val2 = false;
  bool val3 = false;
  bool val4 = false;
  bool val5 = false;
  bool val6 = false;
  bool val7 = false;
  bool val8 = false;
  bool firsttime1 = true;
  bool firsttime2 = true;
  bool firsttime3 = true;
  bool firsttime4 = true;
  bool firsttime5 = true;
  bool firsttime6 = true;
  bool firsttime7 = true;
  bool firsttime8 = true;
  bool done = false;
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _businesstype = TextEditingController();
  final TextEditingController _phonenumber = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _tags = TextEditingController();
  final TextEditingController _locations = TextEditingController();
  final TextEditingController _phones = TextEditingController();
  List<String> locationsfinal = [''];
  List<String> phonesfinal = [''];
  List<String> tagsfinal = [''];
  int _column1 = 0;
  int _column2 = 0;
  int _column3 = 0;
  int _column4 = 0;
  int _column5 = 0;
  int _column6 = 0;
  final formKey = GlobalKey<FormState>();
  int postcheck = 0;
  final picker = ImagePicker();
  String _locationcountry = "";
  String _locationcity = "";
  String _locationstate = "";

  void init(){
    if(done){return;}
     _firstname.text = user.full_name;
     _businesstype.text = user.business_type;
     _phonenumber.text = user.phone_number;
     _bio.text = user.details;
     _location.text = '${user.location()}';
done = true;
return;

  }

  bool isnullfunc(String value){
    if(value == null){    return true;}
    if(value == 'null'){    return true;}
    if(value == ''){    return true;}
    if(value == '-'){    return true;}
    return false;

  }
  
  bool isprivatefunc(){
    if(val6 == false){return true;}
    if(user.public_profile == false){return true;}
    return false;

  }

  bool isnstl(bool originalvalue,bool check){
    bool returnvalue;
    returnvalue = firsttime1 == true? (originalvalue == true? true : false) : (check == false ? false : true) ;
    firsttime1 = false;
    return returnvalue;
  }

  bool isnsfw(bool originalvalue,bool check){
    bool returnvalue;
    returnvalue = firsttime2 == true? (originalvalue == true? true : false) : (check == false ? false : true) ;
    firsttime2 = false;
    return returnvalue;
  }

  bool issensitive(bool originalvalue,bool check){
    bool returnvalue;
    returnvalue = firsttime3 == true? (originalvalue == true? true : false) : (check == false ? false : true) ;
    firsttime3 = false;
    return returnvalue;
  }

  bool isspoiler(bool originalvalue,bool check){
    bool returnvalue;
    returnvalue = firsttime4 == true? (originalvalue == true? true : false) : (check == false ? false : true) ;
    firsttime4 = false;
    return returnvalue;
  }
  bool isdetailsprivate(bool originalvalue,bool check){
    bool returnvalue;
    returnvalue = firsttime5 == true? (originalvalue == true? true : false) : (check == false ? false : true) ;
    firsttime5 = false;
    return returnvalue;
  }
  bool isuserprivate(bool originalvalue,bool check){
    bool returnvalue;
    returnvalue = firsttime6 == true? (originalvalue == true? true : false) : (check == false ? false : true) ;
    firsttime6 = false;
    return returnvalue;
  }

  bool isprofileanon(bool originalvalue,bool check){
    bool returnvalue;
    returnvalue = firsttime7 == true? (originalvalue == true? true : false) : (check == false ? false : true) ;
    firsttime7 = false;
    return returnvalue;
  }

  bool allowsubusers(bool originalvalue,bool check){
    bool returnvalue;
    returnvalue = firsttime8 == true? (originalvalue == true? true : false) : (check == false ? false : true) ;
    firsttime8 = false;
    return returnvalue;
  }

  pickFromCamera() async {
    final _image = await picker.getImage(source: ImageSource.camera,  imageQuality: 80);

    setState(() {
      image1a = File(_image.path);
    });
  }

  pickFromPhone() async {
    final _image = await picker.getImage(source: ImageSource.gallery,  imageQuality: 80);

    setState(() {
      image1a = File(_image.path);
    });
  }

  String tagsinit() {
    locationsfinal = _locations.text.split(',');
    phonesfinal = _phones.text.split(',');
    tagsfinal = _tags.text.split(',');
  }


  @override
  Widget build(BuildContext context) {
   init();
   print(user.profile_type);
    if (user.profile_type == 'P') {
      return Scaffold(
        appBar: new AppBar(
          backgroundColor: colordtmainone,
          leading:  IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 30.0,
            color: colordtmaintwo,
            onPressed: () {
              Navigator.pop(context,true);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.location_on),
              iconSize: 30.0,
              color: colordtmaintwo,
              onPressed: () {
                ChooseLocation(context);
              },
            ),
          ],

          title: Text(edituserst,
            style: TextStyle(
              color:colordtmaintwo,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,

            ),),
        ),
        backgroundColor: colordtmainone,

        body:SingleChildScrollView(
          child: Form(
            key: formKey,
            child:  Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height*0.03),

                SizedBox(height: MediaQuery.of(context).size.height*0.035),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Material(
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.height*0.045,
                        backgroundImage: image1a == null ? (user.image == null ? NetworkImage('https://st2.depositphotos.com/4111759/12123/v/600/depositphotos_121233262-stock-illustration-male-default-placeholder-avatar-profile.jpg') :
                        NetworkImage(user.image)) : FileImage(image1a) ,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.035),
                    IconButton(
                      icon: Icon(Icons.add_a_photo,color:colordtmaintwo),
                      onPressed: () {
                        pickFromCamera();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add_photo_alternate,color:colordtmaintwo),
                      onPressed: () {
                        pickFromPhone();
                      },
                    )

                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.035),
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01 ,right: MediaQuery.of(context).size.width*0.01),
                  child:
                  Container(
                    margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.023 , vertical: MediaQuery.of(context).size.height*0.013),
                    decoration: BoxDecoration(
                      color: colordtmainone,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child:  Padding(
                      padding: EdgeInsets.only(left : 8),
                      child: TextFormField(
  style: TextStyle(color: colordtmaintwo),
                        controller: _firstname,
                        maxLength: 30,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,

                          hintText:  firstnamest ,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
                        ),
                      ),
                    ),
                  ),

                ),

                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01 ,right: MediaQuery.of(context).size.width*0.01),
                  child:
                  Container(
                    margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.023 , vertical: MediaQuery.of(context).size.height*0.013),
                    decoration: BoxDecoration(
                      color: colordtmainone,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child:  Padding(
                      padding: EdgeInsets.only(left : 8),
                      child: TextFormField(
  style: TextStyle(color: colordtmaintwo),
                        controller: _phonenumber,
                        keyboardType: TextInputType.phone,
                        maxLength: 30,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(

                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,

                          hintText:  phonenost,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
                        ),
                      ),
                    ),
                  ),

                ),
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01 ,right: MediaQuery.of(context).size.width*0.01),
                  child:
                  Container(
                    margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.023 , vertical: MediaQuery.of(context).size.height*0.013),
                    decoration: BoxDecoration(
                      color: colordtmainone,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child:  Padding(
                      padding: EdgeInsets.only(left : 8),
                      child: TextFormField(
  style: TextStyle(color: colordtmaintwo),
                        controller: _bio,
                        minLines: 1,
                        maxLines: 5,
                        maxLength: 64000,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(

                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,

                          hintText:  eyaboutst ,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                    vertical: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child:
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical:4),
                    decoration: BoxDecoration(
                      color: colordtmainone,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child:  Padding(
                      padding: EdgeInsets.only(left : 8),
                      child: TextFormField(
  style: TextStyle(color: colordtmaintwo),
                        onChanged:  (tags){
                          setState(() {
                            tagsinit();
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,

                          labelText: usertagsst,labelStyle:TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo) ,
                          hintText: eypersontagsst, hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        controller: _tags,
                      ),
                    ),
                  ),

                ),

                SizedBox(height:MediaQuery.of(context).size.height*0.025),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                    vertical: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child:
                  Tags(
                    key: Tagstatekeys._tagStateKey1,
                    columns: _column1,
                    itemCount: tagsfinal.length,
                    itemBuilder: (i) {
                      return ItemTags(
                        key: Key(i.toString()),
                        index: i,
                        title: tagsfinal[i].toString(),
                        color: Color(0xFFEEEEEE),
                        activeColor: Color(0xFFEEEEEE),
                        textActiveColor: colordtmaintwo,
                        textStyle: TextStyle(
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height * 0.018, color: colordtmaintwo,),
                      );
                    },
                  ),

                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                    vertical: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child:
                  Tags(
                    key: Tagstatekeys._tagStateKey2,
                    columns: _column2,
                    itemCount: user.tags.length,
                    itemBuilder: (i) {
                      return ItemTags(
                        removeButton: ItemTagsRemoveButton(
                          onRemoved: (){
                            setState(() {
                              DeleteUserTags(user.tags[i].id);
                              user.tags.removeAt(i);
                            });
                            return true;
                          },
                        ), // OR null

                        key: Key(i.toString()),
                        index: i,
                        title: user.tags[i].tag.toString(),
                        color: Color(0xFFEEEEEE),
                        activeColor: Color(0xFFEEEEEE),
                        textActiveColor: colordtmaintwo,
                        textStyle: TextStyle(
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height * 0.018, color: colordtmaintwo,),
                      );
                    },
                  ),

                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.025),


                CheckboxListTile(
                  title:  Text(allowsensitivest,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                  value: firsttime3 == true ? user.issensitiveallowed : val3,
                  onChanged: (bool value) {
                    setState(() {
                      val3 = value;
                      print(val3);
                      firsttime3 = false;
                    });
                  },
                  secondary: const Icon(Icons.add_comment),
                ),
                CheckboxListTile(
                  title:  Text(allowspoilerst,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                  value: firsttime4 == true ? user.issensitiveallowed : val4,
                  onChanged: (bool value) {
                    setState(() {
                      val4 = value;
                      print(val4);
                      firsttime4 = false;
                    });
                  },
                  secondary: const Icon(Icons.add_comment),
                ),

                CheckboxListTile(
                  title:  Text(publicprofilest,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                  value: firsttime6 == true ? user.public_profile : val6,
                  onChanged: (bool value) {
                    setState(() {
                      val6= value;
                      print(val6);
                      firsttime6 = false;
                    });
                  },

                  secondary:  Icon(Icons.visibility),),
                CheckboxListTile(
                  title:  Text(isdetailsprivatest,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                  value: firsttime5 == true ? user.isdetailsprivate : val5,
                  onChanged: (bool value) {
                    setState(() {
                      val5= value;
                      print(val5);
                      firsttime5 = false;
                    });
                  },
                  secondary:  Icon(Icons.visibility),) ,
                SizedBox(height:MediaQuery.of(context).size.height*0.025),
                FittedBox(
                   child: ElevatedButton(
                    child: Text(changest),

                    onPressed: () {
                      setState(() {
                        Future<User> refreshProfile() async {
                          User _user1;
                          WidgetsFlutterBinding.ensureInitialized();
                          final http.Response response = await http.get(Uri.parse("$SERVER_IP/api/ownuser/"),
                            headers: <String, String>{"Authorization" : "Token ${globaltoken}"},
                          );
                          if (response.statusCode == 200) {
                            var responseJson = json.decode(response.body);
                            print(responseJson);
                            _user1 = User.fromJSON(responseJson[0]);
                            print(_user1.full_name);
                            //iseditsubuser = false;
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user: _user1)));

                            //  if(iseditsubuser == false){}
                       //     if(iseditsubuser == true){//    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubUsersListScreen(user: masteruser)));iseditsubuser = false;}
                          }
                        }

                        image1a == null ?
                        EditUser(user.id, _firstname.text, _locationcountry,_locationstate,_locationcity,_phonenumber.text, _bio.text,user,null,tagsfinal, [],[],'',user.calendar_type,user.calendar_ismultichoice,'null',val1,val2,val3,val4,val5,val6,val8,user.hotelclass,user.ishotel) :
                          FileSizeLimitImage(image1a.path)..then((value){
                          if(value){print('File too big to upload!');
                          return;}
                          if(value == false){
                            EditUser(user.id, _firstname.text,  _locationcountry,_locationstate,_locationcity, _phonenumber.text, _bio.text,user,image1a,tagsfinal, [],[],'',user.calendar_type,user.calendar_ismultichoice,'null',val1,val2,val3,val4,val5,val6,val8,user.hotelclass,user.ishotel);
                          }
                        });
                        Future.delayed(new Duration(seconds:3), ()
                        {
                          refreshProfile();
                        });
                      });

                    },
                  ),
                ),


                SizedBox(height:MediaQuery.of(context).size.height*0.1),
              ],
            ),
          ),
        ),
      );
    }
    else if (user.profile_type == 'B') {
      return Scaffold(

        backgroundColor: colordtmainone,

        body:SingleChildScrollView(
          child: Form(
            key: formKey,
            child:  Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height*0.07),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Material(
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.height*0.045,
                        backgroundImage: image1a == null ? (user.image == null ? NetworkImage('https://st2.depositphotos.com/4111759/12123/v/600/depositphotos_121233262-stock-illustration-male-default-placeholder-avatar-profile.jpg') :
                        NetworkImage(user.image)) : FileImage(image1a) ,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.035),
                    IconButton(
                      icon: Icon(Icons.add_a_photo,color:colordtmaintwo),
                      onPressed: () {
                        pickFromCamera();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add_photo_alternate,color:colordtmaintwo),
                      onPressed: () {
                        pickFromPhone();
                      },
                    )

                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.height*0.035),

         //       Padding(
          //           padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01 ,right: MediaQuery.of(context).size.width*0.01),
          //           child:
          //           Container(
          //             margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.023 , vertical: MediaQuery.of(context).size.height*0.013),
          //             decoration: BoxDecoration(
          //              color: colordtmainone,
          //              borderRadius: BorderRadius.circular(8),
                //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.grey.withOpacity(0.3),
          //                  spreadRadius: 1,
          //                  blurRadius: 7,
          //                  offset: Offset(0, 3),
                //               ),
          //             ],
          //            ),
          //            child:  Padding(
          //               padding: EdgeInsets.only(left : 8),
          //                child: TextFormField(
          // style: TextStyle(color: colordtmaintwo),
          //             controller: _businesstype,
          //             maxLength: 30,
          //               maxLengthEnforcement: MaxLengthEnforcement.enforced,
          //              decoration: InputDecoration(

          //               border: InputBorder.none,
          //                 focusedBorder: InputBorder.none,
          //               enabledBorder: InputBorder.none,
          //                errorBorder: InputBorder.none,
          //                disabledBorder: InputBorder.none,

          //                 hintText:  businesstypest,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
                //                   ),),),),),

                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01 ,right: MediaQuery.of(context).size.width*0.01),
                  child:
                  Container(
                    margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.023 , vertical: MediaQuery.of(context).size.height*0.013),
                    decoration: BoxDecoration(
                      color: colordtmainone,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child:  Padding(
                      padding: EdgeInsets.only(left : 8),
                      child: TextFormField(
  style: TextStyle(color: colordtmaintwo),
                        controller: _phonenumber,
                        keyboardType: TextInputType.number,
                        maxLength: 30,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(

                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,

                          hintText: phonenost,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
                        ),
                      ),
                    ),
                  ),

                ),
                Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01 ,right: MediaQuery.of(context).size.width*0.01),
                  child:
                  Container(
                    margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.023 , vertical: MediaQuery.of(context).size.height*0.013),
                    decoration: BoxDecoration(
                      color: colordtmainone,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child:  Padding(
                      padding: EdgeInsets.only(left : 8),
                      child: TextFormField(
  style: TextStyle(color: colordtmaintwo),
                        controller: _bio,
                        minLines: 1,
                        maxLines: 5,
                        maxLength: 64000,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(

                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,

                          hintText:  eyaboutst ,hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
                        ),
                      ),
                    ),
                  ),

                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                    vertical: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child:
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical:4),
                    decoration: BoxDecoration(
                      color: colordtmainone,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child:  Padding(
                      padding: EdgeInsets.only(left : 8),
                      child: TextFormField(
  style: TextStyle(color: colordtmaintwo),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,

                          labelText: usertagsst,labelStyle:TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo) ,
                          hintText: eypersontagsst, hintStyle: TextStyle(fontWeight:  FontWeight.w400,color: colordtmaintwo),
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        controller: _tags,
                        onChanged:  (_tags){
                          setState(() {
                            tagsinit();
                          });
                        },
                      ),
                    ),
                  ),

                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.025),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                    vertical: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child:
                  Tags(
                    key: Tagstatekeys._tagStateKey1,
                    columns: _column1,
                    itemCount: tagsfinal.length,
                    itemBuilder: (i) {
                      return tagsfinal[i] == '' ? Container(height: 0,width: 0,) : ItemTags(
                        key: Key(i.toString()),
                        index: i,
                        title: tagsfinal[i].toString(),
                        color: Color(0xFFEEEEEE),
                        activeColor: Color(0xFFEEEEEE),
                        textActiveColor: colordtmaintwo,
                        textStyle: TextStyle(
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height * 0.018, color: colordtmaintwo,),
                      );
                    },
                  ),

                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                    vertical: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child:
                  Tags(
                    key: Tagstatekeys._tagStateKey2,
                    columns: _column2,
                    itemCount: user.tags.length,
                    itemBuilder: (i) {
                      return ItemTags(
                        removeButton: ItemTagsRemoveButton(
                          onRemoved: (){
                            setState(() {
                              DeleteUserTags(user.tags[i].id);
                              user.tags.removeAt(i);
                            });
                            return true;
                          },
                        ), // OR null

                        key: Key(i.toString()),
                        index: i,
                        title: user.tags[i].tag.toString(),
                        color: Color(0xFFEEEEEE),
                        activeColor: Color(0xFFEEEEEE),
                        textActiveColor: colordtmaintwo,
                        textStyle: TextStyle(
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height * 0.018, color: colordtmaintwo,),
                      );
                    },
                  ),

                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.025),
                if(user.profile_type == 'B')ElevatedButton(
                  child: Text(editmerchantinfost, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditMerchantScreen(user:user)));
                  },
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.025),
                if(user.profile_type == 'B' )ElevatedButton(
                  child: Text(edithotelinfost, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditHotelScreen(user:user)));
                  },
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.025),

                CheckboxListTile(
                  title:  Text(allowsensitivest,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                  value: firsttime3 == true ? user.issensitiveallowed : val3,
                  onChanged: (bool value) {
                    setState(() {
                      val3 = value;
                      print(val3);
                      firsttime3 = false;
                    });
                  },
                  secondary:  Icon(Icons.visibility),
                ),
                CheckboxListTile(
                  title:  Text(allowspoilerst,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                  value: firsttime4 == true ? user.issensitiveallowed : val4,
                  onChanged: (bool value) {
                    setState(() {
                      val4 = value;
                      print(val4);
                      firsttime4 = false;
                    });
                  },
                  secondary:  Icon(Icons.visibility),

                ),
                CheckboxListTile(
                  title:  Text(publicprofilest,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                  value: firsttime6 == true ? user.public_profile : val6,
                  onChanged: (bool value) {
                    setState(() {
                      val6= value;
                      print(val6);
                      firsttime6 = false;
                    });
                  },

                  secondary:  Icon(Icons.visibility),),
              CheckboxListTile(
                  title:  Text(isdetailsprivatest,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                  value: firsttime5 == true ? user.isdetailsprivate : val5,
                  onChanged: (bool value) {
                    setState(() {
                      val5= value;
                      print(val5);
                      firsttime5 = false;
                    });
                  },
                  secondary:  Icon(Icons.visibility),) ,
                user.hasparent()? CheckboxListTile(
                  title:  Text(isprofileanonst,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)),
                  value: firsttime7 == true ? user.isprofileanon : val7,
                  onChanged: (bool value) {
                    setState(() {
                      val7= value;
                      print(val7);
                      firsttime7 = false;
                    });
                  },
                  secondary:  Icon(Icons.visibility),) :Container(height: 0,width: 0,),
             //   CheckboxListTile(title:  Text(allowsubusersst,style: TextStyle(color:colordtmaintwo,fontWeight:  FontWeight.w400)), value: firsttime8 == true ? user.isprofileanon : val8, onChanged: (bool value) {setState(() {val8= value;print(val8);firsttime8 = false;});}, secondary:  Icon(Icons.visibility),),
                SizedBox(height:MediaQuery.of(context).size.height*0.025),

                FittedBox(
                  child: ElevatedButton(
                    child: Text(changest),

                    onPressed: () {
                      setState(() {
                        Future<User> refreshProfile() async {
                          User _user1;
                          WidgetsFlutterBinding.ensureInitialized();
                          final http.Response response = await http.get(Uri.parse("$SERVER_IP/api/ownuser/"),
                            headers: <String, String>{"Authorization" : "Token ${globaltoken}"},
                          );
                          if (response.statusCode == 200) {
                            var responseJson = json.decode(response.body);
                            print(responseJson);
                            _user1 = User.fromJSON(responseJson[0]);
                            print(_user1.full_name);
                            //       iseditsubuser = false;
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(user: _user1)));
                        //    if(iseditsubuser == false){}
                      //      if(iseditsubuser == true){//   Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubUsersListScreen(user: masteruser)));//  iseditsubuser = false;}
                          }
                        }

                        image1a == null ? EditUser(user.id, _firstname.text, _locationcountry,_locationstate,_locationcity, _phonenumber.text, _bio.text,user,null,tagsfinal,locationsfinal,phonesfinal,'',user.calendar_type,user.calendar_ismultichoice,_businesstype.text,val1,val2,val3,val4,val5,val6,val8,user.hotelclass,user.ishotel) :
                        FileSizeLimitImage(image1a.path)..then((value){
                          if(value){print('File too big to upload!');
                          return;}
                          if(value == false){
                            EditUser(user.id, _firstname.text,  _locationcountry,_locationstate,_locationcity, _phonenumber.text, _bio.text,user,image1a,tagsfinal,locationsfinal,phonesfinal,'',user.calendar_type,user.calendar_ismultichoice,_businesstype.text,val1,val2,val3,val4,val5,val6,val8,user.hotelclass,user.ishotel);
                          }
                        });
                        Future.delayed(new Duration(seconds:3), ()
                        {
                          refreshProfile();
                        });
                      });


                    },
                  ),
                ),


                SizedBox(height:MediaQuery.of(context).size.height*0.025),
              ],
            ),
          ),
        ),
      );
    }


  }
  _showError(String error) {
 print(error);
 return;
  }
}

class EditMerchantScreen extends StatefulWidget {
  final User user;
  const EditMerchantScreen({Key key, this.user,}) : super(key: key);
  @override
  EditMerchantScreenState createState() => EditMerchantScreenState(user:user);
}

class EditMerchantScreenState extends State<EditMerchantScreen> with SingleTickerProviderStateMixin{
  final User user;

  EditMerchantScreenState({Key key, this.user});
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
  final TextEditingController gatewayname = TextEditingController();
  final TextEditingController gatewaymerchantid = TextEditingController();
  final TextEditingController merchantid = TextEditingController();
  final TextEditingController merchantname = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  List<String> tagsfinal = [''];
  int _column = 0;
  String type = 'yes';












  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: colordtmainone,
      key: _scaffoldKey,
      body: SingleChildScrollView(

        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[



            SizedBox(height: MediaQuery.of(context).size.height*0.04),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[


                  Text(firsttimecreditcardinfost,
                    style: TextStyle(
                      color:colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height*0.025,
                      fontWeight: FontWeight.bold,

                    ),),SizedBox(height:40),

                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery
                        .of(context)
                        .size
                        .width * 0.01, right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.01),
                    child:
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery
                          .of(context)
                          .size
                          .width * 0.023,),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: merchantid,

                          maxLength: 50,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            hintText: ibannost,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,

                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400, color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),

                  ),
                  SizedBox(height:  MediaQuery.of(context).size.height*0.025),
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery
                        .of(context)
                        .size
                        .width * 0.01, right: MediaQuery
                        .of(context)
                        .size
                        .width * 0.01),
                    child:
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery
                          .of(context)
                          .size
                          .width * 0.023,),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: merchantname,

                          maxLength: 50,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            hintText: namesurnamest,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,

                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400, color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),

                  ),
                  SizedBox(height:  MediaQuery.of(context).size.height*0.025),


                  SizedBox(height: MediaQuery.of(context).size.height*0.02),

                  ElevatedButton(
                    child: Text(donest, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                    onPressed: (){
                      EditUserMerchantInfo(user, '', gatewayname.text, gatewaymerchantid.text, merchantid.text, merchantname.text);
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.06),
                ],
              ),
            ),


          ],
        ),

      ),

    );

  }

}

