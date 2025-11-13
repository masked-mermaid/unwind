import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'; // Added for clarity, though often imported via material

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage>
    with SingleTickerProviderStateMixin {
      
  // 🐛 FIX 1: Declare as simple 'late' or instance variables, not 'late final'.
  // The value of _randomIndex is set inside initState.
  late int _randomIndex;
  
  // These are correctly late since they are initialized in initState
  late AnimationController _controller;
  late Animation<Color?> _glowColor;

  // 🔸 Define the maximum number of GIFs.
  final int totalShreks = 25; 

  @override
  void initState() {
    super.initState();

    // Pick a random gif number (1 to totalShreks inclusive)
    // The value is assigned to the 'late' variable _randomIndex
    _randomIndex = Random().nextInt(totalShreks) + 1;

    // Glowing border animation
    _controller = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 1500), // Slightly faster cycle
    )..repeat(reverse: true);

    _glowColor = ColorTween(
      begin: Colors.amber.shade400,
      end: Colors.amberAccent.shade700,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Construct the asset path here once
    final String assetPath = 'assets/shreks/$_randomIndex.gif';

    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 100),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    // Border uses the animated color value
                    border: Border.all(
                      color: _glowColor.value ?? Colors.amber,
                      width: 8,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    // Adding a BoxShadow for the glowing effect
                    boxShadow: [
                      BoxShadow(
                        color: (_glowColor.value ?? Colors.amber).withOpacity(0.8),
                        blurRadius: 25,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: child, // Use the child argument to prevent the image from rebuilding
                );
              },
              // The GIF image itself, which doesn't need to rebuild with the animation
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  assetPath,
                  fit: BoxFit.cover,
                  // ❗ Important: Handle potential asset loading errors
                  errorBuilder: (context, error, stackTrace) {
                    // Show a fallback widget if the GIF number is missing
                    return const Icon(Icons.error, color: Colors.red, size: 200);
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          const Center(
            child: Text(
              'HAHA! GET REKED NOOB!! XD XD!! \n \nWHAT A NERD LOL!!! 😆😆',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.amberAccent,
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
          ),
        ],
      ),
    );
  }
}