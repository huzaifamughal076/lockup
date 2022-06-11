class UserModel{

  String? name,email,phone;

  UserModel(
      {required this.name,
        required this.email,
        required this.phone,}

      );

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone
    };
  }



}