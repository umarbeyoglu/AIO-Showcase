import 'package:untitled/language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../colors.dart';

class GeneralAboutScreen extends StatefulWidget {
  const GeneralAboutScreen({Key key}) : super(key: key);

  @override
  GeneralAboutScreenState createState() => GeneralAboutScreenState();
}

class GeneralAboutScreenState extends State<GeneralAboutScreen>{
  GeneralAboutScreenState({Key key,});
  String image = 'https://media-exp1.licdn.com/dms/image/C4E03AQHekCIz1CjvRQ/profile-displayphoto-shrink_800_800/0/1618328499805?e=1644451200&v=beta&t=UyVM_7IBTdiQg-cWNVQqknJmH169uFYFEeiCtP4wwwg';

  @override
  Widget build(BuildContext context) {
     return Scaffold(

       backgroundColor: colordtmainone,

       body:Center(
         child: Column(
           children: [
             SizedBox( height: MediaQuery
                 .of(context)
                 .size
                 .height * 0.12,),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 CircleAvatar(
                   radius: MediaQuery
                       .of(context)
                       .size
                       .height * 0.12,
                   backgroundImage: NetworkImage(image),

                 ),
               ],
             ),SizedBox(height:20),
             Text('Umar Beyoğlu'),SizedBox(height:20),
             Text(founderandcoderst),SizedBox(height:20),

             FittedBox(

               child: ElevatedButton(
                 child: Text('Linkedin'),

                 onPressed: (){
                   {setState(() async {launch('https://www.linkedin.com/in/umar-beyo%C4%9Flu-4a20931b0/');});}
                 },
               ),),SizedBox(height:20),
             FittedBox(

               child: ElevatedButton(
                 child: Text('Whatsapp'),

                 onPressed: (){
                   {setState(() async {launch('whatsapp://send?phone=905428513410');});}
                 },
               ),),SizedBox(height:20),
             FlutterLogo(
               size:50
             ),SizedBox(height:20),
             Text(poweredbyflutterst),
           ],
         ),
       ),
     );

  }


}


