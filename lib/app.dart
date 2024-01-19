import 'package:better_calculator/widgets/calculator.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Better Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Color(
            int.parse("00FFCC", radix: 16),
          ),
        ),
        useMaterial3: true,
      ),
      home: const Calculator(),
    );
  }
}
