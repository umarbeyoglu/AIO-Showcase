import 'dart:async';
import 'dart:convert';
import 'package:untitled/repository.dart';
import 'package:untitled/screens/Calendar_Screen/calendar_time_screen.dart';
import 'package:dio_http/dio_http.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:untitled/language.dart';
import 'package:untitled/models/User_Model/user_model.dart';
import '../../colors.dart';

String chosensearchtype = userst;
bool reload = false;

class MessagingHomeScreen extends StatefulWidget {
  MessagingHomeScreen({this.user});
  final User user;
  @override
  MessagingHomeScreenState createState() => MessagingHomeScreenState(user:user);
}

class MessagingHomeScreenState extends State<MessagingHomeScreen> {
  MessagingHomeScreenState({this.user});
  final User user;
  Timer timer;
  int messagecount = 0;
  bool start = true;


  void didChangeDependencies() {
    super.didChangeDependencies();
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => FetchUserMC()..then((value) {
      if(start == false && (value>messagecount ||value<messagecount)){
        messagecount=value;
        messagecheck();
      }
      if(start){
        messagecount = value;
        start = false;}}));
  }

  void startcheck(){
    user.recentchats2 = [];
    List<Message> allmessages = [];
    allmessages = user.messagesreceived + user.messagessent;
    bool getout = false;

    for(int i=0;i<allmessages.length;i++){

      for(int r=0;r<user.recentchats2.length;r++){
        if(user.recentchats2[r].guest == allmessages[i].authorinit
            || user.recentchats2[r].guest == allmessages[i].profileinit
        ){user.recentchats2[r].messages.add(allmessages[i]); getout=true;}
      }

      if(getout){
        getout = false;
        continue;
      }


      if(allmessages[i].authorinit == user.id){
        RecentChat test = RecentChat(guest: allmessages[i].profileinit );
        test.messages.add(allmessages[i]);user.recentchats2.add(test);getout=true;
      }
      if(getout){
        getout = false;
        continue;}
      if(allmessages[i].profileinit == user.id){
        RecentChat test = RecentChat(guest: allmessages[i].authorinit );
        test.messages.add(allmessages[i]);user.recentchats2.add(test);getout=true;
      }
      if(getout){
        getout = false;
        continue;}
    }

    for(int r=0;r<user.recentchats2.length;r++){

      user.recentchats2[r].timestamp = user.recentchats2[r].messages.last.timestamp;
      user.recentchats2[r].time = user.recentchats2[r].messages.last.time;
    }
    return;
  }

  void messagecheck() async{
    user.recentchats2 = [];
    List<Message> allmessages = [];
    final response = await http.get(Uri.parse("$SERVER_IP/api/usergetmessages/?format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    user.messagessent = User.fromJSON(responseJson[0]).messagessent;
    user.messagesreceived = User.fromJSON(responseJson[0]).messagesreceived;
    allmessages = user.messagesreceived + user.messagessent;
    bool getout = false;


    for(int i=0;i<allmessages.length;i++){
      for(int r=0;r<user.recentchats2.length;r++){
        if(user.recentchats2[r].guest == allmessages[i].authorinit
            || user.recentchats2[r].guest == allmessages[i].profileinit
        ){
          user.recentchats2[r].messages.add(allmessages[i]); getout=true;}
      }

      if(getout){
        getout = false;
        continue;}


      if(allmessages[i].authorinit == user.id){
        RecentChat test = RecentChat(guest: allmessages[i].profileinit );
        test.messages.add(allmessages[i]);user.recentchats2.add(test);getout=true;
      }
      if(getout){
        getout = false;
        continue;}
      if(allmessages[i].profileinit == user.id){
        RecentChat test = RecentChat(guest: allmessages[i].authorinit );
        test.messages.add(allmessages[i]);user.recentchats2.add(test);getout=true;
      }
    }

    for(int r=0;r<user.recentchats2.length;r++){

      user.recentchats2[r].timestamp = user.recentchats2[r].messages.last.timestamp;
      user.recentchats2[r].time = user.recentchats2[r].messages.last.time;
    print(user.recentchats2[r].messages.last.content);
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    startcheck();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        leading: new Container(


        ),


        elevation: 0.0,
        actions: <Widget>[

          IconButton(
            icon: Icon(Icons.add_box),
            iconSize: 30.0,
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatSearchScreen(
                      user:user,
                    )
                ),
              );
            },
          ),

        ],

      ),
      backgroundColor: Colors.white,

      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child:Container(
                      child: ListView.builder(
                        itemCount: user.recentchats2.length,
                        itemBuilder: (BuildContext context, int index) {
                          user.recentchats2.sort((b,a) => a.timestamp.compareTo(b.timestamp));
                          return FutureBuilder<User>(
                              future:  FetchUserPrivate(user.recentchats2[index].guest),
                              builder:(context,snapshot2){
                                if (snapshot2.hasError) print (snapshot2.error);

                                return snapshot2.hasData ? GestureDetector(
                                  onTap: () {
                                    returnfullmessages(user, snapshot2.data.id,user.recentchats2[index]);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ChatScreen(
                                          user: user,
                                          visiteduser:snapshot2.data,
                                        ),),);},
                                  child:  Container(
                                    margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right:5.0),
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),

                                    child:     Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: MediaQuery.of(context).size.height*0.045,
                                          backgroundImage: snapshot2.data.image == null ? NetworkImage('https://st2.depositphotos.com/4111759/12123/v/600/depositphotos_121233262-stock-illustration-male-default-placeholder-avatar-profile.jpg') : NetworkImage(snapshot2.data.image),


                                        ),
                                        SizedBox(width: 10.0),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  snapshot2.data.username,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:  MediaQuery.of(context).size.height*0.025,
                                                  ),
                                                ),
                                                SizedBox(width:MediaQuery.of(context).size.width*0.01,),


                                              ],
                                            ),

                                            SizedBox(height: 5.0),



                                            Container(



                                              width: MediaQuery.of(context).size.width*0.7,
                                              child: Text(
                                                user.recentchats2[index].lastmessage(),
                                                style: TextStyle(

                                                  color: Colors.black,
                                                  fontSize: MediaQuery.of(context).size.height*0.022,

                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),

                                            ),
                                            SizedBox(height:5),
                                            Container(



                                              width: MediaQuery.of(context).size.width*0.7,
                                              child: Text(
                                                "${user.recentchats2[index].messages.last.formatDate().day.toString().padLeft(2,'0')}-${user.recentchats2[index].messages.last.formatDate().month.toString()}-${user.recentchats2[index].messages.last.formatDate().year.toString().padLeft(2,'0')} ${user.recentchats2[index].messages.last.formatDate().hour.toString().padLeft(2,'0')}:${user.recentchats2[index].messages.last.formatDate().minute.toString().padLeft(2,'0')}",
                                                style: TextStyle(

                                                  color: Colors.black,
                                                  fontSize: MediaQuery.of(context).size.height*0.022,

                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),

                                            ),
                                            SizedBox(height:MediaQuery.of(context).size.height*0.01),


                                          ],
                                        ),

                                      ],
                                    ),
                                  ) ,
                                ) :
                                Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));
                              }
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  ChatScreen({this.user,this.visiteduser,this.message, this.time, this.isMe});
  final User user;
  final User visiteduser;
  final String message, time;
  final isMe;

  @override
  ChatScreenState createState() => ChatScreenState(
      user:user,visiteduser:visiteduser,
  );
}

