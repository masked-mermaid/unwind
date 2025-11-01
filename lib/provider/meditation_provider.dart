import 'dart:async';

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
  late Duration _timer;
  late Duration _slidertime = Duration.zero;
  bool _isPlaying = false;
  Timer? _timer1;
  ConfettiController? _confettiController;
  double _slider = 0.0;
  bool _buttonsActive = true;

  // getters
  Meditationoptions? get selectedOption => _selectedTime;
  List<Meditationoptions> get selectionOptions => _options;
  Duration? get medTime => _timer;
  bool get isPlaying => _isPlaying;
  Duration get sliderTime => _slidertime;
  ConfettiController? get confettiController => _confettiController;
  double get slider => _slider;
  bool get btn => _buttonsActive;

  void playConfetti() {
    _confettiController?.play();
    notifyListeners();
  }

  void stopConfetti() {
    _confettiController?.stop();
    notifyListeners();
  }

  void disposeConfetti() {
    _confettiController?.dispose();
    _confettiController = null;
  }
  // setters
  void setSelectionOption(Meditationoptions options) {
    _selectedTime = options;
    _timer = _selectedTime!.value;
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );

    notifyListeners();
  }

  void setplaying() {
    _isPlaying = true;
    notifyListeners();
  }

  void settimer() {
    if (_timer1?.isActive ?? false) return;
    
    _slidertime = Duration.zero;
    _buttonsActive = true;
    
    if (_timer.inSeconds == 0) return;
    
    _timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
      _slidertime += const Duration(seconds: 1);
      _slider = (_slidertime.inSeconds / _timer.inSeconds) * 100;

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
    void stopSession() {
    _timer1?.cancel();
    _timer1 = null;
    _isPlaying = false;
    _buttonsActive = true;
    _slidertime = Duration.zero;
    _slider = 0.0;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer1?.cancel();
    _audioplayer.dispose();
    disposeConfetti();
    super.dispose();
  }



  
  void medEnd() async {
    _timer1?.cancel();
    _timer1 = null;
    _isPlaying = false;
    
    // Play sounds in sequence
    try {
      await _audioplayer.stop();
      await _audioplayer.play(AssetSource("audio/uplifting.mp3"));
      await Future.delayed(const Duration(milliseconds: 500));
      await _audioplayer.play(AssetSource("audio/crowd.mp3"));
    } catch (e) {
      print("Audio play error in medEnd: $e");
    }
    
    playConfetti();
    notifyListeners();
  }

  Duration calculateOnePercentDuration(Duration medTime) {
    const int divisionFactor = 100;
    final int totalSeconds = _timer.inSeconds;
    final double resultInSeconds = totalSeconds / divisionFactor;
    return Duration(milliseconds: (resultInSeconds * 1000).round());
  }

  // audio player

  final AudioPlayer _audioplayer = AudioPlayer();

  void playAudio() {
    _audioplayer.setSourceAsset("audio/bell.mp3");
  }

  void play() {
    _isPlaying = true;
    settimer();
    notifyListeners();
  }

  void pause() {
    _isPlaying = false;
    _timer1?.cancel();
    notifyListeners();
  }

  void skipTenForward() {
    if (_slidertime + const Duration(seconds: 10) < _timer) {
      _slidertime = _slidertime + const Duration(seconds: 10);
      notifyListeners();
    }
  }

  void goTenBackwards() {
    if (_slidertime - const Duration(seconds: 10) > Duration(seconds: 1)) {
      _slidertime = _slidertime - const Duration(seconds: 10);
      notifyListeners();
    }
  }

  void add30Seconds() {
    _timer = _timer + const Duration(seconds: 30);
    notifyListeners();
  }

  void remove30Seconds() {
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

}
// void _streak()async{
// await /prefs.setString
// }