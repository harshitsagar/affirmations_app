import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://your-api-url.com/login'),
      body: jsonEncode({"email": email, "password": password}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['verified'] == true) {
        return true;
      }
    }
    return false;
  }
}
