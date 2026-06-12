import 'package:flutter/material.dart';

class InventoryItem {
  final String name;
  final String category;
  final String lastUpdate;
  final int total;
  final int siap;
  final int perbaikan;
  final int rusak;
  final String? keterangan;

  InventoryItem({
    required this.name,
    required this.category,
    required this.lastUpdate,
    required this.total,
    required this.siap,
    required this.perbaikan,
    required this.rusak,
    this.keterangan,
  });
}

class InventarisScreen extends StatefulWidget {
  const InventarisScreen({super.key});

  @override
  State<InventarisScreen> createState() => _InventarisScreenState();
}

class _InventarisScreenState extends State<InventarisScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _activeFilter = 'Semua';
  final List<String> _filters = [
    'Semua',
    'Siap Digunakan',
    'Perlu Perbaikan',
    'Rusak',
    'Stok Menipis'
  ];

  final List<InventoryItem> _allInventory = [
    // Camp
    InventoryItem(name: 'Tenda Camping 4P', category: 'Camp', lastUpdate: '30 Mei 2026', total: 10, siap: 8, perbaikan: 0, rusak: 2),
    InventoryItem(name: 'Kursi Lipat', category: 'Camp', lastUpdate: '28 Mei 2026', total: 15, siap: 15, perbaikan: 0, rusak: 0),
    InventoryItem(name: 'Sleeping Bag', category: 'Camp', lastUpdate: '27 Mei 2026', total: 20, siap: 20, perbaikan: 0, rusak: 0),
    InventoryItem(name: 'Meja Lipat', category: 'Camp', lastUpdate: '27 Mei 2026', total: 5, siap: 5, perbaikan: 0, rusak: 0),
    InventoryItem(name: 'Lampu Camping', category: 'Camp', lastUpdate: '26 Mei 2026', total: 12, siap: 10, perbaikan: 2, rusak: 0),
    InventoryItem(name: 'Kompor Portable', category: 'Camp', lastUpdate: '25 Mei 2026', total: 8, siap: 6, perbaikan: 1, rusak: 1),
    
    // Rafting
    InventoryItem(name: 'Helm Rafting', category: 'Rafting', lastUpdate: '30 Mei 2026', total: 20, siap: 20, perbaikan: 0, rusak: 0),
    InventoryItem(name: 'Pelampung', category: 'Rafting', lastUpdate: '29 Mei 2026', total: 30, siap: 28, perbaikan: 2, rusak: 0),
    InventoryItem(name: 'Dayung Rafting', category: 'Rafting', lastUpdate: '28 Mei 2026', total: 10, siap: 6, perbaikan: 2, rusak: 2),
    InventoryItem(name: 'Dry Bag', category: 'Rafting', lastUpdate: '27 Mei 2026', total: 15, siap: 15, perbaikan: 0, rusak: 0),
    InventoryItem(name: 'Peluit Safety', category: 'Rafting', lastUpdate: '26 Mei 2026', total: 10, siap: 10, perbaikan: 0, rusak: 0),

    // Outbound
    InventoryItem(name: 'Cone Marker', category: 'Outbound', lastUpdate: '30 Mei 2026', total: 50, siap: 45, perbaikan: 0, rusak: 5),
    InventoryItem(name: 'Tali Outbound', category: 'Outbound', lastUpdate: '29 Mei 2026', total: 5, siap: 5, perbaikan: 0, rusak: 0),
    InventoryItem(name: 'Bendera Tim', category: 'Outbound', lastUpdate: '28 Mei 2026', total: 20, siap: 20, perbaikan: 0, rusak: 0),
    InventoryItem(name: 'Megaphone', category: 'Outbound', lastUpdate: '27 Mei 2026', total: 4, siap: 3, perbaikan: 1, rusak: 0),
    InventoryItem(name: 'Peralatan Fun Game', category: 'Outbound', lastUpdate: '26 Mei 2026', total: 1, siap: 1, perbaikan: 0, rusak: 0),

    // Gathering
    InventoryItem(name: 'Kursi Gathering', category: 'Gathering', lastUpdate: '30 Mei 2026', total: 100, siap: 95, perbaikan: 0, rusak: 5),
    InventoryItem(name: 'Meja Gathering', category: 'Gathering', lastUpdate: '29 Mei 2026', total: 20, siap: 20, perbaikan: 0, rusak: 0),
    InventoryItem(name: 'Sound System', category: 'Gathering', lastUpdate: '28 Mei 2026', total: 2, siap: 2, perbaikan: 0, rusak: 0),
    InventoryItem(name: 'Tenda Gathering', category: 'Gathering', lastUpdate: '27 Mei 2026', total: 5, siap: 4, perbaikan: 1, rusak: 0),
    InventoryItem(name: 'Proyektor', category: 'Gathering', lastUpdate: '26 Mei 2026', total: 1, siap: 1, perbaikan: 0, rusak: 0),

    // Paintball
    InventoryItem(name: 'Marker Paintball', category: 'Paintball', lastUpdate: '30 Mei 2026', total: 15, siap: 12, perbaikan: 2, rusak: 1),
    InventoryItem(name: 'Masker Paintball', category: 'Paintball', lastUpdate: '29 Mei 2026', total: 20, siap: 18, perbaikan: 2, rusak: 0),
    InventoryItem(name: 'Pelindung Dada', category: 'Paintball', lastUpdate: '28 Mei 2026', total: 20, siap: 20, perbaikan: 0, rusak: 0),
    InventoryItem(name: 'Peluru Paintball', category: 'Paintball', lastUpdate: '27 Mei 2026', total: 1000, siap: 1000, perbaikan: 0, rusak: 0),
    InventoryItem(name: 'Seragam Paintball', category: 'Paintball', lastUpdate: '26 Mei 2026', total: 20, siap: 15, perbaikan: 5, rusak: 0),

    // Jeeptour
    InventoryItem(name: 'Jeep Offroad', category: 'Jeeptour', lastUpdate: '30 Mei 2026', total: 5, siap: 4, perbaikan: 1, rusak: 0),
    InventoryItem(name: 'HT Komunikasi', category: 'Jeeptour', lastUpdate: '29 Mei 2026', total: 10, siap: 8, perbaikan: 2, rusak: 0),
    InventoryItem(name: 'Toolkit Jeep', category: 'Jeeptour', lastUpdate: '28 Mei 2026', total: 5, siap: 5, perbaikan: 0, rusak: 0),
    InventoryItem(name: 'Ban Cadangan', category: 'Jeeptour', lastUpdate: '27 Mei 2026', total: 10, siap: 10, perbaikan: 0, rusak: 0),
    InventoryItem(name: 'Kotak P3K', category: 'Jeeptour', lastUpdate: '26 Mei 2026', total: 5, siap: 5, perbaikan: 0, rusak: 0),

    // Adventure Game
    InventoryItem(name: 'Tali Adventure', category: 'Adventure Game', lastUpdate: '30 Mei 2026', total: 10, siap: 10, perbaikan: 0, rusak: 0),
    InventoryItem(name: 'Harness', category: 'Adventure Game', lastUpdate: '29 Mei 2026', total: 15, siap: 15, perbaikan: 0, rusak: 0),
    InventoryItem(name: 'Helm Adventure', category: 'Adventure Game', lastUpdate: '28 Mei 2026', total: 15, siap: 15, perbaikan: 0, rusak: 0),
    InventoryItem(name: 'Carabiner', category: 'Adventure Game', lastUpdate: '27 Mei 2026', total: 30, siap: 30, perbaikan: 0, rusak: 0),
    InventoryItem(name: 'Peralatan Challenge Game', category: 'Adventure Game', lastUpdate: '26 Mei 2026', total: 1, siap: 1, perbaikan: 0, rusak: 0),
  ];

  List<InventoryItem> get _filteredInventory {
    return _allInventory.where((item) {
      final matchesSearch = item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.category.toLowerCase().contains(_searchQuery.toLowerCase());

      bool matchesStatus = true;
      if (_activeFilter == 'Siap Digunakan') {
        matchesStatus = item.siap > 0;
      } else if (_activeFilter == 'Perlu Perbaikan') {
        matchesStatus = item.perbaikan > 0;
      } else if (_activeFilter == 'Rusak') {
        matchesStatus = item.rusak > 0;
      } else if (_activeFilter == 'Stok Menipis') {
        matchesStatus = item.siap <= 5;
      }

      return matchesSearch && matchesStatus;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSummarySection(),
                    const SizedBox(height: 32),
                    _buildFilterStatus(),
                    const SizedBox(height: 24),
                    _buildSearchSection(),
                    const SizedBox(height: 12),
                    _buildFilterInfoText(),
                    const SizedBox(height: 24),
                    if (_activeFilter == 'Stok Menipis') _buildStokMenipisWarning(),
                    _buildInventarisList(),
                    const SizedBox(height: 32),
                    _buildInfoCardBawah(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      color: Colors.white,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Inventaris',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 2),
                Text(
                  'Pantau stok dan kondisi inventaris',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    int totalInv = _allInventory.length;
    int siap = _allInventory.fold(0, (sum, item) => sum + item.siap);
    int perbaikan = _allInventory.fold(0, (sum, item) => sum + item.perbaikan);
    int rusak = _allInventory.fold(0, (sum, item) => sum + item.rusak);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ringkasan Inventaris',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildSummaryCard(
                title: 'Total Inventaris',
                value: totalInv.toString(),
                unit: 'Item',
                icon: Icons.inventory_2_outlined,
                iconBg: const Color(0xFFE8F5E9),
                iconColor: Colors.green,
              ),
              const SizedBox(width: 12),
              _buildSummaryCard(
                title: 'Siap Digunakan',
                value: siap.toString(),
                unit: 'Unit',
                icon: Icons.check_circle_outline,
                iconBg: const Color(0xFFE8F5E9),
                iconColor: Colors.green,
              ),
              const SizedBox(width: 12),
              _buildSummaryCard(
                title: 'Perlu Perbaikan',
                value: perbaikan.toString(),
                unit: 'Unit',
                icon: Icons.build_outlined,
                iconBg: const Color(0xFFFFF3E0),
                iconColor: Colors.orange,
              ),
              const SizedBox(width: 12),
              _buildSummaryCard(
                title: 'Rusak',
                value: rusak.toString(),
                unit: 'Unit',
                icon: Icons.cancel_outlined,
                iconBg: const Color(0xFFFFEBEE),
                iconColor: Colors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
  }) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(unit, style: const TextStyle(fontSize: 10, color: Colors.black38)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterStatus() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _filters.map((filter) {
          final bool isActive = _activeFilter == filter;
          return GestureDetector(
            onTap: () => setState(() => _activeFilter = filter),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFFB7E8A5) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isActive ? const Color(0xFF81C784) : const Color(0xFFE0E0E0),
                ),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  color: isActive ? const Color(0xFF2E7D32) : Colors.black54,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          const Icon(Icons.search, color: Colors.black38, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Cari inventaris...',
                hintStyle: TextStyle(color: Colors.black38, fontSize: 13),
                border: InputBorder.none,
                isDense: true,
              ),
              style: const TextStyle(fontSize: 13),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            GestureDetector(
              onTap: () {
                setState(() {
                  _searchController.clear();
                  _searchQuery = '';
                });
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.close, size: 18, color: Colors.black26),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterInfoText() {
    final count = _filteredInventory.length;
    String mainText = '';
    
    if (_searchQuery.isNotEmpty) {
      mainText = 'Hasil pencarian untuk "$_searchQuery"';
    } else if (_activeFilter != 'Semua') {
      mainText = 'Hasil filter: $_activeFilter';
    } else {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mainText,
          style: const TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w500),
        ),
        Text(
          'Ditemukan $count item',
          style: const TextStyle(fontSize: 11, color: Colors.black38),
        ),
      ],
    );
  }

  Widget _buildStokMenipisWarning() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orangeAccent.withOpacity(0.3)),
      ),
      child: const Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '⚠️ Stok Menipis',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.orange),
                ),
                Text(
                  'Menampilkan inventaris dengan jumlah Siap Digunakan kurang dari atau sama dengan 5 unit.',
                  style: TextStyle(fontSize: 11, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventarisList() {
    final list = _filteredInventory;
    if (list.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              Icon(Icons.inventory_2_outlined, size: 48, color: Colors.grey[300]),
              const SizedBox(height: 12),
              const Text('Tidak ada inventaris ditemukan', style: TextStyle(color: Colors.black38)),
            ],
          ),
        ),
      );
    }

    return Column(
      children: list.map((item) => _buildInventarisCard(item)).toList(),
    );
  }

  Widget _buildInventarisCard(InventoryItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.image_outlined, color: Colors.black26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: const Color(0xFFD9ECFF), borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        item.category,
                        style: const TextStyle(color: Color(0xFF1976D2), fontSize: 9, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('Update: ${item.lastUpdate}', style: const TextStyle(fontSize: 9, color: Colors.black38)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildStatusMini(label: 'Total', value: item.total.toString(), color: Colors.black54),
                    const SizedBox(width: 12),
                    _buildStatusMini(label: 'Siap', value: item.siap.toString(), color: Colors.green),
                    const SizedBox(width: 12),
                    _buildStatusMini(label: 'Perbaikan', value: item.perbaikan.toString(), color: Colors.orange),
                    const SizedBox(width: 12),
                    _buildStatusMini(label: 'Rusak', value: item.rusak.toString(), color: Colors.red),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusMini({required String label, required String value, required Color color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 8, color: Colors.black38)),
        Text(value, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  Widget _buildInfoCardBawah() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFC8E6C9)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kelola inventaris dengan baik',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                ),
                const SizedBox(height: 8),
                Text(
                  'Pastikan inventaris dalam kondisi baik dan stok mencukupi untuk memberikan pengalaman terbaik kepada wisatawan.',
                  style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.6), height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          const Icon(Icons.inventory_2, size: 48, color: Color(0xFF81C784)),
        ],
      ),
    );
  }
}
