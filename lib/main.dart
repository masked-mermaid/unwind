import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unwind/boxes.dart';
import 'package:unwind/data/quotes/get_quotes.dart';
import 'package:unwind/models/quotes.dart';
import 'package:unwind/pages/homepage.dart';
import 'package:unwind/pages/intropage.dart';
import 'package:unwind/provider/meditation_provider.dart';
import 'package:unwind/provider/quotes_provider.dart';
import 'package:unwind/provider/userdata_provider.dart';
import 'package:unwind/theme/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(QuotesAdapter());

  // Open quotes box
  box = await Hive.openBox<Quotes>('quotesbox');

  // Fetch quotes (if needed)
  fetchAndSaveQuotes();

  // Check if user has seen onboarding
  final prefs = await SharedPreferences.getInstance();
  final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

  // Run app with providers
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => QuotesProvider()),
        ChangeNotifierProvider(create: (_) => UserDataProvider()),
        ChangeNotifierProvider(create: (_) => MeditationProvider()),
      ],
      child: MyApp(hasSeenOnboarding: hasSeenOnboarding),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool hasSeenOnboarding;

  const MyApp({super.key, required this.hasSeenOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: hasSeenOnboarding ? const Homepage() : Intropage(),
    );
  }
}
