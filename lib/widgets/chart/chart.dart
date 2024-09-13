import 'package:flutter/material.dart';

import 'package:expanse_tracker/widgets/chart/chart_bar.dart';
import 'package:expanse_tracker/models/expanse.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expanses});

  final List<Expanse> expanses;

  List<ExpanseBucket> get buckets {
    return [
      ExpanseBucket.forCategory(expanses, Category.food),
      ExpanseBucket.forCategory(expanses, Category.leisure),
      ExpanseBucket.forCategory(expanses, Category.travel),
      ExpanseBucket.forCategory(expanses, Category.work),
    ];
  }

  double get maxTotalExpanse {
    double maxTotalExpanse = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpanses > maxTotalExpanse) {
        maxTotalExpanse = bucket.totalExpanses;
      }
    }

    return maxTotalExpanse;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    fill: bucket.totalExpanses == 0
                        ? 0
                        : bucket.totalExpanses / maxTotalExpanse,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.category],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}