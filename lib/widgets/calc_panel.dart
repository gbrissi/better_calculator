import 'package:better_calculator/services/color_utils.dart';
import 'package:better_calculator/widgets/calc_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_provider.dart';

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
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
          child: Material(
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
                              Text(
                                provider.calcResultView,
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
          ),
        );
      },
    );
  }
}
