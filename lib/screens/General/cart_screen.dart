import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_food_delivery_app/screens/General/profile_search_screen.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../colors.dart';
import '../../language.dart';
import '../../models/User_Model/user_model.dart';
import '../../models/User_Model/user_tags_model.dart';
import '../../repository.dart';
import '../Calendar_Screen/calendar_schedule_screen.dart';
import '../Visited_Profile_Screen/visited_profile_screen.dart';
import 'item_widget_screen.dart';

class GeneralCartScreen extends StatefulWidget {
  final User user;

  const GeneralCartScreen({Key key, this.user}) : super(key: key);

  @override
  GeneralCartScreenState createState() => GeneralCartScreenState(
        user: user,
      );
}

class GeneralCartScreenState extends State<GeneralCartScreen> {
  final User user;

  GeneralCartScreenState({Key key, this.user});
  final TextEditingController contact = TextEditingController();
  final TextEditingController fullname = TextEditingController();
  final TextEditingController deliverytime = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController specialrequest = TextEditingController();
  List<User> cartitemowners = [];
  bool deliverytypepickup = false;
  bool deliverytypedinein = false;
  bool deliverytypedelivery = false;
  String description = 'abc12345';
  String chosendeliverytype = '';
  bool isfood = false;
  bool pickup = true;
  bool dinein = true;
  bool delivery = true;
  double deliverytypeinit = 0;
  double deliverytype = 0;
  Map<String, dynamic> paymentIntentData;
  double totalcartprice = 0;