class ChatScreenState extends State<ChatScreen> {
  Future<List<Message>> fetchPostsfuture;
  final User user;
  final User visiteduser;
  Timer timer;
  int messagecount = 0;
  bool start = true;
  TextEditingController _message = TextEditingController(text:'');
  ChatScreenState({this.user,this.visiteduser});

  Future<void> FetchUserMessages2(User user) async {
    final response = await http.get(Uri.parse("$SERVER_IP/api/usergetmessages/?format=json"), headers: <String, String>{'Content-Type': 'application/json; charset=utf-8',"Authorization" : "Token ${globaltoken}"},);
    var responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    List<Message> messagesfinal = [];
    setState(() {
      user.messagessent = User.fromJSON(responseJson[0]).messagessent;
      user.messagesreceived = User.fromJSON(responseJson[0]).messagesreceived;
      user.recentchats = user.messagesreceived + user.messagessent;

      user.recentchats.forEach((item) {
        final formatter = DateFormat("yyyy-MM-ddThh:mm:ss");
        item.time  = formatter.parse(item.timestamp);

      });
      user.recentchats.sort((b,a) => a.timestamp.compareTo(b.timestamp));

        user.relevantmessages = [];

      for(int i=0;i<user.recentchats.length;i++){
        if(user.recentchats[i].profileinit == visiteduser.id){
          messagesfinal.add(user.recentchats[i]);
        }
        if(user.recentchats[i].authorinit == visiteduser.id){
          messagesfinal.add(user.recentchats[i]);
        }
      }

      user.relevantmessages = messagesfinal;
      user.relevantmessages.sort((b,a) => a.timestamp.compareTo(b.timestamp));
    });
    return;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      timer = Timer.periodic(Duration(seconds: 1), (Timer t) => FetchUserMC()..then((value) {


        if(start == false && (value>messagecount ||value<messagecount)){
          messagecount=value;
          setState(() {});
          FetchUserMessages2(user);
        }
        if(start){
          messagecount = value;
          start = false;}}));
    });
  }

  _build(Message message, bool isMe) {
    final bg = isMe ?Color(0XFF2196F3) :  Color(0xFFEEEEEE);
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.end;

    final Column msg =  Column(
      crossAxisAlignment : align,
      children: <Widget>[

      InkWell(
        child:   Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.only(left: 18 ,right:0 ,top:12,bottom:12),
          //padding: const EdgeInsets.only(left: 18 ,right:18 ,top:12,bottom:12),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: .3,
                  spreadRadius: 1.0,
                  color: Colors.black.withOpacity(.12))
            ],
            color: bg,
            borderRadius:  BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          child: Stack(
            children: <Widget>[
              Padding(

                padding: EdgeInsets.only(right: MediaQuery.of(context).size.height*0.08),
                child:
                // InkWell(child:  Image.network('https://www.imagesource.com/wp-content/uploads/2019/06/Rio.jpg',height: 128.0,), onTap:(){Navigator.push(context, MaterialPageRoute(builder: (_) => ViewImageScreen(image:'https://www.imagesource.com/wp-content/uploads/2019/06/Rio.jpg'),),);},),
                Text(message.content, style:TextStyle(fontWeight: FontWeight.w900, fontSize: MediaQuery.of(context).size.height*0.02, color: isMe ? Colors.white : Colors.black,),),
              ),
              SizedBox(height:35),
              Positioned(

                bottom: 1.0,
                right: 6.0,
                child: Row(
                  children: <Widget>[
                    Text(
                        "${message.formatDate().day.toString().padLeft(2,'0')}-${message.formatDate().month.toString()}-${message.formatDate().year.toString().padLeft(2,'0')} ${message.formatDate().hour.toString().padLeft(2,'0')}:${message.formatDate().minute.toString().padLeft(2,'0')}",

                        style: TextStyle(
                          color:isMe ? Colors.white: Colors.black,
                          fontSize:
                          MediaQuery.of(context).size.height*0.012,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
        onLongPress:(){
        if(isMe){
          Navigator.push(context, MaterialPageRoute(builder: (_) => DeleteThingScreen(id:message.id,category: 'MS',),),);
        }
        },
      ),
      ],
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(

        backgroundColor: Colors.white,

        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => MessagingHomeScreen(user:user),),);
            },
          ),
          SizedBox(width: 10,),
       //   CircleAvatar(radius: MediaQuery.of(context).size.height*0.04, backgroundImage:Container(), // visiteduser.image == null ? NetworkImage('https://st2.depositphotos.com/4111759/12123/v/600/depositphotos_121233262-stock-illustration-male-default-placeholder-avatar-profile.jpg') : NetworkImage(visiteduser.image),),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(visiteduser.username,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                SizedBox(height: 3,),
               ],
            ),
          ),

        ],
      ),
      body:
      ListView.builder(
        reverse: true,
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 15.0),
        itemCount: user.relevantmessages.length,
        itemBuilder: (BuildContext context, int index) {
          final Message text = user.relevantmessages[index];
          final bool isMe = text.authorinit == user.id;
          return _build(text, isMe);
        },
      ),



      bottomNavigationBar: Transform.translate(
        offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          height: 60.0,
          color: Colors.white,
          child: Row(
            children: <Widget>[

              Expanded(
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (value) {},controller: _message,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Send message...',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                iconSize: 26,
                color: Colors.blue,
                onPressed: () {
                  CreateMessage(user.id, visiteduser.id, '', _message.text);
                  _message.clear();

                  },

              ),
            ],
          ),
        ),
      ),
    );
  }
}

