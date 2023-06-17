class UserModel {
  String? email;
  String? name;
  String? token;

  UserModel({this.email, this.name, this.token});

  factory UserModel.fromJson(Map<String, dynamic> responseBody) {
    return UserModel(
      email: responseBody['email'],
      name: responseBody['name'],
      token: responseBody['token'],
    );
  }
}
