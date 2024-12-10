import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/bloc/spek_teknis/spek_teknis_cubit.dart';
import 'package:login/bloc/spek_teknis/spek_teknis_state.dart';

class ListSpekTeknisPage extends StatefulWidget {
  const ListSpekTeknisPage({super.key});

  @override
  State<ListSpekTeknisPage> createState() => _ListSpekTeknisPageState();
}

class _ListSpekTeknisPageState extends State<ListSpekTeknisPage> {
  late SpekTeknisCubit spektekCubit;
  @override
  void initState() {
    super.initState();
    // Panggil initData saat widget pertama kali diinisialisasi
    // profileCubit = BlocProvider.of<ProfileCubit>(context); // untuk
    spektekCubit = context.read<SpekTeknisCubit>();
    // final state = spektekCubit.state;
    spektekCubit.initListSpecTech(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SpekTeknisCubit, SpektekState>(
      listener: (context, state) {},
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
                        .filterData(value); // contoh fungsi search
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
                      : state.filteredData.isEmpty
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
                                  color: Colors.teal,
                                );
                              },
                              key: ValueKey(state.filteredData),
                              itemCount: state.filteredData.length,
                              itemBuilder: (context, index) {
                                final item = state.filteredData[index];
                                String kodeSpekTeknis =
                                    '${item.jenisModul} - ${item.pakets?.kodePaket} - ${item.kodeModul}';
                                return ListTile(
                                  leading: const CircleAvatar(
                                    backgroundColor: Colors.teal,
                                    child: Icon(Icons.build),
                                  ),
                                  title: Text(
                                    kodeSpekTeknis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Keterangan: ${item.keterangan ?? '-'}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: const Icon(
                                    Icons.remove_red_eye_rounded,
                                    size: 26,
                                    color: Colors.teal,
                                  ),
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors
                                          .transparent, // Untuk membuat radius pojok terlihat
                                      builder: (context) {
                                        return BlocBuilder<SpekTeknisCubit,
                                            SpektekState>(
                                          builder: (context, state) {
                                            return DraggableScrollableSheet(
                                              initialChildSize:
                                                  0.4, // Ukuran awal BottomSheet
                                              minChildSize:
                                                  0.2, // Ukuran terkecil BottomSheet
                                              maxChildSize:
                                                  0.8, // Ukuran terbesar BottomSheet
                                              expand: false,
                                              builder:
                                                  (context, scrollController) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        const BorderRadius.vertical(
                                                      top: Radius.circular(20),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        blurRadius: 10,
                                                        offset: const Offset(0, -5),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      // Handle Bar untuk BottomSheet
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10.0),
                                                        child: Container(
                                                          width: 50,
                                                          height: 5,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey[300],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: ListView(
                                                          controller:
                                                              scrollController,
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      16.0),
                                                          children: [
                                                            // Header Section
                                                            Text(
                                                              item.pakets
                                                                      ?.judul ??
                                                                  "Detail Modul",
                                                              style: const TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            const SizedBox(height: 8),
                                                            Divider(
                                                                thickness: 1,
                                                                color: Colors
                                                                    .grey[300]),
                                                            const SizedBox(height: 8),

                                                            // Detail Section
                                                            buildDetailRow(
                                                              title:
                                                                  "Kode Paket",
                                                              value: item.pakets
                                                                      ?.kodePaket ??
                                                                  "-",
                                                            ),
                                                            buildDetailRow(
                                                              title:
                                                                  "Judul Paket",
                                                              value: item.pakets
                                                                      ?.judul ??
                                                                  "-",
                                                            ),
                                                            buildDetailRow(
                                                              title:
                                                                  "Jenis Modul",
                                                              value:
                                                                  item.jenisModul ??
                                                                      "-",
                                                            ),
                                                            buildDetailRow(
                                                              title:
                                                                  "Kode Modul",
                                                              value:
                                                                  item.kodeModul ??
                                                                      "-",
                                                            ),
                                                            buildDetailRow(
                                                              title: "Modul",
                                                              value:
                                                                  item.modul ??
                                                                      "-",
                                                            ),
                                                            buildDetailRow(
                                                              title:
                                                                  "Keterangan",
                                                              value:
                                                                  item.keterangan ??
                                                                      "-",
                                                            ),
                                                            const SizedBox(
                                                                height: 16),

                                                            // Action Buttons
                                                            // Row(
                                                            //   mainAxisAlignment:
                                                            //       MainAxisAlignment
                                                            //           .spaceEvenly,
                                                            //   children: [
                                                            //     ElevatedButton(
                                                            //       onPressed:
                                                            //           () {
                                                            //         Navigator.pop(
                                                            //             context);
                                                            //       },
                                                            //       child: const Text(
                                                            //           "Tutup"),
                                                            //       style: ElevatedButton
                                                            //           .styleFrom(
                                                            //         backgroundColor:
                                                            //             Colors
                                                            //                 .red,
                                                            //         shape:
                                                            //             RoundedRectangleBorder(
                                                            //           borderRadius:
                                                            //               BorderRadius.circular(
                                                            //                   8),
                                                            //         ),
                                                            //       ),
                                                            //     ),
                                                            //     ElevatedButton(
                                                            //       onPressed:
                                                            //           () {
                                                            //         // Lakukan sesuatu
                                                            //       },
                                                            //       child: const Text(
                                                            //           "Edit"),
                                                            //       style: ElevatedButton
                                                            //           .styleFrom(
                                                            //         backgroundColor:
                                                            //             Colors
                                                            //                 .blue,
                                                            //         shape:
                                                            //             RoundedRectangleBorder(
                                                            //           borderRadius:
                                                            //               BorderRadius.circular(
                                                            //                   8),
                                                            //         ),
                                                            //       ),
                                                            //     ),
                                                            //   ],
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    );

                                    // Implementasi navigasi detail
                                  },
                                );
                              },
                            ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget buildDetailRow({required String title, required String value}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title: ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
  );
}


// kode spekteknis
// "jenis_modul": "All",
// "pakets": {
//                 "id": 10,
//                 "kode_paket": "ADM",
// "kode_modul": "01",

// keterangan
// "keterangan": "Persiapan, pembuatan dan pengelolaan surat menyurat IT Dept",

// action 