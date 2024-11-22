import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:login/bloc/dar/dar_cubit.dart';
import 'package:login/bloc/dar/dar_state.dart';
import 'package:login/model/user.dart';
import 'package:login/utils/constants/colors.dart';

class AktivitasPage extends StatefulWidget {
  const AktivitasPage({super.key});

  @override
  State<AktivitasPage> createState() => _AktivitasPageState();
}

class _AktivitasPageState extends State<AktivitasPage> {
  late DarCubit darCubit;
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Panggil initData saat widget pertama kali diinisialisasi
    // profileCubit = BlocProvider.of<ProfileCubit>(context); // untuk
    darCubit = context.read<DarCubit>();
    final state = darCubit.state;

    // Reset selectedUserForTask jika tidak ada dalam daftar users
    if (state.selectedUserForTask != null &&
        !state.users.contains(state.selectedUserForTask)) {
      darCubit.setSelectedUserForTask(null, context);
    }
    darCubit.initData(
        context); // buat fungsi khusus untuk manggil filter data jangan di gabung dengan initData
    darCubit.initDataUsers(context);
  }

  Widget build(BuildContext context) {
    return BlocConsumer<DarCubit, DarState>(listener: (context, state) {
      // Cek apakah selectedUserForTask tidak ada dalam daftar users
      // if (state.selectedUserForTask != null &&
      //     !state.users.contains(state.selectedUserForTask)) {
      //   // Set selectedUserForTask menjadi null jika user yang dipilih tidak ada dalam daftar
      //   context.read<DarCubit>().setSelectedUserForTask(null, context);
      // }
    }, builder: (context, state) {
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
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (state.role == '1' || state.role == '2')
                                    Column(
                                      children: [
                                        Text(task.user!.name!,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                        const Divider(
                                          thickness: 2,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  Text(
                                    '${task.task}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
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
                                      Icons.playlist_add_check_circle_outlined,
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
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ColorApp.button,
            tooltip: "Filtering Data",
            autofocus: true,
            child: const Icon(
              Icons.search_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return BlocBuilder<DarCubit, DarState>(
                    builder: (context, state) {
                      // Cek jika selectedUserForTask tidak ada dalam daftar users
                      User? validatedUser = state.selectedUserForTask;
                      if (validatedUser != null &&
                          !state.users.contains(validatedUser)) {
                        // Set ke null jika user yang dipilih tidak ditemukan dalam daftar
                        validatedUser = null;
                        // Emit state baru dengan null jika diperlukan
                        context
                            .read<DarCubit>()
                            .setSelectedUserForTask(null, context);
                      }
                      return Container(
                        decoration: const BoxDecoration(
                            color: ColorApp.basic,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Filter Data',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (state.role == '1' || state.role == '2')
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 1.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<User>(
                                        isExpanded: true,
                                        hint: const Text(
                                          'Filter Name',
                                          style: TextStyle(
                                            fontSize: 14,
                                            // color: Colors.white,
                                          ),
                                        ),
                                        items: state.users
                                            .map((item) => DropdownMenuItem(
                                                  value: item,
                                                  child: Text(
                                                    item.name!,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        value: validatedUser,
                                        onChanged: (value) {
                                          context
                                              .read<DarCubit>()
                                              .setSelectedUserForTask(
                                                  value, context);
                                        },
                                        buttonStyleData: const ButtonStyleData(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: Colors.white),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          height: 40,
                                          width: 200,
                                        ),
                                        dropdownStyleData:
                                            const DropdownStyleData(
                                          maxHeight: 200,
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          height: 40,
                                        ),
                                        dropdownSearchData: DropdownSearchData(
                                          searchController:
                                              textEditingController,
                                          searchInnerWidgetHeight: 50,
                                          searchInnerWidget: Container(
                                            height: 50,
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                              bottom: 4,
                                              right: 8,
                                              left: 8,
                                            ),
                                            child: TextFormField(
                                              expands: true,
                                              maxLines: null,
                                              controller: textEditingController,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 8,
                                                ),
                                                hintText: 'Search for name...',
                                                hintStyle: const TextStyle(
                                                    fontSize: 12),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ),
                                          ),
                                          searchMatchFn: (item, searchValue) {
                                            return item.value
                                                .toString()
                                                .contains(searchValue);
                                          },
                                        ),
                                        //This to clear the search value when you close the menu
                                        onMenuStateChange: (isOpen) {
                                          if (!isOpen) {
                                            textEditingController.clear();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ListTile(
                                  title: const Text(
                                    'Start Date Task',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${state.fromDate} s/d ${state.toDate}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  onTap: () => context
                                      .read<DarCubit>()
                                      .pickDateRange(context),
                                ),
                                ListTile(
                                  title: const Text(
                                    'Status',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ...state.listStatus.map((item) {
                                        return Row(
                                          children: [
                                            Radio<String>(
                                              fillColor: WidgetStateProperty
                                                  .resolveWith<Color>(
                                                (Set<WidgetState> states) {
                                                  return Colors.white;
                                                },
                                              ),
                                              value: item,
                                              groupValue: state.selectedStatus,
                                              onChanged: (String? value) {
                                                context
                                                    .read<DarCubit>()
                                                    .selectStatus(
                                                        item, context);
                                              },
                                            ),
                                            Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }),
      );
    });
  }
}

// Izin
// sakit,
// Nonjobdesc,
// - pelatihan
// - gudang
// 
// kordinasi dengan MAP (Fino) / pgangan kontrak
// cek spektek kontrak smapia tanggal berapa
// mencakup hardware atau software
// baru ke purchasing terkait biaya sebelum ke purchasing harus ada bukti kerusakan
// detail kerusakan kalau perlu vc
// 