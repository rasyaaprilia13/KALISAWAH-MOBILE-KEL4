import 'package:flutter/material.dart';
import 'histori_booking_bulanan_screen.dart';
import 'histori_booking_harian_screen.dart';

class HistoriBookingScreen extends StatelessWidget {
  const HistoriBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Background abu muda soft
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
                    'Histori Booking',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600, // semi bold
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
                        // Smooth slide transition
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => const HistoriBookingBulananScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeOutCubic;

                              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                              var fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation, curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: FadeTransition(
                                  opacity: fadeAnimation,
                                  child: child,
                                ),
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
                    child: GestureDetector(
                      onTap: () {
                        // Navigasi ke Harian dengan animasi modern
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => const HistoriBookingHarianScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeOutCubic;

                              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                              var fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation, curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: FadeTransition(
                                  opacity: fadeAnimation,
                                  child: child,
                                ),
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
                          'Harian',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Empty body area
            const Expanded(
              child: SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
