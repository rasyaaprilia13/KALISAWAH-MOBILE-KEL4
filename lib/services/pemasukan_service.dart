import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'api_client.dart';

class PemasukanService {


  /// GET DATA PEMASUKAN

  static Future<List<dynamic>> getPemasukan() async {
    final response = await ApiClient.get('/pemasukan');

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['data'];
    } else {
      throw Exception('Gagal mengambil data pemasukan');
    }
  }

  
  /// DETAIL PEMASUKAN
  static Future<Map<String, dynamic>> getPemasukanById(int id) async {
    final response = await ApiClient.get('/pemasukan/$id');

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['data'];
    } else {
      throw Exception('Data pemasukan tidak ditemukan');
    }
  }

 
  /// DOWNLOAD LAPORAN PEMASUKAN (PDF / EXCEL)

  static Future<String> downloadLaporanPemasukan({
    required String format, // pdf / excel
    required String fileName,
  }) async {

    // 1. request ke API untuk dapatkan file URL
    final response = await ApiClient.get(
      '/pemasukan/laporan/download?format=$format',
    );

    if (response.statusCode != 200) {
      final result = jsonDecode(response.body);
      throw Exception(result['message'] ?? 'Gagal download laporan pemasukan');
    }

    final result = jsonDecode(response.body);
    final url = result['file_url'];

    // 2. permission storage
    await Permission.storage.request();

    // 3. folder Download HP
    Directory dir = Directory('/storage/emulated/0/Download');

    final savePath = '${dir.path}/$fileName';

    // 4. download file pakai Dio
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