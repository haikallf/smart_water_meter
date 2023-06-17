import 'package:smart_water_meter/models/user_model.dart';

class UserResponseModel {
  UserModel? currentUser;
  int responseStatusCode;

  UserResponseModel({this.currentUser, required this.responseStatusCode});

  factory UserResponseModel.fromJson(
      Map<String, dynamic> responseBody, int statusCode) {
    return UserResponseModel(
      currentUser: UserModel.fromJson(responseBody),
      responseStatusCode: statusCode,
    );
  }
}
