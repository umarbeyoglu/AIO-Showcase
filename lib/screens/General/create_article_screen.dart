import 'dart:async';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../colors.dart';
import '../../language.dart';
import '../../models/Article_Model/article_model.dart';
import '../../models/User_Model/user_model.dart';
import '../../repository.dart';
import '../Calendar_Screen/calendar_screen.dart';
import '../Profile_Screen/profile_image_screen.dart';
import 'choice_screen.dart';
import 'home_screen.dart';
import 'memes_screen.dart';

class Tagstatekeys {
  static final _tagStateKey1 = const Key('__TSK1__');
}

String ceday = '';
String articlecreatecategory = '';

List<ActivityModel> activities = [];
List<HighlightModel> highlights = [];
List<TravelLocationModel> travellocations = [];
List<AmenityModel> amenities = [];
List<DetailIncludedModel> detailincludeds = [];
List<DetailRuleModel> detailrules = [];
List<CheckBoxModel> checkboxes = [];
List<FormModel> forms = [];

class CreateArticleScreen extends StatefulWidget {
  final User user;
  final Article post;
  final String type;
  CreateArticleScreen({
    Key key,
    this.user,
    this.type,
    this.post,
  }) : super(key: key);

  @override
  CreateArticleScreenState createState() =>
      CreateArticleScreenState(user: user, post: post, type: type);
}

class CreateArticleScreenState extends State<CreateArticleScreen> {
  final User user;
  final Article post;
  final String type;
  CreateArticleScreenState({Key key, this.type, this.user, this.post});

  set _imageFile(PickedFile value) {
    _imageFileList = value == null ? null : [value];
  }

  List<PickedFile> _imageFileList;
  int _column = 0;
  List<String> items = [];
  final TextEditingController item = TextEditingController();
  String itemchosen1 = '';
  final TextEditingController details = TextEditingController();
  final TextEditingController tags = TextEditingController();
  List<String> tagsfinal = [''];
  final TextEditingController deliveryfee = TextEditingController();
  final TextEditingController etatime = TextEditingController();
  bool allowstocks = false;
  bool isdelivered = false;
  final ImagePicker _picker = ImagePicker();
  dynamic _pickImageError;
  bool isVideo = false;
  VideoPlayerController _controller;
  VideoPlayerController _toBeDisposed;
  final TextEditingController price = TextEditingController();
  List<File> pickedimages;
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();
  File video;
  bool disablecomments = false;
  bool disablestats = false;
  var _textfield = TextEditingController();
  bool searching2 = false;
  bool isbuyenabled = false;
  final TextEditingController stock = TextEditingController();

  bool isimagerequired = false;
  File image;
  bool imageselected = false;
  List<Path> pathimages;
  // ignore: deprecated_member_use
  List<File> images = List<File>();
  String articleid;
  String createpostgroupid;
  bool everythingfine = false;
  bool ispromovideo = false;
  bool waiting = true;
  final formKey = GlobalKey<FormState>();
  bool allowcalls = false;
  bool allowmessaging = false;
  bool done = false;
  bool businessatt = false;
  int postcheck = 0;
  bool isjobposting = false;
  bool isnstl = false;
  bool isnsfw = false;
  bool issensitive = false;
  bool isspoiler = false;
  final TextEditingController location = TextEditingController();
  final TextEditingController caption = TextEditingController();
  final TextEditingController details2 = TextEditingController();
  final TextEditingController name = TextEditingController();
  String maincategory = '';
  String _retrieveDataError;
  bool searching = false;
  bool firsttime11 = false;
  List<User> _users = List<User>();
  List<User> _usersForDisplay = List<User>();
  ScrollController _scrollController = ScrollController();
  int page = 1;
  String globaltxt = '';
  List<Article> posts = [];
  Future fetchPostsfuture;
  bool isLoading = false;

