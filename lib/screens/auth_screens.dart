import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. إعادة الخلفية الأساسية (الصورة رقم 3)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'), // الخلفية المسبقة
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. محتوى الشاشة (تم التوسيط بالكامل)
          SafeArea(
            child: Center( // توسيط المحتوى في وسط الشاشة
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // نص "Samha" كبديل للصورة الملغاة
                    const Text(
                      '          ',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // حقل البريد الإلكتروني أو الهاتف
                    _buildCustomField(
                      hint: 'Phone number/Email',
                      icon: Icons.phone_android_outlined,
                    ),

                    const SizedBox(height: 15),

                    // حقل كلمة المرور
                    _buildCustomField(
                      hint: 'Password',
                      icon: Icons.lock_outline,
                      isPass: true,
                    ),

                    const SizedBox(height: 25),

                    // أزرار Apple و Google في الوسط
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(Icons.apple, Colors.black),
                        const SizedBox(width: 20),
                        _buildSocialButton(Icons.g_mobiledata, Colors.blue),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // زر تسجيل الدخول الرئيسي
                    _buildMainButton('Log in', () {
                      Navigator.pushReplacementNamed(context, '/home');
                    }),

                    const SizedBox(height: 15),

                    // رابط نسيت كلمة السر
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Color(0xFFC795A4),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
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

  // دالة بناء حقول الإدخال بتصميم متناسق
  Widget _buildCustomField({required String hint, required IconData icon, bool isPass = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        obscureText: isPass,
        textAlign: TextAlign.center, // توسيط النص داخل الحقل
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: const Color(0xFFC795A4)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  // بناء أزرار التواصل الاجتماعي بشكل دائري وموسط
  Widget _buildSocialButton(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)
        ],
      ),
      child: Icon(icon, color: color, size: 35),
    );
  }

  // زر تسجيل الدخول
  Widget _buildMainButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 200, // تحديد عرض الزر ليكون متناسقاً في المنتصف
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC795A4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          elevation: 5,
        ),
        child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}