import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
      );
      
      if (pickedFile != null) {
        final File file = File(pickedFile.path);
        
        // Validasi tipe file
        final String extension = pickedFile.name.split('.').last.toLowerCase();
        final List<String> allowedExtensions = ['jpg', 'jpeg', 'png'];
        
        if (!allowedExtensions.contains(extension)) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Format file tidak didukung. Silakan unggah file JPG, JPEG, atau PNG.'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }

        // Validasi Ukuran File (5 MB)
        final int fileSizeInBytes = await file.length();
        const int maxFileSizeInBytes = 5 * 1024 * 1024;

        if (fileSizeInBytes > maxFileSizeInBytes) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Ukuran file maksimal 5 MB.'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }

        setState(() {
          _imageFile = file;
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Terjadi kesalahan: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showPickerOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Text(
                'Pilih Sumber',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildPickerOption(
                      icon: Icons.camera_alt_outlined,
                      text: 'Ambil dari Kamera',
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildPickerOption(
                      icon: Icons.image_outlined,
                      text: 'Pilih dari Galeri',
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.gallery);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  child: const Text(
                    'Batal',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPickerOption({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF64B5F6), size: 32),
            const SizedBox(height: 12),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
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
                    GestureDetector(
                      onTap: _showPickerOptions,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: const Color(0xFFE0E0E0),
                            backgroundImage: _imageFile != null
                                ? FileImage(_imageFile!)
                                : const NetworkImage('https://i.pravatar.cc/150?u=rasya') as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Color(0xFF64B5F6),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: _showPickerOptions,
                      child: const Text(
                        'Ubah Foto',
                        style: TextStyle(
                          color: Color(0xFF64B5F6),
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
                    backgroundColor: const Color(0xFF64B5F6),
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
