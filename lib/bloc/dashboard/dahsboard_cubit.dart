import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login/bloc/dashboard/dashboard_state.dart';
import 'package:login/router/app_routes.dart';
import 'package:login/screens/components/showDialog.dart';

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
      default:
        cShowDialog(
            context: context, title: "Warning", message: 'Under Maintenance');
    }
    print(title);
  }
}
