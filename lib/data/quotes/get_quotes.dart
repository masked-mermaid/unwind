import 'package:unwind/boxes.dart';
import 'package:unwind/data/quotes/quotes.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';


class Getquotes {

  static Future <void> fetchAndSaveQuotes () async {

    // fetch 
    final response = await http.get(Uri.parse("https://zenquotes.io/api/quotes"));
    if(response.statusCode==200){
      final List data = json.decode(response.body);

      final  box =await Hive.openBox<Quotes>('quotesbox'); 

      for (var item in data){
        final quote= Quotes(quote: item["q"], author: item["a"], characterCount: item["c"]);
        await box.add(quote);
      }
    }else {throw Exception("failed to fetch quotes");}


    }






  }


