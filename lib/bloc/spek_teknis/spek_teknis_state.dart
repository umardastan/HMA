import 'package:equatable/equatable.dart';
import 'package:login/model/spektek.dart';

class SpektekState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;
  final String message;
  final String titleMessage;
  final String typeMessage;
  final List<Spektek> listSpektek;
  final List<Spektek> filteredData;
  final List<Spektek> listModul;
  final List<Spektek> filteredDataModul;

  SpektekState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
    this.message = '',
    this.titleMessage = '',
    this.typeMessage = '',
    List<Spektek>? listSpektek,
    List<Spektek>? filteredData,
    List<Spektek>? listModul,
    List<Spektek>? filteredDataModul,
  })  : listSpektek = listSpektek ?? <Spektek>[],
        filteredData = filteredData ?? <Spektek>[],
        listModul = listModul ?? <Spektek>[],
        filteredDataModul = filteredDataModul ?? <Spektek>[];

  SpektekState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    String? message,
    String? titleMessage,
    String? typeMessage,
    List<Spektek>? listSpektek,
    List<Spektek>? filteredData,
    List<Spektek>? listModul,
    List<Spektek>? filteredDataModul,
  }) {
    return SpektekState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      message: message ?? this.message,
      titleMessage: titleMessage ?? this.titleMessage,
      typeMessage: typeMessage ?? this.typeMessage,
      listSpektek: listSpektek ?? this.listSpektek,
      filteredData: filteredData ?? this.filteredData,
      listModul: listModul ?? this.listModul,
      filteredDataModul: filteredDataModul ?? this.filteredDataModul,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isSuccess,
        errorMessage,
        message,
        titleMessage,
        typeMessage,
        listSpektek,
        filteredData,
        listModul,
        filteredDataModul,
      ];
}