  bool hideifoutofstock = false;
  bool isforstay = false;
  bool isquestion = false;

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
  final TextEditingController productcondition = TextEditingController();
  final TextEditingController bedrooms = TextEditingController();
  final TextEditingController bathrooms = TextEditingController();

  bool istagged(User user) {
    for (int i = 0; i < taggedusers.length; i++) {
      if (taggedusers[i].id == user.id) {
        return true;
      }
    }
    return false;
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

  Future<void> _playVideo(PickedFile file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      VideoPlayerController controller;
      if (kIsWeb) {
        controller = VideoPlayerController.network(file.path);
      } else {
        controller = VideoPlayerController.file(File(file.path));
      }
      _controller = controller;
      final double volume = kIsWeb ? 0.0 : 1.0;
      await controller.setVolume(volume);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      setState(() {});
    }
  }

  String tagsinit() {
    tagsfinal = tags.text.split(',');
  }

  bool isbusatt() {
    if (businessatt) {
      return true;
    }
    if (isjobposting) {
      return true;
    }
    return false;
  }

  void _onImageButtonPressed(ImageSource source,
      {BuildContext context, bool isMultiImage = false}) async {
    if (_controller != null) {
      await _controller.setVolume(0.0);
    }
    if (isVideo) {
      final PickedFile file = await _picker.getVideo(
          source: source, maxDuration: const Duration(seconds: 60));
      video = File(file.path);
      await _playVideo(file);
    } else if (isMultiImage) {
      try {
        final pickedFileList = await _picker.getMultiImage(
          imageQuality: 60,
        );
        setState(() {
          _imageFileList = pickedFileList;
          for (int i = 0; i < _imageFileList.length; i++) {
            pickedimages.add(File(_imageFileList[i].path));
          }
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller.setVolume(0.0);
      _controller.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _disposeVideoController();
    super.dispose();
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  Image carouselimages(PickedFile image) {
    return Image.file(File(image.path));
  }

  Widget _previewVideo() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_controller == null) {
      return Text(
        youhavenotyetpickedavideost,
        textAlign: TextAlign.center,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatioVideo(_controller),
    );
  }

  Widget _previewImages() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          color: colordtmainone,
        ),
        width: MediaQuery.of(context).size.width,
        child: Carousel(
          images:
              _imageFileList.map((peritem) => carouselimages(peritem)).toList(),
          autoplay: false,
          dotPosition: DotPosition.bottomCenter,
          onImageTap: (index) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ViewImageScreen(
                  image: post.images[index].image,
                ),
              ),
            );
          },
          dotSize: 5,
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        '$pickimageerrorst: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return Text(
        youhavenotyetpickedanimagest,
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _handlePreview() {
    if (isVideo) {
      return _previewVideo();
    } else {
      return _previewImages();
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        isVideo = true;
        await _playVideo(response.file);
      } else {
        isVideo = false;
        setState(() {
          _imageFile = response.file;
        });
      }
    } else {
      _retrieveDataError = response.exception.code;
    }
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

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  void _showSuccess() {
    print('success');
  }

  void _showError(String error) {
    print('error');
    return;
  }

  @override
  void initState() {
    print(detailcategories.length);
    FetchTagusers(globaltxt, page).then((value) {
      setState(() {
        _users.addAll(value);
        _usersForDisplay = _users;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colordtmainone,
      appBar: AppBar(
        backgroundColor: colordtmainone,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            iconSize: 30.0,
            color: colordtmaintwo,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreateArticleExtendedDetailsScreen(
                    user: user,
                    type: type,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.location_on),
            iconSize: 30.0,
            color: colordtmaintwo,
            onPressed: () {
              ChooseLocation(context);
            },
          ),
          IconButton(
            color: colordtmaintwo,
            onPressed: () {
              isVideo = false;

              _onImageButtonPressed(
                ImageSource.gallery,
                context: context,
                isMultiImage: true,
              );
            },
            tooltip: 'Pick Multiple Image from gallery',
            icon: Icon(Icons.photo_library),
          ),
          IconButton(
            color: colordtmaintwo,
            onPressed: () {
              isVideo = true;
              _onImageButtonPressed(ImageSource.gallery);
            },
            icon: Icon(Icons.video_library),
          ),
          IconButton(
            color: colordtmaintwo,
            onPressed: () {
              isVideo = true;
              _onImageButtonPressed(ImageSource.camera);
            },
            icon: Icon(Icons.videocam),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: waiting == true
                      ? MediaQuery.of(context).size.height * 0.5
                      : MediaQuery.of(context).size.height * 0.55,
                  child:
                      !kIsWeb && defaultTargetPlatform == TargetPlatform.android
                          ? FutureBuilder<void>(
                              future: retrieveLostData(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<void> snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                  case ConnectionState.waiting:
                                    return Text(
                                      youhavenotyetpickedanimageorvideost,
                                      textAlign: TextAlign.center,
                                    );
                                  case ConnectionState.done:
                                    return _handlePreview();
                                  default:
                                    if (snapshot.hasError) {
                                      return Text(
                                        '$pickimagevideoerrorst: ${snapshot.error}}',
                                        textAlign: TextAlign.center,
                                      );
                                    } else {
                                      return Text(
                                        youhavenotyetpickedanimagest,
                                        textAlign: TextAlign.center,
                                      );
                                    }
                                }
                              },
                            )
                          : _handlePreview(),
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

                if (type == 'UP')
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
                          maxLength: 200,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: productconditionst,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (type != 'A' && type != 'OFFER')
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
                if ((allowstocks) && (isbuyenabled))
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
                  ), //stock
                if (type != 'A' && type != 'OFFER')
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
                  ), //price
                if (type == 'R' && type == 'UP')
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
                if (type == 'R' && type == 'UP')
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
                if (type == 'R' && type == 'UP')
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
                if (type == 'R' && type == 'UP')
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
                if (type != 'A' && type != 'OFFER')
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
                if (type == 'UP')
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
                if (type == 'UP')
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
                if (type != 'A' && type != 'OFFER')
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
                if (type != 'A' && type != 'OFFER')
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
                if (type != 'A' && type != 'OFFER')
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
                if (type != 'A' && type != 'OFFER')
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
                if (type != 'A' && type != 'OFFER')
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
                if (type != 'UP' && type != 'A' && type != 'OFFER')
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
                if (type != 'UP' && type != 'A' && type != 'OFFER')
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
                if (type != 'UP' && type != 'A' && type != 'OFFER')
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
                            hintText: productconditionst,
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ),
                      ),
                    ),
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
                        controller: tags,
                        onChanged: (tags) {
                          setState(() {
                            tagsinit();
                          });
                        },
                        maxLength: 300,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: posttagsst,
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: colordtmaintwo),
                        ),
                      ),
                    ),
                  ),
                ),
                Tags(
                  key: Tagstatekeys._tagStateKey1,
                  columns: _column,
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
                            textColor: colordtmaintwo,
                            textActiveColor: colordtmaintwo,
                            textStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.018,
                              color: colordtmaintwo,
                            ),
                          );
                  },
                ),
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

                SizedBox(height: MediaQuery.of(context).size.height * 0.013),

                if (type == 'US')
                  CheckboxListTile(
                    title: Text(requireimagesst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.w400)),
                    value: isimagerequired,
                    onChanged: (bool value) {
                      setState(() {
                        isimagerequired = value;
                      });
                    },
                    secondary: Icon(Icons.add_comment, color: colordtmaintwo),
                  ), //requireimagesst
                if (type != 'A' && type != 'OFFER')
                  CheckboxListTile(
                    title: Text(isbuyenabledst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.w400)),
                    value: isbuyenabled,
                    onChanged: (bool value) {
                      setState(() {
                        isbuyenabled = value;
                      });
                    },
                    secondary: Icon(Icons.add_comment, color: colordtmaintwo),
                  ), //isbuyenabled
                if (isbuyenabled)
                  CheckboxListTile(
                    title: Text(allowstocksst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.w400)),
                    value: allowstocks,
                    onChanged: (bool value) {
                      setState(() {
                        allowstocks = value;
                      });
                    },
                    secondary: Icon(Icons.add_comment, color: colordtmaintwo),
                  ), //allowstocks

                if (isbuyenabled && allowstocks)
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
                  ), //stock
                if (isbuyenabled && allowstocks)
                  CheckboxListTile(
                    title: Text(hideifoutofstockst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.w400)),
                    value: hideifoutofstock,
                    onChanged: (bool value) {
                      setState(() {
                        hideifoutofstock = value;
                      });
                    },
                    secondary: Icon(Icons.add_comment, color: colordtmaintwo),
                  ), //hideifoutofstock
                if (type != 'A' && type != 'OFFER')
                  CheckboxListTile(
                    title: Text(isdeliveredst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.w400)),
                    value: isdelivered,
                    onChanged: (bool value) {
                      setState(() {
                        isdelivered = value;
                      });
                    },
                    secondary: Icon(Icons.add_comment, color: colordtmaintwo),
                  ), //isdelivered
                CheckboxListTile(
                  title: Text(disablecommentsst,
                      style: TextStyle(
                          color: colordtmaintwo, fontWeight: FontWeight.w400)),
                  value: disablecomments,
                  onChanged: (bool value) {
                    setState(() {
                      disablecomments = value;
                    });
                  },
                  secondary: Icon(Icons.add_comment, color: colordtmaintwo),
                ),
                CheckboxListTile(
                  title: Text(disablestatsst,
                      style: TextStyle(
                          color: colordtmaintwo, fontWeight: FontWeight.w400)),
                  value: disablestats,
                  onChanged: (bool value) {
                    setState(() {
                      disablestats = value;
                    });
                  },
                  secondary:
                      Icon(Icons.format_list_numbered, color: colordtmaintwo),
                ),

                CheckboxListTile(
                  title: Text(sensitivest,
                      style: TextStyle(
                          color: colordtmaintwo, fontWeight: FontWeight.w400)),
                  value: issensitive,
                  checkColor: Colors.white,
                  selectedTileColor: Colors.white,
                  onChanged: (bool value) {
                    setState(() {
                      issensitive = value;
                    });
                  },
                  secondary:
                      Icon(Icons.format_list_numbered, color: colordtmaintwo),
                ),
                CheckboxListTile(
                  title: Text(spoilerst,
                      style: TextStyle(
                          color: colordtmaintwo, fontWeight: FontWeight.w400)),
                  value: isspoiler,
                  onChanged: (bool value) {
                    setState(() {
                      isspoiler = value;
                    });
                  },
                  secondary:
                      Icon(Icons.format_list_numbered, color: colordtmaintwo),
                ),

                if (isdelivered)
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
                if (isdelivered)
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
                if (type == 'CE')
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: ElevatedButton(
                      child: Text(
                        choosedatest,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Calendar(
                                    user: user,
                                    calendarowner: user,
                                    issearch: false,
                                  )),
                        );
                      },
                    ),
                  ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ElevatedButton(
                    child: Text(publishst),
                    onPressed: () {
                      setState(() {
                        int finalprice =
                            price.text == '' ? 0 : int.parse(price.text);
                        int finalstock =
                            stock.text == '' ? 0 : int.parse(stock.text);
                        int finaldeliveryfee = deliveryfee.text == ''
                            ? 0
                            : int.parse(deliveryfee.text);

                        int finaladults =
                            adults.text == '' ? 0 : int.parse(adults.text);
                        int finalkids =
                            kids.text == '' ? 0 : int.parse(kids.text);
                        int finalbathrooms = bathrooms.text == ''
                            ? 0
                            : int.parse(bathrooms.text);
                        int finalbedrooms =
                            bedrooms.text == '' ? 0 : int.parse(bedrooms.text);
                        print('a: ${highlights.length}');

                        CreateArticle(
                            user,
                            caption.text,
                            details.text,
                            disablecomments,
                            disablestats,
                            issensitive,
                            isspoiler,
                            tags.text,
                            _imageFileList,
                            taggedusers,
                            false,
                            '',
                            video,
                            isjobposting,
                            articlecreatecategory,
                            finalprice,
                            isbuyenabled,
                            finalstock,
                            isdelivered,
                            finaldeliveryfee,
                            etatime.text,
                            allowstocks,
                            isimagerequired,
                            forms,
                            checkboxes,
                            type,
                            hideifoutofstock,
                            isforstay,
                            isquestion,
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
                            activities,
                            highlights,
                            travellocations,
                            amenities,
                            detailcategories,
                            [],
                            detailincludeds,
                            detailrules,
                            productcondition.text,
                            ceday);
                        if (type != 'A') {
                          Navigator.pop(context);
                        }
                        if (type == 'A') {
                          Future.delayed(new Duration(seconds: 1), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => HomeScreen(
                                  user: user,
                                ),
                              ),
                            );
                          });
                        }
                      });
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserProductCategoryCreateScreen extends StatefulWidget {
  final User user;
  const UserProductCategoryCreateScreen({Key key, this.user}) : super(key: key);
  @override
  UserProductCategoryCreateScreenState createState() =>
      UserProductCategoryCreateScreenState(user: user);
}

