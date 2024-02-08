import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_provider.dart';

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
  late final TextEditingController _textController =
      _controller.inputController;

  void _keepTextFocusedAllTimes() {
    if (!_focusNode.hasFocus) {
      _focusNode.requestFocus();
    }
  }

  @override
  void initState() {
    _focusNode.addListener(_keepTextFocusedAllTimes);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_keepTextFocusedAllTimes);
    super.dispose();
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
