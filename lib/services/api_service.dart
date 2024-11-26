import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:takemeals/utils/shared_preferences_helper.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000/api/v1';
  // final String baseUrl = 'https://f183-103-246-107-3.ngrok-free.app/api/v1';

  Future<http.Response> get(String endpoint) async {
    final String? token = await SharedPreferencesHelper.getAccessToken();
    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'ngrok-skip-browser-warning': 'true',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return response;
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    final String? token = await SharedPreferencesHelper.getAccessToken();
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'ngrok-skip-browser-warning': 'true',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );
    print(response.body);
    return response;
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> data) async {
    final String? token = await SharedPreferencesHelper.getAccessToken();
    final response = await http.put(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'ngrok-skip-browser-warning': 'true',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );
    return response;
  }

  Future<http.Response> delete(String endpoint) async {
    final String? token = await SharedPreferencesHelper.getAccessToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'ngrok-skip-browser-warning': 'true',
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }
}
