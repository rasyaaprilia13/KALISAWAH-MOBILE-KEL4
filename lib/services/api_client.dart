import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {

  // Timeout request API
  static const int timeoutSeconds = 30;

  // Ambil base URL dari .env
  static String get baseUrl => dotenv.env['API_URL']!;

  /// GET REQUEST
  static Future<http.Response> get(
    String endpoint,
  ) async {

    // Ambil token dari local storage
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // Kirim GET request
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),

      headers: {
        'Accept': 'application/json',

        // Kirim token jika ada
        if (token != null)
          'Authorization': 'Bearer $token',
      },
    ).timeout(
      const Duration(seconds: timeoutSeconds),
    );

    return response;
  }


  /// POST REQUEST
  static Future<http.Response> post(
    String endpoint, {
    Object? body,
  }) async {

    // Ambil token
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // Kirim POST request
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),

      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',

        if (token != null)
          'Authorization': 'Bearer $token',
      },

      body: body,
    ).timeout(
      const Duration(seconds: timeoutSeconds),
    );

    return response;
  }

  
  /// DELETE REQUEST
  static Future<http.Response> delete(
    String endpoint,
  ) async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),

      headers: {
        'Accept': 'application/json',

        if (token != null)
          'Authorization': 'Bearer $token',
      },
    ).timeout(
      const Duration(seconds: timeoutSeconds),
    );

    return response;
  }
}