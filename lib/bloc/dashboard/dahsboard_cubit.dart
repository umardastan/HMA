import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:login/bloc/dashboard/dashboard_state.dart';
import 'package:login/router/app_routes.dart';
import 'package:login/screens/components/showDialog.dart';
import 'package:login/utils/helper/helper.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState());

  // Memanggil metode ini untuk memulai animasi
  void startAnimation() {
    emit(state.copyWith(isStartAnimation: true));
  }

  // Reset animasi jika diperlukan
  void resetAnimation() {
    emit(state.copyWith(isResetAnimation: true));
  }

  void clickMenu(String title, BuildContext context) {
    switch (title) {
      case 'DAR':
        context.go("/${Routes.MAINPAGE}/${Routes.DAR}");
        break;
      case 'Management Users':
        context.go("/${Routes.MAINPAGE}/${Routes.MANAGEMENTUSERS}");
        break;
      default:
        cShowDialog(
            context: context, title: "Warning", message: 'Under Maintenance');
    }
    print(title);
  }

  Future<void> cekExpiredToken() async {
    String? tanggalExpired = await Helper().getExpiredToken();
    print(tanggalExpired);
    // Format dari tanggal expiredAt
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");

    // Parse expiredAt ke DateTime
    DateTime expiredDate =
        format.parse(tanggalExpired ?? '1000-01-08 00:00:00');

    // Dapatkan waktu sekarang
    DateTime now = DateTime.now();

    // Bandingkan expiredDate dengan waktu sekarang
    emit(state.copyWith(isExpired: now.isAfter(expiredDate)));
  }

  Future<void> initRole() async {
    String? role = await Helper().getRole();
    emit(state.copyWith(role: role));
  }

  Future<void> logout(BuildContext context) async {
    try {
      await Helper().deleteDataUser();
      await Helper().deleteToken();
      await Helper().deleteInitialLocation();
      await Helper().deleteExpiredToken();
      if (context.mounted) {
        context.go(Routes.HOME);
      } // Sesuaikan dengan route login
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to log out'));
    }
  }
}
