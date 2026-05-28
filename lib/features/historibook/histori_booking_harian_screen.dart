import 'package:flutter/material.dart';
import 'histori_booking_bulanan_screen.dart';

class HistoriBookingHarianScreen extends StatefulWidget {
  const HistoriBookingHarianScreen({super.key});

  @override
  State<HistoriBookingHarianScreen> createState() => _HistoriBookingHarianScreenState();
}

class _HistoriBookingHarianScreenState extends State<HistoriBookingHarianScreen> {
  final List<String> _statusFilters = [
    'Semua',
    'Confirmed',
    'Pending',
    'Selesai',
    'Dibatalkan'
  ];
  String _activeStatus = 'Semua';

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
                      'Histori Booking',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Tab Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Navigasi ke Bulanan
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => const HistoriBookingBulananScreen(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(-1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.easeOutCubic;
                                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                var fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation, curve: curve));
                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: FadeTransition(opacity: fadeAnimation, child: child),
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFFE0E0E0),
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Bulanan',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFB7E8A5), // Hijau muda (Active)
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Harian',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Filter Tanggal
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFEEEEEE)),
                      ),
                      child: const Icon(Icons.chevron_left, size: 20, color: Colors.black87),
                    ),
                    const SizedBox(width: 24),
                    const Text(
                      '28 Mei 2026',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFEEEEEE)),
                      ),
                      child: const Icon(Icons.chevron_right, size: 20, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: const Color(0xFFEEEEEE)),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Cari nama pemesan / paket...',
                            hintStyle: TextStyle(
                              color: Colors.black38,
                              fontSize: 13,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF64B5F6), // Biru muda
                          borderRadius: BorderRadius.circular(18),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Cari',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Filter Status (Scrollable Horizontal)
              SizedBox(
                height: 36,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  itemCount: _statusFilters.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final status = _statusFilters[index];
                    final isActive = status == _activeStatus;
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _activeStatus = status;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isActive ? const Color(0xFFB7E8A5) : Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isActive ? const Color(0xFF81C784) : const Color(0xFFE0E0E0),
                          ),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                            color: isActive ? Colors.black87 : Colors.black54,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Tabel Data Booking Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Data Booking Pengunjung',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFEEEEEE)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Ekspor PDF/Excel',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Tabel Content
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFEEEEEE)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.01),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Table Header
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF9F9F9),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      ),
                      child: Row(
                        children: [
                          _buildTableColHeader('Kode Booking', flex: 2),
                          _buildTableColHeader('Nama Pemesan', flex: 2),
                          _buildTableColHeader('Paket', flex: 2),
                          _buildTableColHeader('Tanggal', flex: 2),
                          _buildTableColHeader('Status', flex: 2),
                          _buildTableColHeader('Detail', flex: 1, alignRight: true),
                        ],
                      ),
                    ),
                    const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
                    
                    // Empty Rows Placeholder
                    ...List.generate(5, (index) {
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                            child: Row(
                              children: [
                                _buildTableColEmpty(flex: 2),
                                _buildTableColEmpty(flex: 2),
                                _buildTableColEmpty(flex: 2),
                                _buildTableColEmpty(flex: 2),
                                _buildTableColEmpty(flex: 2),
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(Icons.more_horiz, size: 16, color: Colors.grey[400]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (index < 4) const Divider(height: 1, thickness: 1, color: Color(0xFFFAFAFA)),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Section Paket Paling Diminati
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Paket Paling Diminati',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              SizedBox(
                height: 120,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildPaketCard('Camping Family', '1'),
                    const SizedBox(width: 12),
                    _buildPaketCard('Rafting', '2'),
                    const SizedBox(width: 12),
                    _buildPaketCard('Outbond Asik', '3'),
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

  Widget _buildTableColHeader(String text, {required int flex, bool alignRight = false}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: alignRight ? TextAlign.right : TextAlign.left,
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: Color(0xFF757575),
        ),
      ),
    );
  }
  
  Widget _buildTableColEmpty({required int flex}) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 8,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _buildPaketCard(String title, String rank) {
    return Container(
      width: 130,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9E6), // Krem muda
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.terrain_rounded, size: 20, color: Color(0xFF81C784)),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50), // Hijau
                shape: BoxShape.circle,
              ),
              child: Text(
                rank,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
