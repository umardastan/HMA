import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressCircleWidget extends StatelessWidget {
  final String totalPersenAll;
  final String title;
  final Color backgroundColor;
  final double fontSize;
  final Color textPersetColor;

  const ProgressCircleWidget({
    required this.totalPersenAll,
    required this.title,
    required this.backgroundColor,
    required this.fontSize,
    required this.textPersetColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Konversi string ke double dengan default 0 jika null atau tidak valid
    double percentage = double.tryParse(totalPersenAll) ?? 0;
    double progressValue = percentage / 100;

    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: fontSize,
              color: percentage >= 80
                  ? Colors.green
                  : (percentage >= 50 ? Colors.orange : Colors.red),
              fontWeight: FontWeight.w600),
        ),
        const Gap(10),
        CircularPercentIndicator(
          radius: 35.0,
          lineWidth: 5.0,
          animation: true,
          percent: progressValue,
          center: Text(
            "$percentage%",
            style: TextStyle(color: textPersetColor),
          ),
          progressColor: percentage >= 80
              ? Colors.green
              : (percentage >= 50 ? Colors.orange : Colors.red),
          backgroundColor: backgroundColor,
          circularStrokeCap: CircularStrokeCap.round,
        ),
      ],
    );
    // CircularPercentIndicator(
    //   radius: 60.0,
    //   lineWidth: 8.0,
    //   percent: progressValue.clamp(0.0, 1.0), // batas 0-100%
    //   center: Text(
    //     "${percentage.toStringAsFixed(1)}%", // Tampilkan persentase
    //     style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    //   ),
    //   backgroundColor: Colors.grey[300]!,
    //   progressColor: percentage >= 80 ? Colors.green : Colors.orange,
    //   circularStrokeCap: CircularStrokeCap.round,
    // );
  }
}
