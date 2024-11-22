import 'package:login/model/paket.dart';
import 'package:login/model/role.dart';

class User {
  int? id;
  String? nik;
  String? username;
  String? email;
  String? name;
  String? role;
  String? phone;
  String? hireDate;
  String? emailVerifiedAt;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? taskType;
  String? keterangan;
  String? signature;
  String? jabatan;
  int? loginAtk;
  int? loginIzin;
  int? loginEvent;
  int? loginCa;
  ProjectLeader? projectLeader;
  List<PivotPakets>? pivotPakets;
  Role? roles;

  User(
      {this.id,
      this.nik,
      this.username,
      this.email,
      this.name,
      this.role,
      this.phone,
      this.hireDate,
      this.emailVerifiedAt,
      this.rememberToken,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.taskType,
      this.keterangan,
      this.signature,
      this.jabatan,
      this.loginAtk,
      this.loginIzin,
      this.loginEvent,
      this.loginCa,
      this.projectLeader,
      this.pivotPakets,
      this.roles});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nik = json['nik'];
    username = json['username'];
    email = json['email'];
    name = json['name'];
    role = json['role'];
    phone = json['phone'];
    hireDate = json['hire_date'];
    emailVerifiedAt = json['email_verified_at'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    taskType = json['task_type'];
    keterangan = json['keterangan'];
    signature = json['signature'];
    jabatan = json['jabatan'];
    loginAtk = json['login_atk'];
    loginIzin = json['login_izin'];
    loginEvent = json['login_event'];
    loginCa = json['login_ca'];
    projectLeader = json['project_leader'] != null
        ? ProjectLeader.fromJson(json['project_leader'])
        : null;
    if (json['pivot_pakets'] != null) {
      pivotPakets = <PivotPakets>[];
      json['pivot_pakets'].forEach((v) {
        pivotPakets!.add(PivotPakets.fromJson(v));
      });
    }
    roles = json['roles'] != null ? Role.fromJson(json['roles']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nik'] = nik;
    data['username'] = username;
    data['email'] = email;
    data['name'] = name;
    data['role'] = role;
    data['phone'] = phone;
    data['hire_date'] = hireDate;
    data['email_verified_at'] = emailVerifiedAt;
    data['remember_token'] = rememberToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['task_type'] = taskType;
    data['keterangan'] = keterangan;
    data['signature'] = signature;
    data['jabatan'] = jabatan;
    data['login_atk'] = loginAtk;
    data['login_izin'] = loginIzin;
    data['login_event'] = loginEvent;
    data['login_ca'] = loginCa;
    if (projectLeader != null) {
      data['project_leader'] = projectLeader!.toJson();
    }
    if (pivotPakets != null) {
      data['pivot_pakets'] = pivotPakets!.map((v) => v.toJson()).toList();
    }
    if (roles != null) {
      data['roles'] = roles!.toJson();
    }
    return data;
  }

  @override
  toString() =>
      "id: $id, nik: $nik, username: $username, email: $email, name: $name, role: $role, phone: $phone, hireDate: $hireDate";
}

class PivotPakets {
  int? id;
  String? userId;
  String? paketId;
  String? createdAt;
  String? updatedAt;
  Pakets? pakets;

  PivotPakets(
      {this.id,
      this.userId,
      this.paketId,
      this.createdAt,
      this.updatedAt,
      this.pakets});

  PivotPakets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    paketId = json['paket_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pakets = json['pakets'] != null ? Pakets.fromJson(json['pakets']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['paket_id'] = paketId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pakets != null) {
      data['pakets'] = pakets!.toJson();
    }
    return data;
  }

  @override
  toString() =>
      "id: $id, user_id: $userId, paket_id: $paketId, created_at: $createdAt, updated_at: $updatedAt, pakets: $pakets";
}

// class Roles {
//   int? id;
//   String? role;
//   String? description;
//   String? createdAt;
//   String? updatedAt;

//   Roles({this.id, this.role, this.description, this.createdAt, this.updatedAt});

//   Roles.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     role = json['role'];
//     description = json['description'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['role'] = role;
//     data['description'] = description;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }

//   @override
//   toString() => "id: $id, role: $role, description: $description";
// }

class ProjectLeader {
  int? id;
  int? userId;
  int? paketId;
  String? createdAt;
  String? updatedAt;
  Pakets? pakets;

  ProjectLeader({
    this.id,
    this.userId,
    this.paketId,
    this.createdAt,
    this.updatedAt,
    this.pakets,
  });

  ProjectLeader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    paketId = json['paket_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pakets =
        json['pakets'] != null ? Pakets.fromJson(json['pakets']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['paket_id'] = paketId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pakets != null) {
      data['pakets'] = pakets!.toJson();
    }
    return data;
  }

  @override
  toString() => '{id: $id, userId: $userId, paketId: $paketId, paket: $pakets}';
}
