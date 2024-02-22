import 'dart:io';

import 'package:better_calculator/src/providers/drawer_provider.dart';
import 'package:better_calculator/src/widgets/title_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Shell extends StatelessWidget {
  const Shell({
    super.key,
    required this.child,
  });
  final Widget child;
  bool get isTitleBarSupported {
    if (kIsWeb) return false;
    if (Platform.isAndroid) return false;
    if (Platform.isIOS) return false;
    if (Platform.isFuchsia) return false;
    if (Platform.isLinux) return true;
    if (Platform.isMacOS) return true;
    if (Platform.isWindows) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebPrevBuilder(
        child: Column(
          children: [
            if (isTitleBarSupported) const TitleBar(),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class WebPrevBuilder extends StatelessWidget {
  final Widget child;
  const WebPrevBuilder({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Selector<DrawerProvider, bool>(
                selector: (_, provider) => provider.isOpen,
                builder: (_, isOpen, __) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    width: !isOpen ? 320 : 320 * 2,
                    height: 640,
                    child: child,
                  );
                },
              ),
            ),
            const Opacity(
              opacity: 0.8,
              child: Column(
                children: [
                  Text(
                    "this is a web preview for a desktop app",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    "the application may not behave as expected",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    return child;
  }
}
