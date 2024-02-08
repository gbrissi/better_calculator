import 'package:flutter/material.dart';

class SimpleDate {
  final int year;
  final int month;
  final int day;

  SimpleDate({
    required this.year,
    required this.month,
    required this.day,
  });

  bool equals(SimpleDate simpleDate) {
    bool isSameYear = simpleDate.year == year;
    bool isSameMonth = simpleDate.month == month;
    bool isSameDay = simpleDate.day == day;
    return isSameYear && isSameMonth && isSameDay;
  }

  SimpleDate.fromDateTime(DateTime date)
      : year = date.year,
        month = date.month,
        day = date.day;
}

class Calculation {
  final DateTime createdAt;
  final String expression;
  final String result;

  Calculation({
    required this.createdAt,
    required this.expression,
    required this.result,
  });
}

class CalcHistory {
  final SimpleDate date;
  final List<Calculation> calculations;

  void addCalculation(Calculation calculation) {
    if (SimpleDate.fromDateTime(calculation.createdAt).equals(date)) {
      calculations.add(calculation);
    }
  }

  CalcHistory({
    required this.date,
    required this.calculations,
  });
}

class HistoryProvider extends ChangeNotifier {
  List<CalcHistory>? _calcHistories;
  List<CalcHistory> get calcHistories => _calcHistories = [];
}
