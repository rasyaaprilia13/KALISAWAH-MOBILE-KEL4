import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

import 'api_client.dart';

class InventarisService {

 
  static Future<List<dynamic>> getInventaris() async {
    final response = await ApiClient.get('/inventaris');

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['data'];
    } else {
      throw Exception('Gagal mengambil data inventaris');
    }
  }

  
  static Future<Map<String, dynamic>> getInventarisById(int id) async {
    final response = await ApiClient.get('/inventaris/$id');

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['data'];
    } else {
      throw Exception('Data inventaris tidak ditemukan');
    }
  }


  /// DOWNLOAD LAPORAN INVENTARIS (PDF / EXCEL)
 
  static Future<String> downloadLaporanInventaris({
    required String format,
    required String fileName,
  }) async {

    final response = await ApiClient.get(
      '/inventaris/laporan/download?format=$format',
    );

    if (response.statusCode != 200) {
      final result = jsonDecode(response.body);
      throw Exception(result['message'] ?? 'Gagal download laporan inventaris');
    }

    final result = jsonDecode(response.body);
    final url = result['file_url'];

    // minta izin storage
    await Permission.storage.request();

    // folder Download HP (Android)
    final dir = Directory('/storage/emulated/0/Download');

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final savePath = '${dir.path}/$fileName';

    // download file pakai Dio
    Dio dio = Dio();

    await dio.download(
      url,
      savePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          print('Progress: ${(received / total * 100).toStringAsFixed(0)}%');
        }
      },
    );

    return savePath;
  }
}