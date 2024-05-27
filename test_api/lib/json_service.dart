import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';

class ApiService {
  final String apiUrl = "http://localhost:3000/usuarios";

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<User> users = body.map((dynamic item) => User.fromJson(item)).toList();
      return users;
    } else {
      throw Exception("Failed to load users");
    }
  }
}
