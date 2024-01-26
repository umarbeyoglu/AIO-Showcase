import 'dart:typed_data';
import 'package:Welpie/repository.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

import '../../colors.dart';
import '../../language.dart';
import '../../models/User_Model/user_tags_model.dart';

class SelectMeme extends StatefulWidget {
  @override
  _SelectMemeState createState() => _SelectMemeState();
}

class _SelectMemeState extends State<SelectMeme> {
  int currentIndex = 0;

  List<Meme> articles = [];
  Future fetchPostsfuture;

  @override
  void initState() {
    super.initState();

    fetchPostsfuture = FetchMemes();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colordtmainone,
      body: FutureBuilder<List<Meme>>(
        future: fetchPostsfuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          articles = snapshot.data;
          return snapshot.hasData ? (snapshot.data.length == 0 ? Center(
            child: Text(nopostst,style:TextStyle(color: colordtmaintwo,fontWeight: FontWeight.bold)),
          ):
          GridView.builder(
              itemCount: articles.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 13, crossAxisCount: 2),
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditMeme(selectedMeme: articles[index].picture))),
                  child: Image.network(articles[index].picture))))
              :
          Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,valueColor: new AlwaysStoppedAnimation<Color>(Colors.pinkAccent)));

        },
      ),
    );
  }


}

class TextInfo{

  String text;
  double left;
  double top;
  Color color;
  FontWeight fontWeight;
  FontStyle fontStyle;
  double fontSize;
  TextAlign textAlign;

  TextInfo({
    @required this.text,
    @required this.left,
    @required this.top,
    @required this.color,
    @required this.fontWeight,
    @required this.fontStyle,
    @required this.fontSize,
    @required this.textAlign
  });

}



class EditMeme extends StatefulWidget {
  final String selectedMeme;

  EditMeme({@required this.selectedMeme});

  @override
  _EditMemeState createState() => _EditMemeState();
}

class _EditMemeState extends EditMemeViewModel {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colordtmainone,
        automaticallyImplyLeading: false,
        title: Container(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit,color: colordtmaintwo,),
                onPressed: () => addNewDialog(context),
                tooltip: 'addNewText',
              ),
              IconButton(
                tooltip: 'increaseFontSize',
                icon: Icon(Icons.add,color: colordtmaintwo,),
                onPressed: increaseFontSize,
              ),
              IconButton(
                tooltip: 'decreaseFontSize',
                icon: Icon(Icons.remove,color: colordtmaintwo,),
                onPressed: decreaseFontSize,
              ),
              IconButton(
                tooltip: 'alignLeft',
                icon: Icon(Icons.format_align_left,color: colordtmaintwo,),
                onPressed: alignLeft,
              ),
              IconButton(
                tooltip: 'alignCenter',
                icon: Icon(Icons.format_align_center,color: colordtmaintwo,),
                onPressed: alignCenter,
              ),
              IconButton(
                tooltip: 'alignRight',
                icon: Icon(Icons.format_align_right,color: colordtmaintwo,),
                onPressed: alignRight,
              ),
              IconButton(
                tooltip: 'boldText',
                icon: Icon(Icons.format_bold,color: colordtmaintwo,),
                onPressed: boldText,
              ),
              IconButton(
                tooltip: 'italicText',
                icon: Icon(Icons.format_italic,color: colordtmaintwo,),
                onPressed: italicText,
              ),
              IconButton(
                tooltip: 'addNewLine',
                icon: Icon(Icons.space_bar,color: colordtmaintwo,),
                onPressed: addLinesToText,
              ),
              Tooltip(
                message: 'red',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.red),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'white',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.white),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'black',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.black),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'blue',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.blue),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'yellow',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.yellow),
                  child: CircleAvatar(
                    backgroundColor: Colors.yellow,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'green',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.green),
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'orange',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.orange),
                  child: CircleAvatar(
                    backgroundColor: Colors.orange,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'pink',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.pink),
                  child: CircleAvatar(
                    backgroundColor: Colors.pink,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Screenshot(
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Image.network(
                widget.selectedMeme,
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              for (int i = 0; i < texts.length; i++)
                Positioned(
                    left: texts[i].left,
                    top: texts[i].top,
                    child: GestureDetector(
                        onLongPress: () {
                          setState(() {
                            currentIndex = i;
                          });
                        },
                        onTap: () => setCurrentIndex(i),
                        child: Draggable(
                          feedback: MemeText(textInfo: texts[i]),
                          child: MemeText(textInfo: texts[i]),
                          onDraggableCanceled:
                              (Velocity velocity, Offset offset) {
                            setState(() {
                              texts[i].top = offset.dy - 50;
                              texts[i].left = offset.dx;
                            });
                          },
                        ))),
              creatorText.text.length > 0
                  ? Positioned(
                left: 0,
                bottom: 0,
                child: Text(creatorText.text,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(.3))),
              )
                  : SizedBox.shrink(),
            ],
          ),
        ),
        controller:screenshotController,
      ),
    );
  }



}

