import 'package:better_calculator/providers/drawer_provider.dart';
import 'package:better_calculator/widgets/calc_digits.dart';
import 'package:better_calculator/widgets/custom_drawer_button.dart';
import 'package:better_calculator/widgets/shell.dart';
import 'package:better_calculator/widgets/side_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calc_panel.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Shell(
      child: Selector<DrawerProvider, bool>(
        selector: (_, provider) => provider.isOpen,
        builder: (_, isOpen, __) {
          return Row(
            children: [
              const Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 18,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.end,
                                      children: [
                                        CDrawerButton(),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: CalcPanel(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 39,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: CalcDigits(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              isOpen
                  ? const Expanded(
                      child: SidePanel(),
                    )
                  : null,
            ].whereType<Widget>().toList(),
          );
        },
      ),
    );
  }
}
