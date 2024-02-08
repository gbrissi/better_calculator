import 'package:better_calculator/providers/calculator_provider.dart';
import 'package:better_calculator/providers/custom_colors_provider.dart';
import 'package:better_calculator/providers/drawer_provider.dart';
import 'package:better_calculator/providers/tab_provider.dart';
import 'package:better_calculator/providers/theme_provider.dart';
import 'package:better_calculator/widgets/calculator.dart';
import 'package:better_calculator/widgets/theme_builder.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CalculatorProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DrawerProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TabProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CustomColorsProvider(),
        ),
      ],
      child: ThemeBuilder(
        builder: (ThemeData themeData) {
          return MaterialApp(
            title: 'Better Calculator',
            debugShowCheckedModeBanner: false,
            theme: themeData,
            home: ScrollConfiguration(
              behavior: MyCustomScrollBehavior(),
              child: const Calculator(),
            ),
          );
        },
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
