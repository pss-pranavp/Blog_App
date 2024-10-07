import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class AuthService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  Future<void> register(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to register');
    }
  }

  Future<String> login(String username, String password) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/api/login/'),
    body: {
      'username': username,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['token'];
  } else {
    throw Exception('Failed to log in');
  }
}

  //  Future<String> login(String username, String password) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/login/'), // Adjust the endpoint as needed
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({'username': username, 'password': password}),
  //   );

  //   if (response.statusCode == 200) {
  //     final responseData = jsonDecode(response.body);
  //     return responseData['token']; // Adjust based on your response
  //   } else {
  //     throw Exception('Failed to login');
  //   }
  // }
}
