import 'package:flutter/material.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  // مصفوفة للتحكم في حالة الألوان لكل عنصر إحصائي (true تعني أخضر، false تعني أحمر)
  final List<bool> _isGreenStatus = [true, true, true, true];

  // دالة لإظهار رسالة تأكيد التحميل
  void _showSuccessMessage(String type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم تحميل ملف $type بنجاح',
          textAlign: TextAlign.center,
          style: const TextStyle(fontFamily: 'Arial', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. الخلفية
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

          // 2. المحتوى
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  const Text(
                    'التقارير',
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.w900, color: Colors.black),
                  ),
                  const SizedBox(height: 40),

                  // قسم المبالغ المالية
                  _buildFinancialCard('اجمالي الشهر', '22400 ﷼'),
                  _buildFinancialCard('نسبة التطبيق', '3360 ﷼'),
                  _buildFinancialCard('صافي المشغل', '19040 ﷼'),

                  const SizedBox(height: 20),

                  // أزرار التحميل مع رسالة التأكيد
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDownloadLink('PDF تحميل', () => _showSuccessMessage('PDF')),
                      const Text(' [ ] ', style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold)),
                      _buildDownloadLink('Excel تحميل', () => _showSuccessMessage('Excel')),
                    ],
                  ),

                  const SizedBox(height: 50),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text('إحصائيات', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),

                  // قائمة الإحصائيات التفاعلية
                  _buildInteractiveStatRow(0, 'عدد الفواتير المفعلة', '70'),
                  _buildInteractiveStatRow(1, 'متوسط قيمة الفواتير', '112'),
                  _buildInteractiveStatRow(2, 'عدد الفواتير الملغاه', '5'),
                  _buildInteractiveStatRow(3, 'نسبة النمو على التطبيق', '25%'),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // زر الرجوع
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

  // ويدجت الإحصائيات التفاعلية (تتغير عند الضغط)
  Widget _buildInteractiveStatRow(int index, String label, String value) {
    Color currentColor = _isGreenStatus[index] ? Colors.green : Colors.red;

    return GestureDetector(
      onTap: () {
        setState(() {
          _isGreenStatus[index] = !_isGreenStatus[index]; // تبديل اللون عند الضغط
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: const Color(0xFFD9A7A7).withOpacity(0.8),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              width: 75,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: currentColor, width: 1.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const Spacer(),
            Text(
              label,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: currentColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialCard(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFD9A7A7).withOpacity(0.85),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black54, width: 0.8),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 6, offset: const Offset(0, 4))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildDownloadLink(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(text, style: const TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}