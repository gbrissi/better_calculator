import 'package:better_calculator/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeBuilder extends StatelessWidget {
  const ThemeBuilder({
    super.key,
    required this.builder,
  });
  final Widget Function(ThemeData theme) builder;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, provider, child) {
        if (provider.isLoad) {
          return builder(
            ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                brightness: provider.curTheme.brightness,
                seedColor: provider.curTheme.colorSeed,
              ),
            ),
          );
        }

        return const Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Text(
                    "Loading theme settings...",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
