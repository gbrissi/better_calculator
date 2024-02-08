import 'package:flutter/material.dart';

import '../services/shared_prefs.dart';

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['year'] = year;
    json['month'] = month;
    json['day'] = day;

    return json;
  }

  SimpleDate.fromJson(Map<String, dynamic> json)
      : year = json['year'],
        month = json['month'],
        day = json['day'];

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
    // required this.createdAt,
    required this.expression,
    required this.result,
  }) : createdAt = DateTime.now();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['createdAt'] = createdAt.toIso8601String();
    json['expression'] = expression;
    json['result'] = result;

    return json;
  }

  Calculation.fromJson(Map<String, dynamic> json)
      : createdAt = DateTime.parse(json['createdAt']),
        expression = json['expression'],
        result = json['result'];
}

class CalcsHistory {
  final SimpleDate date;
  final List<Calculation> calculations;

  void addCalculation(Calculation calculation) {
    if (SimpleDate.fromDateTime(calculation.createdAt).equals(date)) {
      calculations.add(calculation);
    }
  }

  CalcsHistory({
    required this.date,
    required this.calculations,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['calculations'] = calculations.map((e) => e.toJson()).toList();
    json['date'] = date.toJson();

    return json;
  }

  CalcsHistory.fromJson(Map<String, dynamic> json)
      : date = SimpleDate.fromJson(json['date']),
        calculations = json['calculations']
            .map<Calculation>((e) => Calculation.fromJson(e))
            .toList();
}

class HistoryProvider extends ChangeNotifier {
  List<CalcsHistory>? _calcHistories;
  List<CalcsHistory>? get calcHistories => _calcHistories;

  HistoryProvider() {
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    _calcHistories = await SharedPrefs.getHistory();
    notifyListeners();
  }

  Future<void> addHistory(Calculation calculation) async {
    final SimpleDate calcSimpleDate = SimpleDate.fromDateTime(
      calculation.createdAt,
    );

    final int? calcHistoryIndex = calcHistories?.indexWhere(
      (e) => e.date.equals(
        calcSimpleDate,
      ),
    );

    final CalcsHistory calcHistory = CalcsHistory(
      date: calcSimpleDate,
      calculations: [calculation],
    );

    if (calcHistoryIndex == null) {
      _calcHistories = [
        calcHistory,
      ];
    } else if (calcHistoryIndex == -1) {
      calcHistories!.add(
        calcHistory,
      );
    } else {
      calcHistories![calcHistoryIndex].addCalculation(
        calculation,
      );
    }

    await SharedPrefs.setHistory(_calcHistories);
    notifyListeners();
  }
}
