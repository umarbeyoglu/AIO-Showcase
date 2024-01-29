import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../colors.dart';
import '../../language.dart';
import '../../models/Article_Model/article_model.dart';
import '../../models/User_Model/user_model.dart';
import '../../repository.dart';

class DetailCategoryModel {
  TextEditingController item;
  List<DetailSpecModel> detailspecs = [];

  DetailCategoryModel({this.item});

  TextEditingController hintchange() {
    print(item.text);
    return item ?? TextEditingController(text: '');
  }
}

class DetailIncludedModel {
  TextEditingController item;

  DetailIncludedModel({this.item});

  TextEditingController hintchange() {
    print(item.text);
    return item ?? TextEditingController(text: '');
  }
}

class DetailRuleModel {
  TextEditingController item;

  DetailRuleModel({this.item});

  TextEditingController hintchange() {
    print(item.text);
    return item ?? TextEditingController(text: '');
  }
}

class ActivityModel {
  TextEditingController item;
  TextEditingController starttime;

  ActivityModel({this.item, this.starttime});

  TextEditingController hintchange() {
    print(item.text);
    return item ?? TextEditingController(text: '');
  }

  TextEditingController hintchange2() {
    print(starttime.text);
    return starttime ?? TextEditingController(text: '');
  }
}

class HighlightModel {
  TextEditingController item;

  HighlightModel({this.item});

  TextEditingController hintchange() {
    print(item.text);
    return item ?? TextEditingController(text: '');
  }
}

class TravelLocationModel {
  TextEditingController item;

  TravelLocationModel({this.item});

  TextEditingController hintchange() {
    print(item.text);
    return item ?? TextEditingController(text: '');
  }
}

class AmenityModel {
  TextEditingController item;

  AmenityModel({this.item});

  TextEditingController hintchange() {
    print(item.text);
    return item ?? TextEditingController(text: '');
  }
}

class DetailSpecModel {
  String category;
  TextEditingController item;

  DetailSpecModel({this.item, this.category});

  TextEditingController hintchange() {
    print(item.text);
    return item ?? TextEditingController(text: '');
  }
}

class CheckBoxModel {
  TextEditingController hint;

  CheckBoxModel({this.hint});

  TextEditingController hintchange() {
    print(hint.text);
    return hint ?? TextEditingController(text: '');
  }
}

class FormModel {
  TextEditingController hint;

  FormModel({this.hint});

  TextEditingController hintchange() {
    print(hint.text);
    return hint ?? TextEditingController(text: '');
  }
}

class CalendarEventEditChoiceScreen extends StatefulWidget {
  final Article product;
  const CalendarEventEditChoiceScreen({Key key, this.product})
      : super(key: key);
  @override
  CalendarEventEditChoiceScreenState createState() =>
      CalendarEventEditChoiceScreenState(product: product);
}

