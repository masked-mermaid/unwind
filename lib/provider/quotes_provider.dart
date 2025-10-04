import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:unwind/models/quotes.dart';
import 'dart:convert';


class QuotesProvider extends ChangeNotifier {
  late Box<Quotes> _quotesBox;
  Quotes? _currentQuote;

  Quotes? get currentQuote => _currentQuote;

  // ✅ Initialize: open Hive and load first quote
  Future<void> init() async {
    _quotesBox = await Hive.openBox<Quotes>('quotesbox');

    // If box is empty, fetch fresh quotes
    if (_quotesBox.isEmpty) {
      await fetchAndSaveQuotes();
    }

    _loadQuote();
  }

  // ✅ Fetch from API and save into Hive
  Future<void> fetchAndSaveQuotes() async {
    final response = await http.get(Uri.parse("https://zenquotes.io/api/quotes"));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);

      await _quotesBox.clear();

      final quotes = data.map((item) {
        return Quotes(
          quote: item["q"],
          author: item["a"],
          characterCount: int.tryParse(item["c"] ?? "0") ?? 0,
        );
      }).toList();

      await _quotesBox.addAll(quotes);
      print('Fetched & saved ${_quotesBox.length} quotes');
    } else {
      throw Exception("Failed to fetch quotes");
    }
  }

  // ✅ Load one unused quote
  void _loadQuote() {
    try {
      final unusedQuote = _quotesBox.values.firstWhere(
        (q) => q.used == false,
        orElse: () => _quotesBox.values.first,
      );

      unusedQuote.used = true;
      unusedQuote.save();

      _currentQuote = unusedQuote;
      notifyListeners();
    } catch (e) {
      print("Error loading quote: $e");
    }
  }

  // ✅ Manual refresh
  void refreshQuote() {
    _loadQuote();
  }
  Future<void> main() async {
    await fetchAndSaveQuotes();
  }
}
