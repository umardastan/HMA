import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/bloc/management_user/management_user_state.dart';
import 'package:login/model/paket.dart';
import 'package:login/model/role.dart';
import 'package:login/model/user.dart';
import 'package:login/screens/components/showDialog.dart';
import 'package:login/services/service.dart';
import 'package:login/utils/constants/constantVar.dart';
import 'package:login/utils/helper/helper.dart';

class ManagementUserCubit extends Cubit<ManagementUserState> {
  List<User> originalDataList = []; // Daftar data asli
  List<User> filteredDataList = []; // Daftar data yang terfilter

  ManagementUserCubit() : super(ManagementUserState());

  Future<void> initDataUsers() async {
    emit(state.copyWith(isLoading: true));
    try {
      String? token = await Helper().getToken();
      if (token != null) {
        var response = await Request.req(
            path: PathUrl.users,
            params: null,
            body: null,
            token: token,
            method: 'get');
        var result = json.decode(response!.body);
        if (response.statusCode == 200 && result['success'] == true) {
          emit(
            state.copyWith(
              listUser: (result['data'] as List)
                  .map((item) {
                    User data = User.fromJson(item);

                    // print("ini ${data.name} => ${data.projectLeader}");
                    return data;
                  })
                  .toList()
                  .cast<User>(),
              isLoading: false,
            ),
          );
          loadData(state.listUser);
        } else {
          emit(state.copyWith(isLoading: false));
        }
      } else {
        emit(state.copyWith(isLoading: false, isSuccess: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: 'Failed to load data'));
    }
  }

  Future<void> initDataPakets() async {
    emit(state.copyWith(isLoading: true));
    try {
      String? token = await Helper().getToken();
      if (token != null) {
        var response = await Request.req(
            path: PathUrl.listPaket,
            params: null,
            body: null,
            token: token,
            method: 'get');
        var result = json.decode(response!.body);
        if (response.statusCode == 200 && result['success'] == true) {
          emit(
            state.copyWith(
              listPaket: (result['data'] as List)
                  .map((item) {
                    return Pakets.fromJson(item);
                  })
                  .toList()
                  .cast<Pakets>(),
              isLoading: false,
            ),
          );
        } else {
          emit(state.copyWith(isLoading: false));
        }
      } else {
        emit(state.copyWith(isLoading: false, isSuccess: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: 'Failed to load data'));
    }
  }

  Future<void> initDataRoles() async {
    emit(state.copyWith(isLoading: true));
    try {
      String? token = await Helper().getToken();
      if (token != null) {
        var response = await Request.req(
            path: PathUrl.listRole,
            params: null,
            body: null,
            token: token,
            method: 'get');
        var result = json.decode(response!.body);
        if (response.statusCode == 200 && result['success'] == true) {
          emit(
            state.copyWith(
              listRole: (result['data'] as List)
                  .map((item) {
                    return Role.fromJson(item);
                  })
                  .toList()
                  .cast<Role>(),
              isLoading: false,
            ),
          );
        } else {
          emit(state.copyWith(isLoading: false));
        }
      } else {
        emit(state.copyWith(isLoading: false, isSuccess: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: 'Failed to load data'));
    }
  }

  // Fungsi untuk menginisialisasi data asli dan menampilkan semua data
  void loadData(List<User> data) {
    originalDataList = data;
    filteredDataList = List.from(data); // Awalnya, tampilkan semua data
    emit(state.copyWith(listUser: filteredDataList));
  }

  // Fungsi filter data berdasarkan input teks pencarian
  void filterData(String query) {
    if (query.isEmpty) {
      // Jika input pencarian kosong, tampilkan semua data
      filteredDataList = List.from(originalDataList);
    } else {
      filteredDataList = originalDataList
          .where((data) =>
              data.name!.toLowerCase().contains(query.toLowerCase()) ||
              data.email!.toLowerCase().contains(query.toLowerCase()) ||
              data.roles!.description!
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              data.role
                  .toString()
                  .contains(query)) // Filter berdasarkan nama, email, atau role
          .toList();
    }
    emit(state.copyWith(
        listUser: filteredDataList)); // Emit state baru dengan data terfilter
  }

  void setSelectedRole(Role? value) {
    emit(state.copyWith(selectedRole: value));
    print(state.selectedRole);
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // Tanggal paling awal
      lastDate: DateTime(2100), // Tanggal paling akhir
    );

    if (pickedDate != null) {
      final formattedDate =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

      // Perbarui teks dalam controller
      state.selectedHireDate.text = formattedDate;

      // Emit state baru tanpa mengganti controller
      emit(state.copyWith());
      print(state.selectedHireDate.text);
    }
  }

  void saveUser() async {
    String? token = await Helper().getToken();
    Map body = {
      "nik": state.nikTextEditingController.text,
      "username": state.usernameTextEditingController.text,
      "email": state.emailTextEditingController.text,
      "role": state.selectedRole!.id,
      "password": state.passwordTextEditingController.text,
      "hire_date": state.selectedHireDate.text,
      "name": state.nameTextEditingController.text,
      "phone": state.phoneTextEditingController.text,
      "paket":
          state.selectedPakets, //jika role 1 & 2 tidak di sertakan komen saja
      "project_leader":
          state.selectedProjectLeader!.id, //disi id "2" sesuai id table paket
      "task_type": state.taskTypeTextEditingController
          .text, //software, hardware, dan all biasa untuk ITadmin. jika role 1 & 2 tidak di sertakan komen saja
      "keterangan": state.keteranganTextEditingController.text
    };

    try {
      var response = await Request.req(
          path: PathUrl.createUser,
          params: null,
          body: body,
          token: token,
          method: 'post');
      var result = json.decode(response!.body);
      print(response.statusCode);
      print(result);
      if (response.statusCode == 200 && result['success'] == true) {
        emit(state.copyWith(
            message: 'Create User Berhasil',
            titleMessage: 'Success',
            typeMessage: 'success'));
        emit(state.copyWith(message: '', titleMessage: '', typeMessage: ''));
        resetForm();
      } else {
        emit(state.copyWith(
            message: 'Gagal Create User',
            titleMessage: 'Failed',
            typeMessage: 'error'));
        emit(state.copyWith(message: '', titleMessage: '', typeMessage: ''));
      }
    } catch (e) {}
    print(body);
  }

  void setSelectedProjectLeader(Pakets pakets) {
    emit(state.copyWith(selectedProjectLeader: pakets));
  }

  void resetForm() {
    print(state.selectedRole);
    state.nikTextEditingController.clear();
    state.usernameTextEditingController.clear();
    state.emailTextEditingController.clear();
    state.passwordTextEditingController.clear();
    state.selectedHireDate.clear();
    state.nameTextEditingController.clear();
    state.phoneTextEditingController.clear();
    state.taskTypeTextEditingController.clear();
    state.keteranganTextEditingController.clear();
    emit(state.copyWith(
        selectedRole: null, selectedPakets: [], selectedProjectLeader: null));
    print(
        "Form reset: selectedRole=${state.selectedRole}, selectedProjectLeader=${state.selectedProjectLeader}");
  }

  void parsingData(User user) {
    // Contoh sinkronisasi nilai
    List<String>? paket =
        user.pivotPakets!.map((item) => item.pakets!.id.toString()).toList();
    state.nikTextEditingController.text = user.nik ?? '';
    state.usernameTextEditingController.text = user.username ?? '';
    state.emailTextEditingController.text = user.email ?? '';
    emit(state.copyWith(
        selectedRole: user.roles ?? Role(),
        selectedPakets: paket,
        selectedProjectLeader: user.projectLeader?.pakets));
    state.selectedHireDate.text = user.hireDate ?? '';
    state.nameTextEditingController.text = user.name ?? '';
    state.phoneTextEditingController.text = user.phone ?? '';
    state.taskTypeTextEditingController.text = user.taskType ?? '';
    state.keteranganTextEditingController.text = user.keterangan ?? "";
    // print("ini data project leader => ${user.projectLeader}");
    // // print(user.projectLeader!.pakets);
    // print(
    //     "ini data Selected Project Leader yang sudah di emit=> ${state.selectedProjectLeader}");
  }

  void updateUser() async {
    String? token = await Helper().getToken();
    Map body = {
      "username": "ittest",
      "nik": null,
      "name": "test saja",
      "hire_date": "2024-03-01",
      "email": "testsaja@gmail.com",
      "phone": "0812940775952",
      "keterangan": "blok",
      "paket": ["11"],
      "project_leader": null,
    };

    try {
      var response = await Request.req(
          path: PathUrl.createUser,
          params: null,
          body: body,
          token: token,
          method: 'post');
      var result = json.decode(response!.body);
      print(response.statusCode);
      print(result);
      if (response.statusCode == 200 && result['success'] == true) {
        emit(state.copyWith(
            message: 'Create User Berhasil',
            titleMessage: 'Success',
            typeMessage: 'success'));
        emit(state.copyWith(message: '', titleMessage: '', typeMessage: ''));
        resetForm();
      } else {
        emit(state.copyWith(
            message: 'Gagal Create User',
            titleMessage: 'Failed',
            typeMessage: 'error'));
        emit(state.copyWith(message: '', titleMessage: '', typeMessage: ''));
      }
    } catch (e) {}
    print(body);
  }
}
