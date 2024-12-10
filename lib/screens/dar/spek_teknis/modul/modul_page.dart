import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login/bloc/modul/modul_cubit.dart';
import 'package:login/bloc/spek_teknis/spek_teknis_cubit.dart';
import 'package:login/bloc/spek_teknis/spek_teknis_state.dart';
import 'package:login/utils/constants/colors.dart';
import 'package:login/utils/widget.dart';

import '../../../../router/app_routes.dart';

class ModulPage extends StatefulWidget {
  const ModulPage({super.key});

  @override
  State<ModulPage> createState() => _ModulPageState();
}

class _ModulPageState extends State<ModulPage> {
  late SpekTeknisCubit spektekCubit;
  @override
  void initState() {
    super.initState();
    // Panggil initData saat widget pertama kali diinisialisasi
    // profileCubit = BlocProvider.of<ProfileCubit>(context); // untuk
    spektekCubit = context.read<SpekTeknisCubit>();
    // final state = spektekCubit.state;
    spektekCubit.initListModul(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SpekTeknisCubit, SpektekState>(
      listener: (context, state) {
        if (state.message.isNotEmpty &&
            state.titleMessage.isNotEmpty &&
            state.typeMessage.isNotEmpty) {
          AwesomeDialog(
            dismissOnTouchOutside: false,
            context: context,
            dialogType: state.typeMessage == 'success'
                ? DialogType.success
                : state.typeMessage == 'warning'
                    ? DialogType.warning
                    : DialogType.error,
            animType: AnimType.topSlide,
            title: state.titleMessage,
            desc: state.message,
            btnOkOnPress: () async {
              context.read<SpekTeknisCubit>().initListModul(context);
            },
          ).show();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    // Panggil fungsi untuk mencari atau memfilter berdasarkan nilai 'value'
                    context
                        .read<SpekTeknisCubit>()
                        .filterDataModul(value); // contoh fungsi search
                  },
                  decoration: InputDecoration(
                    hintText: 'Search modul...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: state.isLoading
                      ? const Center(child: LinearProgressIndicator())
                      : state.filteredDataModul.isEmpty
                          ? const Center(
                              child: Text(
                                'No data found',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            )
                          : ListView.separated(
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  thickness: 1,
                                  color: ColorApp.secondary,
                                );
                              },
                              key: ValueKey(state.filteredDataModul),
                              itemCount: state.filteredDataModul.length,
                              itemBuilder: (context, index) {
                                final item = state.filteredDataModul[index];
                                String kodeSpekTeknis =
                                    '${item.jenisModul} - ${item.pakets?.kodePaket} - ${item.kodeModul}';
                                return ListTile(
                                  leading: const CircleAvatar(
                                    backgroundColor: ColorApp.button,
                                    child: Icon(
                                      Icons.description,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Text(
                                    kodeSpekTeknis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Text(
                                    item.modul ?? '-',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: PopupMenuButton<String>(
                                    icon: const Icon(
                                      Icons.more_vert,
                                      color: ColorApp
                                          .button, // Ganti warna titik tiga di sini
                                    ),
                                    color: Colors.white,
                                    onSelected: (value) {
                                      if (value == 'tambahmodul') {
                                      } else if (value == 'detail') {
                                        context.go(
                                            "/${Routes.MAINPAGE}/${Routes.DAR}/${Routes.ADDEDITMODUL}/detail/null",
                                            extra: item);
                                      } else if (value == 'edit') {
                                        context.go(
                                            "/${Routes.MAINPAGE}/${Routes.DAR}/${Routes.ADDEDITMODUL}/edit/null",
                                            extra: item);
                                      } else if (value == 'hapus') {
                                        AwesomeDialog(
                                          dismissOnTouchOutside: false,
                                          context: context,
                                          dialogType: DialogType.warning,
                                          animType: AnimType.topSlide,
                                          title: "Peringatan !!!",
                                          desc:
                                              "Apakah anda yakin ingin menghapus ${item.modul}",
                                          btnOkOnPress: () async {
                                            context
                                                .read<SpekTeknisCubit>()
                                                .deleteModul(item);
                                          },
                                          btnCancelOnPress: () {},
                                        ).show();
                                      }
                                    },
                                    itemBuilder: (context) => const [
                                      // PopupMenuItem(
                                      //   value: 'tambahmodul',
                                      //   child: Row(
                                      //     children: [
                                      //       Icon(Icons.add_card_rounded,
                                      //           color: Colors.blue),
                                      //       SizedBox(width: 8),
                                      //       Text("Tambah Sub Modul"),
                                      //     ],
                                      //   ),
                                      // ),
                                      PopupMenuItem(
                                        value: 'detail',
                                        child: Row(
                                          children: [
                                            Icon(Icons.remove_red_eye_rounded,
                                                color: Colors.red),
                                            SizedBox(width: 8),
                                            Text("Detail"),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'edit',
                                        child: Row(
                                          children: [
                                            Icon(Icons.edit_document,
                                                color: Colors.green),
                                            SizedBox(width: 8),
                                            Text("Edit"),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'hapus',
                                        child: Row(
                                          children: [
                                            Icon(Icons.delete,
                                                color: Colors.redAccent),
                                            SizedBox(width: 8),
                                            Text("Hapus"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // onTap: () {
                                  //   // Implementasi navigasi detail
                                  // },
                                );
                              },
                            ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0XFFAE445A),
            tooltip: 'Tambah Modul',
            onPressed: () {
              context.go(
                  "/${Routes.MAINPAGE}/${Routes.DAR}/${Routes.ADDEDITMODUL}/tambah/null");
            },
            child: const Icon(
              Icons.add_circle_outline,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
