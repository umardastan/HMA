import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/bloc/modul/modul_state.dart';
import 'package:login/model/detail_paket.dart';
import 'package:login/model/paket.dart';
import 'package:login/services/service.dart';
import 'package:login/utils/constants/constantVar.dart';
import 'package:login/utils/helper/helper.dart';

class ModulCubit extends Cubit<ModulState> {
  ModulCubit() : super(ModulState());

  void parsingData(Pakets paket) {
    emit(state.copyWith(
      selectedModulType: null,
    ));
    state.kodeModulTextEditingController.clear();
    state.modulTextEditingController.clear();
    state.keteranganTextEditingController.clear();
  }

  void setSelectedModulType(String? value) {
    emit(state.copyWith(selectedModulType: value));
    print(state.selectedModulType);
  }

  Future<void> saveModul(int? id) async {
    String? token = await Helper().getToken();
    Map body = {
      "paket_id": id,
      "kode_modul": state.kodeModulTextEditingController.text,
      "jenis_modul": state.selectedModulType, // software & hardware,
      "modul": state.modulTextEditingController.text,
      "keterangan": state.keteranganTextEditingController.text
    };

    try {
      var response = await Request.req(
          path: PathUrl.createModul,
          params: null,
          body: body,
          token: token,
          method: 'post');
      var result = json.decode(response!.body);
      print(response.statusCode);
      print(result);
      if (response.statusCode == 200 && result['success'] == true) {
        emit(state.copyWith(
            message: 'Create Modul Berhasil',
            titleMessage: 'Success',
            typeMessage: 'success'));
        emit(state.copyWith(message: '', titleMessage: '', typeMessage: ''));
        resetForm();
      } else {
        emit(state.copyWith(
            message: 'Gagal Create Paket',
            titleMessage: 'Failed',
            typeMessage: 'error'));
        emit(state.copyWith(message: '', titleMessage: '', typeMessage: ''));
      }
    } catch (e) {
      emit(state.copyWith(
          message: e.toString(), titleMessage: 'Failed', typeMessage: 'error'));
      emit(state.copyWith(message: '', titleMessage: '', typeMessage: ''));
    }
    print(body);
  }

  void resetForm() {
    state.kodeModulTextEditingController.clear();
    state.modulTextEditingController.clear();
    state.keteranganTextEditingController.clear();
    emit(state.copyWith(selectedModulType: null));
  }

  void parsingDataModul(Moduls? module) {
    print(module);
    emit(state.copyWith(selectedModulType: module!.jenisModul));
    state.kodeModulTextEditingController.text = module.kodeModul ?? '';
    state.modulTextEditingController.text = module.modul ?? '';
    state.keteranganTextEditingController.text = module.keterangan ?? '';
  }

  Future<void> updateModul(Pakets paket, Moduls? module) async {
      String? token = await Helper().getToken();
      Map body = {
        "paket_id": paket.id,
        "kode_modul": state.kodeModulTextEditingController.text,
        "jenis_modul": state.selectedModulType, // software & hardware,
        "modul": state.modulTextEditingController.text,
        "keterangan": state.keteranganTextEditingController.text
      };

      try {
        var response = await Request.req(
            path: "${PathUrl.updateModul}${module!.id}",
            params: null,
            body: body,
            token: token,
            method: 'post');
        var result = json.decode(response!.body);
        print(response.statusCode);
        print(result);
        if (response.statusCode == 200 && result['success'] == true) {
          emit(state.copyWith(
              message: 'Create Modul Berhasil',
              titleMessage: 'Success',
              typeMessage: 'success'));
          emit(state.copyWith(message: '', titleMessage: '', typeMessage: ''));
          resetForm();
        } else {
          emit(state.copyWith(
              message: 'Gagal Create Paket',
              titleMessage: 'Failed',
              typeMessage: 'error'));
          emit(state.copyWith(message: '', titleMessage: '', typeMessage: ''));
        }
      } catch (e) {
        emit(state.copyWith(
            message: e.toString(), titleMessage: 'Failed', typeMessage: 'error'));
        emit(state.copyWith(message: '', titleMessage: '', typeMessage: ''));
      }
      print(body);
  }
}
