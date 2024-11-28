import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login/bloc/paket/paket_cubit.dart';
import 'package:login/bloc/paket/paket_state.dart';
import 'package:login/model/detail_paket.dart';
import 'package:login/router/app_routes.dart';

class Paket extends StatefulWidget {
  const Paket({super.key});

  @override
  State<Paket> createState() => _PaketState();
}

class _PaketState extends State<Paket> {
  late PaketCubit paketCubit;
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
  static const contentStyleHeader = TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
  static const contentStyle = TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);
  static const loremIpsum =
      '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum', a 1st century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.''';
  static const slogan =
      'Do not forget to play around with all sorts of colors, backgrounds, borders, etc.';

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
                    // headerBorderWidth: 1,
                    headerBackgroundColorOpened: Colors.green,
                    contentBackgroundColor: Colors.white,
                    contentBorderColor: Colors.green,
                    contentBorderWidth: 3,
                    contentHorizontalPadding: 20,
                    scaleWhenAnimating: true,
                    openAndCloseAnimation: true,
                    headerPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                    sectionClosingHapticFeedback: SectionHapticFeedback.light,
                    children: [
                      ...state.listPaket.map((item) {
                        return AccordionSection(
                          isOpen: true,
                          contentVerticalPadding: 20,
                          // leftIcon: const Icon(Icons.text_fields_rounded,
                          //     color: Colors.white),
                          header: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                item.judul ?? '',
                                style: headerStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    item.kodePaket ?? "",
                                    style: headerStyle,
                                  ),
                                  if (item.kendala != "" &&
                                      item.kendala != null)
                                    Tooltip(
                                        message: item.kendala,
                                        child: const Icon(
                                          Icons.warning,
                                          color: Colors.amberAccent,
                                        )),
                                  if (item.tglDeadline != "" &&
                                      item.tglDeadline != null)
                                    Tooltip(
                                      message: item.tglDeadline ?? '',
                                      child: const Icon(
                                        Icons.date_range,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  Text(
                                    item.tahun ?? "",
                                    style: headerStyle,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    color: const Color(0xffffffff),
                                    icon: const Icon(Icons.add_card_outlined),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    color: const Color(0xffffffff),
                                    icon: const Icon(
                                        Icons.remove_red_eye_outlined),
                                    onPressed: () {
                                      context.go(
                                          "/${Routes.MAINPAGE}/${Routes.DAR}/${Routes.ADDEDITPAKET}/detail",
                                          extra: item);
                                    },
                                  ),
                                  IconButton(
                                    color: const Color(0xffffffff),
                                    icon: const Icon(Icons.edit_document),
                                    onPressed: () {
                                      context.go(
                                          "/${Routes.MAINPAGE}/${Routes.DAR}/${Routes.ADDEDITPAKET}/edit",
                                          extra: item);
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                          content: Container(
                            height: 300,
                            // padding: const EdgeInsets.all(8.0),
                            child: ListView.separated(
                              itemCount: item.moduls!.length,
                              itemBuilder: (context, index) {
                                return Text(item.moduls![index].modul!);
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