class CalendarEventEditChoiceScreenState
    extends State<CalendarEventEditChoiceScreen> {
  final Article product;
  CalendarEventEditChoiceScreenState({Key key, this.product});

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
                ChoiceCategoryModel model = ChoiceCategoryModel(
                  title: TextEditingController(text: ""),
                );
                choices.add(model);
              });
            },
          ),
        ],
      ),
      backgroundColor: colordtmainone,
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          for (final item in choices)
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
                        controller: item.title,
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
                for (final item2 in item.choices)
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
                                    controller: item2.price,
                                    maxLength: 15,
                                    keyboardType: TextInputType.number,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      helperText: 'Enter item price',
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
                            'Delete Choice',
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
                                item.choices.remove(item2);
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
                          choices.remove(item);
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
                          ChoiceModel model = ChoiceModel(
                              item: TextEditingController(text: ""),
                              price: TextEditingController(text: ""));
                          item.choices.add(model);
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Text(
                  'End of Category ${item.title.text}',
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: colordtmaintwo),
                ),
                Divider(
                  color: colordtmaintwo,
                  thickness: 3,
                ),
              ],
            ),
          for (final item in product.choicecategories)
            Column(
              children: [
                Text(
                  '${item.category}',
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: colordtmaintwo),
                ),
                Divider(
                  color: colordtmaintwo,
                ),
                for (final item2 in product.choices)
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Text(
                            'Item ${item2.item}',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Text(
                            'Delete Choice',
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
                                DeleteArticleChoice(item2.id);
                                product.choices.remove(item2);
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
                          DeleteArticleChoiceCategory(item.id);
                          product.choicecategories.remove(item);
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
                          ChoiceModel model = ChoiceModel(
                              item: TextEditingController(text: ""),
                              price: TextEditingController(text: ""));
                          item.choices.add(model);
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 50),
                CheckboxListTile(
                  title: Text(allchooseablest,
                      style: TextStyle(
                          color: colordtmaintwo, fontWeight: FontWeight.w400)),
                  value: item.firsttime == true ? item.allchooseable : item.val,
                  onChanged: (bool value) {
                    setState(() {
                      item.val = value;
                      item.firsttime = false;
                    });
                  },
                ),
                Text(
                  'End of Category ${item.category}',
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: colordtmaintwo),
                ),
                Divider(
                  color: colordtmaintwo,
                  thickness: 3,
                ),
                InkWell(
                    child: Text('Finish Edits'),
                    onTap: () {
                      for (int i = 0; i < choices.length; i++) {
                        CreateUserProductChoiceCategory(product.id, choices[i]);
                      }
                      for (int i = 0;
                          i < product.choicecategories.length;
                          i++) {
                        if (product.choicecategories[i].ischanged) {
                          EditUserProductChoiceCategory(
                              product.choicecategories[i],
                              product.choicecategories[i].val);
                        }
                      }

                      Navigator.pop(context);
                    }),
              ],
            ),
        ],
      ),
    );
  }
}

class CalendarEventChoiceScreen extends StatefulWidget {
  final User user;
  final User visiteduser;
  final Article product;
  final String category;
  const CalendarEventChoiceScreen(
      {Key key, this.user, this.product, this.visiteduser, this.category})
      : super(key: key);
  @override
  CalendarEventChoiceScreenState createState() =>
      CalendarEventChoiceScreenState(
          user: user,
          product: product,
          category: category,
          visiteduser: visiteduser);
}

class CalendarEventChoiceScreenState extends State<CalendarEventChoiceScreen> {
  final User user;
  final User visiteduser;
  final Article product;
  final String category;
  CalendarEventChoiceScreenState(
      {Key key, this.user, this.product, this.visiteduser, this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colordtmainone,
        actions: [],
      ),
      backgroundColor: colordtmainone,
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          for (final item in product.choicecategories)
            Column(
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Text('${item.category}',
                        style: TextStyle(
                            color: colordtmainthree,
                            fontWeight: FontWeight.bold)),
                  ],
                ), //Choice Categories Here

