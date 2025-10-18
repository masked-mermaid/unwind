import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:unwind/models/quotes.dart';
import 'dart:convert';


class QuotesProvider extends ChangeNotifier {
  late Box<Quotes> _quotesBox;
  Quotes? _currentQuote;
  DateTime _now = DateTime.now();
  DateTime? _previousUpdate;
  int _quoteIndex=0;

  Quotes? get currentQuote => _currentQuote;
  int get quoteIndex=> _quoteIndex;

  void isIt6Hours(){

    // Initialize _previousUpdate if it's null
    _previousUpdate ??= _now;

    // check if at least 6 hours have passed since last update
    if (_now.difference(_previousUpdate!).inHours >= 6) {
      // perform update actions here, e.g. fetchAndSaveQuotes();
      (_quoteIndex%50)+1;
      _previousUpdate = _now;
      notifyListeners();
    }
  }



  Future <void> fetchAndSaveQuotes () async {

    // fetch 
    final response = await http.get(Uri.parse("https://zenquotes.io/api/quotes"));
    if(response.statusCode==200){
      final List data = json.decode(response.body);

// init box
      final  box =await Hive.openBox<Quotes>('quotesbox'); 

      // write to box
      await box.clear();

      final quotes = data.map((item){
        return Quotes(quote: item["q"],
         author: item["a"],
         characterCount: int.tryParse(item["c"]?? "0")??0);
      }).toList();
      await box.addAll(quotes);
      quotes.sort((a, b) => a.characterCount.compareTo(b.characterCount),);
      print('box length = ${box.length}');
      
      
    }else {throw Exception("failed to fetch quotes");}


    }
}