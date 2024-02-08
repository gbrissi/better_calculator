import 'package:better_calculator/widgets/row_separated.dart';
import 'package:better_calculator/widgets/tab_button.dart';
import 'package:flutter/material.dart';

class TabProperties {
  final String text;

  TabProperties({
    required this.text,
  });
}

class TabModel {
  final TabProperties tab;
  final Widget body;

  TabModel({
    required this.tab,
    required this.body,
  });
}

class PanelTabView extends StatefulWidget {
  const PanelTabView({
    super.key,
    required this.tabs,
  });
  final List<TabModel> tabs;

  @override
  State<PanelTabView> createState() => _PanelTabViewState();
}

class _PanelTabViewState extends State<PanelTabView> {
  late TabModel selectedTab = widget.tabs[0];

  void _setTab(TabModel tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: RowSeparated(
                spacing: 8,
                children: widget.tabs
                    .map(
                      (e) => TabButton(
                        text: e.tab.text,
                        onTap: () => _setTab(e),
                        isActive: selectedTab.hashCode == e.hashCode,
                      ),
                    )
                    .toList(),
              ),
            ),
            Flexible(
              child: selectedTab.body,
            ),
          ],
        ),
      ),
    );
  }
}
