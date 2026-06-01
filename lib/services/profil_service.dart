import 'dart:convert';
import 'api_client.dart';

class ProfileService {

  /// Ambil profil
  Future<Map<String, dynamic>> getProfile() async {
    final response = await ApiClient.get('/profile');

    final result = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return result['data'];
    }

    throw Exception(
      result['message'] ?? 'Gagal mengambil profil',
    );
  }

  /// Update profil
  Future<Map<String, dynamic>> updateProfile({
    required String name,
    required String email,
  }) async {

    final response = await ApiClient.post(
      '/profile/update',
      body: jsonEncode({
        'name': name,
        'email': email,
      }),
    );

    final result = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return result;
    }

    throw Exception(
      result['message'] ?? 'Gagal memperbarui profil',
    );
  }

  /// Ganti password
  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {

    final response = await ApiClient.post(
      '/profile/change-password',
      body: jsonEncode({
        'current_password': currentPassword,
        'password': newPassword,
        'password_confirmation': confirmPassword,
      }),
    );

    final result = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return result;
    }

    throw Exception(
      result['message'] ?? 'Gagal mengganti password',
    );
  }
}