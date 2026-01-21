import 'package:flutter/material.dart';

class RevenuesScreen extends StatefulWidget {
  const RevenuesScreen({super.key});

  @override
  State<RevenuesScreen> createState() => _RevenuesScreenState();
}

class _RevenuesScreenState extends State<RevenuesScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/3.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  const Text(
                    'الإيرادات و الفواتير',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.black),
                  ),
                  const SizedBox(height: 30),

                  _buildAnimatedCounterCard('عدد فواتير لليوم', '12'),

                  const SizedBox(height: 40),

                  _buildInteractiveRevenueRow(0, 'اليوم', '1200'),
                  _buildInteractiveRevenueRow(1, 'الاسبوع', '10000'),
                  _buildInteractiveRevenueRow(2, 'الشهر', '400000'),

                  const SizedBox(height: 40),

                  const Text(
                    'فواتير اليوم',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      decoration: TextDecoration.underline,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // تمرير context للويدجت ليتمكن من التنقل بين الشاشات
                  _buildCleanInvoiceItem(
                    context,
                    id: '444-63-875',
                    name: 'سارة أحمد',
                    date: '20-أبريل-2025',
                    total: '350',
                    activatedBy: 'مديرة المشغل',
                  ),
                  _buildCleanInvoiceItem(
                    context,
                    id: '444-63-876',
                    name: 'ليلى محمد',
                    date: '20-أبريل-2025',
                    total: '420',
                    activatedBy: 'مديرة المشغل',
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCounterCard(String title, String count) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFD9A7A7), Color(0xFFCDB69E)]),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ScaleTransition(
            scale: _pulseAnimation,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green, width: 2),
              ),
              child: Text(count, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
            ),
          ),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildInteractiveRevenueRow(int index, String label, String value) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 160,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFD9A7A7).withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.green.shade700 : Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 80,
              child: Text(label, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  // تم إضافة BuildContext كباراميتر هنا
  Widget _buildCleanInvoiceItem(BuildContext context, {required String id, required String name, required String date, required String total, required String activatedBy}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black12, width: 1)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),

          // [التعديل الرئيسي]: إضافة GestureDetector للانتقال عند الضغط على رقم الفاتورة
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/invoice_model');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFD9A7A7), Color(0xFFCDB69E)]),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))],
              ),
              child: Text(
                id,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, decoration: TextDecoration.none),
              ),
            ),
          ),

          const SizedBox(height: 20),
          _buildCorrectRow('اسم العميل', name, Colors.black),
          _buildCorrectRow('تاريخ الاستخدام', date, Colors.red),
          _buildCorrectRow('اجمالي الفاتورة', '$total ريال', Colors.red),
          _buildCorrectRow('تم التفعيل بواسطة', activatedBy, Colors.red),
        ],
      ),
    );
  }

  Widget _buildCorrectRow(String label, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: TextStyle(color: valueColor, fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            ' : $label',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}