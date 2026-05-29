import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'api_client.dart';

class BookingService {

 
  /// GET LAPORAN
  static Future<List<dynamic>> getLaporanBooking() async {
    final response = await ApiClient.get('/bookings/laporan');

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['data'];
    } else {
      throw Exception('Gagal ambil laporan');
    }
  }


  /// DOWNLOAD BENAR-BENAR KE HP
  static Future<String> downloadLaporanBooking({
    required String format,
    required String fileName,
  }) async {

    // 1. ambil url dari API
    final response = await ApiClient.get(
      '/bookings/laporan/download?format=$format',
    );

    if (response.statusCode != 200) {
      final result = jsonDecode(response.body);
      throw Exception(result['message'] ?? 'Gagal download');
    }

    final result = jsonDecode(response.body);
    final url = result['file_url'];

    // 2. minta permission storage (Android)
    await Permission.storage.request();

    // 3. ambil folder Download HP (INI YANG BENAR)
    Directory? dir;

    if (Platform.isAndroid) {
      dir = Directory('/storage/emulated/0/Download');
    } else {
      dir = await getApplicationDocumentsDirectory();
    }

    final savePath = '${dir.path}/$fileName';

    // 4. download pakai Dio
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

    return savePath; // lokasi file tersimpan
  }
}