class UserProductCategoryCreateScreenState
    extends State<UserProductCategoryCreateScreen> {
  final User user;
  UserProductCategoryCreateScreenState({Key key, this.user});
  int _column = 0;
  List<String> items = [];
  String itemchosen1 = '';
  final TextEditingController item = TextEditingController();
  final TextEditingController details = TextEditingController();
  dynamic _pickImageError;
  bool isVideo = false;
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();
  List<User> _subusers = List<User>();
  List<User> _subusersForDisplay = List<User>();
  bool searching2 = false;
  var _textfield = TextEditingController();
  var _textfield2 = TextEditingController();
  File image;
  final picker = ImagePicker();

  pickFromCamera() async {
    final _image =
        await picker.getImage(source: ImageSource.camera, imageQuality: 80);

    setState(() {
      image = File(_image.path);
    });
  }

  pickFromPhone() async {
    final _image =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 80);

    setState(() {
      image = File(_image.path);
    });
  }

  void ischosen(String itemchosen) {
    for (int i = 0; i < items.length; i++) {
      if (items[i] == itemchosen) {
        items.removeAt(i);
        return;
      }
    }
    items.add(itemchosen);
    return;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            tooltip: tfphonest,
            icon: Icon(Icons.add_photo_alternate, color: colordtmaintwo),
            onPressed: () {
              pickFromPhone();
            },
          ),
        ],
      ),
      backgroundColor: colordtmainone,
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                        controller: item,
                        maxLength: 250,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: categoryst,
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: colordtmaintwo),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: ElevatedButton(
                    child: Text(
                      donest,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ),
                    onPressed: () {
                      if (image?.path == null) {
                        CreateUserProductCategory(item.text, user.id, null);
                        Navigator.pop(context);
                      }
                      if (image?.path != null) {
                        FileSizeLimitImage(image.path)
                          ..then((value) {
                            if (value) {
                              print('File too big to upload!');
                              return;
                            }
                            if (value == false) {
                              CreateUserProductCategory(
                                  item.text, user.id, image);
                            }
                          });

                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                SizedBox(height: 80),
              ])),
        ],
      ),
    );
  }
}

