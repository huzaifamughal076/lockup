class UserModel{

  String? name,email,phone;
  String id;

  UserModel(
      {required this.name,
       required this.id,
        required this.email,
        required this.phone,}

      );

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "id": id,
      "email": email,
      "phone": phone
    };
  }



}