  @override
  void initState() {
    deliverytype = 0;
    for (int i = 0; i < user.cartitems.length; i++) {
      if (user.cartitems[i].foodbusinesstype == 'A' ||
          user.cartitems[i].foodbusinesstype == 'B') {
        dinein = true;
      }
    }
    for (int i = 0; i < user.cartitems.length; i++) {
      double priceinit = 0;
      priceinit = user.cartitems[i].price * user.cartitems[i].countnow;

      if (user.cartitems[i].countnow > 1) {
        for (int i2 = 0; i2 < user.cartitems[i].choices.length; i2++) {
          totalcartprice = totalcartprice +
              user.cartitems[i].choices[i2].price *
                  (user.cartitems[i].countnow - 1);
        }
      }
      for (int i2 = 0; i2 < user.cartitems[i].choices.length; i2++) {
        totalcartprice = totalcartprice + user.cartitems[i].choices[i2].price;
      }
      totalcartprice = totalcartprice + priceinit;
    }

    for (int i = 0; i < user.cartitems.length; i++) {
      print(user.cartitems[i].isfood);
      if (user.cartitems[i].isfood) {
        isfood = true;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colordtmainone,
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: colordtmainone,
              borderRadius: BorderRadius.only(),
            ),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                ListTile(
                  title: Text(
                    cartst,
                    style: TextStyle(
                      color: colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.shopping_cart),
                    iconSize: 30.0,
                    color: colordtmaintwo,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CartItemScreen(
                            user: user,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (isfood)
                  Row(children: <Widget>[
                    Text(deliveryoptionst,
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20)),
                    Expanded(child: Divider()),
                  ]),
                if (isfood && pickup)
                  CheckboxListTile(
                    title: Text(pickupst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.w400)),
                    value: deliverytypepickup,
                    onChanged: (bool value) {
                      setState(() {
                        chosendeliverytype = 'pickup';
                        deliverytypepickup = value;
                        deliverytypedinein = !value;
                        deliverytypedelivery = !value;
                      });
                    },
                  ),
                if (isfood && dinein)
                  CheckboxListTile(
                    title: Text(dineinst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.w400)),
                    value: deliverytypedinein,
                    onChanged: (bool value) {
                      setState(() {
                        chosendeliverytype = 'dinein';
                        deliverytypepickup = !value;
                        deliverytypedinein = value;
                        deliverytypedelivery = !value;
                      });
                    },
                  ),
                if (isfood && delivery)
                  CheckboxListTile(
                    title: Text(deliveryst,
                        style: TextStyle(
                            color: colordtmaintwo,
                            fontWeight: FontWeight.w400)),
                    value: deliverytypedelivery,
                    onChanged: (bool value) {
                      setState(() {
                        chosendeliverytype = 'delivery';
                        deliverytypepickup = !value;
                        deliverytypedinein = !value;
                        deliverytypedelivery = value;
                      });
                    },
                  ),
                Divider(),
                ListTile(
                  title: Text(
                    deliverydatest,
                    style: TextStyle(
                      color: colordtmaintwo,
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                  subtitle: Text(
                    deliveryday,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.calendar_today_outlined),
                    iconSize: 30.0,
                    color: colordtmaintwo,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CalendarSearch(
                            user: user,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ListTile(
                  title: Container(
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
                        controller: deliverytime,
                        maxLength: 80,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: deliverytimest,
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: colordtmaintwo),
                        ),
                      ),
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.timer),
                    iconSize: 30.0,
                    color: colordtmaintwo,
                    onPressed: () {},
                  ),
                ),
                Divider(),
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
                        controller: fullname,
                        maxLength: 80,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: fullnamest,
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
                        controller: contact,
                        maxLength: 80,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: contactst,
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
                        controller: address,
                        maxLength: 80,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: addressst,
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
                        controller: specialrequest,
                        maxLength: 80,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: specialrequestst,
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: colordtmaintwo),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  '$totalcostst : ${totalcartprice.toString()}',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 150),
                InkWell(
                  //  onTap: ()async{await makePayment();},
                  onTap: () {
                    for (int i = 0; i < user.cartitems.length; i++) {
                      CreateBuyNotification(
                          user.cartitems[i],
                          user.cartitems[i].author,
                          user.cartitems[i].owner,
                          user.cartitems[i].item,
                          deliveryday,
                          deliverytime.text,
                          user.cartitems[i].link,
                          user.cartitems[i].type,
                          contact.text,
                          address.text,
                          specialrequest.text,
                          fullname.text,
                          deliveryday,
                          chosendeliverytype,
                          user.cartitems[i].count +
                              (user.cartitems[i].countnow - 1));
                      CreateBoughtCheck(
                          user.cartitems[i],
                          user.cartitems[i].author,
                          user.cartitems[i].owner,
                          user.cartitems[i].price,
                          user.cartitems[i].count,
                          user.cartitems[i].item,
                          user.cartitems[i].link,
                          user.cartitems[i].type,
                          '',
                          contact.text,
                          fullname.text,
                          deliveryday,
                          chosendeliverytype,
                          0.0,
                          address.text,
                          specialrequest.text,
                          deliverytime.text);
                      //       DeleteCartItem(user.cartitems[i].id);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    color: Colors.green,
                    child: Center(
                      child: Text(
                        payst,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              ],
            ),
          )
        ],
      )),
    );
  }

  Future<void> makePayment() async {
    try {
      String amount = totalcartprice.round().toString();
      paymentIntentData = await createPaymentIntent(amount);
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntentData['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'aio_ui'))
          .then((value) {});
      try {
        await Stripe.instance.presentPaymentSheet().then((newValue) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Payment Successful !!"),
              backgroundColor: Colors.green));

          paymentIntentData = null;
          for (int i = 0; i < user.cartitems.length; i++) {
            //ADD COUNT,DELIVERY TYPE
            //  CreateBuyNotification(user.cartitems[i].author, user.cartitems[i].owner, user.cartitems[i].item, deliveryday, deliverytime.text, user.cartitems[i].link, user.cartitems[i].type, contact.text, address.text, specialrequest.text, fullname.text, deliveryday);
            //   CreateBoughtCheck(user.cartitems[i], user.cartitems[i].author, user.cartitems[i].owner, price, user.cartitems[i].count, user.cartitems[i].item, user.cartitems[i].link, user.cartitems[i].type, '', contact.text, fullname.text, deliveryday, 0.0, address.text);
            DeleteCartItem(user.cartitems[i].id);
          }
        }).onError((error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Payment Failed !!"),
            backgroundColor: Colors.red,
          ));
        });
      } on StripeException catch (e) {
        print('Exception/DISPLAYPAYMENTSHEET==> $e');
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Text("Cancelled "),
                ));
      } catch (e) {
        print('$e');
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(String amount) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': 'USD',
        'payment_method_types[]': 'card',
        "description": description,
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51KX7gOCtBvlhM0xozoUKHvJ9r2Ui5UGoJvTHGeNfszhZ2DwnmQevr8h6vffuwzor5HlPjqhbgB9h7ZIha3wvutkI00rCdad0cf',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {}
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}

