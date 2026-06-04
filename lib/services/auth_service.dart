import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Service untuk mengatur session/login user
class AuthService extends ChangeNotifier {
  // Status apakah user sudah login atau belum
  bool _authenticated = false;

  // Menyimpan role user (admin/owner/user)
  String? _userRole;

  // Menyimpan ID user login
  int? _currentUserId;

  // Menyimpan email user login
  String? _currentUserEmail;

  // Getter agar variable private bisa dibaca dari luar class
  bool get authenticated => _authenticated;
  String? get userRole => _userRole;
  int? get currentUserId => _currentUserId;
  String? get currentUserEmail => _currentUserEmail;

  final List<Map<String, dynamic>> _allowedUsers = const [
    {'email': 'admin@demo.com', 'password': '123456', 'role': 'admin', 'id': 1},
    {
      'email': 'owner@demo.com',
      'password': 'owner123',
      'role': 'owner',
      'id': 2,
    },
    {'email': 'user@demo.com', 'password': 'password', 'role': 'user', 'id': 3},
  ];

  /// CEK SESSION LOGIN
  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();

    _authenticated = prefs.getBool('authenticated') ?? false;
    _userRole = prefs.getString('role');
    _currentUserId = prefs.getInt('user_id');
    _currentUserEmail = prefs.getString('email');

    notifyListeners();
  }

  /// LOGIN USER SEMENTARA TANPA DATABASE
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    final user = _allowedUsers.firstWhere(
      (user) => user['email'] == email && user['password'] == password,
      orElse: () => {},
    );

    if (user.isEmpty) {
      return {'status': false, 'message': 'Email atau password tidak valid'};
    }

    _authenticated = true;
    _userRole = user['role'] as String;
    _currentUserId = user['id'] as int;
    _currentUserEmail = user['email'] as String;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('authenticated', true);
    await prefs.setString('email', _currentUserEmail!);
    await prefs.setString('role', _userRole!);
    await prefs.setInt('user_id', _currentUserId!);

    notifyListeners();

    return {'status': true, 'message': 'Berhasil login'};
  }

  /// LOGOUT USER
  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    _authenticated = false;
    _userRole = null;
    _currentUserId = null;
    _currentUserEmail = null;

    notifyListeners();
  }
}
