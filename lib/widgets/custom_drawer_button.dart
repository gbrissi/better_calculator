import 'package:better_calculator/providers/drawer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CDrawerButton extends StatelessWidget {
  const CDrawerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DrawerProvider>(
      builder: (_, provider, child) {
        return IconButton(
          onPressed:
              provider.isOpen ? provider.closeDrawer : provider.openDrawer,
          icon: const Icon(
            Icons.menu,
          ),
        );
      },
    );
  }
}
