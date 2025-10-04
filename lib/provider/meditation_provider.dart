import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:unwind/models/meditationoptions.dart';

class MeditationProvdier extends ChangeNotifier{


final List<Meditationoptions> _options=[

  
  Meditationoptions(label: "5 min", value: Duration(minutes: 5)),
  Meditationoptions(label: "10 min", value: Duration(minutes: 10)),
  Meditationoptions(label: "15 min", value: Duration(minutes: 15)),
  Meditationoptions(label: "20 min", value: Duration(minutes: 20)),
  Meditationoptions(label: "25 min", value: Duration(minutes: 25)),
  Meditationoptions(label: "30 min", value: Duration(minutes: 30)),
  Meditationoptions(label: "45 min", value: Duration(minutes: 45)),
  Meditationoptions(label: "60 min", value: Duration(minutes: 60)),

];
Meditationoptions? _selectedTime;
Duration? _timer;

// getters
Meditationoptions? get selectedOption => _selectedTime;
List<Meditationoptions> get selectionOptions=> _options;
Duration? get timer=> _timer;
bool get isPlaying=> _isPlaying;

// setters
void setSelectionOption(Meditationoptions options){
  _selectedTime =options;
Duration _timer= _selectedTime!.value;

  notifyListeners();
}


// audio player

final AudioPlayer _audioplayer= AudioPlayer();

void playAudio(){
_audioplayer.setSourceAsset("audio/bell.mp3");
}


bool _isPlaying= false;

void play() async{
 _isPlaying =true;
 notifyListeners();
}

void pause() async{
  _isPlaying=false;
  notifyListeners();
  }

  void skipTenForward(){

_timer! + Duration(seconds: 10);
notifyListeners();
  }
  void goTenBackwards(){
_timer! + Duration(seconds: 10);
notifyListeners();
  }


void add30Sconds(){
_selectedTime!.value + Duration(seconds: 30);
notifyListeners();


}

void remove30Sconds(){
_selectedTime!.value - Duration(seconds: 30);


}
void provideEndTime(){

}

}