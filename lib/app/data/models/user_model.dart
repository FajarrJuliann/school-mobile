import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int id;
  String username;
  String email;
  int role;
  int isLogin;
  int isDelete;
  String
      createdAt; // Ubah menjadi String agar kompatibel dengan SharedPreferences
  String
      updatedAt; // Ubah menjadi String agar kompatibel dengan SharedPreferences

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.isLogin,
    required this.isDelete,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        role: json["role"],
        isLogin: json["is_login"],
        isDelete: json["is_delete"],
        createdAt: json["created_at"], // Simpan sebagai String
        updatedAt: json["updated_at"], // Simpan sebagai String
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "role": role,
        "is_login": isLogin,
        "is_delete": isDelete,
        "created_at": createdAt, // Simpan sebagai String
        "updated_at": updatedAt, // Simpan sebagai String
      };
}
