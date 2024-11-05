import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:takemeals/services/api_service.dart';
import 'package:takemeals/utils/entrypoint.dart';
import 'package:takemeals/utils/shared_preferences_helper.dart';

class AuthService {
  ApiService apiService = ApiService();

  Future<void> login(
      BuildContext context, String email, String password) async {
    final response = await apiService.post(
      'login',
      {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['access_token'];
      await SharedPreferencesHelper.setAccessToken(token);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const EntryPoint(),
        ),
        (_) => true,
      );
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid email or password"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("An error occurred"),
        ),
      );
    }
  }

  Future<void> register(BuildContext context, String name, String email, String phone, String password) async {
    final response = await apiService.post(
      'register',
      {'name': name, 'email': email, 'password': password},
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registration successful"),
        ),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const EntryPoint(),
        ),
        (_) => true,
      );
    } else if (response.statusCode == 401) {
      final data = jsonDecode(response.body);
      final errors = data['message'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errors.toString()),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("An error occurred"),
        ),
      );
    }
  }

  Future<bool> logout() async {
    final response = await apiService.post('logout', {});

    if (response.statusCode == 200) {
      await SharedPreferencesHelper.clearAccessToken();
      return true;
    } else {
      return false;
    }
  }
}
