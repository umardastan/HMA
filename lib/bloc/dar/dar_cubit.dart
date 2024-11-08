import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/bloc/dar/dar_state.dart';
import 'package:login/model/dashboard_dar.dart';
import 'package:login/model/menu_dar.dart';
import 'package:login/model/aktivitas.dart';
import 'package:login/model/user.dart';
import 'package:login/screens/components/showDialog.dart';
import 'package:login/screens/dar/aktivitas.dart';
import 'package:login/screens/dar/dashboard.dart';
import 'package:login/screens/dar/paket.dart';
import 'package:login/services/service.dart';
import 'package:login/utils/constants/constantVar.dart';
import 'package:login/utils/helper/helper.dart';

class DarCubit extends Cubit<DarState> {
  DarCubit() : super(DarState());

  Future<void> initData(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? user = await Helper().getDataUser();
      String? token = await Helper().getToken();
      print(user);

      if (user != null && token != null) {
        emit(state.copyWith(user: User.fromJson(jsonDecode(user))));
        var response = await Request.req(
            path: "${PathUrl.task}${state.user.id}",
            params: {
              "filter_date_start": state.fromDate,
              "filter_date_end": state.toDate
            },
            body: null,
            token: token,
            method: 'get');
        var result = json.decode(response!.body);
        print(response.statusCode);
        print('ini hasilnya =>> $result');
        if (response.statusCode == 200) {
          if (state.selectedStatus == 'all') {
            emit(state.copyWith(
                tasks: (result['data'] as List)
                    .map((item) {
                      return Aktivitas.fromJson(item);
                    })
                    .toList()
                    .cast<Aktivitas>()));
          } else {
            emit(state.copyWith(
                tasks: (result['data'] as List)
                    .map((item) {
                      return Aktivitas.fromJson(item);
                    })
                    .toList()
                    .cast<Aktivitas>()
                    .where((task) => task.status == state.selectedStatus)
                    .toList()));
          }
        } else {
          cShowDialog(
              context: context, title: "Warning", message: result['success']);
        }
      } else {
        emit(state.copyWith(isLoading: false, isSuccess: false));
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load data'));
    }
  }

  Future<void> initMenu() async {
    emit(state.copyWith(currentScreen: 'Dashboard', listMenu: [
      MenuDar(
          title: "Dashboard",
          icon: const Icon(Icons.dashboard),
          screen: const DashboardDar()),
      MenuDar(
          title: "Aktivitas",
          icon: const Icon(Icons.timeline),
          screen: const AktivitasPage()),
      MenuDar(
          title: "Dashboard Paket",
          icon: const Icon(Icons.card_giftcard),
          screen: const Paket())
    ]));
  }

  void navigateTo(String menu, int i) {
    emit(state.copyWith(currentScreen: menu, indexMenu: i));
  }

  void updateStatus(int? id, String newStatus) {
    print(newStatus);
  }

  void initDataDashboard(BuildContext context) async {
    print('ini data dashboard invoked <<<===');
    emit(state.copyWith(isLoading: true));
    try {
      String? user = await Helper().getDataUser();
      String? token = await Helper().getToken();
      print(user);

      if (user != null && token != null) {
        var response = await Request.req(
            path: PathUrl.dataDashboard,
            params: null,
            body: null,
            token: token,
            method: 'get');
        var result = json.decode(response!.body);
        if (response.statusCode == 200) {
          emit(state.copyWith(
              dataDashboard: DashboardModel.fromJson(result['data']),
              chartData: (result['data']['activity'] as List)
                  .map((month) {
                    String bulan = month.keys.first;
                    double val = month[bulan]!.toDouble();
                    return ChartData(bulan, val);
                  })
                  .toList()
                  .cast<ChartData>()));
        } else {
          cShowDialog(
              context: context, title: "Warning", message: result['success']);
        }
      } else {
        emit(state.copyWith(isLoading: false, isSuccess: false));
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load data'));
    }
  }

  void updateStatusTask(BuildContext context, int taskId) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? user = await Helper().getDataUser();
      String? token = await Helper().getToken();
      print(user);
      Map body = {"task_id": taskId, "status": "done"};
      if (user != null && token != null) {
        emit(state.copyWith(user: User.fromJson(jsonDecode(user))));
        var response = await Request.req(
            path: PathUrl.updateStatusTask,
            params: null,
            body: body,
            token: token,
            method: 'post');
        var result = json.decode(response!.body);
        print(response.statusCode);
        print('ini hasilnya =>> $result');
        if (response.statusCode == 200 && result['success'] == true) {
          if (context.mounted) {
            AwesomeDialog(
              dismissOnTouchOutside: false,
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.topSlide,
              title: 'Success',
              desc: 'Task ${result['data']['task']} berhasil di update',
              btnOkOnPress: () {
                initData(context);
                // context.read<DarCubit>().updateStatusTask(context, task.id!);
              },
            ).show();
          }
        } else {
          cShowDialog(
              context: context, title: "Warning", message: result['success']);
        }
      } else {
        emit(state.copyWith(isLoading: false, isSuccess: false));
      }
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load data'));
    }
  }

  void filterStatus(String? value) {
    // emit(state.copyWith(selectedStatus: value));
  }

  void selectStatus(String value, BuildContext context) {
    emit(state.copyWith(selectedStatus: value));
    initData(context);
  }

  Future<void> pickDateRange(BuildContext context) async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: state.selectedDateRange,
    );

    if (picked != null && picked != state.selectedDateRange) {
      emit(state.copyWith(
          fromDate: state.dateFormat.format(picked.start),
          toDate: state.dateFormat.format(picked.end),
          selectedDateRange: picked));
    }

    initData(context);
  }
}
