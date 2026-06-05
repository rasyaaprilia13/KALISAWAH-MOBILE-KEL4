import 'package:flutter/material.dart';
import '../dashboard/dashboard_screen.dart';
import '../historibook/histori_booking_screen.dart';
import '../analitik_pengunjung/analitik_pengunjung_page.dart';
import '../inventaris/inventaris_screen.dart';
import '../keuangan/laporan_keuangan_screen.dart';
import '../profile/profile_screen.dart';

class BantuanScreen extends StatelessWidget {
  const BantuanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Bantuan',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Tentang Aplikasi',
              icon: Icons.info_outline,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Aplikasi Monitoring Wisata Kalisawah merupakan sistem yang digunakan untuk membantu pengelolaan operasional wisata secara digital, meliputi monitoring booking, inventaris, analitik pengunjung, dan laporan keuangan.',
                    style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB7E8A5).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Versi Aplikasi: 1.0.0',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            const Text(
              'Panduan Penggunaan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            
            _buildGuideCard(
              icon: Icons.dashboard_outlined,
              title: 'Dashboard',
              description: 'Menampilkan ringkasan pemasukan, pengeluaran, pengunjung, booking, dan inventaris.',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardScreen())),
            ),
            _buildGuideCard(
              icon: Icons.history_outlined,
              title: 'History Booking',
              description: 'Melihat data booking pengunjung, melakukan pencarian, filter status booking, dan ekspor laporan.',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoriBookingScreen())),
            ),
            _buildGuideCard(
              icon: Icons.analytics_outlined,
              title: 'Analitik Pengunjung',
              description: 'Menampilkan statistik pengunjung berdasarkan bulan yang dipilih.',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AnalitikPengunjungPage())),
            ),
            _buildGuideCard(
              icon: Icons.inventory_2_outlined,
              title: 'Inventaris',
              description: 'Mengelola data inventaris wisata.',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const InventarisScreen())),
            ),
            _buildGuideCard(
              icon: Icons.account_balance_wallet_outlined,
              title: 'Laporan Keuangan',
              description: 'Melihat pemasukan, pengeluaran, dan ekspor laporan keuangan.',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LaporanKeuanganScreen())),
            ),
            _buildGuideCard(
              icon: Icons.person_outline,
              title: 'Profile',
              description: 'Mengakses bantuan dan logout aplikasi.',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen())),
            ),
            
            const SizedBox(height: 16),
            _buildSection(
              title: 'Informasi Pengembang',
              icon: Icons.code,
              content: const Text(
                'Sistem Monitoring Wisata Kalisawah dikembangkan untuk membantu proses pengelolaan data wisata agar lebih efektif, terstructured, dan terdokumentasi dengan baik.',
                style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
              ),
            ),
            const SizedBox(height: 40),
            const Center(
              child: Text(
                '© 2026 Kalisawah Smart Tourism',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required IconData icon, required Widget content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF2E7D32), size: 20),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Divider(height: 32, thickness: 1),
          content,
        ],
      ),
    );
  }

  Widget _buildGuideCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB7E8A5).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: const Color(0xFF2E7D32), size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.black26, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
