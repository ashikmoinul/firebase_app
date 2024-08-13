import 'package:firebase_app/ui/screens/match_list_screen.dart';
import 'package:flutter/material.dart';


class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MatchListScreen(),
      theme: _lightTheme(),
    );
  }

  ThemeData _lightTheme() {
    return ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromWidth(double.maxFinite),
                padding: const EdgeInsets.symmetric(vertical: 12)
            )
        )
    );
  }
}