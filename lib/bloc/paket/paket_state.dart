import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:login/model/detail_paket.dart';

class PaketState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;
  final bool isFetchData;
  final String message;
  final String titleMessage;
  final String typeMessage;
  final List<DetailPaket> listPaket;
  final TextEditingController kodepaketTextEditingController;
  final TextEditingController judulTextEditingController;
  final TextEditingController tahunTextEditingController;
  final TextEditingController keteranganTextEditingController;

  PaketState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
    this.isFetchData = false,
    this.message = '',
    this.titleMessage = '',
    this.typeMessage = '',
    List<DetailPaket>? listPaket,
    TextEditingController? kodePaketTextEditingController,
    TextEditingController? judulTextEditingController,
    TextEditingController? tahunTextEditingController,
    TextEditingController? keteranganTextEditingController,
  })  : listPaket = listPaket ?? <DetailPaket>[],
        kodepaketTextEditingController =
            kodePaketTextEditingController ?? TextEditingController(),
        judulTextEditingController =
            judulTextEditingController ?? TextEditingController(),
        tahunTextEditingController =
            tahunTextEditingController ?? TextEditingController(),
        keteranganTextEditingController =
            keteranganTextEditingController ?? TextEditingController();

  PaketState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    bool? isFetchData,
    String? message,
    String? titleMessage,
    String? typeMessage,
    List<DetailPaket>? listPaket,
  }) {
    return PaketState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      isFetchData: isFetchData ?? this.isFetchData,
      message: message ?? this.message,
      titleMessage: titleMessage ?? this.titleMessage,
      typeMessage: typeMessage ?? this.typeMessage,
      listPaket: listPaket ?? this.listPaket,
      kodePaketTextEditingController: kodepaketTextEditingController,
      judulTextEditingController: judulTextEditingController,
      tahunTextEditingController: tahunTextEditingController,
      keteranganTextEditingController: keteranganTextEditingController,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isSuccess,
        errorMessage,
        isFetchData,
        message,
        titleMessage,
        typeMessage,
        listPaket,
        kodepaketTextEditingController,
        judulTextEditingController,
        tahunTextEditingController,
        keteranganTextEditingController,
      ];
}
