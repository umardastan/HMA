import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:login/model/paket.dart';

class ModulState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;
  final Pakets? selectedPaket;
  final String? selectedModulType;
  final String message;
  final String titleMessage;
  final String typeMessage;
  final TextEditingController kodeModulTextEditingController;
  final TextEditingController modulTextEditingController;
  final TextEditingController tahunTextEditingController;
  final TextEditingController keteranganTextEditingController;

  ModulState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
    this.selectedPaket,
    this.selectedModulType,
    this.message = '',
    this.titleMessage = '',
    this.typeMessage = '',
    TextEditingController? kodeModulTextEditingController,
    TextEditingController? modulTextEditingController,
    TextEditingController? tahunTextEditingController,
    TextEditingController? keteranganTextEditingController,
  })  : kodeModulTextEditingController =
            kodeModulTextEditingController ?? TextEditingController(),
        modulTextEditingController =
            modulTextEditingController ?? TextEditingController(),
        tahunTextEditingController =
            tahunTextEditingController ?? TextEditingController(),
        keteranganTextEditingController =
            keteranganTextEditingController ?? TextEditingController();

  ModulState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    Pakets? selectedPaket,
    String? selectedModulType,
    String? message,
    String? titleMessage,
    String? typeMessage,
  }) {
    return ModulState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedPaket: selectedPaket ?? this.selectedPaket,
      selectedModulType: selectedModulType,
      message: message ?? this.message,
      titleMessage: titleMessage ?? this.titleMessage,
      typeMessage: typeMessage ?? this.typeMessage,
      kodeModulTextEditingController: kodeModulTextEditingController,
      modulTextEditingController: modulTextEditingController,
      tahunTextEditingController: tahunTextEditingController,
      keteranganTextEditingController: keteranganTextEditingController,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        errorMessage,
        selectedPaket ?? Pakets(),
        selectedModulType,
        message,
        titleMessage,
        typeMessage,
        kodeModulTextEditingController,
        modulTextEditingController,
        tahunTextEditingController,
        keteranganTextEditingController,
      ];
}
