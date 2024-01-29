import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../models/Article_Model/article_model.dart';
import '../../models/User_Model/user_model.dart';
import '../../models/User_Model/user_tags_model.dart';
import '../../repository.dart';
import '../General/choice_screen.dart';

class CartScreen extends StatefulWidget {
  final User user;
  final User visiteduser;
  const CartScreen({Key key, this.user, this.visiteduser}) : super(key: key);

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  final User user;
  final User visiteduser;
  CartScreenState({Key key, this.user, this.visiteduser});
  ScrollController _scrollController = ScrollController();
  int page = 1;
  List<CartItem> posts = [];
  Future fetchPostsfuture;
  bool isLoading = false;

  @override
  void initState() {
    setState(() {
      fetchPostsfuture = FetchCartItems(page);
    });
    return;
  }

  Future _loadData() async {
    FetchCartItems(page)
      ..then((result) {
        setState(() {
          for (final item2 in result) posts.add(item2);
          isLoading = false;
        });
        return;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colordtmainone,
      body: SingleChildScrollView(
        child: Column(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!isLoading &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  page = page + 1;
                  _loadData();
                  setState(() {
                    isLoading = true;
                  });
                  return true;
                }
              },
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: colordtmainone,
                          borderRadius: BorderRadius.only(),
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05),
                            Column(
                              children: [
                                FutureBuilder<List<CartItem>>(
                                  future: fetchPostsfuture,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError)
                                      print(snapshot.hasError);
                                    posts = snapshot.data;
                                    return snapshot.hasData
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: posts.length,
                                            physics: ClampingScrollPhysics(),
                                            controller: _scrollController,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Text(posts[index].item),
                                                  Text(posts[index]
                                                      .price
                                                      .toString()),
                                                  InkWell(
                                                    child: Text('Choices'),
                                                    onTap: () {
                                                      List<ArticleChoice>
                                                          cichoice = [];
                                                      if (posts[index].type ==
                                                          'UP') {
                                                        for (int i = 0;
                                                            i <
                                                                posts[index]
                                                                    .choices
                                                                    .length;
                                                            i++) {
                                                          ArticleChoice choice =
                                                              ArticleChoice(
                                                                  price: posts[
                                                                          index]
                                                                      .choices[
                                                                          i]
                                                                      .price
                                                                      .toString(),
                                                                  item: posts[
                                                                          index]
                                                                      .choices[
                                                                          i]
                                                                      .item);
                                                          cichoice.add(choice);
                                                        }
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  UserProductChoiceScreen(
                                                                    user: user,
                                                                    product: Article(
                                                                        choices:
                                                                            cichoice),
                                                                  )),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  InkWell(
                                                    child: Text('Done'),
                                                    onTap: () {
                                                      for (int i = 0;
                                                          i < posts.length;
                                                          i++) {
                                                        double price = 0;
                                                        price = price +
                                                            posts[i]
                                                                .price
                                                                .toDouble();
                                                        for (int y = 0;
                                                            y <
                                                                posts[i]
                                                                    .choices
                                                                    .length;
                                                            y++) {
                                                          price = price +
                                                              posts[i]
                                                                  .choices[y]
                                                                  .price
                                                                  .toDouble();
                                                        }
                                                      }
                                                    },
                                                  ),
                                                ],
                                              );
                                            })
                                        : Center(
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.pink,
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                      Color>(Colors.pinkAccent),
                                            ),
                                          );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
