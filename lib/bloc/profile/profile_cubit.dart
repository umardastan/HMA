import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login/bloc/profile/profile_state.dart';
import 'package:login/model/user.dart';
import 'package:login/router/app_routes.dart';
import 'package:login/services/service.dart';
import 'package:login/utils/constants/constantVar.dart';
import 'package:login/utils/helper/helper.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());

  Future<void> initData(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? user = await Helper().getDataUser();

      if (user != null) {
        User dataUser = User.fromJson(jsonDecode(user));
        emit(state.copyWith(
            name: dataUser.name ?? '',
            email: dataUser.email ?? '',
            phone: dataUser.phone ?? '',
            keterangan: dataUser.keterangan ?? '',
            user: dataUser,
            isLoading: false,
            isSuccess: true));
      } else {
        emit(state.copyWith(isLoading: false, isSuccess: false));
      }
      // Simulasikan pengambilan data user dengan delay
      // await Future.delayed(const Duration(seconds: 2));
      // // Misalkan data user diperoleh di sini
      // final user = User(
      //   username: username,
      //   email: 'user@example.com',
      //   name: 'John Doe',
      // );
      // emit(state.copyWith(user: user, isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load data'));
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await Helper().deleteDataUser();
      await Helper().deleteToken();
      await Helper().deleteInitialLocation();
      // await Helper().deleteExpiredToken();
      if (context.mounted) {
        context.go(Routes.HOME);
      } // Sesuaikan dengan route login
    } catch (e) {
      // emit(state.copyWith(errorMessage: 'Failed to log out'));
    }
  }

  Future<void> updateProfile(BuildContext context) async {
    String? token = await Helper().getToken();
    Map body = {
      "username": state.user.username,
      "name": state.name,
      "hire_date": state.user.hireDate,
      "email": state.email,
      "phone": state.phone,
      "keterangan": state.keterangan
    };
    try {
      var response = await Request.req(
          path: "${PathUrl.updateUser}${state.user.id}",
          params: null,
          body: body,
          token: token,
          method: 'post');
      var result = json.decode(response!.body);
      print(response.statusCode);
      print(result);
      if (response.statusCode == 200 && result['success'] == true) {
        emit(state.copyWith(isUpdateSuccess: true));
        emit(state.copyWith(isUpdateSuccess: false));
      } else {
        emit(state.copyWith(errorMessage: "Gagal Update Data"));
        emit(state.copyWith(errorMessage: ""));
      }
    } catch (e) {}
    print(body);
  }

  void updateData(String key, String value) {
    switch (key) {
      case 'name':
        emit(state.copyWith(name: value));
        break;
      case 'email':
        emit(state.copyWith(email: value));
        break;
      case 'phone':
        emit(state.copyWith(phone: value));
        break;
      case 'keterangan':
        emit(state.copyWith(keterangan: value));
        break;
      default:
    }
  }

  Future<void> refreshData(BuildContext context) async {
    String? token = await Helper().getToken();
    try {
      var response = await Request.req(
          path: "${PathUrl.getUserById}${state.user.id}",
          params: null,
          body: null,
          token: token,
          method: 'get');
      var result = json.decode(response!.body);
      if (response.statusCode == 200 && result['success'] == true) {
        Helper().saveDataUser(jsonEncode(result['data']));
        if (context.mounted) {
          print('refresh data dijalankan');
          await initData(context);
        }
      } else {
        emit(state.copyWith(
            isLoading: false, errorMessage: 'Gagal Get Data User By ID'));
        emit(state.copyWith(errorMessage: ''));
      }
    } catch (e) {
      print('error get user By ID');
      print(e);
    }
  }

  void teslistener() {
    emit(state.copyWith(isKeluar: true));
    emit(state.copyWith(isKeluar: false));
  }

  void updatePassword(String key, String value) {
    switch (key) {
      case 'passwordLama':
        emit(state.copyWith(passwordLama: value));
        break;
      case 'passwordBaru':
        emit(state.copyWith(passwordBaru: value));
        break;
      default:
    }
  }

  Future<void> saveUpdatePassword(BuildContext context) async {
    String? token = await Helper().getToken();
    Map body = {
      "password_lama": state.passwordLama,
      "password_baru": state.passwordBaru
    };
    print(body);
    try {
      var response = await Request.req(
          path: "${PathUrl.updatePassword}${state.user.id}",
          params: null,
          body: body,
          token: token,
          method: 'post');
      var result = json.decode(response!.body);
      print(response.statusCode);
      print(result);
      if (response.statusCode == 200 && result['success'] == true) {
        emit(state.copyWith(isUpdatePasswordSuccess: true));
        emit(state.copyWith(isUpdatePasswordSuccess: false));
      } else if(response.statusCode == 422 && result['success'] == false){
        emit(state.copyWith(
            errorMessage: "${result['error']}"));
        emit(state.copyWith(errorMessage: ""));
      } else {
        emit(state.copyWith(
            errorMessage: "${result['message']}\n${result['errors']}"));
        emit(state.copyWith(errorMessage: ""));
      }
    } catch (e) {
      emit(state.copyWith(
          errorMessage: e.toString()));
      emit(state.copyWith(errorMessage: ""));
    }
  }
}
