import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/bloc/login/login_state.dart';
import 'package:login/bloc/spek_teknis/spek_teknis_state.dart';
import 'package:login/model/spektek.dart';
import 'package:login/screens/components/showDialog.dart';
import 'package:login/services/service.dart';
import 'package:login/utils/constants/constantVar.dart';
import 'package:login/utils/helper/helper.dart';

class SpekTeknisCubit extends Cubit<SpektekState> {
  SpekTeknisCubit() : super(SpektekState());

  Future<void> initListSpecTech(BuildContext context) async {
    try {
      emit(state.copyWith(isLoading: true));
      String? token = await Helper().getToken();
      if (token != null) {
        var response = await Request.req(
            path: PathUrl.listSpecTech,
            params: null,
            body: null,
            token: token,
            method: 'get');
        var result = json.decode(response!.body);
        if (response.statusCode == 200 && result['success'] == true) {
          List<Spektek> data = (result['data'] as List)
              .map((item) {
                return Spektek.fromJson(item);
              })
              .toList()
              .cast<Spektek>();
          emit(
            state.copyWith(
                listSpektek: data, filteredData: data, isLoading: false),
          );
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

  Future<void> initListModul(BuildContext context) async {
    try {
      emit(state.copyWith(isLoading: true));
      String? token = await Helper().getToken();
      if (token != null) {
        var response = await Request.req(
            path: PathUrl.listModul,
            params: null,
            body: null,
            token: token,
            method: 'get');
        var result = json.decode(response!.body);
        if (response.statusCode == 200 && result['success'] == true) {
          List<Spektek> data = (result['data'] as List)
              .map((item) {
                return Spektek.fromJson(item);
              })
              .toList()
              .cast<Spektek>();
          emit(
            state.copyWith(
                listModul: data, filteredDataModul: data, isLoading: false),
          );
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

  void filterData(String query) {
    if (query.isEmpty) {
      // Jika input pencarian kosong, tampilkan semua data
      emit(state.copyWith(filteredData: state.listSpektek));
    } else {
      List<Spektek> tempData = state.listSpektek.where((item) {
        final keterangan = item.keterangan?.toLowerCase() ?? '';
        final jenisModul = item.jenisModul?.toLowerCase() ?? '';
        final kodePaket = item.pakets?.kodePaket?.toLowerCase() ?? '';

        return keterangan.contains(query.toLowerCase()) ||
            jenisModul.contains(query.toLowerCase()) ||
            kodePaket.contains(query.toLowerCase());
      }).toList();

      emit(state.copyWith(filteredData: tempData));
    }
  }

  void filterDataModul(String query) {
    if (query.isEmpty) {
      // Jika input pencarian kosong, tampilkan semua data
      emit(state.copyWith(filteredDataModul: state.listModul));
    } else {
      List<Spektek> tempData = state.listModul.where((item) {
        final keterangan = item.keterangan?.toLowerCase() ?? '';
        final jenisModul = item.jenisModul?.toLowerCase() ?? '';
        final kodePaket = item.pakets?.kodePaket?.toLowerCase() ?? '';
        final modul = item.modul?.toLowerCase() ?? '';

        return keterangan.contains(query.toLowerCase()) ||
            jenisModul.contains(query.toLowerCase()) ||
            kodePaket.contains(query.toLowerCase()) || 
            modul.contains(query.toLowerCase());
      }).toList();

      emit(state.copyWith(filteredDataModul: tempData));
    }
  }

  Future<void> deleteModul(Spektek item) async {
    String? token = await Helper().getToken();

    try {
      var response = await Request.req(
          path: "${PathUrl.deleteModul}${item.id}",
          params: null,
          body: null,
          token: token,
          method: 'delete');
      var result = json.decode(response!.body);
      print(response.statusCode);
      print(result);
      if (response.statusCode == 200 && result['success'] == true) {
        emit(state.copyWith(
            message: 'Delete Modul Berhasil',
            titleMessage: 'Success',
            typeMessage: 'success'));
        emit(state.copyWith(message: '', titleMessage: '', typeMessage: ''));
      } else {
        emit(state.copyWith(
            message: 'Gagal Delete Modul',
            titleMessage: 'Failed',
            typeMessage: 'error'));
        emit(state.copyWith(message: '', titleMessage: '', typeMessage: ''));
      }
    } catch (e) {
      emit(state.copyWith(
          message: e.toString(), titleMessage: 'Failed', typeMessage: 'error'));
      emit(state.copyWith(message: '', titleMessage: '', typeMessage: ''));
    }
  }
}
