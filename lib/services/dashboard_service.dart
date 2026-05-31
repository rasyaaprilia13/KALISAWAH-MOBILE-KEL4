
// dashboard_service.dart
import 'dart:convert';

// Menggunakan ApiClient agar
// token, header, dan timeout otomatis ditangani
import 'api_client.dart';

class DashboardService {

  
  /// GET DATA DASHBOARD
  
  /// Fungsi ini digunakan untuk:
  /// - mengambil statistik dashboard
  /// - total booking
  /// - total pemasukan
  /// - total pengunjung
  /// - slot kosong / terisi
  
  /// Endpoint:
  /// GET /api/admin/dashboard
  ///
  /// Optional:
  /// fieldId → untuk filter dashboard berdasarkan lapangan
  ///
  static Future<Map<String, dynamic>> fetchDashboard({
    int? fieldId,
  }) async {

    try {

      String endpoint = '/api/admin/dashboard';

      // Jika fieldId dikirim
      // maka tambahkan query parameter
      //
      // Contoh:
      // /api/admin/dashboard?field_id=1
      //
      if (fieldId != null) {
        endpoint += '?field_id=$fieldId';
      }

      
      // Request GET ke API menggunakan ApiClient
      final response =
          await ApiClient.get(endpoint);

      // Decode response JSON

      final result =
          jsonDecode(response.body);

     
      // Jika request berhasil

      if (response.statusCode == 200) {

        // Mengembalikan data dashboard
        //
        // Contoh:
        // {
        //   "total_booking": 20,
        //   "total_pengunjung": 50
        // }
        //
        return result['data'];
      }

      // Jika request gagal

      throw Exception(
        result['message'] ??
        'Gagal mengambil data dashboard',
      );

    } catch (e) {

      
      rethrow;
    }
  }
}