// import 'package:flutter/material.dart';
// import 'package:unwind/theme/dark_theme.dart';
// import 'package:unwind/theme/light_theme.dart';


// class ThemeProvider extends ChangeNotifier{

// // inital theme
// ThemeData _themeData= lightMode;

// // get theme
// ThemeData get themeData=>_themeData;

// // set theme
// set themeData (ThemeData themeData){
//   _themeData =themeData;
//   notifyListeners();
// }

// // toggle modes



// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unwind/theme/dark_theme.dart';
import 'package:unwind/theme/light_theme.dart';

class ThemeProvider extends ChangeNotifier {
  // Key for SharedPreferences
  static const String _keyTheme = 'is_dark_mode';

  // Initial theme (Assume lightMode is default, but check storage first)
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  // Add a helper getter to check if the current theme is dark
  bool get isDarkMode => _themeData == darkMode;

  // Constructor to load the preference when the Provider is created
  ThemeProvider() {
    _loadThemePreference();
  }

  // --- Load and Persist Logic ---

  void _loadThemePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isDark = prefs.getBool(_keyTheme) ?? false; // Default to false (Light)
    
    // Set the initial theme based on persistence
    _themeData = isDark ? darkMode : lightMode;
    notifyListeners();
  }

  void _saveThemePreference(bool isDark) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyTheme, isDark);
  }

  // --- Theme Toggling Method ---

  // Use a method instead of a setter for control
  void toggleTheme() {
    // Check if the current theme is light mode
    if (_themeData == lightMode) {
      // Switch to dark mode
      _themeData = darkMode;
      _saveThemePreference(true);
    } else {
      // Switch back to light mode
      _themeData = lightMode;
      _saveThemePreference(false);
    }
    notifyListeners();
  }
}