class CreateDetailCategoryScreen extends StatefulWidget {
  const CreateDetailCategoryScreen({
    Key key,
  }) : super(key: key);
  @override
  CreateDetailCategoryScreenState createState() =>
      CreateDetailCategoryScreenState();
}

class CreateDetailCategoryScreenState
    extends State<CreateDetailCategoryScreen> {
  CreateDetailCategoryScreenState({Key key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colordtmainone,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            iconSize: 30.0,
            color: colordtmaintwo,
            onPressed: () {
              setState(() {
                DetailCategoryModel model =
                    DetailCategoryModel(item: TextEditingController(text: ""));
                detailcategories.add(model);
              });
            },
          ),
        ],
      ),
      backgroundColor: colordtmainone,
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Text(
            'Detail Cat',
            style: TextStyle(color: Colors.black),
          ),
          for (final item in detailcategories)
            Column(
              children: [
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
                          helperText: 'Please Enter Category Title',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: colordtmaintwo),
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: colordtmaintwo,
                ),
                for (final item2 in item.detailspecs)
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Text(
                            'Item ${item2.item.text}',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.01,
                                  right:
                                      MediaQuery.of(context).size.width * 0.01),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.023,
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.013),
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
                                    controller: item2.item,
                                    maxLength: 15,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      helperText: 'Enter item description',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Text(
                            'Delete Spec',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            iconSize: 30.0,
                            color: colordtmaintwo,
                            onPressed: () {
                              setState(() {
                                item.detailspecs.remove(item2);
                              });
                            },
                          ),
                        ],
                      ),
                      Divider(
                        color: colordtmaintwo,
                      ),
                    ],
                  ),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      'Delete Category',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: colordtmaintwo),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      iconSize: 30.0,
                      color: colordtmaintwo,
                      onPressed: () {
                        setState(() {
                          detailcategories.remove(item);
                        });
                      },
                    ),
                    Text(
                      'Add Item',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: colordtmaintwo),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      iconSize: 30.0,
                      color: colordtmaintwo,
                      onPressed: () {
                        setState(() {
                          DetailSpecModel model = DetailSpecModel(
                              item: TextEditingController(text: ""));
                          item.detailspecs.add(model);
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Text(
                  'End of Category ${item.item.text}',
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: colordtmaintwo),
                ),
                Divider(
                  color: colordtmaintwo,
                  thickness: 3,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller.value.isInitialized) {
      initialized = controller.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
      );
    } else {
      return Container(
        height: 0,
        width: 0,
      );
    }
  }
}

