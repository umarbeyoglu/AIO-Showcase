import 'package:untitled/language.dart';
import 'package:untitled/models/User_Model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../colors.dart';
import '../General/create_article_screen.dart';
import '../Calendar_Screen/calendar_status_screen.dart';

class CreateArticleChooseScreen extends StatefulWidget {
  final User user;
  const CreateArticleChooseScreen({Key key, this.user}) : super(key: key);
  @override
  CreateArticleChooseScreenState createState() => CreateArticleChooseScreenState(user:user);
}

class CreateArticleChooseScreenState extends State<CreateArticleChooseScreen> {
  final User user;
  CreateArticleChooseScreenState({Key key, this.user}) ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: colordtmainone,



      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Container(

              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
 SizedBox(height:50),

                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(whatdoyouwanttocreatest, style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    SizedBox(height:50),
                    InkWell(
                      child:ListTile(
                        leading: Icon(Icons.article,color: colordtmaintwo),
                        title: Text(articlest,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold)),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => CreateArticleScreen(user: user, type:'A' ),),);
                      },
                    ), Divider(color: colordtmaintwo,),
                    InkWell(
                      child:ListTile(
                        leading: Icon(Icons.category,color: colordtmaintwo),
                        title: Text(bycataloguest,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold)),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => UserProductCategoryCreateScreen(user: user, ),),);
                      },
                    ), Divider(color: colordtmaintwo,),
                    InkWell(
                      child:ListTile(
                        leading: Icon(Icons.shopping_cart,color: colordtmaintwo),
                        title: Text(productst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold)),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => CreateArticleScreen(user: user, type:'UP' ),),);
                      },
                    ), Divider(color: colordtmaintwo,),

                    InkWell(
                      child:ListTile(
                        leading: Icon(Icons.calendar_month,color: colordtmaintwo),
                        title: Text(appointmentsst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold)),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => CreateArticleScreen(user: user, type:'CI' ),),);
                      },
                    ), Divider(color: colordtmaintwo,),
                    InkWell(
                      child:ListTile(
                        leading: Icon(Icons.calendar_month_outlined,color: colordtmaintwo),
                        title: Text(appointmentsettingsst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold)),
                      ),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => StatusScreen(
                              user: user,
                            ),
                          ),
                        );
                        },
                    ), Divider(color: colordtmaintwo,),
                    InkWell(
                      child:ListTile(
                        leading: Icon(Icons.calendar_today_rounded,color: colordtmaintwo),
                        title: Text(eventsst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold)),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => CreateArticleScreen(user: user, type:'CE' ),),);
                      },
                    ), Divider(color: colordtmaintwo,),
                    InkWell(
                      child:ListTile(
                        leading: Icon(Icons.edit_calendar,color: colordtmaintwo),
                        title: Text(reservationst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold)),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => CreateArticleScreen(user: user, type:'R' ),),);
                      },
                    ), Divider(color: colordtmaintwo,),
                    InkWell(
                      child:ListTile(
                          leading: Icon(Icons.newspaper_outlined,color: colordtmaintwo),
                        title: Text(formsst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold)),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => CreateArticleScreen(user: user, type:'US' ),),);
                      },
                    ), Divider(color: colordtmaintwo,),
                    InkWell(
                      child:ListTile(
                        leading: Icon(Icons.local_offer,color: colordtmaintwo),
                        title: Text(offersst,style: TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold)),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => CreateArticleScreen(user: user, type:'OFFER' ),),);
                      },
                    ), Divider(color: colordtmaintwo,),




  ]),
          )
        ],),);
  }
}
