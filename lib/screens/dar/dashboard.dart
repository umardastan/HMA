import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:login/bloc/dar/dar_cubit.dart';
import 'package:login/bloc/dar/dar_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardDar extends StatefulWidget {
  const DashboardDar({super.key});

  @override
  State<DashboardDar> createState() => _DashboardDarState();
}

class _DashboardDarState extends State<DashboardDar> {
  late DarCubit darCubit;
  @override
  void initState() {
    super.initState();
    // Panggil initData saat widget pertama kali diinisialisasi
    // profileCubit = BlocProvider.of<ProfileCubit>(context); // untuk
    darCubit = context.read<DarCubit>();
    darCubit.initDataDashboard(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DarCubit, DarState>(
        listener: (context, state) {},
        builder: (context, state) {
          // var proses = state.dataDashboard.task![0].proses;
          // var done = state.dataDashboard.task![0].proses;
          // List<ChartData> listChartData = [
          //   const ChartData(2010, 35),
          //   const ChartData(2011, 28),
          //   const ChartData(2012, 34),
          //   const ChartData(2013, 32),
          //   const ChartData(2014, 40),
          // ];
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: _buildCard('Paket', state.dataDashboard.paket,
                              Icons.list_alt_rounded, const Color(0xFFf05252))),
                      const Gap(16),
                      Expanded(
                          child: _buildCard('User', state.dataDashboard.user,
                              Icons.person, const Color(0xFF3A80F9))),
                    ],
                  ),
                  // const Gap(16),
                  if (state.dataDashboard.run != null)
                    Card(
                      color: const Color(0xFF172554),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14.0, vertical: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                'Run: ${state.dataDashboard.run == null ? 0 : state.dataDashboard.run!.length}'),
                            Wrap(
                              spacing: 8.0,
                              children:
                                  state.dataDashboard.run!.map<Widget>((user) {
                                return Chip(
                                  side: const BorderSide(
                                      width: 2, color: Colors.white),
                                  backgroundColor: const Color(0xFF172554),
                                  label: Text(
                                    user.username ?? '-',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  // avatar:
                                  //     CircleAvatar(child: Text(user.id.toString())),
                                );
                              }).toList(),
                            ),
                            // const Gap(16),
                            const Gap(5),
                            const Divider(thickness: 2, color: Colors.white,),
                            const Gap(5),
                            Text(
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                'Idle Users: ${state.dataDashboard.idle == null ? 0 : state.dataDashboard.idle!.length}'),
                            Wrap(
                              spacing: 8.0,
                              children:
                                  state.dataDashboard.idle!.map<Widget>((user) {
                                return Chip(
                                    side: const BorderSide(
                                        width: 2, color: Colors.white),
                                    backgroundColor: const Color(0xFF172554),
                                    label: Text(user.username!,
                                        style: const TextStyle(
                                            color: Colors.white)));
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const Gap(16),
                  if (state.dataDashboard.task != null)
                    Center(
                      child: SfCircularChart(
                        title: ChartTitle(
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                            text:
                                'Grafik Status Tahun ${state.dataDashboard.year}'),
                        legend: const Legend(isVisible: true),
                        series: <PieSeries<_PieDatas, String>>[
                          PieSeries<_PieDatas, String>(
                            explode: true,
                            explodeIndex: 0,
                            dataSource: _getPieData(
                                state.dataDashboard.task![0].proses!,
                                state.dataDashboard.task![1].done!),
                            xValueMapper: (_PieDatas data, _) => data.xData,
                            yValueMapper: (_PieDatas data, _) => data.yData,
                            dataLabelMapper: (_PieDatas data, _) =>
                                '${data.percentage.toStringAsFixed(1)}%',
                            pointColorMapper: (_PieDatas data, _) {
                              if (data.xData == 'Proses') {
                                return const Color(
                                    0xFF09FC21); // Warna untuk "Proses"
                              } else if (data.xData == 'Done') {
                                return const Color(
                                    0xFF43ACF7); // Warna untuk "Done"
                              }
                              return null;
                            },
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  SfCartesianChart(
                      // isTransposed: true,
                      title: ChartTitle(
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          text:
                              'Grafik Aktifitas Per Bulan Tahun ${state.dataDashboard.year}'),
                      primaryXAxis: const CategoryAxis(),
                      tooltipBehavior: TooltipBehavior(
                          enable: true,
                          color: Colors.blueAccent,
                          textStyle: const TextStyle(color: Colors.white)),
                      series: <CartesianSeries>[
                        SplineAreaSeries<ChartData, String>(
                          dataSource: state.chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          borderColor:
                              const Color(0xFF235CDC), // Warna garis utama
                          borderWidth: 4, // Ketebalan garis
                          color: const Color(0xFF235CDC)
                              .withOpacity(0.4), // Warna samar di bawah garis
                        ),
                      ]),
                  const Gap(16),
                  const Text(
                    'Copyright © 2024 PT. HANATEKINDO MULIA ABADI. All rights reserved.',
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          );
        });
  }

  List<_PieDatas> _getPieData(int proses, int done) {
    final int total = proses + done;
    final double prosesPercentage = (proses / total) * 100;
    final double donePercentage = (done / total) * 100;

    return [
      _PieDatas('Proses', proses, prosesPercentage),
      _PieDatas('Done', done, donePercentage),
    ];
  }

  List<PieChartSectionData> _buildPieChartSections(
      {required proses, required done}) {
    final total = proses + done;
    final prosesPercentage = (proses / total) * 100;
    final donePercentage = (done / total) * 100;

    return [
      PieChartSectionData(
        showTitle: true,
        value: proses.toDouble(),
        color: Colors.blue,
        title: '${prosesPercentage.toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        showTitle: true,
        value: done.toDouble(),
        color: Colors.green,
        title: '${donePercentage.toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }

  Widget _buildCard(String title, int? count, IconData icon, Color color) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(color: Colors.white, icon, size: 40),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  Text('$count',
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPieChart(List<dynamic> tasks) {
    int proses = tasks.firstWhere((t) => t.containsKey('proses'))['proses'];
    int done = tasks.firstWhere((t) => t.containsKey('done'))['done'];

    return Container(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
                value: proses.toDouble(), color: Colors.blue, title: 'Proses'),
            PieChartSectionData(
                value: done.toDouble(), color: Colors.green, title: 'Done'),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChart(List<dynamic> activityData) {
    List<FlSpot> spots = [];
    for (var i = 0; i < activityData.length; i++) {
      int value = activityData[i].values.first;
      spots.add(FlSpot(i.toDouble(), value.toDouble()));
    }

    return Container(
      height: 200,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              // spots: [Colors.blue],
              barWidth: 3,
              belowBarData:
                  BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
            ),
          ],
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: _buildBottomTitles()),
          ),
        ),
      ),
    );
  }

  SideTitles _buildBottomTitles() {
    return SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        const months = [
          "Jan",
          "Feb",
          "Mar",
          "Apr",
          "May",
          "Jun",
          "Jul",
          "Aug",
          "Sep",
          "Oct",
          "Nov",
          "Dec"
        ];
        return Text(months[value.toInt()]);
      },
      reservedSize: 30,
    );
  }
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);
  final String xData;
  final num yData;
  String? text;
}

class _PieDatas {
  _PieDatas(this.xData, this.yData, this.percentage);
  final String xData;
  final int yData;
  final double percentage;
}

// ListTile(
//                       selected: state.currentScreen == 'Dashboard',
//                       leading: const Icon(Icons.dashboard),
//                       title: const Text('Dashboard'),
//                       onTap: () {
//                         _navigateTo("Dashboard");
//                       },
//                     ),
//                     ListTile(
//                       selected: state.currentScreen == 'Aktivitas',
//                       leading: const Icon(Icons.timeline),
//                       title: const Text('Aktivitas'),
//                       onTap: () {
//                         _navigateTo("Aktivitas");
//                       },
//                     ),
//                     ListTile(
//                       selected: state.currentScreen == 'Paket',
//                       leading: const Icon(Icons.card_giftcard),
//                       title: const Text('Paket'),
//                       onTap: () {
//                         _navigateTo("Paket");
//                       },
//                     ),