import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TaskPieChart extends StatelessWidget {
  final int proses;
  final int done;

  const TaskPieChart({super.key, required this.proses, required this.done});

  @override
  Widget build(BuildContext context) {
    print('proses dari components TaskPieChart ==>> $proses');
    print('done dari components TaskPieChart ==>> $done');
    return Scaffold(
      appBar: AppBar(title: const Text('Task Overview')),
      body: Center(
        child: SfCircularChart(
          title: const ChartTitle(text: 'Task Status'),
          legend:
              const Legend(isVisible: true, position: LegendPosition.bottom),
          series: <PieSeries<_TaskData, String>>[
            PieSeries<_TaskData, String>(
              dataSource: _getChartData(),
              xValueMapper: (_TaskData data, _) => data.status,
              yValueMapper: (_TaskData data, _) => data.count,
              dataLabelMapper: (_TaskData data, _) => '${data.count}',
              dataLabelSettings: const DataLabelSettings(isVisible: true),
            )
          ],
        ),
      ),
    );
  }

  List<_TaskData> _getChartData() {
    return [
      _TaskData('Proses', 10),
      _TaskData('Done', 2),
    ];
  }
}

class _TaskData {
  _TaskData(this.status, this.count);
  final String status;
  final int count;
}
