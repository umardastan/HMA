import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:login/model/paket.dart';
import 'package:login/model/role.dart';
import 'package:login/model/user.dart';

class ManagementUserState extends Equatable {
  final bool isLoading;
  final bool isFetchData;
  final bool isSuccess;
  final String message;
  final String titleMessage;
  final String typeMessage;
  final List<User> listUser;
  final List<Pakets> listPaket;
  final List<Role> listRole;
  final List<String> selectedPakets;
  final Role? selectedRole;
  final TextEditingController nikTextEditingController;
  final TextEditingController usernameTextEditingController;
  final TextEditingController emailTextEditingController;
  final TextEditingController selectedHireDate;
  final TextEditingController passwordTextEditingController;
  final TextEditingController nameTextEditingController;
  final TextEditingController phoneTextEditingController;
  final TextEditingController taskTypeTextEditingController;
  final TextEditingController keteranganTextEditingController;
  final Pakets? selectedProjectLeader;

  ManagementUserState({
    this.isLoading = false,
    this.isFetchData = false,
    this.isSuccess = false,
    this.message = '',
    this.titleMessage = '',
    this.typeMessage = '',
    List<User>? listUser,
    List<Pakets>? listPaket,
    List<Role>? listRole,
    List<String>? selectedPakets,
    this.selectedRole,
    TextEditingController? nikTextEditingController,
    TextEditingController? usernameTextEditingController,
    TextEditingController? emailTextEditingController,
    TextEditingController? selectedHireDate,
    TextEditingController? passwordTextEditingController,
    TextEditingController? nameTextEditingController,
    TextEditingController? phoneTextEditingController,
    TextEditingController? taskTypeTextEditingController,
    TextEditingController? keteranganTextEditingController,
    this.selectedProjectLeader,
  })  : listUser = listUser ?? <User>[],
        listPaket = listPaket ?? <Pakets>[],
        listRole = listRole ?? <Role>[],
        selectedPakets = selectedPakets ?? <String>[],
        nikTextEditingController =
            nikTextEditingController ?? TextEditingController(),
        usernameTextEditingController =
            usernameTextEditingController ?? TextEditingController(),
        emailTextEditingController =
            emailTextEditingController ?? TextEditingController(),
        selectedHireDate = selectedHireDate ?? TextEditingController(),
        passwordTextEditingController =
            passwordTextEditingController ?? TextEditingController(),
        nameTextEditingController =
            nameTextEditingController ?? TextEditingController(),
        phoneTextEditingController =
            phoneTextEditingController ?? TextEditingController(),
        taskTypeTextEditingController =
            taskTypeTextEditingController ?? TextEditingController(),
        keteranganTextEditingController =
            keteranganTextEditingController ?? TextEditingController();

  ManagementUserState copyWith({
    bool? isLoading,
    bool? isFetchData,
    bool? isSuccess,
    String? message,
    String? titleMessage,
    String? typeMessage,
    List<User>? listUser,
    List<Pakets>? listPaket,
    List<Role>? listRole,
    List<String>? selectedPakets,
    Role? selectedRole,
    Pakets? selectedProjectLeader,
    // String? nikTextEditingController,
    // String? usernameTextEditingController,
    // String? emailTextEditingController,
    // TextEditingController? selectedHireDate,
  }) {
    return ManagementUserState(
        isLoading: isLoading ?? this.isLoading,
        isFetchData:  isFetchData ?? this.isFetchData,
        isSuccess: isSuccess ?? this.isSuccess,
        message: message ?? this.message,
        titleMessage: titleMessage ?? this.titleMessage,
        typeMessage: typeMessage ?? this.typeMessage,
        listUser: listUser ?? this.listUser,
        listPaket: listPaket ?? this.listPaket,
        listRole: listRole ?? this.listRole,
        selectedPakets: selectedPakets ?? this.selectedPakets,
        selectedRole: selectedRole,
        nikTextEditingController: nikTextEditingController,
        usernameTextEditingController: usernameTextEditingController,
        emailTextEditingController: emailTextEditingController,
        selectedHireDate: selectedHireDate,
        passwordTextEditingController: passwordTextEditingController,
        nameTextEditingController: nameTextEditingController,
        phoneTextEditingController: phoneTextEditingController,
        taskTypeTextEditingController: taskTypeTextEditingController,
        keteranganTextEditingController: keteranganTextEditingController,
        selectedProjectLeader: selectedProjectLeader);
  }

  @override
  List<Object> get props => [
        isLoading,
        isFetchData,
        isSuccess,
        message,
        titleMessage,
        typeMessage,
        listUser,
        listPaket,
        listRole,
        selectedPakets,
        selectedRole ?? Role(),
        nikTextEditingController,
        usernameTextEditingController,
        emailTextEditingController,
        selectedHireDate,
        passwordTextEditingController,
        nameTextEditingController,
        phoneTextEditingController,
        taskTypeTextEditingController,
        keteranganTextEditingController,
        selectedProjectLeader ?? Pakets()
      ];
}
