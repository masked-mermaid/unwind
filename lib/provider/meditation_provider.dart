import 'dart:async';
import 'dart:core';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

// import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:unwind/models/meditationoptions.dart';

class MeditationProvider extends ChangeNotifier {
  final List<Meditationoptions> _options = [
    Meditationoptions(label: "1 min", value: Duration(minutes: 1)),
    Meditationoptions(label: "5 min", value: Duration(minutes: 5)),
    Meditationoptions(label: "10 min", value: Duration(minutes: 10)),
    Meditationoptions(label: "15 min", value: Duration(minutes: 15)),
    Meditationoptions(label: "20 min", value: Duration(minutes: 20)),
    Meditationoptions(label: "25 min", value: Duration(minutes: 25)),
    Meditationoptions(label: "30 min", value: Duration(minutes: 30)),
    Meditationoptions(label: "60 min", value: Duration(minutes: 60)),

    // Meditationoptions(label: "60 min", value: Duration(minutes: 60)),
  ];
  Meditationoptions? _selectedTime;
  // late Duration _currentDuration;

  // Timer?_sedionTimer;

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
  // gettersMeditationoptions? _selectedTime;
  late Duration _timer;
  final Duration _currentDuration = Duration.zero;
  late Duration _slidertime = Duration.zero;
  // late Timer? _timer1;
  bool _isPlaying = false;
  late Timer _timer1;
  late ConfettiController _confttieController;
  late double _slider=0.0;
  bool _buttonsActive= true;
  int? _streakCount;
  // bool  _streak=hasMeditatedToday;
  DateTime? _lastmed;

bool get hasMeditatedToday {
  // Get today's date formatted the same way it's saved (e.g., "2025-11-13")
  final today = DateTime.now().toLocal();
  final todayDateString = "${today.year}-${today.month}-${today.day}";
  
  // Return true if the saved last date matches today's date
  return todayDateString == _lastMeditationDate; 
}

  // getters
  Meditationoptions? get selectedOption => _selectedTime;
  List<Meditationoptions> get selectionOptions => _options;
  Duration? get medTime => _timer;
  bool get isPlaying => _isPlaying;
  Duration get sliderTime => _slidertime;
  ConfettiController get confettiController => _confttieController;
  double get slider =>_slider;
  bool get btn=>_buttonsActive;
  // bool get streak=>_streak;
  int? get streakCount =>_streakCount;

  void playConfetti() {
    _confttieController.play();
    notifyListeners();
  }

  void stioConfetti() {
    _confttieController.stop();
    notifyListeners();
  }

  @override
  void disposeConfettie() {
    _confttieController.dispose();
    super.dispose();
  }
void changeStreak(){

  
}
  // setters
  void setSelectionOption(Meditationoptions options) {
    _selectedTime = options;
    _timer = _selectedTime!.value;
    _confttieController = ConfettiController(
      duration: const Duration(seconds: 2),
    );

    notifyListeners();
  }

  void setplaying() {
    _isPlaying = true;
    notifyListeners();
  }

 getSliderPosititon(){
       notifyListeners();
       
}
  void settimer() {
    _slidertime = Duration.zero;
    _buttonsActive= true;
    _timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
      _slidertime+=const Duration(seconds: 1);
       _slider= (_slidertime.inSeconds/_timer.inSeconds)*100;

      notifyListeners();
      print("timer started, rn its $_slidertime");
      if(_slidertime == Duration(seconds: 3) || _timer .inSeconds-_slidertime.inSeconds==4 ) {
        _triggeraudio();
      }
      if (_slidertime >= _timer) {
        medEnd();
        _buttonsActive=false;
        notifyListeners();
      }
    });
  }
  @override
void dispose() {
  _timer1.cancel();
  // _audioplayer.dispose();
  // _confttieController.dispose();
  // super.dispose();
}



  
  void medEnd()async{
   _timer1.cancel();
    _isPlaying = false;
     _playUplifting();
      playConfetti();
      _playcrowd();
      completeMeditation();
    //  await prefs.setString('medCompletion','$DateTime.now')

    notifyListeners();
  }

  Duration calculateOnePercentDuration(Duration medTime) {
    const int divisionFactor = 100;
    final int totalSeconds = _timer.inSeconds;
    final double resultInSeconds = totalSeconds / divisionFactor;
    return Duration(milliseconds: (resultInSeconds * 1000).round());
  }

  late Duration actualTime;

  // audio player

  final AudioPlayer _audioplayer = AudioPlayer();

  void playAudio() {
    _audioplayer.setSourceAsset("audio/bell.mp3");
  }

  void play() async {
    _isPlaying = true;
    notifyListeners();
  }

  void pause() async {
    _isPlaying = false;
    notifyListeners();
  }

  void skipTenForward() {
    if (_slidertime +const Duration(seconds: 10)<_timer) {
    _slidertime=_slidertime + const Duration(seconds: 10);}


    notifyListeners();
  }

  void goTenBackwards() {
    if (_slidertime - const Duration(seconds: 10)>Duration(seconds: 1)) {
    _slidertime=_slidertime - const Duration(seconds: 10);}


    notifyListeners();
  }

  void add30Sconds() {
    _timer = _timer + const Duration(seconds: 30);
    notifyListeners();
  }

  void remove30Sconds() {
    if (_timer - const Duration(seconds: 30)>_slidertime) {

    _timer = _timer - const Duration(seconds: 30);}
    notifyListeners();
  }

  void pauseorplay() {
    _isPlaying ? pause() : play();
  }

void _triggeraudio() async {
  try {
    await _audioplayer.stop(); // stop any current play
    await _audioplayer.play(AssetSource("audio/bell.mp3"));
  } catch (e) {
    print("Audio play error: $e");
  }
}

  void _playUplifting() async {
    await _audioplayer.play(AssetSource("audio/uplifting.mp3"));
  }

  void _playcrowd() async {
    await _audioplayer.play(AssetSource("audio/crowd.mp3"));
  }
}
// void _streak()async{
// await /prefs.setString
// }