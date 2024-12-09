import 'package:flutter/material.dart';

class MenuDar {
  final String title;
  final Icon? icon;
  final Widget? screen;
  final List<MenuDar>? subMenu; // Tambahkan properti ini

  MenuDar({
    required this.title,
    this.icon,
    this.screen,
    this.subMenu,
  });

  @override
  toString() => "title: $title, icon: $icon, screen: $screen, subMenu: $subMenu";
}

// class MenuDar {
//   String? title;
//   Icon? icon;
//   Widget? screen;

//   MenuDar({this.title, this.icon, this.screen});

//   MenuDar.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     icon = json['icon'];
//     icon = json['screen'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['title'] = title;
//     data['icon'] = icon;
//     data['screen'] = screen;
//     return data;
//   }

//   @override
//   toString() => "title: $title, icon: $icon, screen: $screen";
// }
