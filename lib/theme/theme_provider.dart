import 'package:flutter/material.dart';
import 'package:unwind/theme/light_theme.dart';

class ThemeProvider extends ChangeNotifier{

// inital theme
ThemeData _themeData= lightMode;

// get theme
ThemeData get themeData=>_themeData;

// set theme
set themeData (ThemeData themeData){
  _themeData =themeData;
  notifyListeners();
}

// toggle modes



}