                for (final item2 in product.choices)
                  if (item.category == item2.category)
                    CheckboxListTile(
                      title: Text('${item2.item} ',
                          style: TextStyle(
                              color: colordtmaintwo,
                              fontWeight: FontWeight.bold)),
                      subtitle: Text('${item2.price.toString()} Dollars',
                          style: TextStyle(
                              color: colordtmaintwo,
                              fontWeight: FontWeight.w400)),
                      value: item2.ischosen,
                      checkColor: Colors.white,
                      selectedTileColor: Colors.white,
                      onChanged: (bool value) {
                        setState(() {
                          item2.ischosen = value;
                          if (item.allchooseable == false) {
                            for (int i = 0; i < product.choices.length; i++) {
                              if (product.choices[i].id != item2.id &&
                                  product.choices[i].ischosen) {
                                setState(() {
                                  product.choices[i].ischosen = false;
                                });
                              }
                            }
                          }
                        });
                      },
                    ), //Choices Here
                Divider(color: colordtmaintwo),
                InkWell(
                  child: Text('Add To Cart'),
                  onTap: () {
                    CreateCartItem(
                        product,
                        user.id,
                        product.author,
                        product.caption,
                        product.id,
                        'Article',
                        1,
                        product.price,
                        double.parse(product.deliveryfee));
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class CreateChoiceScreen extends StatefulWidget {
  const CreateChoiceScreen({
    Key key,
  }) : super(key: key);
  @override
  CreateChoiceScreenState createState() => CreateChoiceScreenState();
}

class CreateChoiceScreenState extends State<CreateChoiceScreen> {
  CreateChoiceScreenState({Key key});

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
                ChoiceCategoryModel model =
                    ChoiceCategoryModel(title: TextEditingController(text: ""));
                choices.add(model);
              });
            },
          ),
        ],
      ),
      backgroundColor: colordtmainone,
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          for (final item in choices)
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
                        controller: item.title,
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
                for (final item2 in item.choices)
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
                                    controller: item2.price,
                                    maxLength: 15,
                                    keyboardType: TextInputType.number,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      helperText: 'Enter item price',
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
                            'Delete Choice',
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
                                item.choices.remove(item2);
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
                          choices.remove(item);
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
                          ChoiceModel model = ChoiceModel(
                              item: TextEditingController(text: ""),
                              price: TextEditingController(text: ""));
                          item.choices.add(model);
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 50),
                CheckboxListTile(
                  title: Text(allchooseablest,
                      style: TextStyle(
                          color: colordtmaintwo, fontWeight: FontWeight.w400)),
                  value: item.allchooseable,
                  onChanged: (bool value) {
                    setState(() {
                      item.allchooseable = value;
                    });
                  },
                ),
                SizedBox(height: 50),
                Text(
                  'End of Category ${item.title.text}',
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

class UserProductEditChoiceScreen extends StatefulWidget {
  final Article product;
  const UserProductEditChoiceScreen({Key key, this.product}) : super(key: key);
  @override
  UserProductEditChoiceScreenState createState() =>
      UserProductEditChoiceScreenState(product: product);
}

class UserProductEditChoiceScreenState
    extends State<UserProductEditChoiceScreen> {
  final Article product;
  UserProductEditChoiceScreenState({Key key, this.product});

  Widget changeinit() {
    return Container(
      height: 0,
      width: 0,
    );
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
              setState(() {
                ChoiceCategoryModel model = ChoiceCategoryModel(
                  title: TextEditingController(text: ""),
                );
                choices.add(model);
              });
            },
          ),
        ],
      ),
      backgroundColor: colordtmainone,
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          for (final item in choices)
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
                        controller: item.title,
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
                for (final item2 in item.choices)
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
                                    controller: item2.price,
                                    maxLength: 15,
                                    keyboardType: TextInputType.number,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      helperText: 'Enter item price',
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
                            'Delete Choice',
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
                                item.choices.remove(item2);
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
                          choices.remove(item);
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
                          ChoiceModel model = ChoiceModel(
                              item: TextEditingController(text: ""),
                              price: TextEditingController(text: ""));
                          item.choices.add(model);
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 50),
                CheckboxListTile(
                  title: Text(allchooseablest,
                      style: TextStyle(
                          color: colordtmaintwo, fontWeight: FontWeight.w400)),
                  value: item.allchooseable,
                  onChanged: (bool value) {
                    setState(() {
                      item.allchooseable = value;
                    });
                  },
                ),
                SizedBox(height: 50),
                Text(
                  'End of Category ${item.title.text}',
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: colordtmaintwo),
                ),
                Divider(
                  color: colordtmaintwo,
                  thickness: 3,
                ),
              ],
            ),
          for (final item in product.choicecategories)
            Column(
              children: [
                Text(
                  '${item.category}',
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: colordtmaintwo),
                ),
                Divider(
                  color: colordtmaintwo,
                ),
                for (final item2 in product.choices)
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Text(
                            'Item ${item2.item}',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Text(
                            'Delete Choice',
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
                                DeleteArticleChoice(item2.id);
                                product.choices.remove(item2);
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
                          DeleteArticleChoiceCategory(item.id);
                          product.choicecategories.remove(item);
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
                          ChoiceModel model = ChoiceModel(
                              item: TextEditingController(text: ""),
                              price: TextEditingController(text: ""));
                          item.choices.add(model);
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 50),
                CheckboxListTile(
                  title: Text(allchooseablest,
                      style: TextStyle(
                          color: colordtmaintwo, fontWeight: FontWeight.w400)),
                  value: item.firsttime == true ? item.allchooseable : item.val,
                  onChanged: (bool value) {
                    setState(() {
                      item.val = value;
                      item.firsttime = false;
                    });
                  },
                ),
                SizedBox(height: 50),
                Text(
                  'End of Category ${item.category}',
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

class UserProductEditDetailCategoryScreen extends StatefulWidget {
  final Article product;
  const UserProductEditDetailCategoryScreen({Key key, this.product})
      : super(key: key);
  @override
  UserProductEditDetailCategoryScreenState createState() =>
      UserProductEditDetailCategoryScreenState(product: product);
}

class UserProductEditDetailCategoryScreenState
    extends State<UserProductEditDetailCategoryScreen> {
  final Article product;
  UserProductEditDetailCategoryScreenState({Key key, this.product});

  Widget changeinit() {
    return Container(
      height: 0,
      width: 0,
    );
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
              setState(() {
                DetailCategoryModel model = DetailCategoryModel(
                  item: TextEditingController(text: ""),
                );
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
                            'Item ${item2.category}',
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
                            'Delete Choice',
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
          for (final item in product.detailcategories)
            Column(
              children: [
                Text(
                  '${item.category}',
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: colordtmaintwo),
                ),
                Divider(
                  color: colordtmaintwo,
                ),
                for (final item2 in product.detailspecs)
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Text(
                            'Item ${item2.spec}',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: colordtmaintwo),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Text(
                            'Delete Choice',
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
                                DeleteArticleDetailSpec(item2.id);
                                product.detailspecs.remove(item2);
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
                          DeleteArticleDetailCategory(item.id);
                          product.detailcategories.remove(item);
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
                          item.specs.add(model);
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 50),
                SizedBox(height: 50),
                Text(
                  'End of Category ${item.category}',
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

class UserProductChoiceScreen extends StatefulWidget {
  final User user;
  final User visiteduser;
  final Article product;
  final String category;
  const UserProductChoiceScreen(
      {Key key, this.user, this.product, this.visiteduser, this.category})
      : super(key: key);
  @override
  UserProductChoiceScreenState createState() => UserProductChoiceScreenState(
      user: user,
      product: product,
      category: category,
      visiteduser: visiteduser);
}

class UserProductChoiceScreenState extends State<UserProductChoiceScreen> {
  final User user;
  final User visiteduser;
  final Article product;
  final String category;
  UserProductChoiceScreenState(
      {Key key, this.user, this.product, this.visiteduser, this.category});

  @override
  Widget build(BuildContext context) {
    print('hereaa');
    print(product.choicecategories);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colordtmainone,
        actions: [],
      ),
      backgroundColor: colordtmainone,
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          for (final item in product.choicecategories)
            Column(
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Text('${item.category}',
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.bold)),
                  ],
                ), //Choice Categories Here

                for (final item2 in product.choices)
                  if (item.category == item2.category)
                    CheckboxListTile(
                      title: Text('${item2.item} ',
                          style: TextStyle(
                              color: colordtmaintwo,
                              fontWeight: FontWeight.bold)),
                      subtitle: Text('${item2.price.toString()} Dollars',
                          style: TextStyle(
                              color: colordtmaintwo,
                              fontWeight: FontWeight.w400)),
                      value: item2.ischosen,
                      checkColor: Colors.white,
                      selectedTileColor: Colors.white,
                      onChanged: (bool value) {
                        setState(() {
                          item2.ischosen = value;
                          if (item.allchooseable == false) {
                            for (int i = 0; i < product.choices.length; i++) {
                              if (product.choices[i].id != item2.id &&
                                  product.choices[i].ischosen) {
                                setState(() {
                                  product.choices[i].ischosen = false;
                                });
                              }
                            }
                          }
                        });
                      },
                    ), //Choices Here
                Divider(color: colordtmaintwo),
                InkWell(
                  child: Text('Add To Cart'),
                  onTap: () {
                    //AddToCart
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
