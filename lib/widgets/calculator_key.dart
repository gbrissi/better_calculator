import 'package:better_calculator/providers/calculator_provider.dart';
import 'package:better_calculator/services/color_utils.dart';
import 'package:better_calculator/services/regex_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

enum KeyType {
  cOperator,
  number,
}

class CalculatorKey extends StatefulWidget {
  CalculatorKey({
    super.key,
    String? cLabel,
    this.iconRepresentation,
    this.customTapBehavior,
    required this.logicalKey,
  }) : label = cLabel ?? logicalKey.keyLabel;

  final LogicalKeyboardKey logicalKey;
  final void Function()? customTapBehavior;
  final String label;
  final IconData? iconRepresentation;

  @override
  State<CalculatorKey> createState() => _CalculatorKeyState();
}

class _CalculatorKeyState extends State<CalculatorKey> {
  late final _controller = context.read<CalculatorProvider>();
  final GlobalKey _calcKey = GlobalKey();
  final GlobalKey _inkWellKey = GlobalKey();
  final _inkWellController = MaterialStatesController();

  KeyType get _keyType => RegexUtils.numberRegExp.hasMatch(_keyChar)
      ? KeyType.number
      : KeyType.cOperator;
      
  String get _keyLabel => widget.label;
  String get _keyChar => widget.logicalKey.keyLabel;
  Color get _buttonColor => _keyType == KeyType.number
      ? Theme.of(context).colorScheme.primary
      : Theme.of(context).colorScheme.secondary;
  Color get _textColor => ColorUtils.getAdaptiveTextColor(_buttonColor);
  double _keyHeight = 0;

  void Function() get _onTapBehavior =>
      widget.customTapBehavior ?? _updateExpression;

  void _updateExpression() {
    print("Button pressed: ${widget.logicalKey.keyLabel}, $_keyChar");
    _controller.addCharacterToCalc(
      _keyChar,
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final double size = _calcKey.currentContext!.size!.width;
      RawKeyboard.instance.addListener(_listenKeyEvent);
      if (mounted) setState(() => _keyHeight = size);
    });

    super.initState();
  }

  @override
  void dispose() {
    RawKeyboard.instance.removeListener(_listenKeyEvent);
    super.dispose();
  }

  Future<void> _listenKeyEvent(RawKeyEvent event) async {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == widget.logicalKey) {
        _onTapBehavior();
      }
    }
  }

  Widget get _keyRepresentation => widget.iconRepresentation != null
      ? Icon(
          widget.iconRepresentation,
          color: _textColor,
          weight: 1000,
          size: _keyHeight / 3,
        )
      : Text(
          _keyLabel,
          style: TextStyle(
            fontSize: _keyHeight / 3,
            fontWeight: FontWeight.bold,
            color: _textColor,
          ),
        );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // final double keySize = constraints.maxHeight < constraints.maxWidth
        //     ? constraints.maxHeight
        //     : constraints.maxWidth;

        return SizedBox(
          key: _calcKey,
          // width: keySize,
          // height: keySize,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Material(
              color: _buttonColor,
              child: InkWell(
                key: _inkWellKey,
                statesController: _inkWellController,
                onTap: _onTapBehavior,
                child: Center(
                  child: _keyRepresentation,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
