import 'package:better_calculator/src/widgets/tab_view.dart';
import 'package:flutter/material.dart';

import 'appearance_panel.dart';
import 'history_panel.dart';

class SidePanel extends StatelessWidget {
  const SidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return PanelTabView(
      tabs: [
        TabModel(
          tab: TabProperties(text: "History"),
          body: const HistoryPanel(),
        ),
        TabModel(
          body: const AppearancePanel(),
          tab: TabProperties(
            text: "Appearance",
          ),
        ),
      ],
    );
  }
}
