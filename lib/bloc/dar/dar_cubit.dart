import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/bloc/dar/dar_state.dart';
import 'package:login/model/task.dart';
import 'package:login/model/user.dart';
import 'package:login/screens/components/showDialog.dart';
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
            params: null,
            body: null,
            token: token,
            method: 'get');
        var result = json.decode(response!.body);
        print(response.statusCode);
        print('ini hasilnya =>> $result');
        if (response.statusCode == 200) {
          emit(state.copyWith(
              tasks: (result['data'] as List)
                  .map((item) {
                    return Task.fromJson(item);
                  })
                  .toList()
                  .cast<Task>()));
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

  void updateStatus(int? id, String newStatus) {
    print(newStatus);
  }
}
