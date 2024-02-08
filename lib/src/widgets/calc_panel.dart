
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_provider.dart';
import '../services/color_utils.dart';
import 'calc_text_field.dart';

class CalcPanel extends StatefulWidget {
  const CalcPanel({super.key});

  @override
  State<CalcPanel> createState() => _CalcPanelState();
}

class _CalcPanelState extends State<CalcPanel> {
  Color get panelColor => Theme.of(context).canvasColor;
  Color get textColor => ColorUtils.getAdaptiveTextColor(panelColor);
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, provider, child) {
        return Material(
          color: panelColor,
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: IntrinsicWidth(
                                child: CalcTextField(
                                  // text: provider.viewInput,
                                  textColor: textColor,
                                ),
                              ),
                            ),
                            SelectableText(
                              provider.calcResultView,
                              enableInteractiveSelection: true,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (provider.showParseError)
                const Text(
                  "ERROR: Couldn't parse the current expression.",
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.red,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
