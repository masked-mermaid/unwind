import 'package:unwind/models/quotes.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';




   Future <void> fetchAndSaveQuotes () async {

    // fetch 
    final response = await http.get(Uri.parse("https://zenquotes.io/api/quotes"));
    if(response.statusCode==200){
      final List data = json.decode(response.body);

      final  box =await Hive.openBox<Quotes>('quotesbox'); 
      await box.clear();

      // for (var item in data){
      //   final quote= Quotes(quote: item["q"], author: item["a"], characterCount: item["c"]);
      //   await box.add(quote)};

      final quotes = data.map((item){
        return Quotes(quote: item["q"],
         author: item["a"],
         characterCount: int.tryParse(item["c"]?? "0")??0);
      }).toList();
      await box.addAll(quotes);
      print('box length = ${box.length}');
      
      
    }else {throw Exception("failed to fetch quotes");}


    }
    void main() async{
     await fetchAndSaveQuotes();
      print("Data fetching complete!");
      
    }






  


