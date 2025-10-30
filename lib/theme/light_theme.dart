import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: false,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    tertiary: Colors.grey.shade500,
    secondaryContainer:  Colors.white,
    primary: const Color.fromARGB(255, 97, 97, 97),
    secondary: const Color.fromARGB(255, 168, 166, 166),
    inversePrimary: Colors.grey.shade900,
    onSurface:Colors.grey.shade400
  )

);