import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:unwind/models/meditationoptions.dart';

class MeditationProvdier extends ChangeNotifier{


final List<Meditationoptions> _options=[

  Meditationoptions(label: "1 min", value: Duration(minutes: 1)),
  Meditationoptions(label: "5 min", value: Duration(minutes: 5)),
  Meditationoptions(label: "10 min", value: Duration(minutes: 10)),
  Meditationoptions(label: "15 min", value: Duration(minutes: 15)),
  Meditationoptions(label: "20 min", value: Duration(minutes: 20)),
  Meditationoptions(label: "25 min", value: Duration(minutes: 25)),
  Meditationoptions(label: "30 min", value: Duration(minutes: 30)),
  Meditationoptions(label: "45 min", value: Duration(minutes: 45)),
  // Meditationoptions(label: "60 min", value: Duration(minutes: 60)),

];
Meditationoptions? _selectedTime;
// late Duration _currentDuration;

// Timer?_sedionTimer;

// gettersMeditationoptions? _selectedTime;
late Duration _timer;
Duration _currentDuration=Duration.zero;
late double _slidertime=0;
// late Timer? _timer1;
bool _isPlaying= false;
late Timer _timer1;
late ConfettiController _confttieController;


// getters
Meditationoptions? get selectedOption => _selectedTime;
List<Meditationoptions> get selectionOptions=> _options;
Duration? get medTime=> _timer;
bool get isPlaying=> _isPlaying;
double get sliderTime=> _slidertime;
ConfettiController get confettiController=>_confttieController;


void playConfetti(){
  _confttieController.play();
  notifyListeners();
}
void stioConfetti(){
  _confttieController.stop();
  notifyListeners();
}@override
void disposeConfettie(){
  _confttieController.dispose();
  super.dispose();
}

// setters
void setSelectionOption(Meditationoptions options){
  _selectedTime =options;
_timer= _selectedTime!.value;
_confttieController = ConfettiController(duration: const Duration(seconds: 2));


  notifyListeners();
}

void setplaying(){
  _isPlaying=true;
  notifyListeners();
}


void settimer() {
  if (medTime != null && _isPlaying ) {
_slidertime=0;
   _timer1= Timer.periodic(
      calculateOnePercentDuration(medTime!),
      (timer) {
        _slidertime++;
        notifyListeners();
        print("timer started and renning $_slidertime");
        if (_slidertime==2||_slidertime==98){
          _triggeraudio();
        }
        if (_slidertime==100){
medEnd();
        }
      },
    );
  }
}
@override
void disposeTimer() {
  _timer1?.cancel();
  // _timer1 = null;
  // super.dispose();
}
void medEnd(){
  disposeTimer();
  _isPlaying=false;
Future.delayed(const Duration(seconds: 3),(){
  _playUplifting();
playConfetti();
_playcrowd();

});


notifyListeners();

}

Duration calculateOnePercentDuration(Duration medTime) {
  const int divisionFactor = 100;
  final int totalSeconds = medTime.inSeconds;
  final double resultInSeconds = totalSeconds / divisionFactor;
  return Duration(milliseconds: (resultInSeconds * 1000).round());
}
late Duration actualTime;




// audio player

final AudioPlayer _audioplayer= AudioPlayer();


void playAudio(){
_audioplayer.setSourceAsset("audio/bell.mp3");

}




void play() async{
 _isPlaying =true;
 notifyListeners();
}

void pause() async{
  _isPlaying=false;
  notifyListeners();
  }

  void skipTenForward(){

medTime! + Duration(seconds: 10);
print(medTime);
notifyListeners();
  }
  void goTenBackwards(){
medTime! + Duration(seconds: 10);
print(medTime);

notifyListeners();
  }


void add30Sconds(){
_timer! + Duration(seconds: 30);
print("timer is $_timer");
notifyListeners();


}

void remove30Sconds(){
_timer! - Duration(seconds: 30);
print("timer is $_timer");
notifyListeners();


}

void pauseorplay(){
  _isPlaying ? pause():play();
}
void provideEndTime(){

}
void _triggeraudio() async{

  await _audioplayer.play(AssetSource("audio/bell.mp3"));


}
void _playUplifting()async{
  await _audioplayer.play(AssetSource("audio/uplifting.mp3"));
}
void _playcrowd()async{
  await _audioplayer.play(AssetSource("audio/crowd.mp3"));
}
       
}