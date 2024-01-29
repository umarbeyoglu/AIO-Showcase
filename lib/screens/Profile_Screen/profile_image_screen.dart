import 'package:flutter/cupertino.dart';
import '../../colors.dart';
import '../../language.dart';import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


class ViewImageScreen extends StatefulWidget {
  final String image;
  const ViewImageScreen({Key key, this.image}) : super(key: key);
  @override
  ViewImageScreenState createState() => ViewImageScreenState(image:image);
}

class ViewImageScreenState extends State<ViewImageScreen> {
  final String image;
  ViewImageScreenState({Key key, this.image});


  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
          imageProvider: NetworkImage(image),
        )
    );
  }
}