import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:login/model/user.dart';

class DashboardState extends Equatable {
  final bool isStartAnimation;
  final bool isResetAnimation;
  final List<User> userData;
  final List<Menu> menu;
  final bool isExpired;
  final String errorMessage;
  final String role;

  DashboardState({
    this.isStartAnimation = false,
    this.isResetAnimation = false,
    List<User>? userData,
    List<Menu>? menu,
    this.isExpired = false,
    this.errorMessage = '',
    this.role = '',
  })  : // Beri nilai default di sini jika chartData null
        userData = userData ??
            [
              // Beri nilai default di sini jika userData null
              User(),
              User(),
            ],
        menu = menu ??
            const [
              Menu(Icons.work_history, 'DAR', Colors.purple),
              Menu(Icons.check_box_rounded, 'Form Izin', Colors.indigo),
              Menu(Icons.inventory, 'Asset & ATK', Colors.orange),
              Menu(
                  Icons.request_quote_outlined, 'ATK Permintaan', Colors.green),
              Menu(Icons.shopping_cart, 'CA', Colors.blue),
              Menu(Icons.event, 'Event', Colors.teal),
              Menu(Icons.manage_accounts, 'Management Users',
                  Color.fromARGB(255, 174, 5, 22)),
            ];

  DashboardState copyWith({
    bool? isStartAnimation,
    bool? isResetAnimation,
    List<Menu>? menu,
    bool? isExpired,
    String? errorMessage,
    String? role,
  }) {
    return DashboardState(
      isStartAnimation: isStartAnimation ?? this.isStartAnimation,
      isResetAnimation: isResetAnimation ?? this.isResetAnimation,
      menu: menu ?? this.menu,
      isExpired: isExpired ?? this.isExpired,
      errorMessage: errorMessage ?? this.errorMessage,
      role: role ?? this.role,
    );
  }

  @override
  List<Object> get props =>
      [isStartAnimation, isResetAnimation, menu, isExpired, errorMessage, role];
}
// class User {
//   const User(this.nama, this.umur);
//   final String nama;
//   final int umur;
// }

class Menu {
  const Menu(this.icon, this.title, this.color);
  final IconData icon;
  final String title;
  final Color color;
}
