import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:login/bloc/management_user/management_user_cubit.dart';
import 'package:login/bloc/paket/paket_cubit.dart';
import 'package:login/bloc/paket/paket_state.dart';
import 'package:login/router/app_routes.dart';
import 'package:login/screens/components/progress_circle.dart';
import 'package:login/utils/constants/colors.dart';

class Paket extends StatefulWidget {
  const Paket({super.key});

  @override
  State<Paket> createState() => _PaketState();
}

class _PaketState extends State<Paket> {
  late PaketCubit paketCubit;
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
  @override
  void initState() {
    super.initState();
    // Panggil initData saat widget pertama kali diinisialisasi
    // profileCubit = BlocProvider.of<ProfileCubit>(context); // untuk
    paketCubit = context.read<PaketCubit>();
    // final state = paketCubit.state;
    paketCubit.initDataPaket(
        context); // buat fungsi khusus untuk manggil filter data jangan di gabung dengan initData
    // darCubit.initDataUsers(context);
    context.read<ManagementUserCubit>().initDataPakets();
  }

  @override
  build(context) => BlocConsumer<PaketCubit, PaketState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: state.isLoading
                ? const Center(
                    child: LinearProgressIndicator(),
                  )
                : Accordion(
                    headerBorderColor: Colors.blueGrey,
                    headerBorderColorOpened: Colors.transparent,
                    headerBackgroundColor: ColorApp.basic,
                    // headerBorderWidth: 1,
                    headerBackgroundColorOpened: ColorApp.button,
                    contentBackgroundColor: Colors.white,
                    contentBorderColor: ColorApp.button,
                    contentBorderWidth: 3,
                    contentHorizontalPadding: 20,
                    scaleWhenAnimating: true,
                    openAndCloseAnimation: true,
                    headerPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                    sectionClosingHapticFeedback: SectionHapticFeedback.light,
                    children: [
                      ...state.listPaket.map((itemPaket) {
                        return AccordionSection(
                          isOpen: true,
                          contentVerticalPadding: 20,
                          // leftIcon: const Icon(Icons.text_fields_rounded,
                          //     color: Colors.white),
                          header: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                itemPaket.judul ?? '',
                                style: headerStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Gap(10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    itemPaket.kodePaket ?? "",
                                    style: headerStyle,
                                  ),
                                  if (itemPaket.kendala != "" &&
                                      itemPaket.kendala != null)
                                    Tooltip(
                                        message: itemPaket.kendala,
                                        child: const Icon(
                                          Icons.warning,
                                          color: Colors.amberAccent,
                                        )),
                                  if (itemPaket.tglDeadline != "" &&
                                      itemPaket.tglDeadline != null)
                                    Tooltip(
                                      message: itemPaket.tglDeadline ?? '',
                                      child: const Icon(
                                        Icons.date_range,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  Text(
                                    itemPaket.tahun ?? "",
                                    style: headerStyle,
                                  )
                                ],
                              ),
                              if (itemPaket.kodePaket != "ADM") const Gap(10),
                              if (itemPaket.kodePaket != "ADM")
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width,
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceEvenly,
                                    runAlignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 10.0,
                                    children: [
                                      ProgressCircleWidget(
                                          totalPersenAll:
                                              '${itemPaket.totalPersenAll}',
                                          title: 'Software\nHMA',
                                          fontSize: 12,
                                          backgroundColor: Colors.white,
                                          textPersetColor: Colors.white),
                                      ProgressCircleWidget(
                                          totalPersenAll:
                                              '${itemPaket.totalPersen}',
                                          title: 'SH\nVendor',
                                          fontSize: 12,
                                          backgroundColor: Colors.white,
                                          textPersetColor: Colors.white),
                                      ProgressCircleWidget(
                                          totalPersenAll:
                                              '${itemPaket.totalPersenV}',
                                          title: 'Software\nVendor',
                                          fontSize: 12,
                                          backgroundColor: Colors.white,
                                          textPersetColor: Colors.white),
                                      ProgressCircleWidget(
                                          totalPersenAll:
                                              '${itemPaket.totalPersenHardV}',
                                          title: 'Hardware\n',
                                          fontSize: 12,
                                          backgroundColor: Colors.white,
                                          textPersetColor: Colors.white),
                                    ],
                                  ),
                                ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Tooltip(
                                    message: "Tambah Modul",
                                    child: IconButton(
                                      color: const Color(0xffffffff),
                                      icon: const Icon(Icons.add_card_outlined),
                                      onPressed: () {
                                        // print('tambah modul untuk paket');
                                        context.go(
                                            "/${Routes.MAINPAGE}/${Routes.DAR}/${Routes.ADDEDITMODUL}/tambahModulPaket/null",
                                            extra: itemPaket);
                                      },
                                    ),
                                  ),
                                  Tooltip(
                                    message: 'Lihat Detail',
                                    child: IconButton(
                                      color: const Color(0xffffffff),
                                      icon: const Icon(
                                          Icons.remove_red_eye_outlined),
                                      onPressed: () {
                                        context.go(
                                            "/${Routes.MAINPAGE}/${Routes.DAR}/${Routes.ADDEDITPAKET}/detail",
                                            extra: itemPaket);
                                      },
                                    ),
                                  ),
                                  Tooltip(
                                    message: "Edit paket",
                                    child: IconButton(
                                      color: const Color(0xffffffff),
                                      icon: const Icon(Icons.edit_document),
                                      onPressed: () {
                                        context.go(
                                            "/${Routes.MAINPAGE}/${Routes.DAR}/${Routes.ADDEDITPAKET}/edit",
                                            extra: itemPaket);
                                      },
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          content: SizedBox(
                            height: 300,
                            child: ListView.separated(
                              itemCount: itemPaket.moduls!.length,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return Column(
                                    children: [
                                      const Text(
                                        "Detail Module",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const Gap(10),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(itemPaket
                                                .moduls![index].modul!),
                                          ),
                                          PopupMenuButton<String>(
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
                                                    "/${Routes.MAINPAGE}/${Routes.DAR}/${Routes.ADDEDITMODUL}/detail/$index",
                                                    extra: itemPaket);
                                              } else if (value == 'edit') {
                                                print("ini fungsi edit <==");
                                                context.go(
                                                    "/${Routes.MAINPAGE}/${Routes.DAR}/${Routes.ADDEDITMODUL}/edit/$index",
                                                    extra: itemPaket);
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
                                                    Icon(
                                                        Icons
                                                            .remove_red_eye_rounded,
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
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                }
                                return Row(
                                  children: [
                                    Expanded(
                                      child:
                                          Text(itemPaket.moduls![index].modul!),
                                    ),
                                    PopupMenuButton<String>(
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: ColorApp
                                            .button, // Ganti warna titik tiga di sini
                                      ),
                                      color: Colors.white,
                                      onSelected: (value) {
                                        if (value == 'tambahmodul') {
                                        } else if (value == 'detail') {
                                          print('ini fungsi detail');
                                          context.go(
                                              "/${Routes.MAINPAGE}/${Routes.DAR}/${Routes.ADDEDITMODUL}/detail/$index",
                                              extra: itemPaket);
                                        } else if (value == 'edit') {
                                          print("ini fungsi edit <==");
                                          context.go(
                                              "/${Routes.MAINPAGE}/${Routes.DAR}/${Routes.ADDEDITMODUL}/edit/$index",
                                              extra: itemPaket);
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
                                      ],
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  thickness: 2,
                                  color: Colors.blueGrey,
                                );
                              },
                            ),
                          ),
                        );
                      })
                    ],
                  ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0XFFAE445A),
              tooltip: 'Tambah Paket',
              onPressed: () {
                context.go(
                    "/${Routes.MAINPAGE}/${Routes.DAR}/${Routes.ADDEDITPAKET}/tambah",
                    extra: {"isEditing": true});
              },
              child: const Icon(
                Icons.add_circle_outline,
                color: Colors.white,
              ),
            ),
          );
        },
      );
} //__

