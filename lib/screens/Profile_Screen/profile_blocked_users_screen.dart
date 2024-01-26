import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/repository.dart';
import 'package:untitled/main.dart';
import 'package:untitled/language.dart';
import 'package:untitled/models/User_Model/user_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled/models/User_Model/user_block_model.dart';
import 'package:untitled/screens/Visited_Profile_Screen/visited_profile_screen.dart';
import '../../colors.dart';
import '../../main.dart';

class BlockedUsersScreen extends StatefulWidget {
  final User user;
  const BlockedUsersScreen({Key key,this.user}) : super(key : key);

  @override
  BlockedUsersScreenState createState() => BlockedUsersScreenState(user: user );
}

class BlockedUsersScreenState extends State<BlockedUsersScreen> {
  final User user;
  BlockedUsersScreenState({Key key,this.user});
  ScrollController _scrollController = ScrollController();
  int page = 1;
  List<UserBlock> posts = [];
  Future fetchPostsfuture;
  bool isLoading = false;

  @override
  void initState() {
    fetchPostsfuture = FetchOwnBlockedUsers(http.Client(),user.id,page);
  }



  Future _loadData() async {
    FetchOwnBlockedUsers(http.Client(),user.id,page)..then((result){
      setState(() {
        for(final item2 in result)
          posts.add(item2);
        isLoading = false;
        return;
      });
    });

  }
  Future<Widget> refreshProfile() async {
    User _user1;
    WidgetsFlutterBinding.ensureInitialized();
    final http.Response response = await http.get(Uri.parse("$SERVER_IP/api/ownuser/"),
      headers: <String, String>{"Authorization" : "Token ${globaltoken}"},
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      _user1 = User.fromJSON(responseJson[0]);
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlockedUsersScreen(
            user: _user1,
          ),
        ),
      );
    }
  }



  @override
  Future<User> callUser(String userid) async {
    Future<User> _user = FetchUser(userid);
    return _user;
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

          },
        ),
      ),

      backgroundColor: colordtmainone,
      body:
      NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading && scrollInfo.metrics.pixels ==
              scrollInfo.metrics.maxScrollExtent) {
            page = page +1;
            _loadData();
            setState(() {isLoading = true;});
            return true;
          }},child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children:[
          Column(
            children: <Widget>[


              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colordtmainone,
                  borderRadius: BorderRadius.only(
                  ),
                ),
                child: Column(

                  children: <Widget>[

                    SizedBox(height: MediaQuery.of(context).size.height*0.05),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          iconSize: MediaQuery.of(context).size.height*0.035,
                          color: colordtmaintwo,
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(
                          blockedusersst,
                          style: TextStyle(

                            color:colordtmaintwo,
                            fontSize: MediaQuery.of(context).size.height*0.03,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(children: [
                      FutureBuilder<List<UserBlock>>(
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
                                return FutureBuilder<User>(
                                    future: callUser(posts[index].profile),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) print(snapshot.error);

                                      return snapshot.hasData ? Padding(
                                        padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.008),
                                        child: Column(
                                          children: [
                                            ListTile(
                                              leading: CircleAvatar(
                                                radius: MediaQuery.of(context).size.height*0.035,
                                                backgroundImage: NetworkImage(snapshot.data.image == null ? 'https://st2.depositphotos.com/4111759/12123/v/600/depositphotos_121233262-stock-illustration-male-default-placeholder-avatar-profile.jpg' : snapshot.data.image),

                                              ),

                                              subtitle:
                                              Column(
                                                crossAxisAlignment :CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(

                                                    child: Stack(
                                                      children: <Widget>[
                                                        Padding(

                                                          padding: EdgeInsets.only(right: MediaQuery.of(context).size.height*0.0),
                                                          child: Column(
                                                            crossAxisAlignment :CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              Row(
                                                                children: <Widget>[
                                                                  InkWell(
                                                                    onTap: () {
                                                                      isuserfollowed(user.id,snapshot.data.id)..then((res){
                                                                        if(user.shouldshowuserinfo(snapshot.data,res) == 'public'){
                                                                          FetchPublicUserNav(user,snapshot.data.id,context);
                                                                        };
                                                                        if(user.shouldshowuserinfo(snapshot.data,res) == 'followed'){
                                                                          FetchFollowedUserNav(user,snapshot.data.id,context);
                                                                        };
                                                                        if(user.shouldshowuserinfo(snapshot.data,res) == 'null'){
                                                                          if(snapshot.data.id != user.id){
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (_) => VisitedProfileScreen(
                                                                                    user:user,visiteduserid: '',
                                                                                    visiteduser: snapshot.data,
                                                                                  )
                                                                              ),
                                                                            );
                                                                          }
                                                                        };
                                                                      });  },
                                                                    child: Text(
                                                                      '${snapshot.data.username}',
                                                                      style: TextStyle(
                                                                        fontWeight: FontWeight.bold,
                                                                        color:  colordtmaintwo,
                                                                        fontSize: MediaQuery.of(context).size.height*0.03,
                                                                      ),
                                                                    ),
                                                                  ),

                                                                ],
                                                              ),

                                                            ],
                                                          ),

                                                        ),

                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),






                                            ),
                                            SizedBox(

                                              width:languagest == 'TR' ?MediaQuery.of(context).size.width*0.53: MediaQuery.of(context).size.width*0.4, height:MediaQuery.of(context).size.height*0.06,
                                              child: ElevatedButton(
                                                child: Text(unblockst, style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.02,),),

                                                onPressed: () {

                                                  UnblockUser(posts[index].id);
                                                  Future.delayed(new Duration(seconds:2), ()
                                                  {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext context) => super.widget));
                                                  });

                                                },
                                              ),),
                                          ],
                                        ),
                                      ) :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
                                    });

                              }) : Center(
                            child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                            ),);},),

                    ],),

                    SizedBox(height: MediaQuery.of(context).size.height*0.5),
                  ],
                ),
              )
            ],
          ),
        ],
      ),),
    );
  }
}

