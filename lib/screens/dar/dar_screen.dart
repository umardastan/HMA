import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/bloc/dar/dar_cubit.dart';
import 'package:login/bloc/dar/dar_state.dart';
import 'package:login/model/menu_dar.dart';
import 'package:login/utils/constants/colors.dart';

class DarScreen extends StatefulWidget {
  const DarScreen({super.key});

  @override
  State<DarScreen> createState() => _DarScreenState();
}

class _DarScreenState extends State<DarScreen> {
  late DarCubit darCubit;
  @override
  void initState() {
    super.initState();
    // Panggil initData saat widget pertama kali diinisialisasi
    // profileCubit = BlocProvider.of<ProfileCubit>(context); // untuk
    darCubit = context.read<DarCubit>();
    darCubit.initMenu();
    // darCubit.navigateTo('Dashboard', 0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<DarCubit, DarState>(listener: (context, state) {
        print("State baru: ${state.indexSubMenu}");
      }, builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(state.currentScreen),
              actions: [
                if (Platform.isIOS) // Menampilkan IconButton hanya di iOS
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
              ],
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: ColorApp.basic,
                    ),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ...state.listMenu.map(
                    (menu) {
                      // Jika menu memiliki submenu, gunakan ExpansionTile
                      if (menu.subMenu != null && menu.subMenu!.isNotEmpty) {
                        return ExpansionTile(
                          leading: menu.icon ?? const Icon(Icons.menu),
                          title: Text(menu.title),
                          children: menu.subMenu!.asMap().entries.map((entry) {
                            int subIndex = entry.key; // Index dari submenu
                            MenuDar subMenu = entry.value;
                            return ListTile(
                              title: Text(subMenu.title),
                              onTap: () {
                                context.read<DarCubit>().navigateTo(
                                      menu.title,
                                      state.listMenu.indexOf(menu),
                                      subIndex,
                                      subMenu: subMenu,
                                    );
                                Navigator.pop(
                                    context); // Tutup drawer setelah navigasi
                              },
                            );
                          }).toList(),
                        );
                      }
                      // Jika tidak ada submenu, gunakan ListTile biasa
                      return ListTile(
                        selected: state.currentScreen == menu.title,
                        leading: menu.icon ?? const Icon(Icons.dangerous),
                        title: Text(menu.title),
                        onTap: () {
                          context.read<DarCubit>().navigateTo(
                              menu.title, state.listMenu.indexOf(menu), null, subMenu: null,);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            body: state.listMenu.isEmpty
                ? Container()
                : state.indexSubMenu == null
                    ? state.listMenu[state.indexMenu].screen
                    : state.listMenu[state.indexMenu]
                        .subMenu?[state.indexSubMenu!].screen);
      }),
    );
  }
}

// if (state.role != "4")
//                   Theme(
//                     data: ThemeData(
//                       dividerColor: Colors.transparent, // Menghilangkan border
//                     ),
//                     child: ExpansionTile(
//                       title: const Text('Spek Teknis'),
//                       leading: const Icon(Icons.notes_rounded),
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20),
//                           child: ListTile(
//                             title: const Text('List Spek Teknis'),
//                             onTap: () {
//                               // Aksi saat submenu User dipilih
                              
//                             },
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20),
//                           child: ListTile(
//                             title: const Text('Modul'),
//                             onTap: () {
//                               // Aksi saat submenu Role dipilih
//                             },
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20),
//                           child: ListTile(
//                             title: const Text('Sub Modul'),
//                             onTap: () {
//                               // Aksi saat submenu Role dipilih
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),