CreateMessage(String author,String profile,String article,String content) async {
  try {
    FormData formData = new FormData.fromMap({
      'author' : author,
      'profile': profile,
      'article' : article,
      'content' : content,
    });

    await Dio().post("$SERVER_IP/api/usermessages/", data: formData,options: Options(headers: {"Authorization" : "Token ${globaltoken}"} ));

  } catch (e) {
    print(e);
  }
}





returnfullmessages(User user,String visiteduser,RecentChat recentchats){



  user.relevantmessages = recentchats.messages;
  user.relevantmessages.sort((b,a) => a.timestamp.compareTo(b.timestamp));



  return;
}


class ChatSearchScreen extends StatefulWidget {
  final User user;
  const ChatSearchScreen({Key key, this.user}) : super(key: key);

  @override
  ChatSearchScreenState createState() => ChatSearchScreenState(user: user,key:key);
}

class ChatSearchScreenState extends State<ChatSearchScreen> {
  final User user;
  ChatSearchScreenState({Key key, this.user});
  bool searching = false;
  List<User> _users = [];
  List<User> _usersForDisplay  = [];
  bool done1 = false;
  bool done2 = false;
  bool done3 = false;
  bool done4 = false;
  bool hidebar = false;
  bool done5 = false;
  bool done6 = false;
  bool done7 = false;
  bool done8 = false;
  bool done9 = false;
  String globaltxt = '';
  var _textfield = TextEditingController();
  int _column = 0;
  ScrollController _scrollController = ScrollController();
  int page = 1;
  Future fetchPostsfuture;
  bool isLoading = false;

