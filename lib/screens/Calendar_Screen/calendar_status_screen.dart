import 'package:untitled/models/User_Model/user_calendar_status_model.dart';
import 'package:untitled/repository.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:untitled/models/User_Model/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../colors.dart';
import '../../language.dart';
import 'calendar_date_screen.dart';



class StatusScreen extends StatefulWidget {
  final User user;
  const StatusScreen({Key key, this.user}) : super(key: key);
  @override
  StatusScreenState createState() => StatusScreenState(user:user);
}

class StatusScreenState extends State<StatusScreen> {
  final User user;
  StatusScreenState({Key key, this.user});
  int _column = 0;
  List<String> items = [];
  String itemchosen1 = '';
  final TextEditingController item= TextEditingController();
  ScrollController _scrollController = ScrollController();
  int page = 1;
  List<CalendarStatus> posts = [];
  Future fetchPostsfuture;
  bool isLoading = false;

  @override
  void initState() {
    fetchPostsfuture = FetchOwnCalendarStatus(http.Client(),user.id,page);
  }

  String correctdatemny(String date){
   String year = date.toString().substring(0,4);
    String month = date.toString().substring(5,7);
   return '$month-$year';
  }

  String correctdatedays(String date){
    String days = date.toString().substring(8,date.length);
    return days;
  }

  Future _loadData() async {
    List<CalendarStatus> postsinit = [];
    postsinit = await FetchOwnCalendarStatus(http.Client(),user.id,page+1);
    setState(() {
      page = page +1;
      for(final item2 in postsinit)
      isLoading = false;
      return;
    });
  }

  void ischosen(String itemchosen){
    for(int i=0;i<items.length;i++){
      if(items[i] == itemchosen){
        items.removeAt(i);
        return;
      }
    }
    items.add(itemchosen);
    return;
  }

  @override
  Widget build(BuildContext context) {
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
      icon: Icon(Icons.add),
      iconSize: 30.0,
      color: colordtmaintwo,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DateScreen(
              user: user,
              calendarowner:user,
            ),
          ),
        );
      },
    ),

        ],
      ),
      backgroundColor: colordtmainone,



      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading && scrollInfo.metrics.pixels ==
              scrollInfo.metrics.maxScrollExtent) {
            _loadData();
            setState(() {isLoading = true;});
            return true;
          }},
        child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height:10),
                Text(calendarstatusexpst,style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height*0.019,
                  fontWeight: FontWeight.w600, color: colordtmaintwo,),),
                Divider(color: colordtmaintwo,),
                Text(calendarstatuswarningst,style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height*0.019,
                  fontWeight: FontWeight.w600, color: colordtmaintwo,),),
                Column(children: [
                  Divider(color: colordtmaintwo,),
                  FutureBuilder<List<CalendarStatus>>(
                    future: fetchPostsfuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print('error1');
                      posts = snapshot.data;
                      return snapshot.hasData ?
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: posts.length,
                          physics: ClampingScrollPhysics(),
                          controller: _scrollController,
                          itemBuilder: (context,index){
                            return Column(
                              children: [
                                ListTile(
                                  title: Text('''$daysst: ${correctdatedays(posts[index].dates).toString()} \n'''
                                      '''\n'''
                                      '''$monthandyearst: ${correctdatemny(posts[index].dates).toString()} \n'''
                                      '''\n'''
                                      '''$timesst:${posts[index].times.toString()}  \n'''
                                      '''\n'''
                                      '''$itemsst:${posts[index].items.toString()}  \n'''
                                    ,style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height*0.03,
                                      fontWeight: FontWeight.w600, color: colordtmaintwo,),),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete,color: colordtmaintwo,),
                                    onPressed: (){
                                      RemoveCalendarStatus(posts[index].id);
                                      Future.delayed(Duration(seconds: 1),()=>           Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) => super.widget)));
                                    },
                                  ),





                                ),
                                Divider(color: colordtmaintwo,),
                              ],
                            );

                          }) : Center(
                        child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                        ),);},),

                ],),



              ]
          )],),),);
  }
}

