import 'package:flutter/material.dart';
import 'package:unwind/theme/light_theme.dart';
import 'package:unwind/theme/dark_theme.dart';


class ThemeProvider extends ChangeNotifier{

// inital theme
ThemeData _themeData= darkMode;

// get theme
ThemeData get themeData=>_themeData;

// set theme
set themeData (ThemeData themeData){
  _themeData =themeData;
  notifyListeners();
}

// toggle modes



}