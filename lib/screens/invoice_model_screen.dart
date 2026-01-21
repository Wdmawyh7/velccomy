import 'package:flutter/material.dart';

class InvoiceModelScreen extends StatelessWidget {
  const InvoiceModelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. الخلفية الأساسية (الصورة رقم 4)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/4.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. محتوى الفاتورة المنسق داخل حاوية شفافة
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(), // منع السحب لضمان احتواء الشاشة
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7), // خلفية بيضاء شفافة خلف النص
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // لجعل الحاوية تتقلص حسب المحتوى
                    children: [
                      // شعار Samha - حجم متناسق
                      const Text(
                        'Samha',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          letterSpacing: 1.2,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // البيانات الأساسية - تنسيق مكثف جداً
                      _buildDenseRow('4680-6840', 'رقم الفاتورة'),
                      _buildDenseRow('15/10/2025', 'التاريخ'),
                      _buildDenseRow('مشغل الجمال', 'اسم مقدم الخدمه'),
                      _buildDenseRow('منال احمد', 'اسم العميل'),
                      _buildDenseRow('حنة-بدكير-ميكب', 'الخدمة'),
                      _buildDenseRow('60 دقيقة', 'مده الخدمة المتوقع'),

                      const SizedBox(height: 10),

                      // الباركود - تم تصغيره ليتناسب مع الشاشة الواحدة
                      Column(
                        children: [
                          const Text(
                            'باركود تفعيل الخدمة',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.qr_code_2, size: 60), // حجم أصغر
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // الحساب المالي
                      _buildDenseRow('250', 'سعر الخدمة'),
                      _buildDenseRow('1.5', 'رسوم التطبيق'),
                      _buildDenseRow('37.65', 'الضريبة'),

                      const SizedBox(height: 8),

                      // الإجمالي الكلي
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2C1D1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              '288.67',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                            ),
                          ),
                          const Text(
                            'الإجمالي الكلي',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      // الرقم الضريبي
                      const Text(
                        'الرقم الضريبي',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                      ),
                      const Text(
                        '****000000000****',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // زر الرجوع
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 22),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDenseRow(String value, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3), // مسافة ضيقة جداً لضمان عدم السحب
      child: Row(
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                '................................................................',
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(color: Colors.black26, letterSpacing: 1.2),
              ),
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}