  @override
  void initState() {
    fetchPostsfuture = SearchUsersNew2(page,globaltxt,globaltxt.split(','),tagsearch,searchbasedonlocation);
    super.initState();
  }


  Future _loadmoreusers() async {
    List<User> postsinit = [];
    postsinit = await SearchUsersNew2(page,globaltxt,globaltxt.split(','),tagsearch,searchbasedonlocation);
    setState(() {
      for(final item2 in postsinit)
        _usersForDisplay.add(item2);
      isLoading = false;
      return;
    });
  }


  bool tagsearch = false;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  List<User> searchusers = [];



  _searchBar(){
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child:
      Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 0, vertical:   MediaQuery.of(context).size.width*0.015),
            decoration: BoxDecoration(
              color: colordtmainone,
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.015),
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
              padding: EdgeInsets.only(left :  MediaQuery.of(context).size.width*0.015),
              child:Form(
                child:TextFormField(
                  style: TextStyle(color: colordtmaintwo),
                  controller:_textfield,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,

                    icon: Icon(
                      Icons.search,
                      color: colordtmaintwo,
                    ),
                  ),
                  onChanged: (_textfield) {
                    setState(() {
                      globaltxt = _textfield.toLowerCase();

                    });
                    _textfield == '' ? setState(() {searching = false; }) : setState(() {searching = true;});
                    setState(() {
                      _users = [];
                      _usersForDisplay = [];
                      SearchUsersNew2(page,_textfield.toLowerCase(),_textfield.toLowerCase().split(','),tagsearch,searchbasedonlocation).then((value) {setState(() {_users.addAll(value);_usersForDisplay = _users;});});
                    });

                  },
                ),
              ),
            ),
          ),
          SizedBox(height:10),

        ],
      ),

    );
  }

  _listItemUser(index) {
    return _usersForDisplay[index].id == user.id ? Container(height: 0,width: 0,) : Container(
      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height*0.01, vertical:  MediaQuery.of(context).size.width*0.024),
      child: Column(
        children: [
          ListTile(
            title:   CircleAvatar(
              radius:MediaQuery.of(context).size.height*0.045,
              backgroundImage: NetworkImage(_usersForDisplay[index].image == null ?'https://st2.depositphotos.com/4111759/12123/v/600/depositphotos_121233262-stock-illustration-male-default-placeholder-avatar-profile.jpg' : _usersForDisplay[index].image ),
            ),
            trailing: SizedBox(
              width:MediaQuery.of(context).size.width*0.66,
              child:  Text(
                '${_usersForDisplay[index].username}',
                style: TextStyle(
                  color: colordtmaintwo,
                  fontSize: MediaQuery.of(context).size.height*0.03,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            onTap: () {
              returnfullmessages(user, _usersForDisplay[index].id,RecentChat(guest:_usersForDisplay[index].id));
              user.relevantmessages = [];
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatScreen(
                      user:user,visiteduser: _usersForDisplay[index],
                    )),);
            },
          ),



        ],
      ),
    );
  }


  @override
  Future<User> callUser(String userid) async {
    Future<User> _user = FetchPublicUser(userid);
    return _user;
  }



  @override
  Widget build(BuildContext context) {return SearchScreen();}



  Widget SearchScreen(){
    setState(() {
      page = 1;
    });

    return Scaffold(
      backgroundColor: colordtmainone,
      body:
      NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!isLoading && scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              _loadmoreusers();
              setState(() {isLoading = true;});
              return true;
            }},child:    ListView.builder(
        itemBuilder: (context, index) {
          return index == 0 ? _searchBar() : searching == false ? Container(height: 0,width: 0,) : _listItemUser(index-1);},
        itemCount: _usersForDisplay.length+1,
      )),

    );
  }}