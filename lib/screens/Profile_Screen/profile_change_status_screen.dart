import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/repository.dart';
import 'package:untitled/language.dart';
import 'package:untitled/models/User_Model/user_model.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../colors.dart';

import 'dart:convert';

import '../General/home_screen.dart';


class ProfileChangeStatusScreen extends StatefulWidget {
  final User user;
  final String category;
  const ProfileChangeStatusScreen({Key key,this.user,this.category}) : super(key : key);

  @override
  ProfileChangeStatusScreenState createState() => ProfileChangeStatusScreenState(user: user,category:category );
}

class ProfileChangeStatusScreenState extends State<ProfileChangeStatusScreen> {
  final User user;
  final String category;
  ProfileChangeStatusScreenState({Key key,this.user,this.category});


  bool checkifnull(String data){
    if(data == 'null'){return true;}
    if(data == null){return true;}
    if(data == ''){return true;}
    if(data == ' '){return true;}
    return false;
  }

  CleanSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
  Future<User> refreshProfile() async {
    WidgetsFlutterBinding.ensureInitialized();
    final http.Response response = await http.get(Uri.parse("$SERVER_IP/api/ownuser/"),
      headers: <String, String>{"Authorization" : "Token ${globaltoken}"},
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      User mainuser = User.fromJSON(responseJson[0]);
      Navigator.push(
        context ,
        MaterialPageRoute(
          builder: (_) => HomeScreen(
            user:mainuser,
          ),
        ),
      );

    }
  }
  Widget categorywidget(){
    if(category == 'BS'){
      return Column(
        children: [
          Divider(color: colordtmaintwo,),
          ListTile(
            onTap: (){EditUserBusinessStatusChoice(operatingasusualst);},
            title: Text(operatingasusualst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold),),
          ),
          Divider(color: colordtmaintwo,),
          ListTile(      onTap: (){EditUserBusinessStatusChoice(underservicechangesst);},
            title: Text(underservicechangesst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold),),
          ),Divider(color: colordtmaintwo,),
          ListTile(      onTap: (){EditUserBusinessStatusChoice(temporarilyclosedst);},
            title: Text(temporarilyclosedst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold),),
          ),Divider(color: colordtmaintwo,),
          ListTile(      onTap: (){EditUserBusinessStatusChoice(permanentlyclosedst);},
          title: Text(permanentlyclosedst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold),),
         ),Divider(color: colordtmaintwo,),
        ],
      );
    }
    if(category == 'PR'){
      return Column(
        children: [
          Divider(color: colordtmaintwo,), ListTile(      onTap: (){EditUserPriceRangeChoice(premiumst);},
            title: Text(premiumst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold),),
          ),
          Divider(color: colordtmaintwo,), ListTile(      onTap: (){EditUserPriceRangeChoice(highst);},
            title: Text(highst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold),),
          ),
          Divider(color: colordtmaintwo,),  ListTile(      onTap: (){EditUserPriceRangeChoice(standardst);},
            title: Text(standardst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold),),
          ),
          Divider(color: colordtmaintwo,), ListTile(      onTap: (){EditUserPriceRangeChoice(lowst);},
            title: Text(lowst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold),),
          ),Divider(color: colordtmaintwo,),
        ],
      );
    }
    if(category == 'CR'){
      return Column(
        children: [
          Divider(color: colordtmaintwo,),  ListTile(      onTap: (){EditUserIntensityChoice(verybusyst);},
            title: Text(verybusyst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold),),
          ),
          Divider(color: colordtmaintwo,),  ListTile(      onTap: (){EditUserIntensityChoice(busyst);},
            title: Text(busyst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold),),
          ),
          Divider(color: colordtmaintwo,), ListTile(      onTap: (){EditUserIntensityChoice(normalst);},
            title: Text(normalst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold),),
          ),Divider(color: colordtmaintwo,),ListTile(      onTap: (){EditUserIntensityChoice(lowst);},
            title: Text(lowst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold),),
          ),Divider(color: colordtmaintwo,),


        ],
      );
    }
  }

  EditUserIntensityChoice(String categorieschoices) {

    if (categorieschoices == verybusyst) {
      setState(() {EditUserIntensity(user, 'verybusy',context);
      Future.delayed(Duration(seconds: 1),()=>    refreshProfile());

      });
    }
    if (categorieschoices == busyst) {
      setState(() {EditUserIntensity(user, 'busy',context);  Future.delayed(Duration(seconds: 1),()=>    refreshProfile());});
    }
    if (categorieschoices == normalst) {
      setState(() {EditUserIntensity(user, 'normal',context);  Future.delayed(Duration(seconds: 1),()=>    refreshProfile());});
    }
    if (categorieschoices == lowst) {
      setState(() {EditUserIntensity(user, 'low',context);  Future.delayed(Duration(seconds: 1),()=>    refreshProfile());});
    }
    if (categorieschoices == idlest) {
      setState(() {EditUserIntensity(user, 'idle',context); Future.delayed(Duration(seconds: 1),()=>    refreshProfile());});
    }
  }

  EditUserPriceRangeChoice(String categorieschoices) {

    if (categorieschoices == premiumst) {
      setState(() {EditUserPriceRange(user, 'premium',context);
      refreshProfile();
      });
    }
    if (categorieschoices == highst) {
      setState(() {EditUserPriceRange(user, 'high',context); Future.delayed(Duration(seconds: 1),()=>    refreshProfile());});
    }
    if (categorieschoices == standardst) {
      setState(() {EditUserPriceRange(user, 'standard',context);  Future.delayed(Duration(seconds: 1),()=>    refreshProfile());});
    }
    if (categorieschoices == lowst) {
      setState(() {EditUserPriceRange(user, 'low',context);  Future.delayed(Duration(seconds: 1),()=>    refreshProfile());});
    }
    if (categorieschoices == unspecifiedst) {
      setState(() {EditUserPriceRange(user, '',context);  Future.delayed(Duration(seconds: 1),()=>    refreshProfile());});
    }
  }

  EditUserBusinessStatusChoice(String categorieschoices) {
    print(categorieschoices);
    if (categorieschoices == operatingasusualst) {
      setState(() {EditUserBusinessStatus(user, 'oas',context);
      Future.delayed(Duration(seconds: 1),()=>    refreshProfile());
      });
    }
    if (categorieschoices == underservicechangesst) {
      setState(() {EditUserBusinessStatus(user, 'sc',context);  Future.delayed(Duration(seconds: 1),()=>    refreshProfile());});
    }
    if (categorieschoices == temporarilyclosedst) {
      setState(() {EditUserBusinessStatus(user, 'tc',context);  Future.delayed(Duration(seconds: 1),()=>    refreshProfile());});
    }
    if (categorieschoices == permanentlyclosedst) {
      setState(() {EditUserBusinessStatus(user, 'fc',context);  Future.delayed(Duration(seconds: 1),()=>    refreshProfile());});
    }
    if (categorieschoices == unspecifiedst) {
      setState(() {EditUserBusinessStatus(user, '',context);  Future.delayed(Duration(seconds: 1),()=>    refreshProfile());});
    }
  }

  @override


  Widget build(BuildContext context) {



    return Scaffold(




      backgroundColor: colordtmainone,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[


            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colordtmainone,
                borderRadius: BorderRadius.only(
                ),
              ),
              child: categorywidget(),
            )
          ],
        ),
      ),
    );
  }
}


