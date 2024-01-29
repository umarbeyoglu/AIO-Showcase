import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

import '../../colors.dart';
import '../../language.dart';
import '../../models/User_Model/user_model.dart';

class Tagstatekeys {
  static final _tagStateKey1 = const Key('__TSK1__');
}

class ProfileDetailsScreen extends StatefulWidget {
  final User user;
  const ProfileDetailsScreen({Key key, this.user}) : super(key: key);

  @override
  ProfileDetailsScreenState createState() =>
      ProfileDetailsScreenState(user: user);
}

class ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  final User user;
  ProfileDetailsScreenState({Key key, this.user});
  int _column = 0;

  bool checkifnull(String data) {
    if (data == null) {
      return true;
    }
    if (data == 'null') {
      return true;
    }
    if (data == '') {
      return true;
    }
    if (data == ' ') {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colordtmainone,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.043,
                vertical: 0,
              ),
              child: Text(
                user.details == null ? nothingtoseeherest : user.details,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.043,
                  color: colordtmaintwo,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Tags(
              key: Tagstatekeys._tagStateKey1,
              columns: _column,
              itemCount: user.tags.length,
              itemBuilder: (i) {
                return ItemTags(
                  key: Key(i.toString()),
                  index: i,
                  title: user.tags[i].tag.toString(),
                  color: Color(0xFFEEEEEE),
                  activeColor: Color(0xFFEEEEEE),
                  textColor: colordtmaintwo,
                  textActiveColor: colordtmaintwo,
                  textStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.018,
                    color: colordtmaintwo,
                  ),
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          ],
        ),
      ),
    );
  }
}
