import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../language.dart';
import '../../models/User_Model/user_model.dart';
import '../../repository.dart';
import '../Authentication_Screen/authentication_login_screen.dart';
import '../General/home_screen.dart';

class DeleteUserScreen extends StatefulWidget {
  final User user;
  final bool issubprofile;
  final User mainuser;
  const DeleteUserScreen({Key key, this.user, this.issubprofile, this.mainuser})
      : super(key: key);

  @override
  DeleteUserScreenState createState() => DeleteUserScreenState(
      user: user, issubprofile: issubprofile, mainuser: mainuser);
}

class DeleteUserScreenState extends State<DeleteUserScreen> {
  final User user;
  final bool issubprofile;
  final User mainuser;
  DeleteUserScreenState({Key key, this.user, this.issubprofile, this.mainuser});

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
                borderRadius: BorderRadius.only(),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Image.network('https://i.imgflip.com/2ru1yz.gif'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.04,
                    child: ElevatedButton(
                      child: Text(
                        deletemyprofilest,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ),
                      onPressed: () {
                        DeleteUserPublic(user.id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.08,
        child: ElevatedButton(
          child: Text(
            gobackst,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.04,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HomeScreen(
                  user: user,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
