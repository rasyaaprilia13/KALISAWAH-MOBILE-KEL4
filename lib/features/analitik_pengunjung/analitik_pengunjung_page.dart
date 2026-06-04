import 'package:flutter/material.dart';

class AnalitikPengunjungPage extends StatefulWidget {
  const AnalitikPengunjungPage({super.key});

  @override
  State<AnalitikPengunjungPage> createState() => _AnalitikPengunjungPageState();
}

class _AnalitikPengunjungPageState extends State<AnalitikPengunjungPage> {
  DateTime _selectedMonth = DateTime.now();

  final List<String> _monthsIndo = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];

  // State variables for dynamic data
  String _totalPengunjung = '1.250 Orang';
  String _pengunjungBaru = '320 Orang';
  String _totalPendapatan = 'Rp 25.000.000';
  String _bookingTerbanyak = 'Rafting';
  String _growthTotal = '+18,5%';
  String _growthBaru = '+12,3%';
  String _growthPendapatan = '+22,1%';
  List<double> _chartPoints = [0.2, 0.4, 0.5, 0.7, 0.85, 1.0, 0.8];
  List<int> _chartValues = [180, 210, 260, 320, 380, 420, 370];

  void _prevMonth() {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
      _fetchData();
    });
  }

  void _nextMonth() {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
      _fetchData();
    });
  }

  void _fetchData() {
    // Logic to fetch data from backend based on _selectedMonth.month and _selectedMonth.year
    // Simulated update for UI demonstration
    setState(() {
      // In real app, these values would come from a service/repository
      int baseVal = _selectedMonth.month * 100;
      _totalPengunjung = '${baseVal + 1000} Orang';
      _pengunjungBaru = '${baseVal + 200} Orang';
      _totalPendapatan = 'Rp ${(baseVal + 20).toString()}0.000';
      _growthTotal = '+${(_selectedMonth.month + 5).toString()},2%';
      
      // Randomize chart data to show update
      _chartValues = List.generate(7, (index) => (baseVal / 2).toInt() + (index * 50) + 100);
      double maxVal = _chartValues.reduce((a, b) => a > b ? a : b).toDouble();
      _chartPoints = _chartValues.map((v) => v / maxVal).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Column(
          children: [
            const Text(
              'Analitik Pengunjung',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Lihat data dan statistik pengunjung',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDateSelector(),
                const SizedBox(height: 24),
                _buildStatsGrid(),
                const SizedBox(height: 24),
                _buildChartCard(),
                const SizedBox(height: 24),
                _buildLatestVisitorsHeader(),
                const SizedBox(height: 12),
                _buildVisitorsList(),
              ],
            ),
          ),
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _prevMonth,
            icon: const Icon(Icons.arrow_back_ios, size: 16, color: Colors.black87),
          ),
          Text(
            '${_monthsIndo[_selectedMonth.month - 1]} ${_selectedMonth.year}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          IconButton(
            onPressed: _nextMonth,
            icon: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.1,
      children: [
        _buildStatCard(
          icon: Icons.group,
          iconColor: const Color(0xFF22C55E),
          title: 'Total Pengunjung',
          value: _totalPengunjung,
          growth: _growthTotal,
          isPositive: true,
        ),
        _buildStatCard(
          icon: Icons.star,
          iconColor: Colors.blue,
          title: 'Booking Terbanyak',
          value: _bookingTerbanyak,
          subtitle: 'Paket Wisata',
          showTrend: true,
        ),
        _buildStatCard(
          icon: Icons.person_add,
          iconColor: Colors.purple,
          title: 'Pengunjung Baru',
          value: _pengunjungBaru,
          growth: _growthBaru,
          isPositive: true,
        ),
        _buildStatCard(
          icon: Icons.account_balance_wallet,
          iconColor: Colors.orange,
          title: 'Total Pendapatan',
          value: _totalPendapatan,
          subtitle: 'Total Pendapatan',
          growth: _growthPendapatan,
          isPositive: true,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    String? growth,
    String? subtitle,
    bool isPositive = true,
    bool showTrend = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              if (showTrend)
                const Icon(Icons.trending_up, color: Colors.blue, size: 16),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              const SizedBox(height: 4),
              FittedBox(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (growth != null)
            Row(
              children: [
                Icon(
                  isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                  color: const Color(0xFF22C55E),
                  size: 12,
                ),
                const SizedBox(width: 4),
                Text(
                  growth,
                  style: const TextStyle(
                    color: Color(0xFF22C55E),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle == null)
                  Text(
                    ' dari bln lalu',
                    style: TextStyle(color: Colors.grey[400], fontSize: 10),
                  ),
              ],
            ),
          if (subtitle != null && growth == null)
            Text(
              subtitle,
              style: TextStyle(color: Colors.grey[400], fontSize: 11),
            ),
          if (subtitle != null && growth != null)
             Text(
              subtitle,
              style: TextStyle(color: Colors.grey[400], fontSize: 10),
            ),
        ],
      ),
    );
  }

  Widget _buildChartCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Grafik Pengunjung',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Text('Harian', style: TextStyle(fontSize: 12)),
                    Icon(Icons.arrow_drop_down, size: 18),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 180,
            width: double.infinity,
            child: CustomPaint(
              painter: LineChartPainter(
                points: _chartPoints,
                values: _chartValues,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min']
                .map((e) => Text(e, style: TextStyle(color: Colors.grey[400], fontSize: 12)))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLatestVisitorsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Pengunjung Terbaru',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Lihat Semua >',
            style: TextStyle(color: Color(0xFF22C55E), fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildVisitorsList() {
    return Column(
      children: [
        _buildVisitorItem(
          name: 'Andi Saputra',
          package: 'Rafting Family',
          date: '12 Mei 2026',
          time: '10:00',
          status: 'Confirmed',
          statusColor: const Color(0xFF22C55E),
        ),
        _buildVisitorItem(
          name: 'Siti Nurhaliza',
          package: 'Camping Family',
          date: '12 Mei 2026',
          time: '14:30',
          status: 'Pending',
          statusColor: Colors.orange,
        ),
        _buildVisitorItem(
          name: 'Dika Pratama',
          package: 'Outbound Asik',
          date: '11 Mei 2026',
          time: '09:00',
          status: 'Selesai',
          statusColor: Colors.blue,
        ),
        _buildVisitorItem(
          name: 'Rina Marlina',
          package: 'Rafting Extreme',
          date: '11 Mei 2026',
          time: '11:00',
          status: 'Confirmed',
          statusColor: const Color(0xFF22C55E),
        ),
      ],
    );
  }

  Widget _buildVisitorItem({
    required String name,
    required String package,
    required String date,
    required String time,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Text(name[0], style: const TextStyle(color: Colors.black54)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(package, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_month, size: 12, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text('$date • $time', style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Positioned(
      bottom: 24,
      left: 20,
      right: 20,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [Color(0xFF22C55E), Color(0xFF15803D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF22C55E).withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(30),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.file_download_outlined, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Unduh Laporan',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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

class LineChartPainter extends CustomPainter {
  final List<double> points;
  final List<int> values;

  LineChartPainter({required this.points, required this.values});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF22C55E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final dotPaint = Paint()
      ..color = const Color(0xFF22C55E)
      ..style = PaintingStyle.fill;

    final dotOutlinePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final gridPaint = Paint()
      ..color = Colors.grey[200]!
      ..strokeWidth = 1;

    final double stepX = size.width / (points.length - 1);
    final path = Path();

    // Draw horizontal grid lines
    for (int i = 0; i <= 4; i++) {
      double y = size.height - (size.height / 4 * i);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    for (int i = 0; i < points.length; i++) {
      double x = i * stepX;
      double y = size.height - (points[i] * size.height * 0.8);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        // Bezier for smooth curve
        double prevX = (i - 1) * stepX;
        double prevY = size.height - (points[i - 1] * size.height * 0.8);
        path.cubicTo(
          prevX + stepX / 2, prevY,
          x - stepX / 2, y,
          x, y,
        );
      }
    }

    // Gradient below line
    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF22C55E).withOpacity(0.2),
          const Color(0xFF22C55E).withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    // Draw points and values
    for (int i = 0; i < points.length; i++) {
      double x = i * stepX;
      double y = size.height - (points[i] * size.height * 0.8);

      // Value text
      final textPainter = TextPainter(
        text: TextSpan(
          text: '${values[i]}',
          style: const TextStyle(color: Color(0xFF22C55E), fontSize: 10, fontWeight: FontWeight.bold),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - 20));

      canvas.drawCircle(Offset(x, y), 6, dotOutlinePaint);
      canvas.drawCircle(Offset(x, y), 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant LineChartPainter oldDelegate) => 
      oldDelegate.points != points || oldDelegate.values != values;
}
