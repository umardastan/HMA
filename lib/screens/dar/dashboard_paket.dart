import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:login/bloc/dar/dar_cubit.dart';
import 'package:login/bloc/dar/dar_state.dart';
import 'package:login/screens/components/progress_circle.dart';
import 'package:login/utils/constants/colors.dart';

class DashboardPaket extends StatefulWidget {
  const DashboardPaket({super.key});

  @override
  State<DashboardPaket> createState() => _DashboardPaketState();
}

class _DashboardPaketState extends State<DashboardPaket> {
  late DarCubit darCubit;
  @override
  void initState() {
    super.initState();
    // Panggil initData saat widget pertama kali diinisialisasi
    // profileCubit = BlocProvider.of<ProfileCubit>(context); // untuk
    darCubit = context.read<DarCubit>();
    darCubit.initDataDashboardPaket(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DarCubit, DarState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: ListView.builder(
              itemCount: state.listDashboardPaket.length,
              itemBuilder: (context, index) {
                final paket = state.listDashboardPaket[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorApp.basic,
                        ),
                        child: Text(
                          paket.judul ?? "kosong",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        child: Column(
                          children: [
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Kode: ${paket.kodePaket}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Tahun: ${paket.tahun}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Leader: ${paket.projectLeader}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              'Deadline: ${paket.tglDeadline}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              child: Wrap(
                                alignment: WrapAlignment.spaceEvenly,
                                runAlignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 10.0,
                                children: [
                                  ProgressCircleWidget(
                                    totalPersenAll: '${paket.totalPersenAll}',
                                    title: 'Software\nHMA',
                                  ),
                                  ProgressCircleWidget(
                                    totalPersenAll: '${paket.totalPersenV}',
                                    title: 'Software\nVendor',
                                  ),
                                  ProgressCircleWidget(
                                    totalPersenAll: '${paket.totalPersenHardV}',
                                    title: 'Hardware\n',
                                  ),
                                  ProgressCircleWidget(
                                    totalPersenAll: '${paket.totalPersenAll}',
                                    title: 'SH\nVendor',
                                  ),
                                ],
                              ),
                            ),
                            // LinearProgressIndicator(
                            //   value: double.parse(paket.totalPersenAll ?? "0") / 100,
                            //   backgroundColor: Colors.grey[300],
                            //   color: double.parse(paket.totalPersenAll ?? "0") >= 80
                            //       ? Colors.green
                            //       : Colors.orange,
                            // ),
                            const SizedBox(height: 8),
                            Text(
                              'Keterangan: ${paket.keterangan}',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 13),
                            ),
                            paket.kendala != null
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      'Kendala: ${paket.kendala!.isNotEmpty ? paket.kendala : 'Kosong'}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                : const Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      'Kendala: Kosong',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}

// totalPersen, //sofware HMA
// totalPersenV, // software Vendor
// totalPersenHardV, // hardware
// totalPersenAll, // SH Vendor