class CreatePostTaggedUserScreen extends StatefulWidget {
  final User user;
  const CreatePostTaggedUserScreen({Key key, this.user}) : super(key: key);

  @override
  CreatePostTaggedUserScreenState createState() =>
      CreatePostTaggedUserScreenState(user: user);
}

class CreatePostTaggedUserScreenState
    extends State<CreatePostTaggedUserScreen> {
  final User user;
  CreatePostTaggedUserScreenState({Key key, this.user});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Column(
            children: [
              SizedBox(height: 20),
              Text(clickusertountag,
                  style: TextStyle(
                    color: colordtmaintwo,
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    fontWeight: FontWeight.bold,
                  )),
              Divider(
                color: colordtmaintwo,
              ),
              Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Container(
                          margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.03),
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.height * 0.01,
                              vertical:
                                  MediaQuery.of(context).size.width * 0.024),
                          child: ListTile(
                            title: CircleAvatar(
                              radius:
                                  MediaQuery.of(context).size.height * 0.045,
                              backgroundImage: NetworkImage(taggedusers[index]
                                          .image ==
                                      null
                                  ? 'https://st2.depositphotos.com/4111759/12123/v/600/depositphotos_121233262-stock-illustration-male-default-placeholder-avatar-profile.jpg'
                                  : taggedusers[index].image),
                            ),
                            trailing: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.66,
                              child: Text(
                                '${taggedusers[index].username}',
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
                                taggedusers.remove(taggedusers[index]);
                              });
                            },
                          ),
                        ),
                      );
                    },
                    itemCount: taggedusers.length,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CreateArticleExtendedDetailsScreen extends StatefulWidget {
  final User user;
  final String type;
  const CreateArticleExtendedDetailsScreen({Key key, this.type, this.user})
      : super(key: key);
  @override
  CreateArticleExtendedDetailsScreenState createState() =>
      CreateArticleExtendedDetailsScreenState(type: type, user: user);
}

