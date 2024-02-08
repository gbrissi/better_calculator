import 'package:better_calculator/providers/calculator_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CalcTextField extends StatefulWidget {
  const CalcTextField({
    super.key,
    // required this.text,
    required this.textColor,
  });
  // final String text;
  final Color textColor;

  @override
  State<CalcTextField> createState() => _CalcTextFieldState();
}

class _CalcTextFieldState extends State<CalcTextField> {
  late final _controller = context.read<CalculatorProvider>();
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();
  int get _cursorPosition => _textController.selection.baseOffset;

  void _keepTextFocusedAllTimes() {
    if (!_focusNode.hasFocus) {
      _focusNode.requestFocus();
    }
  }

  // TODO: Create a way to skip all floating points (if the next selection is a floating point, move to the next character)
  // Is it a mask?


  void _keepReactiveBehavior() {
    // Gets the char length diff between the new value and the old one.
    final int oldTextLength = _textController.text.length;
    final int curTextLength = _controller.viewInput.length;
    final int lengthDiff = curTextLength - oldTextLength;

    final int latestCursorPosition = _cursorPosition;
    // Update text value and keep old position updated.
    _textController.text = _controller.viewInput;
    _textController.selection = TextSelection.collapsed(
      offset: latestCursorPosition + lengthDiff,
    );
  }

  @override
  void initState() {
    RawKeyboard.instance.addListener(_listenKeyEvent);
    _focusNode.addListener(_keepTextFocusedAllTimes);
    _controller.addListener(_keepReactiveBehavior);

    super.initState();
  }

  @override
  void dispose() {
    RawKeyboard.instance.removeListener(_listenKeyEvent);
    _focusNode.removeListener(_keepTextFocusedAllTimes);
    _controller.removeListener(_keepReactiveBehavior);

    super.dispose();
  }

  Future<void> _listenKeyEvent(RawKeyEvent event) async {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        _moveCursorRight();
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        _moveCursorLeft();
      }
    }
  }

  void _moveCursorRight() {
    if (_cursorPosition < _textController.text.length) {
      final newPosition = TextSelection.collapsed(offset: _cursorPosition + 1);
      _textController.selection = newPosition;
    }
  }

  void _moveCursorLeft() {
    if (_cursorPosition > _textController.text.length) {
      final newPosition = TextSelection.collapsed(offset: _cursorPosition - 1);
      _textController.selection = newPosition;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      autofocus: true,
      showCursor: true,
      readOnly: true,
      focusNode: _focusNode,
      style: TextStyle(
        color: widget.textColor,
        fontSize: 38,
        fontWeight: FontWeight.bold,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
