import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_provider.dart';
import '../providers/custom_colors_provider.dart';
import '../providers/drawer_provider.dart';
import '../providers/history_provider.dart';
import '../providers/tab_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/calculator.dart';
import '../widgets/theme_builder.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DrawerProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HistoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TabProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CustomColorsProvider(),
        ),
        ChangeNotifierProxyProvider<HistoryProvider, CalculatorProvider>(
          create: (_) => CalculatorProvider(),
          update: (_, firstProvider, secondProvider) {
            secondProvider!.setHistoryProvider(firstProvider);
            return secondProvider;
          },
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
