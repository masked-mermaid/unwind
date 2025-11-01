import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:unwind/boxes.dart';
import 'package:unwind/models/quotes.dart';
import 'dart:convert';


class QuotesProvider extends ChangeNotifier {
  late final Box _quotesBox =box;
  Quotes? _currentQuote;
  DateTime? _previousUpdate;
  int _quoteIndex=0;

  Quotes? get currentQuote => _currentQuote;
  int get quoteIndex=> _quoteIndex;

  void isIt6Hours() {
    final now = DateTime.now();
    _previousUpdate ??= now;

    if (now.difference(_previousUpdate!).inHours >= 6) {
      final boxLength = _quotesBox.length;
      if (boxLength > 0) {
        _quoteIndex = (_quoteIndex + 1) % boxLength;
        _currentQuote = _quotesBox.getAt(_quoteIndex);
      }
      
      _previousUpdate = now;
      notifyListeners();
      
      // Fetch new quotes when we're near the end
      if (_quoteIndex >= boxLength - 5) {
        fetchAndSaveQuotes();
      }
    }
  }

  Future<void> fetchAndSaveQuotes() async {
    try {
      final response = await http.get(Uri.parse("https://zenquotes.io/api/quotes"));
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        
        final quotes = data.map((item) => Quotes(
          quote: item["q"],
          author: item["a"],
          characterCount: int.tryParse(item["c"] ?? "0") ?? 0
        )).toList();

        // Sort before saving
        quotes.sort((a, b) => a.characterCount.compareTo(b.characterCount));
        
        // Update box atomically
        await _quotesBox.clear();
        await _quotesBox.addAll(quotes);
        
        // Update current quote if needed
        if (quotes.isNotEmpty) {
          _quoteIndex = 0;
          _currentQuote = quotes[0];
          notifyListeners();
        }
      } else {
        print('Failed to fetch quotes: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching quotes: $e');
      // Use existing quotes if available
      if (_quotesBox.isNotEmpty && _currentQuote == null) {
        _currentQuote = _quotesBox.getAt(0);
        notifyListeners();
      }
    }


     }
    }
  