class CreateArticleExtendedDetailsScreenState
    extends State<CreateArticleExtendedDetailsScreen> {
  final User user;
  final String type;
  CreateArticleExtendedDetailsScreenState({Key key, this.type, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colordtmainone,
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              InkWell(
                child: ListTile(
                  title: Text(creatememest,
                      style: TextStyle(
                          color: colordtmaintwo, fontWeight: FontWeight.bold)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SelectMeme()),
                  );
                },
              ),
              Divider(
                color: colordtmaintwo,
              ),
              if (type != 'A' && type != 'OFFER')
                InkWell(
                  child: ListTile(
                    title: Text(movearticleinsideacategoryst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.bold)),
                    subtitle: articlecreatecategory != ''
                        ? Text('$chosencategoryst : $articlecreatecategory',
                            style: TextStyle(
                                color: colordtmaintwo,
                                fontWeight: FontWeight.bold))
                        : Container(height: 0, width: 0),
                  ),
                  onTap: () {
                    //    Navigator.push(context, MaterialPageRoute(builder: (_) => UserFilterCategoryScreen(user: user, visiteduser: user, isarticlecreate: true,)),);
                  },
                ),
              if (type != 'A' && type != 'OFFER')
                Divider(
                  color: colordtmaintwo,
                ),
              if (type != 'A' &&
                  type != 'OFFER' &&
                  type != 'US' &&
                  type != 'CI')
                InkWell(
                  child: ListTile(
                    title: Text(addchoicest,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.bold)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CreateChoiceScreen()),
                    );
                  },
                ),
              if (type != 'A' &&
                  type != 'OFFER' &&
                  type != 'US' &&
                  type != 'CI')
                Divider(
                  color: colordtmaintwo,
                ),
              if (type != 'A' && type != 'OFFER')
                InkWell(
                  child: ListTile(
                    title: Text(addextendeddetailsst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.bold)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CreateDetailCategoryScreen()),
                    );
                  },
                ),
              if (type != 'A' && type != 'OFFER')
                Divider(
                  color: colordtmaintwo,
                ),
              if (type == 'CE')
                InkWell(
                  child: ListTile(
                    title: Text(addactivityst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.bold)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CreateArticleExtendedDetails2Screen(
                                type: addactivityst,
                              )),
                    );
                  },
                ),
              if (type == 'CE')
                Divider(
                  color: colordtmaintwo,
                ),
              if (type != 'A' && type != 'OFFER')
                InkWell(
                  child: ListTile(
                    title: Text(adddetailincludedst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.bold)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CreateArticleExtendedDetails2Screen(
                                type: adddetailincludedst,
                              )),
                    );
                  },
                ),
              Divider(
                color: colordtmaintwo,
              ),
              if (type != 'A' && type != 'OFFER')
                if (type != 'A' && type != 'OFFER')
                  InkWell(
                    child: ListTile(
                      title: Text(addrulesst,
                          style: TextStyle(
                              color: colordtmaintwo,
                              fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CreateArticleExtendedDetails2Screen(
                                  type: addrulesst,
                                )),
                      );
                    },
                  ),
              if (type != 'A' && type != 'OFFER')
                Divider(
                  color: colordtmaintwo,
                ),
              if (type == 'UP' || type == 'R')
                InkWell(
                  child: ListTile(
                    title: Text(addamenitiesst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.bold)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CreateArticleExtendedDetails2Screen(
                                type: addamenitiesst,
                              )),
                    );
                  },
                ),
              if (type == 'UP' || type == 'R')
                Divider(
                  color: colordtmaintwo,
                ),
              if (type != 'A' && type != 'OFFER')
                InkWell(
                  child: ListTile(
                    title: Text(addhighlightsst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.bold)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CreateArticleExtendedDetails2Screen(
                                type: addhighlightsst,
                              )),
                    );
                  },
                ),
              if (type != 'A' && type != 'OFFER')
                Divider(
                  color: colordtmaintwo,
                ),
              if (type == 'US')
                InkWell(
                  child: ListTile(
                    title: Text(addformst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.bold)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CreateArticleExtendedDetails2Screen(
                                type: addformst,
                              )),
                    );
                  },
                ),
              if (type == 'US')
                Divider(
                  color: colordtmaintwo,
                ),
              if (type == 'US')
                InkWell(
                  child: ListTile(
                    title: Text(addcheckboxst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.bold)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CreateArticleExtendedDetails2Screen(
                                type: addcheckboxst,
                              )),
                    );
                  },
                ),
              if (type == 'US')
                Divider(
                  color: colordtmaintwo,
                ),
              if (type == 'R')
                InkWell(
                  child: ListTile(
                    title: Text(addtravellocationsst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.bold)),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CreateArticleExtendedDetails2Screen(
                                type: addtravellocationsst,
                              )),
                    );
                  },
                ),
              if (type == 'R')
                Divider(
                  color: colordtmaintwo,
                ),
            ]),
          )
        ],
      ),
    );
  }
}

