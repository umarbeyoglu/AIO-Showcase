import 'package:Welpie/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Stripe.publishableKey = 'pk_test_51KX7gOCtBvlhM0xo0Lz4Zsc2kRaQ4a8iqki9FxwnyEyEACrM9VbjPDdr2K2TIbAXbKgF2ucZrpvglaSqXGuxkU7e00T57oGaCi';
  await Stripe.instance.applySettings();
  var email = prefs.getString('email');
  var password = prefs.getString('password');
  var language = prefs.getString('language');
  var iscyprusinit = prefs.getBool('iscyprus');
  var languageset = prefs.getBool('languageset');
  var darkthemeinit = prefs.getBool('darktheme');
  darkthemeinit = darkthemeinit == null ? false : darkthemeinit;
  darktheme = darkthemeinit;
  iscyprus = iscyprusinit == null ? false : true;
  bool check = email == null ? false : true;
  languageset == true ? languagest = language : languagest = 'EN';
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
   home:await SignInUser(email, password, check),
  ));}
