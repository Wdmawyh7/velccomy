import 'package:flutter/material.dart';

class BarcodeScannerScreen extends StatelessWidget {
  const BarcodeScannerScreen({super.key});

  // --- دالة إظهار الشاشة المنبثقة (Pop-up) ---
  void _showResultDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: const Color(0xFFC795A4), width: 2),
            ),
            child: Stack(
              children: [
                // خلفية الشاشة المنبثقة (الجزء العلوي من الصورة 3)
                Positioned.fill(
                  child: Image.asset(
                    'assets/3.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // زر الإغلاق X بنفس لون التصميم
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Text(
                            'X',
                            style: TextStyle(
                              fontSize: 35,
                              color: Color(0xFFC795A4),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 5),

                      // تم حذف اسم سماح والاكتفاء بالإطارات المطلوبة
                      _buildInfoFrame('تم التفعيل بنجاح', isStatus: true),
                      const SizedBox(height: 12),
                      _buildInfoFrame('رقم الفاتورة', value: '693-78-114'),
                      const SizedBox(height: 12),
                      _buildInfoFrame('الخدمة', value: 'ميكب - بدكير - حنه'),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // بناء إطارات البيانات داخل المنبثقة
  Widget _buildInfoFrame(String label, {String? value, bool isStatus = false}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        border: Border.all(color: const Color(0xFFC795A4), width: 1.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: isStatus
          ? Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black),
      )
          : RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: '($value) ',
              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w900),
            ),
            TextSpan(text: ' : $label'),
          ],
        ),
      ),
    );
  }

  // --- واجهة الشاشة الرئيسية ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية الأساسية (الصورة رقم 3) مركّزة على الجزء العلوي
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/3.png'),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // تم حذف نص "قارئ الباركود" من هنا
                const Spacer(flex: 2),

                // إطار الكاميرا / المسح
                Center(
                  child: Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color(0xFFC795A4), width: 3),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(Icons.qr_code_scanner, size: 100, color: Colors.black12),
                        ..._buildFrameCorners(),
                      ],
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                // منطقة الأزرار المعدلة حسب الصورة المرفقة
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 40),
                  child: Column(
                    children: [
                      // زر التحقق من الكوبون (الآن يظهر الشاشة المنبثقة أيضاً)
                      _buildStyledButton(
                        context,
                        label: 'التحقق من الكوبون',
                        textColor: Colors.black,
                        onPressed: () => _showResultDialog(context),
                      ),

                      const SizedBox(height: 20),

                      // زر تفعيل الكوبون (نفس التصميم مع نص أحمر)
                      _buildStyledButton(
                        context,
                        label: 'تفعيل الكوبون',
                        textColor: Colors.red,
                        onPressed: () => _showResultDialog(context),
                      ),
                    ],
                  ),
                ),
              ],
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

  // ويدجت لتصميم الأزرار بشكل "الكبسولة" مع التدرج والظلال
  Widget _buildStyledButton(BuildContext context, {required String label, required Color textColor, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), // شكل الكبسولة
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFC795A4).withOpacity(0.7),
              const Color(0xFFC795A4),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  // زوايا إطار المسح
  List<Widget> _buildFrameCorners() {
    return [
      Positioned(top: 20, left: 20, child: _corner(top: true, left: true)),
      Positioned(top: 20, right: 20, child: _corner(top: true, left: false)),
      Positioned(bottom: 20, left: 20, child: _corner(top: false, left: true)),
      Positioned(bottom: 20, right: 20, child: _corner(top: false, left: false)),
    ];
  }

  Widget _corner({required bool top, required bool left}) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        border: Border(
          top: top ? const BorderSide(color: Color(0xFFC795A4), width: 5) : BorderSide.none,
          bottom: !top ? const BorderSide(color: Color(0xFFC795A4), width: 5) : BorderSide.none,
          left: left ? const BorderSide(color: Color(0xFFC795A4), width: 5) : BorderSide.none,
          right: !left ? const BorderSide(color: Color(0xFFC795A4), width: 5) : BorderSide.none,
        ),
      ),
    );
  }
}