class ActivityModel {
  String? id, name, password;

  ActivityModel({required this.id,
    required this.name,
    required this.password,});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "password": password
    };
  }
}