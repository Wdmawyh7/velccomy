import 'dart:async';
import 'package:flutter/material.dart';
import 'reports_screen.dart';
import 'revenues_screen.dart';
import 'barcode_scanner_screen.dart';
// [إضافة] استيراد شاشة الإشعارات الجديدة
import 'notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  bool _showBadge = false;
  final List<int> _sequence = [1, 2, 5];
  int _sequenceIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startBadgeCycle();
  }

  void _startBadgeCycle() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (mounted) {
        setState(() {
          if (_sequenceIndex < _sequence.length) {
            _counter = _sequence[_sequenceIndex];
            _showBadge = true;
            _sequenceIndex++;
          } else {
            _showBadge = false;
            _sequenceIndex = 0;
            timer.cancel();
            Future.delayed(const Duration(seconds: 2), () => _startBadgeCycle());
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pushReplacementNamed(context, '/login');
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/dashboard_bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 275),
                  Expanded(
                    child: GridView.count(
                      padding: const EdgeInsets.symmetric(horizontal: 55),
                      crossAxisCount: 2,
                      crossAxisSpacing: 29,
                      mainAxisSpacing: 104,
                      children: [
                        // زر الحجوزات -> ينتقل لشاشة الباركود
                        _buildStyledButton('الحجوزات', onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const BarcodeScannerScreen()),
                          );
                        }),

                        // زر الإشعارات مع العداد (Badge)
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // [تعديل] زر الإشعارات ينقلنا الآن لشاشة الإشعارات
                            _buildStyledButton('الإشعارات', onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                              );
                            }),
                            if (_showBadge)
                              Positioned(
                                top: -2,
                                left: -8,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                                  ),
                                  constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                                  child: Text(
                                    '$_counter',
                                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        _buildStyledButton('التقارير', onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ReportsScreen()),
                          );
                        }),

                        _buildStyledButton('الإيرادات', onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RevenuesScreen()),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledButton(String title, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          const Expanded(child: SizedBox()),
          Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFA8917A), width: 1.2),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFF7EFE6), Color(0xFFEAD6C3), Color(0xFFCDB69E), Color(0xFFBCA188)],
                stops: [0.0, 0.48, 0.50, 1.0],
              ),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 4))],
            ),
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}