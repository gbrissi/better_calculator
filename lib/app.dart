import 'package:better_calculator/providers/calculator_provider.dart';
import 'package:better_calculator/providers/drawer_provider.dart';
import 'package:better_calculator/providers/tab_provider.dart';
import 'package:better_calculator/providers/theme_provider.dart';
import 'package:better_calculator/widgets/calculator.dart';
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
      ],
      child: Consumer<ThemeProvider>(
        builder: (_, provider, __) {
          return MaterialApp(
            title: 'Better Calculator',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: provider.curTheme.brightness,
              colorScheme: ColorScheme.fromSeed(
                brightness: provider.curTheme.brightness,
                seedColor: provider.curTheme.colorSeed,
              ),
              useMaterial3: true,
            ),
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
