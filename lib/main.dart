// part of '/library.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/bloc/dar/dar_cubit.dart';
import 'package:login/bloc/dashboard/dahsboard_cubit.dart';
import 'package:login/bloc/management_user/management_user_cubit.dart';
import 'package:login/bloc/modul/modul_cubit.dart';
import 'package:login/bloc/paket/paket_cubit.dart';
import 'package:login/bloc/profile/profile_cubit.dart';
import 'package:login/bloc/spek_teknis/spek_teknis_cubit.dart';
import 'package:login/router/app_routes.dart';
import 'package:login/router/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
  final SharedPreferences prefs = await prefs0;
  runApp(
      MyApp(initalLocation: prefs.getString('initialLocation') ?? Routes.HOME));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initalLocation});
  final String initalLocation;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // KEBUTUHAN MODUL DAR
        BlocProvider(
          create: (context) => DashboardCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider(
          create: (context) => DarCubit(),
        ),
        BlocProvider(create: (context) {
          final managementUserCubit = ManagementUserCubit();
          // Memanggil fungsi async setelah `Cubit` dibuat.
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            try {
              await managementUserCubit.initDataUsers();
              await managementUserCubit.initDataRoles();
              await managementUserCubit.initDataPakets();
            } catch (e) {
              // ignore: avoid_print
              print('error ketika initData pada ManagementUserCubit()');
              // ignore: avoid_print
              print(e);
            }
          });

          return managementUserCubit;
        }),
        BlocProvider(
          create: (context) => PaketCubit(),
        ),
        BlocProvider(
          create: (context) => SpekTeknisCubit(),
        ),
        BlocProvider(
          create: (context) => ModulCubit(),
        ),
        // BlocProvider(
        //   create: (_) => DarCubit()
        //     ..loadTasks(yourTasksList)
        //     ..checkDueDates(),
        // ),
        // KEBUTUHAN MODUL DAR SAMPAI SINI
      ],
      child: MaterialApp.router(
        title: 'HMA App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: router(initalLocation),
      ),
    );
  }
}
