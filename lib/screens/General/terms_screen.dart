import 'package:untitled/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../colors.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({Key key,}) : super(key : key);

  @override
  TermsScreenState createState() => TermsScreenState();
}

class TermsScreenState extends State<TermsScreen> {
  TermsScreenState({Key key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: colordtmainone,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width* 0.043,
                vertical: 0,
              ),
              child: Text(
                termsandconditionsdetailsst,
                style: TextStyle(
                  fontSize:  MediaQuery.of(context).size.width*0.043,
                  color:colordtmaintwo,
                  fontWeight: FontWeight.w500,

                ),
              ),
            ),
          ],
        ),
      ),
    ) ;

  }
}



