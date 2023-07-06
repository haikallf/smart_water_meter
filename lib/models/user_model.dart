class UserModel {
  String? id;
  String? email;
  String? name;
  String? token;

  UserModel({this.id, this.email, this.name, this.token});

  factory UserModel.fromJson(Map<String, dynamic> responseBody) {
    return UserModel(
      id: responseBody['id'],
      email: responseBody['email'],
      name: responseBody['name'],
      token: responseBody['token'],
    );
  }
}
