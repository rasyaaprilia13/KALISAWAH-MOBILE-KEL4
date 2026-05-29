import 'package:flutter/material.dart';

class ExportReportModal extends StatefulWidget {
  final String activeFilter;
  final bool isHarian;
  final String periodText;

  const ExportReportModal({
    super.key,
    required this.activeFilter,
    required this.isHarian,
    required this.periodText,
  });

  @override
  State<ExportReportModal> createState() => _ExportReportModalState();
}

class _ExportReportModalState extends State<ExportReportModal> {
  String? _selectedFormat; // 'pdf' or 'xlsx'
  bool _isExporting = false;

  void _handleExport() async {
    if (_selectedFormat == null) return;

    setState(() {
      _isExporting = true;
    });

    // Simulate export process
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isExporting = false;
      });
      Navigator.pop(context);
      
      // Success feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 12),
              Text('Laporan berhasil diunduh sebagai $_selectedFormat'),
            ],
          ),
          backgroundColor: const Color(0xFF4CAF50),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(24),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String fileName = 'histori_booking_${widget.activeFilter.toLowerCase()}.${_selectedFormat ?? '...'}';

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Indicator
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ekspor Laporan',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.black54),
                  splashRadius: 24,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section: Pilih Format File
                  const Text(
                    'Pilih Format File',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _FormatCard(
                          title: 'PDF',
                          subtitle: 'Dokumen PDF',
                          icon: Icons.picture_as_pdf_rounded,
                          iconColor: Colors.redAccent,
                          isSelected: _selectedFormat == 'pdf',
                          onTap: () => setState(() => _selectedFormat = 'pdf'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _FormatCard(
                          title: 'Excel',
                          subtitle: 'File Excel (.xlsx)',
                          icon: Icons.table_chart_rounded,
                          iconColor: Colors.green,
                          isSelected: _selectedFormat == 'xlsx',
                          onTap: () => setState(() => _selectedFormat = 'xlsx'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Section: Pilih Periode
                  const Text(
                    'Periode Laporan',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFEEEEEE)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined, size: 20, color: Colors.black54),
                        const SizedBox(width: 12),
                        Text(
                          '${widget.isHarian ? 'Harian' : 'Bulanan'} - ${widget.periodText}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Laporan akan dibuat berdasarkan periode yang dipilih.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.black38,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Section: Data yang Diekspor
                  const Text(
                    'Ringkasan Ekspor',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFEEEEEE)),
                    ),
                    child: Column(
                      children: [
                        _buildSummaryItem(Icons.filter_list_rounded, 'Filter Status', widget.activeFilter),
                        const SizedBox(height: 12),
                        _buildSummaryItem(
                          _selectedFormat == 'pdf' ? Icons.picture_as_pdf : Icons.insert_drive_file,
                          'Nama File',
                          fileName,
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // Action Button
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
            child: SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: (_selectedFormat == null || _isExporting) ? null : _handleExport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB7E8A5),
                  foregroundColor: Colors.black87,
                  elevation: 0,
                  disabledBackgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isExporting
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Menyiapkan File...',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.file_download_outlined),
                          SizedBox(width: 8),
                          Text(
                            'Unduh Sekarang',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(IconData icon, String label, String value, {bool isBold = false}) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF81C784)),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.black54),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class _FormatCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final bool isSelected;
  final VoidCallback onTap;

  const _FormatCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF1F8E9) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? const Color(0xFF81C784) : const Color(0xFFEEEEEE),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: const Color(0xFF81C784).withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: iconColor, size: 28),
                if (isSelected)
                  const Icon(Icons.check_circle_rounded, color: Color(0xFF4CAF50), size: 20),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? Colors.black54 : Colors.black38,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