class CalendarSearch extends StatefulWidget {
  final User user;
  CalendarSearch({
    Key key,
    this.user,
  }) : super(key: key);
  @override
  CalendarSearchS createState() => new CalendarSearchS(
        user: user,
      );
}

class CalendarSearchS extends State<CalendarSearch> {
  final User user;
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  CalendarSearchS({
    Key key,
    this.user,
  });
  String date2a = '';
  String mnyia = '';
  bool lol = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (date, events) {
        String date1 = '$date';
        dcmr = date1.substring(0, 10);
        String date2 = date1.substring(8, 10);
        date2a = date2;
        String mnyi = date1.substring(0, 7);
        mnyia = mnyi;

        event1 = date2;
        event2 = mnyi;
        event3 = dcmr;
        // ignore: unnecessary_statements
        setState(() {
          searchday = date2;
          searchmny = mnyi;
          String deliveryday = '$searchmny-$searchday';
        });

        Navigator.pop(context);
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: Colors.yellow)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: colordtmainthree,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: colordtmainthree,
      ),
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return Scaffold(
        backgroundColor: colordtmainone,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),
              Container(
                margin: EdgeInsets.only(
                  top: 30.0,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: new Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      _currentMonth,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    )),
                    ElevatedButton(
                      child: Text(
                        previousst,
                        style: TextStyle(
                          color: colordtmaintwo,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(
                              _targetDateTime.year, _targetDateTime.month - 1);
                          _currentMonth =
                              DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                    ),
                    ElevatedButton(
                      child: Text(
                        nextst,
                        style: TextStyle(
                          color: colordtmaintwo,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(
                              _targetDateTime.year, _targetDateTime.month + 1);
                          _currentMonth =
                              DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: _calendarCarouselNoHeader,
              ),
              //
            ],
          ),
        ));
  }
}

class CartItemScreen extends StatefulWidget {
  final User user;
  const CartItemScreen({
    Key key,
    this.user,
  }) : super(key: key);
  @override
  CartItemScreenState createState() => CartItemScreenState(user: user);
}

class CartItemScreenState extends State<CartItemScreen> {
  final User user;
  CartItemScreenState({Key key, this.user});
  List<String> items = [];
  ScrollController _scrollController = ScrollController();

