import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login/model/detail_paket.dart';
import 'package:login/model/module.dart';
import 'package:login/model/paket.dart';
import 'package:login/model/spektek.dart';
import 'package:login/model/user.dart';
import 'package:login/router/app_routes.dart';
import 'package:login/screens/dar/dar_screen.dart';
import 'package:login/screens/dar/paket/add_edit_paket.dart';
import 'package:login/screens/dar/paket/paket.dart';
import 'package:login/screens/dar/spek_teknis/modul/add_edit_modul.dart';
import 'package:login/screens/login_screen.dart';
import 'package:login/screens/mainpage_screen.dart';
import 'package:login/screens/management_users_screen.dart/add_edit_user_screen.dart';
import 'package:login/screens/management_users_screen.dart/management_users_screen.dart';

GoRouter router(String initialLocation) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.HOME,
        builder: (BuildContext context, GoRouterState state) {
          return LoginScreen();
        },
        routes: <RouteBase>[
          GoRoute(
              path: Routes.MAINPAGE,
              builder: (context, state) => const MainpageScreen(),
              routes: [
                GoRoute(
                    path: Routes.DAR,
                    builder: (context, state) => const DarScreen(),
                    routes: [
                      GoRoute(
                        path: "${Routes.ADDEDITPAKET}/:type",
                        builder: (context, state) {
                          String detailPaketString = jsonEncode(state.extra);
                          DetailPaket detailPaket = DetailPaket.fromJson(
                              jsonDecode(detailPaketString));
                          print('ini dari router');
                          print(detailPaket.id);
                          final type = state.pathParameters['type'];
                          print(type);
                          return AddEditPaket(type: type!, paket: detailPaket);
                        },
                      ),
                      GoRoute(
                        path: "${Routes.ADDEDITMODUL}/:type/:index",
                        builder: (context, state) {
                          Moduls? modul;
                          Pakets? paket;
                          Spektek? spektek;
                          String detailModulString = jsonEncode(state.extra);
                          DetailPaket detailPaket = DetailPaket.fromJson(
                              jsonDecode(detailModulString));
                          Pakets detailModul =
                              Pakets.fromJson(jsonDecode(detailModulString));
                          // print(detailModul.id);
                          final type = state.pathParameters['type'];
                          print('type => $type');
                          String? index = state.pathParameters['index'];
                          print('ini index nya ==> $index');
                          if (index != 'null') {
                            modul =
                                detailPaket.moduls![int.parse(index ?? "0")];
                            paket =
                                Pakets.fromJson(jsonDecode(detailModulString));
                          } else {
                            print('masuk sini index null');
                            spektek =
                                Spektek.fromJson(jsonDecode(detailModulString));
                            paket = spektek.pakets;
                            modul =
                                Moduls.fromJson(jsonDecode(detailModulString));
                          }
                          // print('ini index');
                          // print(index);
                          // print(type);
                          return AddEditModul(
                              type: type!, paket: paket!, module: modul);
                        },
                      ),
                    ]),
                GoRoute(
                  path: Routes.MANAGEMENTUSERS,
                  builder: (context, state) => const ManagementUsersScreen(),
                  routes: [
                    GoRoute(
                      path: "${Routes.ADDEDITUSERSCREEN}/:type",
                      builder: (context, state) {
                        String userString = jsonEncode(state.extra);
                        User user = User.fromJson(jsonDecode(userString));
                        print(user);
                        final type = state.pathParameters['type'];
                        print(type);
                        return AddEditUserScreen(type: type!, user: user);
                      },
                    ),
                  ],
                ),
              ]),
        ],
      ),
    ],
  );
}

// // pemakaian BlocProvider pada route
// GoRouter(
//     initialLocation: '/profile',
//     routes: [
//       GoRoute(
//         path: '/profile',
//         builder: (context, state) {
//           return BlocProvider(
//             create: (context) => ProfileCubit()..initData(context, 'username', 'password'),
//             child: const ProfileScreen(),
//           );
//         },
//       ),
//       // Tambahkan route lain jika diperlukan
//     ],
//   );