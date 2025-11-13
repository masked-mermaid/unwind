import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unwind/data/quotes/get_quotes.dart';
import 'package:unwind/pages/homepage.dart';

class Intropage extends StatelessWidget {
  Intropage({super.key});

  final List<PageViewModel> listPagesViewModel = [
    

    PageViewModel(
      title: "Welcome to UNWIND",
      body:
          "Unwind is a mental health focused app. It is built with love to help you build a meditation habit with daily inspiration, customizable sessions, and a serene interface.",
      image: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: Center(child: Image.asset('assets/applogo/1.png', scale: 3)),
      ),
    ),
    PageViewModel(
      title: "Find Your Calm",
      body:
          "Consistency is the key to peace. Meditate daily, grow stronger mentally, and let Unwind be your calm companion.",
      image: Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: Center(
          child: Image.asset('assets/applogo/ligh.png', scale: 0.5),
        ),
      ),
    ),
  ];

  Future<void> _completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const Homepage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
    
      pages: listPagesViewModel,
      showNextButton: true,
      showSkipButton: false,
      onDone: ()  {
  // fetchAndSaveQuotes();

    _completeOnboarding(context);},
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
