import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/model/dashboard_dar.dart';
import 'package:login/model/dashboard_paket.dart';
import 'package:login/model/menu_dar.dart';
import 'package:login/model/aktivitas.dart';
import 'package:login/model/user.dart';

class DarState extends Equatable {
  final User user;
  final Aktivitas task;
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;
  final List<Aktivitas> tasks;
  final String warningMessage;
  final List<MenuDar> listMenu;
  final String currentScreen;
  final int indexMenu;
  final DashboardModel dataDashboard;
  final List<ChartData> chartData;
  final String selectedStatus;
  final List<String> listStatus;
  final DateTimeRange selectedDateRange;
  final DateFormat dateFormat;
  final String fromDate;
  final String toDate;
  final List<DashboardPaketModel> listDashboardPaket;
  final int selectedIdUser;
  final String role;
  final List<User> users;
  final User? selectedUserForTask;
  final int? indexSubMenu;

  DarState({
    User? user,
    Aktivitas? task,
    DashboardModel? dataDashboard,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
    this.warningMessage = '',
    this.tasks = const <Aktivitas>[],
    this.listMenu = const <MenuDar>[],
    this.currentScreen = '',
    this.indexMenu = 0,
    List<ChartData>? chartData, // Ubah chartData menjadi parameter opsional
    this.selectedStatus = 'all',
    List<String>? listStatus,
    DateTimeRange? selectedDateRange,
    DateFormat? dateFormat,
    final String? fromDate,
    final String? toDate,
    List<DashboardPaketModel>? listDashboardPaket,
    this.selectedIdUser = 0,
    this.role = '',
    List<User>? users,
    this.selectedUserForTask,
    this.indexSubMenu,
  })  : user = user ?? User(),
        task = task ?? Aktivitas(),
        dataDashboard = dataDashboard ?? DashboardModel(),
        chartData = chartData ??
            [
              const ChartData("Jan", 35.0),
              const ChartData("Feb", 28.0),
              const ChartData("Mar", 34.0),
              const ChartData("Apr", 32.0),
              const ChartData("May", 40.0),
              const ChartData("Jun", 10.0),
              const ChartData("Jul", 4.0),
              const ChartData("Aug", 14.0),
              const ChartData("Sep", 23.0),
              const ChartData("Oct", 9.0),
              const ChartData("Nov", 18.0),
              const ChartData("Dec", 2.0),
            ],
        listStatus = listStatus ?? ['all', 'done', 'progress'],
        selectedDateRange = selectedDateRange ??
            DateTimeRange(
              start: DateTime.now().subtract(
                  const Duration(days: 0)), // Contoh: 7 hari yang lalu
              end: DateTime.now(), // Tanggal sekarang
            ),
        dateFormat = dateFormat ?? DateFormat('yyyy-MM-dd'),
        fromDate = fromDate ??
            DateFormat('yyyy-MM-dd').format(DateTime.now()
                .subtract(const Duration(days: 0))), // 7 hari yang lalu
        toDate = toDate ?? DateFormat('yyyy-MM-dd').format(DateTime.now()),
        listDashboardPaket = listDashboardPaket ?? <DashboardPaketModel>[],
        users = users ?? <User>[];
  // selectedUserForTask = selectedUserForTask ?? User();

  DarState copyWith({
    User? user,
    Aktivitas? task,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    List<Aktivitas>? tasks,
    String? warningMessage,
    List<MenuDar>? listMenu,
    String? currentScreen,
    int? indexMenu,
    DashboardModel? dataDashboard,
    List<ChartData>?
        chartData, // Tambahkan chartData di sini jika ingin mengganti datanya
    String? selectedStatus,
    List<String>? listStatus,
    DateTimeRange? selectedDateRange,
    DateFormat? dateFormat,
    String? fromDate,
    String? toDate,
    List<DashboardPaketModel>? listDashboardPaket,
    int? selectedIdUser,
    String? role,
    List<User>? users,
    User? selectedUserForTask,
    int? indexSubMenu,
  }) {
    return DarState(
      user: user ?? this.user,
      task: task ?? this.task,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      tasks: tasks ?? this.tasks, // Update field tasks di sini
      warningMessage: warningMessage ?? this.warningMessage,
      listMenu: listMenu ?? this.listMenu,
      currentScreen: currentScreen ?? this.currentScreen,
      indexMenu: indexMenu ?? this.indexMenu,
      dataDashboard: dataDashboard ?? this.dataDashboard,
      chartData:
          chartData ?? this.chartData, // Tambahkan chartData ke copyWith);
      selectedStatus: selectedStatus ?? this.selectedStatus,
      listStatus: listStatus ?? this.listStatus,
      selectedDateRange: selectedDateRange ?? this.selectedDateRange,
      dateFormat: dateFormat ?? this.dateFormat,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      listDashboardPaket: listDashboardPaket ?? this.listDashboardPaket,
      selectedIdUser: selectedIdUser ?? this.selectedIdUser,
      role: role ?? this.role,
      users: users ?? this.users,
      selectedUserForTask: selectedUserForTask ?? this.selectedUserForTask, // kalau di berikan nilai null diakan kembali kenilai sebelumnya
      indexSubMenu: indexSubMenu // kalau diberikan nilai null, maka nilai nya menjadi null
    );
  }

  @override
  List<Object?> get props => [
        user,
        task,
        isLoading,
        isSuccess,
        errorMessage,
        tasks,
        warningMessage,
        listMenu,
        currentScreen,
        indexMenu,
        dataDashboard,
        chartData,
        selectedStatus,
        listStatus,
        selectedDateRange,
        dateFormat,
        fromDate,
        toDate,
        listDashboardPaket,
        selectedIdUser,
        role,
        users,
        selectedUserForTask,
        indexSubMenu,
      ];
}

class ChartData {
  const ChartData(this.x, this.y); // Tetapkan constructor sebagai const
  final String x;
  final double y;
}
