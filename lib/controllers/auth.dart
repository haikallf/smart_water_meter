import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthController {
  var client = http.Client();

  static const String baseUrl = "http://localhost:8000";

  Future<dynamic> signIn(String email, String password) async {
    var url = Uri.parse("$baseUrl/user/login");
    var _headers = {'Content-Type': 'application/json'};
    var _body = json.encode({
      "email": email,
      "password": password,
    });

    var response = await client.post(url, headers: _headers, body: _body);
    return json.decode(response.body);
  }
}
