class Role {
  int? id;
  String? role;
  String? description;
  String? createdAt;
  String? updatedAt;

  Role({this.id, this.role, this.description, this.createdAt, this.updatedAt});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role'] = role;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  toString() => "{id: $id, role: $role, description: $description, created_at: $createdAt, updated_at: $updatedAt}";

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Role && other.id == id && other.role == role;
  }

  @override
  int get hashCode => id.hashCode ^ role.hashCode;
}