class CreateArticleExtendedDetails2Screen extends StatefulWidget {
  final String type;
  const CreateArticleExtendedDetails2Screen({
    Key key,
    this.type,
  }) : super(key: key);
  @override
  CreateArticleExtendedDetails2ScreenState createState() =>
      CreateArticleExtendedDetails2ScreenState(type: type);
}

class CreateArticleExtendedDetails2ScreenState
    extends State<CreateArticleExtendedDetails2Screen> {
  final String type;
  CreateArticleExtendedDetails2ScreenState({
    Key key,
    this.type,
  });

  void typedetector() {
    if (type == addtravellocationsst) {
      setState(() {
        TravelLocationModel model =
            TravelLocationModel(item: TextEditingController(text: ""));
        travellocations.add(model);
        return;
      });
    }
    if (type == addcheckboxst) {
      setState(() {
        CheckBoxModel model =
            CheckBoxModel(hint: TextEditingController(text: ""));
        checkboxes.add(model);
        return;
      });
    }
    if (type == addformst) {
      setState(() {
        FormModel model = FormModel(hint: TextEditingController(text: ""));
        forms.add(model);
        return;
      });
    }
    if (type == addhighlightsst) {
      setState(() {
        HighlightModel model =
            HighlightModel(item: TextEditingController(text: ""));
        highlights.add(model);
        return;
      });
    }
    if (type == addamenitiesst) {
      setState(() {
        AmenityModel model =
            AmenityModel(item: TextEditingController(text: ""));
        amenities.add(model);
        return;
      });
    }
    if (type == addactivityst) {
      setState(() {
        ActivityModel model =
            ActivityModel(item: TextEditingController(text: ""));
        activities.add(model);
        return;
      });
    }
    if (type == adddetailincludedst) {
      setState(() {
        DetailIncludedModel model =
            DetailIncludedModel(item: TextEditingController(text: ""));
        detailincludeds.add(model);
        return;
      });
    }
    if (type == addrulesst) {
      setState(() {
        DetailRuleModel model =
            DetailRuleModel(item: TextEditingController(text: ""));
        detailrules.add(model);
        return;
      });
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colordtmainone,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            iconSize: 30.0,
            color: colordtmaintwo,
            onPressed: () {
              typedetector();
            },
          ),
        ],
      ),
      backgroundColor: colordtmainone,
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              if (type == addtravellocationsst)
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
              if (type == addcheckboxst)
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
              if (type == addformst)
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
              if (type == addhighlightsst)
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
              if (type == addamenitiesst)
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
              if (type == addactivityst)
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
              if (type == adddetailincludedst)
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
              if (type == addrulesst)
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
            ]),
          )
        ],
      ),
    );
  }
}
