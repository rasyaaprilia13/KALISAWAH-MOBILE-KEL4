import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

import 'api_client.dart';

class PengeluaranService {


  /// GET DATA PENGELUARAN
  
  static Future<List<dynamic>> getPengeluaran() async {
    final response = await ApiClient.get('/pengeluaran');

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['data'];
    } else {
      throw Exception('Gagal mengambil data pengeluaran');
    }
  }


  /// DETAIL PENGELUARAN
  static Future<Map<String, dynamic>> getPengeluaranById(int id) async {
    final response = await ApiClient.get('/pengeluaran/$id');

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['data'];
    } else {
      throw Exception('Data pengeluaran tidak ditemukan');
    }
  }

  /// DOWNLOAD LAPORAN PENGELUARAN (PDF / EXCEL)

  static Future<String> downloadLaporanPengeluaran({
    required String format,
    required String fileName,
  }) async {

    final response = await ApiClient.get(
      '/pengeluaran/laporan/download?format=$format',
    );

    if (response.statusCode != 200) {
      final result = jsonDecode(response.body);
      throw Exception(result['message'] ?? 'Gagal download laporan pengeluaran');
    }

    final result = jsonDecode(response.body);
    final url = result['file_url'];

    await Permission.storage.request();

   
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