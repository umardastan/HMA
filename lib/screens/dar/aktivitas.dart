import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:login/bloc/dar/dar_cubit.dart';
import 'package:login/bloc/dar/dar_state.dart';
import 'package:login/utils/constants/colors.dart';

class AktivitasPage extends StatefulWidget {
  const AktivitasPage({super.key});

  @override
  State<AktivitasPage> createState() => _AktivitasPageState();
}

class _AktivitasPageState extends State<AktivitasPage> {
  late DarCubit darCubit;
  @override
  void initState() {
    super.initState();
    // Panggil initData saat widget pertama kali diinisialisasi
    // profileCubit = BlocProvider.of<ProfileCubit>(context); // untuk
    darCubit = context.read<DarCubit>();
    darCubit.initData(context);
  }

  Widget build(BuildContext context) {
    return BlocConsumer<DarCubit, DarState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              body: Column(
            children: [
              if (state.warningMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.warningMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              state.tasks.isNotEmpty
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: ListView.builder(
                          itemCount: state.tasks.length,
                          itemBuilder: (context, index) {
                            final task = state.tasks[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10.0),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                tileColor:
                                    ColorApp.basic, //const Color(0xFF003161),
                                leading: const Icon(
                                  Icons.work_history,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                title: Text(
                                  '${task.task}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Start Date: ${task.startDate}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'End Date: ${task.endDate}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: task.status != 'done'
                                            ? const Color(0xFFc3ddfc)
                                            : Colors.green.shade100,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ClipOval(
                                            child: Container(
                                              width: 10,
                                              height: 10,
                                              color: task.status != 'done'
                                                  ? const Color(0XFF3e83f8)
                                                  : Colors.green.shade500,
                                            ),
                                          ),
                                          const Gap(10),
                                          Text(
                                            '${task.status}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: task.status != 'done'
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: ColorApp
                                              .button, // const Color(0xff006A67),
                                        ),
                                        onPressed: () {
                                          AwesomeDialog(
                                            dismissOnTouchOutside: false,
                                            context: context,
                                            dialogType: DialogType.warning,
                                            animType: AnimType.topSlide,
                                            title: 'Warning',
                                            desc:
                                                'Yakin Task ${task.task} sudah selesai.',
                                            btnCancelOnPress: () {},
                                            btnOkOnPress: () {
                                              context
                                                  .read<DarCubit>()
                                                  .updateStatusTask(
                                                      context, task.id!);
                                            },
                                          ).show();
                                        },
                                        child: const Text(
                                          'DONE',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    : const Icon(
                                        Icons
                                            .playlist_add_check_circle_outlined,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Image.asset("assets/images/no_task.jpg"),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Anda belum memiliki tugas, hubungi atasan anda untuk assign task',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
              // Add DraggableScrollableSheet here
              Expanded(
                child: DraggableScrollableSheet(
                  initialChildSize: 0.15, // Size when initially visible
                  minChildSize: 0.1, // Minimum size when dragged down
                  maxChildSize: 0.9, // Maximum size when dragged up
                  builder: (context, scrollController) {
                    return Container(
                      decoration: const BoxDecoration(
                          color: ColorApp.basic,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListView(
                          controller: scrollController,
                          children: [
                            const Text(
                              'Filter Data',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            ListTile(
                              title: const Text(
                                'Start Date Task',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                '${state.fromDate} s/d ${state.toDate}',
                                // state.selectedDateRange == null
                                //     ? 'No date range selected'
                                //     : '${state.dateFormat.format(state.selectedDateRange.start)} - ${state.dateFormat.format(state.selectedDateRange.end)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              onTap: () => darCubit.pickDateRange(context),
                            ),
                            ListTile(
                              title: const Text(
                                'Status',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // Agar elemen dalam Row tidak memaksakan lebar penuh
                                children: [
                                  ...state.listStatus.map((item) {
                                    return Row(
                                      children: [
                                        Radio<String>(
                                          // activeColor: Colors.white,
                                          fillColor: WidgetStateProperty
                                              .resolveWith<Color>(
                                                  (Set<WidgetState> states) {
                                            if (states.contains(
                                                WidgetState.disabled)) {
                                              return Colors.orange
                                                  .withOpacity(.32);
                                            }
                                            return Colors.white;
                                          }),
                                          value: item,
                                          groupValue: state
                                              .selectedStatus, // Variabel untuk menyimpan nilai terpilih
                                          onChanged: (String? value) {
                                            darCubit.selectStatus(value!, context);
                                          },
                                        ),
                                        Text(
                                          item,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ],
                                    );
                                  })
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ));
        });
  }
}
