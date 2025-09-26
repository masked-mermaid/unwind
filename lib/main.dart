import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unwind/pages/homepage.dart';
import 'package:unwind/provider/meditation_provider.dart';
import 'package:unwind/theme/theme_provider.dart';

void main(){
  runApp(MultiProvider(providers: [
ChangeNotifierProvider(create: (context)=>ThemeProvider()),
ChangeNotifierProvider(create: (context)=>MeditationProvdier())
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