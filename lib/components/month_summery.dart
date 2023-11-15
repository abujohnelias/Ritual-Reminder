import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:ritual_reminder/datetime/date_time.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;

  const MonthlySummary({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: HeatMap(
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Colors.grey[400],
        textColor: Colors.grey.shade800,
        showColorTip: true,
        colorTipSize: 9,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: const {
          1: Color.fromARGB(20, 255, 0, 0),
          2: Color.fromARGB(40, 255, 0, 0),
          3: Color.fromARGB(60, 255, 0, 0),
          4: Color.fromARGB(80, 255, 0, 0),
          5: Color.fromARGB(100, 255, 0, 0),
          6: Color.fromARGB(120, 255, 0, 0),
          7: Color.fromARGB(150, 255, 0, 0),
          8: Color.fromARGB(180, 255, 0, 0),
          9: Color.fromARGB(220, 255, 0, 0),
          10: Color.fromARGB(255, 255, 0, 0),
        },
        onClick: (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}
