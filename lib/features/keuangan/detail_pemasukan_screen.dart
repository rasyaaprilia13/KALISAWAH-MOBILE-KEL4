import 'package:flutter/material.dart';

class DetailPemasukanScreen extends StatelessWidget {
  const DetailPemasukanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Background abu muda soft
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Detail Pemasukan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Card Nominal
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Guide Rafting',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Rafting',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Rp 2.500.000',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4CAF50), // Hijau
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Title Section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'INFORMASI PEMASUKAN',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50), // Hijau
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Detail Informasi
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildInfoRow('Tanggal Pemasukan', '24 Mei 2026'),
                    _buildDivider(),
                    _buildInfoRow('Waktu', '07.00 WIB'),
                    _buildDivider(),
                    _buildInfoRow('Kategori', 'Rafting'),
                    _buildDivider(),
                    _buildInfoRow('Keterangan', 'Paket Rafting 8 Orang'),
                    _buildDivider(),
                    _buildInfoRow('Jumlah Uang', 'Rp 2.500.000', isGreen: true),
                    _buildDivider(),
                    _buildInfoRow('Dicatat Oleh', 'Admin'),
                    _buildDivider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.calendar_month_outlined, size: 20, color: Colors.grey),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Bukti Pembayaran',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const Text(
                            ':',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://picsum.photos/seed/receipt/60/60', // Mockup image
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isGreen = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.calendar_month_outlined, size: 20, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),
          const Text(
            ':',
            style: TextStyle(
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isGreen ? FontWeight.w600 : FontWeight.normal,
                color: isGreen ? const Color(0xFF4CAF50) : Colors.black54,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 16,
      thickness: 1,
      color: Color(0xFFF0F0F0),
    );
  }
}
