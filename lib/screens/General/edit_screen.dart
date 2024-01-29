import 'package:carousel_pro/carousel_pro.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../colors.dart';
import '../../language.dart';
import '../../models/Article_Model/article_model.dart';
import '../../models/User_Model/user_model.dart';
import '../../repository.dart';
import '../Profile_Screen/profile_image_screen.dart';
import 'choice_screen.dart';

class Tagstatekeys {
  static final _tagStateKey1 = const Key('__TSK1__');
  static final _tagStateKey2 = const Key('__TSK2__');
  static final _tagStateKey3 = const Key('__TSK3__');
}

class EditPostScreen extends StatefulWidget {
  final User user;
  final Article post;
  final String category;
  final String day;
  final String dayfull;
  final String mnyinit;
  const EditPostScreen(
      {Key key,
      this.category,
      this.day,
      this.dayfull,
      this.mnyinit,
      this.user,
      this.post})
      : super(key: key);

  @override
  EditPostScreenState createState() => EditPostScreenState(
      user: user,
      post: post,
      dayfull: dayfull,
      day: day,
      category2: category,
      mnyinit: mnyinit);
}

class EditPostScreenState extends State<EditPostScreen>
    with SingleTickerProviderStateMixin {
  final User user;
  final Article post;
  final String category2;
  final String day;
  final String dayfull;
  final String mnyinit;
  EditPostScreenState({
    Key key,
    this.user,
    this.post,
    this.category2,
    this.day,
    this.dayfull,
    this.mnyinit,
  });

  final formKey = GlobalKey<FormState>();
  bool comments = false;
  bool stats = false;
  bool disablecomments = false;
  bool disablestats = false;
  int _column1 = 0;
  int _column2 = 0;
  bool done = false;
  String globaltxt = '';
  TextEditingController location = TextEditingController();
  TextEditingController caption = TextEditingController();
  TextEditingController details = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController deliveryfee = TextEditingController();
  TextEditingController etatime = TextEditingController();
  TextEditingController _tags = TextEditingController();
  final TextEditingController checkintime = TextEditingController();
  final TextEditingController checkouttime = TextEditingController();
  final TextEditingController startdate = TextEditingController();
  final TextEditingController enddate = TextEditingController();
  final TextEditingController readtime = TextEditingController();
  final TextEditingController deliveredfromtime = TextEditingController();
  final TextEditingController deliveredtotime = TextEditingController();
  final TextEditingController specialinstructions = TextEditingController();
  final TextEditingController guide = TextEditingController();
  final TextEditingController pricecurrency = TextEditingController();
  final TextEditingController pricetype = TextEditingController();
  final TextEditingController adults = TextEditingController();
  final TextEditingController kids = TextEditingController();
  final TextEditingController bedrooms = TextEditingController();
  final TextEditingController bathrooms = TextEditingController();
  final TextEditingController productcondition = TextEditingController();

  List<String> tagsfinal = [''];
  List<User> usertagsfinal = [];
  List<DetailCategoryModel> detailcategories = [];
  List<DetailSpecModel> detailspecs = [];

  List<ActivityModel> activities = [];
  List<HighlightModel> highlights = [];
  List<TravelLocationModel> travellocations = [];
  List<AmenityModel> amenities = []; //UP

  List<DetailIncludedModel> detailincludeds = [];
  List<DetailRuleModel> detailrules = [];
  List<CheckBoxModel> checkboxes = [];
  List<FormModel> forms = [];

  bool searching = false;
  List<User> _users = List<User>();
  List<User> _usersForDisplay = List<User>();
  var _textfield = TextEditingController();
  final picker = ImagePicker();
  int page = 1;
  List<Article> posts = [];
  Future fetchPostsfuture;
  bool isLoading = false;
  String editor(String original) {
    return original;
  }

  String tagsinit() {
    tagsfinal = _tags.text.split(',');
  }

  Future _loadData() async {
    List<User> postsinit = [];
    postsinit = await FetchTagusers(globaltxt, page + 1);
    setState(() {
      page = page + 1;
      _usersForDisplay.addAll(postsinit);
      isLoading = false;
      return;
    });
  }

  bool istagged(User user) {
    for (int i = 0; i < post.usertags.length; i++) {
      if (post.usertags[i].profile == user.id) {
        return true;
      }
    }
    for (int i = 0; i < taggedusers.length; i++) {
      if (taggedusers[i].id == user.id) {
        return true;
      }
    }
    return false;
  }

  void init() {
    if (done) {
      return;
    }
    location.text = '${post.location()}';
    caption.text = post.caption;
    details.text = post.details;
    category.text = post.category;
    productcondition.text = post.productcondition;
    if (isintnull(post.price)) {
      price.text = '';
    }
    if (isintnull(post.stock)) {
      stock.text = '';
    }
    if (isstringnull(post.deliveryfee)) {
      deliveryfee.text = '';
    }
    if (isintnull(post.price) == false) {
      price.text = post.price.toString();
    }
    if (isintnull(post.stock) == false) {
      stock.text = post.stock.toString();
    }
    if (isstringnull(post.deliveryfee) == false) {
      deliveryfee.text = post.deliveryfee.toString();
    }
    post.initeditbool();
    done = true;
    return;
  }

  @override
  void initState() {
    FetchTagusers(globaltxt, page + 1).then((value) {
      setState(() {
        _users.addAll(value);
        _usersForDisplay = _users;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      backgroundColor: colordtmainone,
      appBar: new AppBar(
        backgroundColor: colordtmainone,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 30.0,
          color: colordtmaintwo,
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.reorder),
              iconSize: MediaQuery.of(context).size.height * 0.0425,
              color: colordtmaintwo,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CalendarEventEditChoiceScreen(
                      product: post,
                    ),
                  ),
                );
              }),
          IconButton(
              icon: Icon(Icons.reorder),
              iconSize: MediaQuery.of(context).size.height * 0.0425,
              color: colordtmaintwo,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserProductEditDetailCategoryScreen(
                      product: post,
                    ),
                  ),
                );
              }),
          IconButton(
            icon: Icon(Icons.location_on),
            iconSize: 30.0,
            color: colordtmaintwo,
            onPressed: () {
              ChooseLocation(context);
            },
          ),
        ],
        title: Text(
          editpostst,
          style: TextStyle(
            color: colordtmaintwo,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    post.category == 'D'
                        ? Container(
                            height: 0,
                            width: 0,
                          )
                        : (post.category == 'E'
                            ? Container(
                                child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Container(
                                    child: Chewie(
                                      controller: ChewieController(
                                        videoPlayerController:
                                            VideoPlayerController.network(
                                                'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'),
                                        aspectRatio: 8 / 15,
                                        autoInitialize: true,
                                        autoPlay: true,
                                        looping: true,
                                        errorBuilder: (context, errorMessage) {
                                          return Center(
                                            child: Text(
                                              errorMessage,
                                              style: TextStyle(
                                                  color: colordtmainone),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                  ),
                                ),
                              ))
                            : Center(
                                child: SizedBox(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          decoration: BoxDecoration(
                                            color: colordtmainone,
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Carousel(
                                            images: post.images
                                                .map((post) =>
                                                    post.carouselimages())
                                                .toList(),
                                            autoplay: false,
                                            defaultImage: NetworkImage(
                                                'https://t4.ftcdn.net/jpg/02/07/87/79/360_F_207877921_BtG6ZKAVvtLyc5GWpBNEIlIxsffTtWkv.jpg'),
                                            dotPosition:
                                                DotPosition.bottomCenter,
                                            onImageTap: (index) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      ViewImageScreen(
                                                    image: post
                                                        .images[index].image,
                                                  ),
                                                ),
                                              );
                                            },
                                            dotSize: 5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.01,
                      right: MediaQuery.of(context).size.width * 0.01),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.023,
                        vertical: MediaQuery.of(context).size.height * 0.013),
                    decoration: BoxDecoration(
                      color: colordtmainone,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: TextFormField(
                        style: TextStyle(color: colordtmaintwo),
                        controller: caption,
                        maxLength: 250,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: captionst,
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: colordtmaintwo),
                        ),
                      ),
                    ),
                  ),
                ),
                if (post.type != 'A')
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: details,
                          maxLength: 64000,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          maxLines: 20,
                          minLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: detailsst,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (post.type == 'UP')
                  CheckboxListTile(
                    title: Text(isdeliveredst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.w400)),
                    value: post.isdeliveredinit,
                    onChanged: (bool value) {
                      setState(() {
                        post.isdeliveredinit = value;
                      });
                    },
                    secondary: const Icon(Icons.add_comment),
                  ),
                if (post.isdelivered)
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: deliveryfee,
                          keyboardType: TextInputType.number,
                          maxLength: 15,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: deliveryfeest,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (post.isdelivered)
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: etatime,
                          maxLength: 15,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: etatimest,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (post.type != 'A')
                  CheckboxListTile(
                    title: Text(isbuyenabledst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.w400)),
                    value: post.isbuyenabledinit,
                    onChanged: (bool value) {
                      setState(() {
                        post.isbuyenabledinit = value;
                      });
                    },
                    secondary: const Icon(Icons.shopping_cart),
                  ),
                if (post.isbuyenabled)
                  CheckboxListTile(
                    title: Text(allowstocksst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.w400)),
                    value: post.allowstocksinit,
                    onChanged: (bool value) {
                      setState(() {
                        post.allowstocksinit = value;
                      });
                    },
                    secondary: const Icon(Icons.add_comment),
                  ),
                if ((post.allowstocks) && (post.isbuyenabled))
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: stock,
                          keyboardType: TextInputType.number,
                          maxLength: 15,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: stockst,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                    vertical: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                    decoration: BoxDecoration(
                      color: colordtmainone,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: TextFormField(
                        style: TextStyle(color: colordtmaintwo),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,

                          labelText: posttagsst,
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: colordtmaintwo),
                          hintText: eyposttagsst,
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: colordtmaintwo),
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        controller: _tags,
                        onChanged: (tags) {
                          setState(() {
                            tagsinit();
                          });
                        },
                      ),
                    ),
                  ),
                ),
                if (post.type != 'A')
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: price,
                          keyboardType: TextInputType.number,
                          maxLength: 15,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: pricest,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (post.type == 'R' && post.type == 'UP')
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: checkintime,
                          keyboardType: TextInputType.number,
                          maxLength: 15,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: checkintimest,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ), //checkintime
                if (post.type == 'R' && post.type == 'UP')
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: checkouttime,
                          keyboardType: TextInputType.number,
                          maxLength: 15,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: checkouttimest,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ), //checkouttime
                if (post.type == 'R' && post.type == 'UP')
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: startdate,
                          keyboardType: TextInputType.datetime,
                          maxLength: 30,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: startdatest,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ), //startdate
                if (post.type == 'R' && post.type == 'UP')
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: enddate,
                          keyboardType: TextInputType.datetime,
                          maxLength: 30,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: enddatest,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ), //enddate
                if (post.type != 'A')
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: readtime,
                          maxLength: 30,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: readtimest,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ), //readtime
                if (post.type == 'UP')
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: deliveredfromtime,
                          keyboardType: TextInputType.number,
                          maxLength: 30,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: deliveredfromtimest,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ), //deliveredfromtime
                if (post.type == 'UP')
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: deliveredtotime,
                          keyboardType: TextInputType.number,
                          maxLength: 30,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: deliveredtotimest,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ), //deliveredtotime
                if (post.type != 'A')
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: specialinstructions,
                          maxLength: 5000,
                          maxLines: 200,
                          minLines: 1,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: specialinstructionsst,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ), //specialinstructions
                if (post.type != 'A')
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: guide,
                          maxLength: 5000,
                          maxLines: 200,
                          minLines: 1,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: guidest,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ), //guide
                if (post.type != 'A')
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: pricecurrency,
                          maxLength: 15,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: pricecurrencyst,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ), //pricecurrency
                if (post.type != 'A')
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: adults,
                          keyboardType: TextInputType.number,
                          maxLength: 15,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: adultsst,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ), //adults
                if (post.type != 'A')
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: kids,
                          keyboardType: TextInputType.number,
                          maxLength: 15,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: kidsst,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ), //kids
                if (post.type != 'UP')
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: bathrooms,
                          keyboardType: TextInputType.number,
                          maxLength: 15,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: bathroomsst,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ), //bathrooms
                if (post.type != 'UP')
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: bedrooms,
                          keyboardType: TextInputType.number,
                          maxLength: 15,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: bedroomsst,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ), //bedrooms
                if (post.type != 'UP')
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: productcondition,
                          maxLength: 50,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: bedroomsst,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ), //bedrooms
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                    vertical: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical:
                                MediaQuery.of(context).size.width * 0.015),
                        decoration: BoxDecoration(
                          color: colordtmainone,
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.height * 0.015),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.015),
                          child: Form(
                            child: TextFormField(
                              style: TextStyle(color: colordtmaintwo),
                              controller: _textfield,
                              decoration: InputDecoration(
                                hintText: taguserssst,
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: colordtmaintwo),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.people,
                                      color: colordtmaintwo,
                                      size: MediaQuery.of(context).size.width *
                                          0.065),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            CreatePostTaggedUserScreen(
                                          user: user,
                                          article: post,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              onChanged: (_textfield) {
                                _textfield == ''
                                    ? setState(() {
                                        searching = false;
                                      })
                                    : setState(() {
                                        searching = true;
                                      });
                                setState(() {
                                  globaltxt = _textfield;
                                  _users = [];
                                  _usersForDisplay = [];
                                  SearchUsersNew2(
                                          page,
                                          _textfield.toLowerCase(),
                                          _textfield.toLowerCase().split(','),
                                          false,
                                          false)
                                      .then((value) {
                                    setState(() {
                                      _users.addAll(value);
                                      _usersForDisplay = _users;
                                    });
                                  });
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(
                  height:
                      searching == false ? 0 : _usersForDisplay.length * 80.0,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!isLoading &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        _loadData();
                        setState(() {
                          isLoading = true;
                        });
                        return true;
                      }
                    },
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return searching == false
                            ? Container(
                                height: 0,
                                width: 0,
                              )
                            : _listItemUser(index);
                      },
                      itemCount: _usersForDisplay.length,
                    ),
                  ),
                ),
                Tags(
                  key: Tagstatekeys._tagStateKey1,
                  columns: _column1,
                  itemCount: tagsfinal.length,
                  itemBuilder: (i) {
                    return tagsfinal[i] == ''
                        ? Container(
                            height: 0,
                            width: 0,
                          )
                        : ItemTags(
                            key: Key(i.toString()),
                            index: i,
                            title: tagsfinal[i].toString(),
                            color: Color(0xFFEEEEEE),
                            activeColor: Color(0xFFEEEEEE),
                            textActiveColor: colordtmaintwo,
                            textStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.018,
                              color: colordtmaintwo,
                            ),
                          );
                  },
                ),
                SizedBox(height: 20),
                Tags(
                  key: Tagstatekeys._tagStateKey2,
                  columns: _column2,
                  itemCount: post.tags.length,
                  itemBuilder: (i) {
                    return ItemTags(
                      removeButton: ItemTagsRemoveButton(
                        onRemoved: () {
                          setState(() {
                            DeleteArticleTags(post.tags[i].id);
                            post.tags.removeAt(i);
                          });
                          return true;
                        },
                      ), // OR null

                      key: Key(i.toString()),
                      index: i,
                      title: post.tags[i].tag.toString(),
                      color: Color(0xFFEEEEEE),
                      activeColor: Color(0xFFEEEEEE),
                      textActiveColor: colordtmaintwo,
                      textStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.018,
                        color: colordtmaintwo,
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                Tags(
                  key: Tagstatekeys._tagStateKey3,
                  columns: _column2,
                  itemCount: post.usertags.length,
                  itemBuilder: (i) {
                    return ItemTags(
                      removeButton: ItemTagsRemoveButton(
                        onRemoved: () {
                          setState(() {
                            DeleteArticleUserTags(post.usertags[i].id);
                            post.usertags.removeAt(i);
                          });
                          return true;
                        },
                      ), // OR null

                      key: Key(i.toString()),
                      index: i,
                      title: post.usertags[i].username.toString(),
                      color: Color(0xFFEEEEEE),
                      activeColor: Color(0xFFEEEEEE),
                      textActiveColor: colordtmainthree,
                      textStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.018,
                        color: colordtmaintwo,
                      ),
                    );
                  },
                ),

                Divider(
                  color: colordtmaintwo,
                ),

                if (post.forms.length > 0)
                  Text(
                    formsst,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.bold),
                  ),
                for (final item in post.forms)
                  if (item.notshow != true)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${item.content}',
                          style: TextStyle(color: colordtmaintwo),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete,
                              color: colordtmaintwo,
                              size: MediaQuery.of(context).size.width * 0.065),
                          onPressed: () {
                            DeleteArticleForm(item.id);
                            setState(() {
                              item.notshow = true;
                            });
                          },
                        ),
                      ],
                    ),
                if (post.forms.length > 0)
                  Divider(
                    color: colordtmaintwo,
                  ),

                if (post.checkboxes.length > 0)
                  Text(
                    'Checkboxes',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.bold),
                  ),
                for (final item in post.checkboxes)
                  if (item.notshow != true)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${item.content}',
                          style: TextStyle(color: colordtmaintwo),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete,
                              color: colordtmaintwo,
                              size: MediaQuery.of(context).size.width * 0.065),
                          onPressed: () {
                            DeleteArticleCheckbox(item.id);
                            setState(() {
                              item.notshow = true;
                            });
                          },
                        ),
                      ],
                    ),
                if (post.checkboxes.length > 0)
                  Divider(
                    color: colordtmaintwo,
                  ),

                if (post.highlights.length > 0)
                  Text(
                    highlightsst,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.bold),
                  ),
                for (final item in post.highlights)
                  if (item.notshow != true)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${item.highlight}',
                          style: TextStyle(color: colordtmaintwo),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete,
                              color: colordtmaintwo,
                              size: MediaQuery.of(context).size.width * 0.065),
                          onPressed: () {
                            DeleteArticleHighlight(item.id);
                            setState(() {
                              item.notshow = true;
                            });
                          },
                        ),
                      ],
                    ),
                if (post.highlights.length > 0)
                  Divider(
                    color: colordtmaintwo,
                  ),

                if (post.detailamenities.length > 0)
                  Text(
                    amenitiesst,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.bold),
                  ),
                for (final item in post.detailamenities)
                  if (item.notshow != true)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${item.amenity}',
                          style: TextStyle(color: colordtmaintwo),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete,
                              color: colordtmaintwo,
                              size: MediaQuery.of(context).size.width * 0.065),
                          onPressed: () {
                            DeleteArticleAmenity(item.id);
                            setState(() {
                              item.notshow = true;
                            });
                          },
                        ),
                      ],
                    ),
                if (post.detailamenities.length > 0)
                  Divider(
                    color: colordtmaintwo,
                  ),

                if (post.detailrules.length > 0)
                  Text(
                    rulesst,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.bold),
                  ),
                for (final item in post.detailrules)
                  if (item.notshow != true)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${item.rule}',
                          style: TextStyle(color: colordtmaintwo),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete,
                              color: colordtmaintwo,
                              size: MediaQuery.of(context).size.width * 0.065),
                          onPressed: () {
                            DeleteArticleDetailRule(item.id);
                            setState(() {
                              item.notshow = true;
                            });
                          },
                        ),
                      ],
                    ),
                if (post.detailrules.length > 0)
                  Divider(
                    color: colordtmaintwo,
                  ),

                if (post.detailincludeds.length > 0)
                  Text(
                    includedst,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.bold),
                  ),
                for (final item in post.detailincludeds)
                  if (item.notshow != true)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${item.included}',
                          style: TextStyle(color: colordtmaintwo),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete,
                              color: colordtmaintwo,
                              size: MediaQuery.of(context).size.width * 0.065),
                          onPressed: () {
                            DeleteArticleDetailIncluded(item.id);
                            setState(() {
                              item.notshow = true;
                            });
                          },
                        ),
                      ],
                    ),
                if (post.detailincludeds.length > 0)
                  Divider(
                    color: colordtmaintwo,
                  ),

                if (post.travellocations.length > 0)
                  Text(
                    travellocationsst,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.bold),
                  ),
                for (final item in post.travellocations)
                  if (item.notshow != true)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${item.location}',
                          style: TextStyle(color: colordtmaintwo),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete,
                              color: colordtmaintwo,
                              size: MediaQuery.of(context).size.width * 0.065),
                          onPressed: () {
                            DeleteArticleTravelLocation(item.id);
                            setState(() {
                              item.notshow = true;
                            });
                          },
                        ),
                      ],
                    ),
                if (post.travellocations.length > 0)
                  Divider(
                    color: colordtmaintwo,
                  ),

                if (post.activities.length > 0)
                  Text(
                    activitiesst,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.bold),
                  ),
                for (final item in post.activities)
                  if (item.notshow != true)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${item.activity}',
                          style: TextStyle(color: colordtmaintwo),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete,
                              color: colordtmaintwo,
                              size: MediaQuery.of(context).size.width * 0.065),
                          onPressed: () {
                            DeleteArticleActivity(item.id);
                            setState(() {
                              item.notshow = true;
                            });
                          },
                        ),
                      ],
                    ),
                if (post.activities.length > 0)
                  Divider(
                    color: colordtmaintwo,
                  ),

                if (post.type == 'CE')
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: ElevatedButton(
                      child: Text(
                        addactivityst,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          ActivityModel model = ActivityModel(
                              item: TextEditingController(text: ""));
                          activities.add(model);
                        });
                      },
                    ),
                  ),
                for (final item in activities)
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: item.item,
                          maxLength: 500,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: enteractivitytextst,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (post.type != 'A')
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: ElevatedButton(
                      child: Text(
                        adddetailincludedst,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          DetailIncludedModel model = DetailIncludedModel(
                              item: TextEditingController(text: ""));
                          detailincludeds.add(model);
                        });
                      },
                    ),
                  ),
                for (final item in detailincludeds)
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: item.item,
                          maxLength: 500,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: enterdetailincludedtextst,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (post.type != 'A')
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: ElevatedButton(
                      child: Text(
                        addrulesst,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          DetailRuleModel model = DetailRuleModel(
                              item: TextEditingController(text: ""));
                          detailrules.add(model);
                        });
                      },
                    ),
                  ),
                for (final item in detailrules)
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: item.item,
                          maxLength: 500,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: enterdetailrulestextst,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (post.type == 'UP' || post.type == 'R')
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: ElevatedButton(
                      child: Text(
                        addamenitiesst,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          AmenityModel model = AmenityModel(
                              item: TextEditingController(text: ""));
                          amenities.add(model);
                        });
                      },
                    ),
                  ),
                for (final item in amenities)
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: item.item,
                          maxLength: 500,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: enteramenitytextst,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (post.type != 'A')
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: ElevatedButton(
                      child: Text(
                        addhighlightsst,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          HighlightModel model = HighlightModel(
                              item: TextEditingController(text: ""));
                          highlights.add(model);
                        });
                      },
                    ),
                  ),
                for (final item in highlights)
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: item.item,
                          maxLength: 500,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: enterhighlighttextst,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (post.type == 'US')
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: ElevatedButton(
                      child: Text(
                        addformst,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          FormModel model =
                              FormModel(hint: TextEditingController(text: ""));
                          forms.add(model);
                        });
                      },
                    ),
                  ),
                if (post.type == 'US')
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: ElevatedButton(
                      child: Text(
                        addcheckboxst,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          CheckBoxModel model = CheckBoxModel(
                              hint: TextEditingController(text: ""));
                          checkboxes.add(model);
                        });
                      },
                    ),
                  ),
                for (final item in checkboxes)
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: item.hint,
                          maxLength: 500,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: entercheckboxtextst,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ),
                for (final item in forms)
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: item.hint,
                          maxLength: 500,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: enterformtextst,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (post.type == 'R')
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: ElevatedButton(
                      child: Text(
                        addtravellocationsst,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          TravelLocationModel model = TravelLocationModel(
                              item: TextEditingController(text: ""));
                          travellocations.add(model);
                        });
                      },
                    ),
                  ),
                for (final item in travellocations)
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: item.item,
                          maxLength: 500,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: entertravellocationtextst,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ),

                if (post.isbuyenabledinit && post.allowstocksinit)
                  CheckboxListTile(
                    title: Text(hideifoutofstockst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.w400)),
                    value: post.hideifoutofstockinit,
                    onChanged: (bool value) {
                      setState(() {
                        post.hideifoutofstockinit = value;
                      });
                    },
                    secondary: Icon(Icons.add_comment, color: colordtmaintwo),
                  ),
                CheckboxListTile(
                  title: Text(sensitivest,
                      style: TextStyle(
                          color: colordtmaintwo, fontWeight: FontWeight.w400)),
                  value: post.sensitiveinit,
                  onChanged: (bool value) {
                    setState(() {
                      post.sensitiveinit = value;
                    });
                  },
                  secondary: const Icon(Icons.add_comment),
                ),
                CheckboxListTile(
                  title: Text(spoilerst,
                      style: TextStyle(
                          color: colordtmaintwo, fontWeight: FontWeight.w400)),
                  value: post.spoilerinit,
                  onChanged: (bool value) {
                    setState(() {
                      post.spoilerinit = value;
                    });
                  },
                  secondary: const Icon(Icons.add_comment),
                ),

                CheckboxListTile(
                  title: Text(disablecommentsst,
                      style: TextStyle(
                          color: colordtmaintwo, fontWeight: FontWeight.w400)),
                  value: post.allowcommentsinit,
                  onChanged: (bool value) {
                    setState(() {
                      post.allowcommentsinit = value;
                    });
                  },
                  secondary: const Icon(Icons.add_comment),
                ),
                CheckboxListTile(
                  title: Text(disablestatsst,
                      style: TextStyle(
                          color: colordtmaintwo, fontWeight: FontWeight.w400)),
                  value: post.anonymity,
                  onChanged: (bool value) {
                    setState(() {
                      post.anonymityinit = value;
                    });
                  },
                  secondary: const Icon(Icons.format_list_numbered),
                ),

                if (post.isbuyenabledinit && post.allowstocksinit)
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.01),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.023,
                          vertical: MediaQuery.of(context).size.height * 0.013),
                      decoration: BoxDecoration(
                        color: colordtmainone,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextFormField(
                          style: TextStyle(color: colordtmaintwo),
                          controller: stock,
                          maxLength: 15,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: stockst,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (post.isbuyenabledinit && post.allowstocksinit)
                  CheckboxListTile(
                    title: Text(hideifoutofstockst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.w400)),
                    value: post.hideifoutofstockinit,
                    onChanged: (bool value) {
                      setState(() {
                        post.hideifoutofstockinit = value;
                      });
                    },
                    secondary: Icon(Icons.add_comment, color: colordtmaintwo),
                  ),
                if (post.type != 'A')
                  CheckboxListTile(
                    title: Text(isdeliveredst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.w400)),
                    value: post.isdeliveredinit,
                    onChanged: (bool value) {
                      setState(() {
                        post.isdeliveredinit = value;
                      });
                    },
                    secondary: Icon(Icons.add_comment, color: colordtmaintwo),
                  ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.025),

                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ElevatedButton(
                    child: Text(donest),
                    onPressed: () {
                      setState(() {
                        print(price.text);
                        int finaladults =
                            adults.text == '' ? 0 : int.parse(adults.text);
                        int finalkids =
                            kids.text == '' ? 0 : int.parse(kids.text);
                        int finalbathrooms = bathrooms.text == ''
                            ? 0
                            : int.parse(bathrooms.text);
                        int finalbedrooms =
                            bedrooms.text == '' ? 0 : int.parse(bedrooms.text);

                        int stockfinal =
                            stock.text == '' ? 0 : int.parse(stock.text);
                        int pricefinal =
                            price.text == '' ? 0 : int.parse(price.text);
                        int deliveryfeefinal = deliveryfee.text == ''
                            ? 0
                            : int.parse(deliveryfee.text);
                        EditArticle(
                            caption.text,
                            details.text,
                            _tags.text,
                            usertagsfinal,
                            post,
                            stockfinal,
                            deliveryfeefinal,
                            etatime.text,
                            pricefinal,
                            post.allowcommentsinit,
                            post.anonymityinit,
                            post.isbuyenabledinit,
                            post.isdeliveredinit,
                            post.sensitiveinit,
                            post.spoilerinit,
                            post.allowstocksinit,
                            post.isimagerequiredinit,
                            post.hideifoutofstockinit,
                            post.isforstayinit,
                            post.isquestioninit,
                            checkintime.text,
                            checkouttime.text,
                            startdate.text,
                            enddate.text,
                            readtime.text,
                            deliveredfromtime.text,
                            deliveredtotime.text,
                            specialinstructions.text,
                            guide.text,
                            pricecurrency.text,
                            pricetype.text,
                            finaladults,
                            finalkids,
                            finalbathrooms,
                            finalbedrooms,
                            productcondition.text);
                      });

                      for (int i = 0; i < activities.length; i++) {
                        CreateArticleActivity(
                            user.id, post.id, activities[i].item.text);
                      }

                      for (int i = 0; i < detailincludeds.length; i++) {
                        CreateArticleDetailIncluded(
                            post.id, detailincludeds[i].item.text);
                      }

                      for (int i = 0; i < detailrules.length; i++) {
                        CreateArticleDetailRule(
                            post.id, detailrules[i].item.text);
                      }

                      for (int i = 0; i < amenities.length; i++) {
                        CreateArticleAmenity(post.id, amenities[i].item.text);
                      }

                      for (int i = 0; i < highlights.length; i++) {
                        CreateArticleHighlight(
                            post.id, highlights[i].item.text);
                      }

                      for (int i = 0; i < travellocations.length; i++) {
                        CreateArticleTravelLocation(
                            post.id, travellocations[i].item.text);
                      }

                      for (int i = 0; i < checkboxes.length; i++) {
                        CreateUserServiceCheckBox(
                            user.id, post.id, checkboxes[i].hint.text);
                      }
                      for (int i = 0; i < forms.length; i++) {
                        CreateUserServiceForms(
                            user.id, post.id, forms[i].hint.text);
                      }
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _listItemUser(index) {
    return _usersForDisplay[index].id == user.id
        ? Container(
            height: 0,
            width: 0,
          )
        : (istagged(_usersForDisplay[index])
            ? Container(
                height: 0,
                width: 0,
              )
            : InkWell(
                child: Container(
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.03),
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height * 0.01,
                      vertical: MediaQuery.of(context).size.width * 0.024),
                  child: ListTile(
                    title: CircleAvatar(
                      radius: MediaQuery.of(context).size.height * 0.045,
                      backgroundImage: NetworkImage(_usersForDisplay[index]
                                  .image ==
                              null
                          ? 'https://st2.depositphotos.com/4111759/12123/v/600/depositphotos_121233262-stock-illustration-male-default-placeholder-avatar-profile.jpg'
                          : _usersForDisplay[index].image),
                    ),
                    trailing: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.66,
                      child: Text(
                        _usersForDisplay[index].username,
                        style: TextStyle(
                          color: colordtmaintwo,
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        taggedusers.add(_usersForDisplay[index]);
                      });
                    },
                  ),
                ),
              ));
  }
}