class MyInputForm extends StatelessWidget //__
{
  const MyInputForm({super.key});

  @override
  Widget build(context) //__
  {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            label: const Text('Some text goes here ...'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Submit'),
        )
      ],
    );
  }
}

// class MyDataTable extends StatelessWidget //__
// {
//   const MyDataTable({super.key});

//   @override
//   Widget build(context) //__
//   {
//     return DataTable(
//       sortAscending: true,
//       sortColumnIndex: 1,
//       showBottomBorder: false,
//       columns: const [
//         DataColumn(
//             label: Text('ID', style: AccordionPage.contentStyleHeader),
//             numeric: true),
//         DataColumn(
//             label:
//                 Text('Description', style: AccordionPage.contentStyleHeader)),
//         DataColumn(
//             label: Text('Price', style: AccordionPage.contentStyleHeader),
//             numeric: true),
//       ],
//       rows: const [
//         DataRow(
//           cells: [
//             DataCell(Text('1',
//                 style: AccordionPage.contentStyle, textAlign: TextAlign.right)),
//             DataCell(Text('Fancy Product', style: AccordionPage.contentStyle)),
//             DataCell(Text(r'$ 199.99',
//                 style: AccordionPage.contentStyle, textAlign: TextAlign.right))
//           ],
//         ),
//         DataRow(
//           cells: [
//             DataCell(Text('2',
//                 style: AccordionPage.contentStyle, textAlign: TextAlign.right)),
//             DataCell(
//                 Text('Another Product', style: AccordionPage.contentStyle)),
//             DataCell(Text(r'$ 79.00',
//                 style: AccordionPage.contentStyle, textAlign: TextAlign.right))
//           ],
//         ),
//         DataRow(
//           cells: [
//             DataCell(Text('3',
//                 style: AccordionPage.contentStyle, textAlign: TextAlign.right)),
//             DataCell(
//                 Text('Really Cool Stuff', style: AccordionPage.contentStyle)),
//             DataCell(Text(r'$ 9.99',
//                 style: AccordionPage.contentStyle, textAlign: TextAlign.right))
//           ],
//         ),
//         DataRow(
//           cells: [
//             DataCell(Text('4',
//                 style: AccordionPage.contentStyle, textAlign: TextAlign.right)),
//             DataCell(Text('Last Product goes here',
//                 style: AccordionPage.contentStyle)),
//             DataCell(Text(r'$ 19.99',
//                 style: AccordionPage.contentStyle, textAlign: TextAlign.right))
//           ],
//         ),
//       ],
//     );
//   }
// }

