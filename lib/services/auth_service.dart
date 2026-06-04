import 'dart:convert'; 
import 'package:flutter/material.dart'; // Untuk ChangeNotifier
import 'package:shared_preferences/shared_preferences.dart'; // Menyimpan data login di HP
import 'package:http/http.dart' as http; // Untuk request API
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Untuk membaca file .env

// Service untuk mengatur session/login user
class AuthService extends ChangeNotifier {

  // Status apakah sedang loading
  bool _isLoading = false;

  // Status apakah user sudah login atau belum
  bool _authenticated = false;

  // ... (rest of variables)
  String? _accessToken;
  String? _userRole;
  int? _currentUserId;

  // Getter
  bool get isLoading => _isLoading;
  bool get authenticated => _authenticated;
  String? get accessToken => _accessToken;
  String? get userRole => _userRole;
  int? get currentUserId => _currentUserId;

  // ... (rest of methods)
  String get apiUrl => dotenv.env['API_URL']!;

  /// CEK SESSION LOGIN
  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('token');
    _userRole = prefs.getString('role');
    _currentUserId = prefs.getInt('user_id');
    _authenticated = _accessToken != null && _accessToken!.isNotEmpty;
    notifyListeners();
  }

  /// LOGIN USER
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('$apiUrl/api/login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _accessToken = result['token'];
        _userRole = result['user']['role'];
        _currentUserId = result['user']['id'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _accessToken!);
        await prefs.setString('role', _userRole!);
        await prefs.setInt('user_id', _currentUserId!);

        _authenticated = true;
        _isLoading = false;
        notifyListeners();

        return {
          'status': true,
          'message': 'Berhasil login',
        };
      }

      _isLoading = false;
      notifyListeners();
      return {
        'status': false,
        'message': result['message'] ?? 'Login gagal',
      };

    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return {
        'status': false,
        'message': 'Server tidak dapat dihubungi',
      };
    }
  }

 
  /// AMBIL PROFILE USER
  Future<Map<String, dynamic>> getProfile() async {

    try {

      // Request GET profile ke Laravel
      final response = await http.get(

        // Endpoint profile
        Uri.parse('$apiUrl/api/profile'),

        // Header authorization token
        headers: {
          'Accept': 'application/json',

          // Mengirim token Bearer
          'Authorization': 'Bearer $_accessToken',
        },
      );

      // Decode response JSON
      final result = jsonDecode(response.body);

      // Jika berhasil
      if (response.statusCode == 200) {

        // Kembalikan data profile
        return result['data'];
      }

      // Jika token invalid / expired
      if (response.statusCode == 401) {

        // Logout otomatis
        await signOut();

        throw Exception('Session telah habis');
      }

      // Error lainnya
      throw Exception(result['message']);

    } catch (e) {

      // Lempar error kembali
      rethrow;
    }
  }


  /// LOGOUT USER
  Future<void> signOut() async {

    try {

      // Jika token masih ada
      if (_accessToken != null) {

        // Kirim request logout ke Laravel
        await http.post(

          // Endpoint logout
          Uri.parse('$apiUrl/api/logout'),

          headers: {

            // Kirim token
            'Authorization': 'Bearer $_accessToken',
            'Accept': 'application/json',
          },
        );
      }

    } catch (_) {}

    // Ambil SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Hapus semua data login dari HP
    await prefs.clear();

    // Reset semua state login
    _authenticated = false;
    _accessToken = null;
    _userRole = null;
    _currentUserId = null;

    // Update UI
    notifyListeners();
  }
}