class CreatePostTaggedUserScreen extends StatefulWidget {
  final User user;
  final Article article;
  const CreatePostTaggedUserScreen({Key key, this.user, this.article})
      : super(key: key);

  @override
  CreatePostTaggedUserScreenState createState() =>
      CreatePostTaggedUserScreenState(user: user, article: article);
}

class CreatePostTaggedUserScreenState
    extends State<CreatePostTaggedUserScreen> {
  final User user;
  final Article article;
  CreatePostTaggedUserScreenState({Key key, this.user, this.article});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: taggedusers.length * 80.0,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.03),
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.height * 0.01,
                        vertical: MediaQuery.of(context).size.width * 0.024),
                    child: ListTile(
                      title: CircleAvatar(
                        radius: MediaQuery.of(context).size.height * 0.045,
                        backgroundImage: NetworkImage(taggedusers[index]
                                    .image ==
                                null
                            ? 'https://st2.depositphotos.com/4111759/12123/v/600/depositphotos_121233262-stock-illustration-male-default-placeholder-avatar-profile.jpg'
                            : taggedusers[index].image),
                      ),
                      trailing: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.66,
                        child: Text(
                          taggedusers[index].username,
                          style: TextStyle(
                            color: colordtmaintwo,
                            fontSize: MediaQuery.of(context).size.height * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          taggedusers.remove(taggedusers[index]);
                        });
                      },
                    ),
                  ),
                );
              },
              itemCount: taggedusers.length,
            ),
          ),
          SizedBox(
              height: article.usertags.length * 80.0,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.03),
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.height * 0.01,
                          vertical: MediaQuery.of(context).size.width * 0.024),
                      child: ListTile(
                        title: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.66,
                          child: Text(
                            article.usertags[index].username,
                            style: TextStyle(
                              color: colordtmaintwo,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            DeleteArticleUserTags(article.usertags[index].id);
                          });
                        },
                      ),
                    ),
                  );
                },
                itemCount: article.usertags.length,
              )),
        ],
      ),
    );
  }
}
