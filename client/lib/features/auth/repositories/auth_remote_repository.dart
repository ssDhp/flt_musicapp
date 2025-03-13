import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await http.get(
      // Uri.parse('http://127.0.0.1:8000/auth/signup'),
      Uri.parse('http://127.0.0.1:8000'),
      // headers: {'Content-Type': 'application/json'},
      // body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    print(response.statusCode);
    print(response.body);
  }

  Future<void> login() async {}
}
