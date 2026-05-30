import 'package:flutter/material.dart';
import 'profile_edit.dart';
import '../keuangan/laporan_keuangan_screen.dart';
import '../historibook/histori_booking_screen.dart';
import '../inventaris/inventaris_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isMonitoringMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB), // Background abu muda soft
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                          size: 28,
                        ),
                      ),
                    ),
                    const Text(
                      'Profil',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),

              // Profile Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFCFD8DC).withOpacity(0.3), // Shadow abu kebiruan lembut
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xFFF1F3F5),
                      backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=rasya'), // Placeholder image
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Rasya Aprilia',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Owner',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'rasyaprilia13@gmail.com',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black26,
                            ),
                          ),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProfileEditScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F3F5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Edit Profile',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),

              // Menu Cards
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    children: [
                      _buildMenuCard(
                        title: 'Informasi Monitoring Usaha',
                        onTap: () {
                          setState(() {
                            _isMonitoringMenuOpen = !_isMonitoringMenuOpen;
                          });
                        },
                        isRotated: _isMonitoringMenuOpen,
                      ),
                      
                      const SizedBox(height: 16),
                      
                      _buildMenuCard(
                        title: 'Informasi Akun',
                        onTap: () {},
                      ),
                      
                      const SizedBox(height: 16),
                      
                      _buildMenuCard(
                        title: 'Bantuan',
                        onTap: () {},
                      ),
                      
                      const SizedBox(height: 32),

                      // Logout Card
                      _buildMenuCard(
                        title: 'Logout',
                        textColor: const Color(0xFFE57373), // Merah soft
                        showArrow: false,
                        onTap: () {},
                      ),
                    ],
                  ),
                  
                  // Dropdown Menu
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutCubic,
                    top: _isMonitoringMenuOpen ? 72 : 50,
                    right: 32,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: _isMonitoringMenuOpen ? 1.0 : 0.0,
                      child: IgnorePointer(
                        ignoring: !_isMonitoringMenuOpen,
                        child: _buildMonitoringDropdown(),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonitoringDropdown() {
    return Container(
      width: 170, // kecil dan compact
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdownItem('Keuangan'),
              _buildDivider(),
              _buildDropdownItem('Data pengunjung'),
              _buildDivider(),
              _buildDropdownItem('Inventaris'),
              _buildDivider(),
              _buildDropdownItem('Histori booking'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownItem(String text) {
    return InkWell(
      onTap: () {
        setState(() {
          _isMonitoringMenuOpen = false;
        });
        if (text == 'Keuangan') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LaporanKeuanganScreen(),
            ),
          );
        } else if (text == 'Histori booking') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HistoriBookingScreen(),
            ),
          );
        } else if (text == 'Inventaris') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InventarisScreen(),
            ),
          );
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF555555), // abu tua
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(0xFFF0F0F0),
    );
  }

  Widget _buildMenuCard({
    required String title,
    required VoidCallback onTap,
    Color textColor = Colors.black87,
    bool showArrow = true,
    bool isRotated = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFCFD8DC).withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                if (showArrow)
                  AnimatedRotation(
                    turns: isRotated ? 0.25 : 0.0,
                    duration: const Duration(milliseconds: 250),
                    child: const Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
