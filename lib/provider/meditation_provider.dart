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

// getters
Meditationoptions? get selectedOption => _selectedTime;
List<Meditationoptions> get selectionOptions=> _options;

// setters
void setSelectionOption(Meditationoptions options){
  _selectedTime =options;
  notifyListeners();
}



}