import 'package:flutter/material.dart';
import 'pemasukan_screen.dart';
import 'pengeluaran_screen.dart';

class LaporanKeuanganScreen extends StatelessWidget {
  const LaporanKeuanganScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB), // Background abu muda sangat soft (mirip existing)
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ),
                  const Text(
                    'LAPORAN KEUANGAN',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600, // bold
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Button Filter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: [
                  Expanded(
                    child: _buildFilterButton('Pemasukan', onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PemasukanScreen(),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildFilterButton('Pengeluaran', onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PengeluaranScreen(),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            
            // Text Tengah
            Expanded(
              child: Center(
                child: Text(
                  'Pilih laporan yang ingin ditampilkan',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String title, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
