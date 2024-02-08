import 'package:better_calculator/providers/history_provider.dart';
import 'package:better_calculator/widgets/calc_history_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPanel extends StatelessWidget {
  const HistoryPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(
      builder: (_, provider, __) {
        print("Value changed");
        if (provider.calcHistories?.isNotEmpty ?? false) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: provider.calcHistories!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CalcHistorySection(
                  calcsHistory: provider.calcHistories![index],
                ),
              );
            },
          );
        }

        return const Row(
          children: [
            Text(
              "No history information available",
            ),
          ],
        );
      },
    );
  }
}
