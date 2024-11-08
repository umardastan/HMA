import 'package:equatable/equatable.dart';
import 'package:login/model/user.dart';

class ProfileState extends Equatable {
  final User user;
  final User person;
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;
  final String name;
  final String email;
  final String phone;
  final String keterangan;
  final bool isUpdateSuccess;
  final bool isKeluar;
  final String passwordLama;
  final String passwordBaru;
  final bool isUpdatePasswordSuccess;

  ProfileState({
    User? user,
    User? person,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.keterangan = '',
    this.isUpdateSuccess = false,
    this.isKeluar = false,
    this.passwordLama = '',
    this.passwordBaru = '',
    this.isUpdatePasswordSuccess = false,
  })  : user = user ?? User(),
        person = person ?? User();

  ProfileState copyWith({
    User? user,
    User? person,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    String? name,
    String? email,
    String? phone,
    String? keterangan,
    bool? isUpdateSuccess,
    bool? isKeluar,
    String? passwordLama,
    String? passwordBaru,
    bool? isUpdatePasswordSuccess,
  }) {
    return ProfileState(
      user: user ?? this.user,
      person: person ?? this.person,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      keterangan: keterangan ?? this.keterangan,
      isUpdateSuccess: isUpdateSuccess ?? this.isUpdateSuccess,
      isKeluar: isKeluar ?? this.isKeluar,
      passwordLama: passwordLama ?? this.passwordLama,
      passwordBaru: passwordBaru ?? this.passwordBaru,
      isUpdatePasswordSuccess:
          isUpdatePasswordSuccess ?? this.isUpdatePasswordSuccess,
    );
  }

  @override
  List<Object> get props => [
        user,
        person,
        isLoading,
        isSuccess,
        errorMessage,
        name,
        email,
        phone,
        keterangan,
        isUpdateSuccess,
        isKeluar,
        passwordLama,
        passwordBaru,
        isUpdatePasswordSuccess,
      ];
}