  Future<User> callUser(String userid) async {
    Future<User> _user = FetchUser(userid);
    return _user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: user.cartitems.length,
          physics: ClampingScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (context, index) {
            return FutureBuilder<User>(
                future: callUser(user.cartitems[index].owner),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.008),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    child: Text(
                                      '''$ownerst: \n ''',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        fontWeight: FontWeight.bold,
                                        color: colordtmaintwo,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                VisitedProfileScreen(
                                                  user: user,
                                                  visiteduser: snapshot.data,
                                                )),
                                      );
                                    },
                                  ),
                                  InkWell(
                                    child: Text(
                                      '''${snapshot.data.username.toString()} \n ''',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        color: colordtmaintwo,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                VisitedProfileScreen(
                                                  user: user,
                                                  visiteduser: snapshot.data,
                                                )),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    child: Text(
                                      '''$itemst : \n''',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          color: colordtmaintwo,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () {
                                      isuserfollowed(user.id, snapshot.data.id)
                                        ..then((result) {
                                          if (user.shouldshowuserinfo(
                                                  snapshot.data, result) ==
                                              'followed') {
                                            FetchFollowedArticle(http.Client(),
                                                user.cartitems[index].link)
                                              ..then((founditem) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        ArticleWidgetScreen(
                                                            user: user,
                                                            post: founditem,
                                                            ischosing: false),
                                                  ),
                                                );
                                              });
                                          }
                                          if (user.shouldshowuserinfo(
                                                  snapshot.data, result) ==
                                              'public') {
                                            FetchPublicArticle(http.Client(),
                                                user.cartitems[index].link)
                                              ..then((founditem) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        ArticleWidgetScreen(
                                                            user: user,
                                                            post: founditem,
                                                            ischosing: false),
                                                  ),
                                                );
                                              });
                                          }
                                        });
                                    },
                                  ),
                                  InkWell(
                                    child: Text(
                                      '''${user.cartitems[index].item.toString()} \n''',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        color: colordtmaintwo,
                                      ),
                                    ),
                                    onTap: () {
                                      isuserfollowed(user.id, snapshot.data.id)
                                        ..then((result) {
                                          if (user.shouldshowuserinfo(
                                                  snapshot.data, result) ==
                                              'followed') {
                                            FetchFollowedArticle(
                                                http.Client(), snapshot.data.id)
                                              ..then((founditem) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        ArticleWidgetScreen(
                                                            user: user,
                                                            post: founditem,
                                                            ischosing: false),
                                                  ),
                                                );
                                              });
                                          }
                                          if (user.shouldshowuserinfo(
                                                  snapshot.data, result) ==
                                              'public') {
                                            FetchPublicArticle(
                                                http.Client(), snapshot.data.id)
                                              ..then((founditem) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        ArticleWidgetScreen(
                                                            user: user,
                                                            post: founditem,
                                                            ischosing: false),
                                                  ),
                                                );
                                              });
                                          }
                                        });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '''$totalcostst: \n''',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        color: colordtmaintwo,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '''${user.cartitems[index].price.toString()} \n''',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      color: colordtmaintwo,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '''$countst : ''',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        color: colordtmaintwo,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '''${user.cartitems[index].countnow.toString()}''',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      color: colordtmaintwo,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  IconButton(
                                    icon: Icon(Icons.add,
                                        color: colordtmaintwo, size: 35),
                                    onPressed: () {
                                      setState(() {
                                        user.cartitems[index].countnow++;
                                        EditCartItemCount(user.cartitems[index],
                                            user.cartitems[index].countnow);
                                      });
                                    },
                                  ),
                                  SizedBox(width: 30),
                                  IconButton(
                                    icon: Icon(Icons.remove,
                                        color: colordtmaintwo, size: 35),
                                    onPressed: () {
                                      setState(() {
                                        user.cartitems[index].countnow--;
                                        EditCartItemCount(user.cartitems[index],
                                            user.cartitems[index].countnow);
                                      });
                                    },
                                  )
                                ],
                              ),
                              SizedBox(height: 40),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.reorder,
                                      color: colordtmaintwo,
                                      size: 35,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                CartItemChoiceScreen(
                                                  user: user,
                                                  choices: user
                                                      .cartitems[index].choices,
                                                )),
                                      );
                                    },
                                  ),
                                  SizedBox(width: 30),
                                  IconButton(
                                    icon: Icon(Icons.delete,
                                        color: colordtmaintwo, size: 35),
                                    onPressed: () {
                                      DeleteCartItem(user.cartitems[index].id);
                                      Future.delayed(
                                          Duration(seconds: 1),
                                          () => Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          super.widget)));
                                      //required
                                      return true;
                                    },
                                  )
                                ],
                              ),
                              Divider(
                                color: colordtmaintwo,
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                              backgroundColor: Colors.pink,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.pinkAccent)));
                });
          }),
    );
  }
}

class CartItemChoiceScreen extends StatefulWidget {
  final User user;

  final List<CartItemChoice> choices;

  const CartItemChoiceScreen({Key key, this.user, this.choices})
      : super(key: key);
  @override
  CartItemChoiceScreenState createState() =>
      CartItemChoiceScreenState(user: user, choices: choices);
}

class CartItemChoiceScreenState extends State<CartItemChoiceScreen> {
  final User user;
  final List<CartItemChoice> choices;

  CartItemChoiceScreenState({Key key, this.user, this.choices});

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
          for (final item2 in choices)
            Column(
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      '''$categoryst: \n ''',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                        fontWeight: FontWeight.bold,
                        color: colordtmaintwo,
                      ),
                    ),
                    Text(
                      '''${item2.category.toString()} \n ''',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                        color: colordtmaintwo,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '''$namest: \n ''',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                        fontWeight: FontWeight.bold,
                        color: colordtmaintwo,
                      ),
                    ),
                    Text(
                      '''${item2.choice.toString()} \n ''',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                        color: colordtmaintwo,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '''$feest: \n ''',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                        fontWeight: FontWeight.bold,
                        color: colordtmaintwo,
                      ),
                    ),
                    Text(
                      '''${item2.price.toString()} \n ''',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                        color: colordtmaintwo,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: colordtmaintwo, size: 35),
                  onPressed: () {
                    DeleteCartItemChoice(item2.id);
                    Future.delayed(
                        Duration(seconds: 1),
                        () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    super.widget)));
                    //required
                    return true;
                  },
                ),
                Divider(color: colordtmaintwo),
              ],
            ),
        ],
      ),
    );
  }
}
