import 'package:flutter/material.dart';
// استيراد الشاشات من ملفاتها المخصصة
import 'package:velccomy/screens/auth_screens.dart';
import 'package:velccomy/screens/home_screen.dart';
import 'package:velccomy/screens/reports_screen.dart';
import 'package:velccomy/screens/revenues_screen.dart';
// استيراد الشاشة الجديدة (تأكد من تسمية الملف بهذا الاسم في مجلد screens)
import 'package:velccomy/screens/invoice_model_screen.dart';

void main() {
  runApp(const VelccomyApp());
}

class VelccomyApp extends StatelessWidget {
  const VelccomyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Velccomy',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Cairo', // يفضل توحيد الخط ليكون متناسقاً مع التصميم العربي
      ),

      // الشاشة الابتدائية
      home: const LoginScreen(),

      // تعريف المسارات (Routes) للتنقل في التطبيق
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/reports': (context) => const ReportsScreen(),
        '/revenues': (context) => const RevenuesScreen(),
        '/invoice_model': (context) => const InvoiceModelScreen(), // المسار الجديد لنموذج الفاتورة
      },
    );
  }
}