// class MyNestedAccordion extends StatelessWidget //__
// {
//   const MyNestedAccordion({super.key});

//   @override
//   Widget build(context) //__
//   {
//     return Accordion(
//       paddingListTop: 0,
//       paddingListBottom: 0,
//       maxOpenSections: 1,
//       headerBackgroundColorOpened: Colors.black54,
//       headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
//       children: [
//         AccordionSection(
//           isOpen: true,
//           leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
//           headerBackgroundColor: Colors.black38,
//           headerBackgroundColorOpened: Colors.black54,
//           header:
//               const Text('Nested Section #1', style: AccordionPage.headerStyle),
//           content: const Text(AccordionPage.loremIpsum,
//               style: AccordionPage.contentStyle),
//           contentHorizontalPadding: 20,
//           contentBorderColor: Colors.black54,
//         ),
//         AccordionSection(
//           isOpen: true,
//           leftIcon: const Icon(Icons.compare_rounded, color: Colors.white),
//           header:
//               const Text('Nested Section #2', style: AccordionPage.headerStyle),
//           headerBackgroundColor: Colors.black38,
//           headerBackgroundColorOpened: Colors.black54,
//           contentBorderColor: Colors.black54,
//           content: const Row(
//             children: [
//               Icon(Icons.compare_rounded,
//                   size: 120, color: Colors.orangeAccent),
//               Flexible(
//                   flex: 1,
//                   child: Text(AccordionPage.loremIpsum,
//                       style: AccordionPage.contentStyle)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }}

// "total_persen_all": "87.55"
// "total_persen": "89.02",
// "total_persen_v": "89.89",
// "total_persen_hard_v": "72.14",