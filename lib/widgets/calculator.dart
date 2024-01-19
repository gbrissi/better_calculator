import 'package:better_calculator/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TitleBar(),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 18,
                  child: Container(color: Colors.red),
                ),
                Expanded(
                  flex: 39,
                  child: Container(color: Colors.yellow),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
