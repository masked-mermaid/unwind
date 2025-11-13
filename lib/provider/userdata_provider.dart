// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserDataProvider extends ChangeNotifier {
//   // Define keys for easy access and to prevent typos
//   static const String _keyName = 'user_name';
//   static const String _keyTheme = 'user_theme_is_dark'; // boolean for theme mode
//   static const String _keyStreak = 'meditation_streak_count';
  
//   // Give them an initial default value.
//   String _userName = 'Guest'; 
//   int _userStreak = 0;

//   String get userName => _userName;
//   int get userStreak=>_userStreak;

//   UserDataProvider(){
//     _loadUserData();
//   }

//   void _loadUserData()async{
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     _userName = prefs.getString(_keyName)??"Guest";
//     _userStreak =prefs.getInt(_keyStreak)?? 0;
//     notifyListeners();
//   }
//   /// Saves the user's name.
//   void saveName(String name) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyName, name);
//     _userName= name;
//     notifyListeners();
//   }

//   /// Saves the theme preference (e.g., true for dark, false for light).
//    void saveTheme(bool isDark) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_keyTheme, isDark);
//   }

//   /// Saves the meditation streak count.
//    void saveStreak(int streakCount) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setInt(_keyStreak, streakCount);
//   }

//   // --- Example Usage to Save Data ---
//   void saveAllData() async {
//     await saveName('Alex');
//     await saveTheme(true); // Setting theme to dark
//     await saveStreak(15);
//   }

// }
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataProvider with ChangeNotifier {
  // --- KEYS (Labels for Storage) ---
  static const String _keyName = 'user_name';
  static const String _keyStreak = 'meditation_streak_count';
  static const String _keyTheme = 'user_theme_is_dark';
  static const String _keyLastDate = 'last_meditation_date'; // New key

  // --- INTERNAL STATE (What the UI reads) ---
  String _userName = 'Guest';
  int _userStreak = 0;
  bool _isDarkMode = false;
  String _lastMeditationDate = ''; // New state variable
  
  // A variable to hold the SharedPreferences instance after it's initialized
  late SharedPreferences _prefs; 
  
  // --- GETTERS (The only way to read data) ---
  String get userName => _userName;
  int get userStreak => _userStreak;
  bool get isDarkMode => _isDarkMode;

  // --- CONSTRUCTOR: Start the loading process immediately ---
  UserDataProvider() {
    _initPreferences();
  }

  // --- ASYNC INITIALIZATION AND LOADING ---
  Future<void> _initPreferences() async {
    // 1. Await the instance inside the provider
    _prefs = await SharedPreferences.getInstance(); 
    
    // 2. Load the stored data using the initialized instance
    _loadUserData();
  }

  void _loadUserData() {
    // Read the data using the instance and provide fallbacks (??)
    _userName = _prefs.getString(_keyName) ?? 'Guest';
    _userStreak = _prefs.getInt(_keyStreak) ?? 0;
    _isDarkMode = _prefs.getBool(_keyTheme) ?? false;
    _lastMeditationDate = _prefs.getString(_keyLastDate) ?? '';
    
    // Notify widgets that the initial data is ready
    notifyListeners();
  }

  // --- SETTERS (Write/Update data) ---

  Future<void> saveName(String name) async {
    // 1. Write to SharedPreferences
    await _prefs.setString(_keyName, name);
    
    // 2. Update internal state
    _userName = name;
    
    // 3. Notify UI
    notifyListeners();
  }
  
  Future<void> incrementStreak() async {
    final newStreak = _userStreak + 1;
    await _prefs.setInt(_keyStreak, newStreak);
    
    _userStreak = newStreak;
    notifyListeners();
  }
  
  Future<void> toggleTheme() async {
    final newMode = !_isDarkMode;
    await _prefs.setBool(_keyTheme, newMode);
    
    _isDarkMode = newMode;
    notifyListeners();
  }
  // In UserDataProvider
void completeMeditation() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Get today's date, formatted as a simple date string (e.g., "2025-11-13")
  final today = DateTime.now().toLocal();
  final todayDateString = "${today.year}-${today.month}-${today.day}";
  
  // If the meditation was already completed today, do nothing.
  if (todayDateString == _lastMeditationDate) {
    return; // Streak already counted for today.
  }
  
  // Convert the last saved date string back into a DateTime object
  // If the string is empty (first use), use a date far in the past.
  DateTime lastDate;
  if (_lastMeditationDate.isEmpty) {
    lastDate = DateTime(1900);
  } else {
    lastDate = DateTime.parse(_lastMeditationDate);
  }
  
  // Calculate the difference in days between the last date and today.
  final difference = today.difference(lastDate).inDays;
  
  int newStreak;
  
  // Case A: Perfect Streak (Difference is exactly 1 day)
  if (difference == 1) {
    newStreak = _userStreak + 1;
  } 
  // Case B: Broken Streak (Difference is 2 or more days)
  else if (difference > 1) {
    newStreak = 1; // Reset streak to 1
  } 
  // Case C: First Time (Difference is greater than 100 years, handled by lastDate = 1900)
  else { 
    newStreak = 1; // Start streak at 1
  }
  
  // --- Save Changes to Storage ---
  await prefs.setInt(_keyStreak, newStreak);
  await prefs.setString(_keyLastDate, todayDateString);
  
  // --- Update State and UI ---
  _userStreak = newStreak;
  _lastMeditationDate = todayDateString;
  notifyListeners();
}
}