import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unwind/boxes.dart';
import 'package:unwind/data/quotes/get_quotes.dart';
import 'package:unwind/models/quotes.dart';
import 'package:unwind/pages/homepage.dart';
import 'package:unwind/provider/meditation_provider.dart';
import 'package:unwind/provider/quotes_provider.dart';
import 'package:unwind/theme/theme_provider.dart';

Future <void> main() async {
WidgetsFlutterBinding.ensureInitialized();

  // init hive
  await Hive.initFlutter();

  // quotes adapter
  Hive.registerAdapter(QuotesAdapter());

  //  init box
  box =await Hive.openBox<Quotes>('quotesbox'); 
fetchAndSaveQuotes();



  runApp(MultiProvider(providers: [
ChangeNotifierProvider(create: (context)=>ThemeProvider()),
ChangeNotifierProvider(create: (context)=>MeditationProvdier()),
 ChangeNotifierProvider(create:(context)=>QuotesProvider())
 
    ],
    child: const MyApp(),));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: Homepage(),
    );
  }
}