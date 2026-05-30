import 'package:flutter/material.dart';
import '../profile/profile_screen.dart';
import '../keuangan/laporan_keuangan_screen.dart';
import '../historibook/histori_booking_screen.dart';
import '../inventaris/inventaris_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Widget infoCard({
    required IconData icon,
    required String title,
    required String value,
    String? suffix,
    bool small = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F0DF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE5E1D0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD9ECFF).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFCFF4A9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.black,
              size: small ? 18 : 22,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: small ? 11 : 12,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: small ? 16 : 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              if (suffix != null)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 4,
                    bottom: 2,
                  ),
                  child: Text(
                    suffix,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget menuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFEEEEEE),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFD9ECFF).withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFD9ECFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Colors.black,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 80,
                    fit: BoxFit.contain,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.notifications_none_outlined,
                        size: 24,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.person_outline,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'HALO, RASYA APRILIA',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Selamat datang di dashboard monitoring Kalisawah Smart Tourism',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 32),

              // Ringkasan Hari ini Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Ringkasan Hari ini',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          '17 Mei 2026',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 14,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          size: 16,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),

              // Statistic Cards
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 160,
                      child: infoCard(
                        icon: Icons.payments_outlined,
                        title: 'Pemasukan Hari Ini',
                        value: 'Rp 10.700.000',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 160,
                      child: infoCard(
                        icon: Icons.people_alt_outlined,
                        title: 'Pengunjung Hari Ini',
                        value: '200',
                        suffix: 'Orang',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 160,
                      child: infoCard(
                        icon: Icons.account_balance_wallet_outlined,
                        title: 'Pengeluaran Hari Ini',
                        value: 'Rp 3.000.000',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 160,
                      child: infoCard(
                        icon: Icons.calendar_month_outlined,
                        title: 'Booking\nHari Ini',
                        value: '15',
                        small: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 160,
                      child: infoCard(
                        icon: Icons.inventory_2_outlined,
                        title: 'Inventaris\nKondisi Normal',
                        value: '50',
                        small: true,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Menu Utama Section
              const Text(
                'Menu Utama',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              menuItem(
                icon: Icons.file_download_outlined,
                title: 'Laporan Keuangan',
                subtitle: 'Lihat pemasukan, pengeluaran, dan riwayat transaksi',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LaporanKeuanganScreen(),
                    ),
                  );
                },
              ),
              menuItem(
                icon: Icons.analytics_outlined,
                title: 'Analitik Pengunjung',
                subtitle: 'Lihat data dan statistik pengunjung',
              ),
              menuItem(
                icon: Icons.inventory_2_outlined,
                title: 'Inventaris',
                subtitle: 'Pantau stok dan kondisi inventaris',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InventarisScreen(),
                    ),
                  );
                },
              ),
              menuItem(
                icon: Icons.list_alt_outlined,
                title: 'Histori Booking',
                subtitle: 'Lihat semua riwayat pemesanan',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoriBookingScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),

              // Footer
              const Center(
                child: Text(
                  '© Kalisawah Smart Tourism',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