abstract class EditMemeViewModel extends State<EditMeme> {
  TextEditingController text = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  bool isPublic = true;
  bool addName = false;

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();
  List<TextInfo> texts = [];
  int currentIndex = 0;

  setCurrentIndex(index) {
    setState(() {
      currentIndex = index;
    });

  }

  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  increaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize = texts[currentIndex].fontSize += 2;
    });
  }

  decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize = texts[currentIndex].fontSize -= 2;
    });
  }

  alignLeft() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.left;
    });
  }

  alignRight() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.right;
      print(texts[currentIndex].textAlign);
    });
  }

  alignCenter() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.center;
    });
  }

  boldText() {
    setState(() {
      if (texts[currentIndex].fontWeight == FontWeight.bold) {
        texts[currentIndex].fontWeight = FontWeight.normal;
      } else {
        texts[currentIndex].fontWeight = FontWeight.bold;
      }
    });
  }

  italicText() {
    setState(() {
      if (texts[currentIndex].fontStyle == FontStyle.italic) {
        texts[currentIndex].fontStyle = FontStyle.normal;
      } else {
        texts[currentIndex].fontStyle = FontStyle.italic;
      }
    });
  }

  addLinesToText() {
    setState(() {
      texts[currentIndex].text = texts[currentIndex].text.replaceAll(' ', '\n');
    });
  }

  addNewText() {
    setState(() {
      texts.add(TextInfo(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          text: text.text,
          textAlign: TextAlign.left,
          fontSize: 20,
          left: 0,
          top: 0));
    });
  }


  addNewDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('addNewText'),
          content: TextField(
            controller: text,
            maxLines: 5,
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.edit),
                filled: true,
                hintText: 'addTextHint'),
          ),
          actions: <Widget>[
            DefaultButton(

              onPressed: (){
                addNewText();
               Navigator.of(context).pop();
              },
              child: Text('addNewText'),
              color: Colors.green,
              textColor: Colors.white,
            ),
            DefaultButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('back'),
              color: Colors.red,
              textColor: Colors.white,
            ),
          ],
        ));
  }
}


class ImagePreview extends StatelessWidget {
  final String imageUrl;
  final bool isMyMeme;
  final String memeId;
  ImagePreview(
      {@required this.imageUrl,
        @required this.isMyMeme,
        @required this.memeId});





  showChoices(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('choices'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              isMyMeme
                  ? InkWell(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('deleteChoice'),
                ),
              )
                  : SizedBox.shrink(),
              SizedBox(height: 5),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('downloadChoice'),
                ),
              )
            ],
          ),
          actions: <Widget>[
            DefaultButton(
              onPressed: () => Navigator.of(context).pop(),
              textColor: Colors.white,
              child: Text('back'),
              color: Colors.indigo,
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () => showChoices(context),
          child: Image.network(this.imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill)),
    );
  }
}

class DefaultButton extends StatelessWidget {

  final Function onPressed;
  final Widget child;
  final Color color;
  final Color textColor;

  DefaultButton({
    @required this.onPressed,
    @required this.child,
    @required this.color,
    @required this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.onPressed,
      child: this.child,
    );
  }
}

class MemeText extends StatefulWidget {
  final TextInfo textInfo;

  MemeText({@required this.textInfo});

  @override
  _MemeTextState createState() => _MemeTextState();
}

class _MemeTextState extends State<MemeText> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.textInfo.text,
        textAlign: widget.textInfo.textAlign,
        style: TextStyle(
          fontSize: this.widget.textInfo.fontSize,
          fontWeight: this.widget.textInfo.fontWeight,
          fontStyle: this.widget.textInfo.fontStyle,
          color: this.widget.textInfo.color,
        ));
  }
}




