
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/history_provider.dart';
import 'calc_history_section.dart';

class HistoryPanel extends StatelessWidget {
  const HistoryPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(
      builder: (_, provider, __) {
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
