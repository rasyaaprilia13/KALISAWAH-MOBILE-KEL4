import 'package:flutter/material.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB), // Background abu muda sangat soft
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              
              // Custom Header
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
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),

              // Profile Image Section
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(0xFFE0E0E0),
                      backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=rasya'),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        // Acti ubah foto
                      },
                      child: const Text(
                        'Ubah Foto',
                        style: TextStyle(
                          color: Color(0xFF64B5F6), // Biru muda soft
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Form Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFCFD8DC).withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      _buildFormRow(label: 'Nama', initialValue: 'Rasya Aprilia'),
                      _buildFormRow(label: 'Email', initialValue: 'rasyaprilia13@gmail.com'),
                      _buildFormRow(label: 'Password', initialValue: '********', isPassword: true),
                      _buildFormRow(label: 'Change Password', initialValue: '********', isPassword: true, isLast: true),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // Simpan Button
              SizedBox(
                width: 140,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF64B5F6), // Biru muda soft
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shadowColor: const Color(0xFF64B5F6).withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormRow({
    required String label,
    required String initialValue,
    bool isPassword = false,
    bool isLast = false,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  obscureText: isPassword,
                  controller: TextEditingController(text: initialValue),
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Divider(
              height: 1,
              thickness: 0.5,
              color: Color(0xFFEEEEEE),
            ),
          ),
      ],
    );
  }
}
