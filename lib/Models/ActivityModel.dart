class ActivityModel {
  String? id, name,manager, password;

  ActivityModel({required this.id,
    required this.name,
    required this.manager,
    required this.password,});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "manager": manager,
      "password": password
    };
  }
}