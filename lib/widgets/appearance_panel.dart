import 'package:better_calculator/providers/custom_colors_provider.dart';
import 'package:better_calculator/widgets/select_color_option.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../services/preset_colors.dart';
import 'color_option.dart';

class AppearancePanel extends StatelessWidget {
  const AppearancePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, provider, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SwitchListTile(
                title: const Text("Adaptative theme"),
                subtitle: const Text(
                  "Replicates your system theme",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                value: provider.isAdaptiveThemeSet,
                onChanged: provider.setAdaptiveThemeState,
              ),
            ),
            IgnorePointer(
              ignoring: provider.isAdaptiveThemeSet,
              child: Opacity(
                opacity: provider.isAdaptiveThemeSet ? 0.5 : 1.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Define your theme settings",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: SwitchListTile(
                        title: const Text("Dark mode"),
                        subtitle: const Text(
                          "Activate dark mode UI",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        value: provider.manualThemeIsDark,
                        onChanged: (_) => provider.setThemeBrightnessMode(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Text(
                              "Select your app color",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Consumer<CustomColorsProvider>(
                            builder: (_, provider, __) {
                              return Wrap(
                                spacing: 4,
                                runSpacing: 4,
                                children: List.from(
                                  [
                                    ...PresetColors.colors.map(
                                      (e) => ColorOption(color: e),
                                    ),
                                    ...provider.customColors.map(
                                      (e) => ColorOption(
                                        color: e,
                                      ),
                                    ),
                                    const SelectColorOption()
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
