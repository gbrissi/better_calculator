import 'package:better_calculator/providers/calculator_provider.dart';
import 'package:better_calculator/widgets/calculator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalculatorProvider(),
      child: MaterialApp(
        title: 'Better Calculator',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: Color(
              int.parse("4B0082", radix: 16),
            ),
          ),
          useMaterial3: true,
        ),
        home: const Calculator(),
      ),
    );
  }
}
