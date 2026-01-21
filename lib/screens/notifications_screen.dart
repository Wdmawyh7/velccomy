import 'dart:async';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, String>> _notifications = [];
  Timer? _timer;
  int _counter = 0;

  // قوائم البيانات لتنويع الإشعارات
  final List<String> _customers = ['سارة الودعاني', 'أحمد الشمري', 'ليلى القحطاني', 'يوسف الحربي', 'نورة السبيعي'];
  final List<String> _services = ['ميكب آرتيست سهرة', 'تنظيف بشرة ملكي', 'بدكير ومنكير فرنسي', 'صبغة شعر أومبري', 'جلسة مساج استرخائي'];
  final List<String> _times = ['الآن', 'منذ دقيقة', 'منذ ثوانٍ'];

  @override
  void initState() {
    super.initState();
    _startAutoNotifications();
  }

  void _startAutoNotifications() {
    // تعديل الوقت ليكون كل 5 ثوانٍ كما طلبت
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          // الحذف التلقائي عند الوصول لـ 5 إشعارات والبدء من جديد
          if (_notifications.length >= 5) {
            _notifications.clear();
          }

          // إضافة إشعار جديد بتنسيق الأسطر المنفصلة
          _notifications.insert(0, {
            'id': DateTime.now().toString(),
            'status': '🔔 طلب جديد قيد الانتظار',
            'customer': _customers[_counter % _customers.length],
            'service': _services[_counter % _services.length],
            'time': _times[_counter % _times.length],
            'isRead': 'false',
          });
          _counter++;
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
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية رقم 3 مع التركيز على الجزء العلوي الجمالي
          Positioned.fill(
            child: Image.asset(
              'assets/3.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),
                _buildHeader(),
                const SizedBox(height: 20),

                Expanded(
                  child: _notifications.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    itemCount: _notifications.length,
                    itemBuilder: (context, index) {
                      final item = _notifications[index];
                      return _buildAnimatedNotifyCard(item, index);
                    },
                  ),
                ),
              ],
            ),
          ),

          // زر الرجوع بتصميم عصري
          Positioned(
            top: 45,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.5),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // رأس الصفحة (Header)
  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          'مركز التنبيهات',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            letterSpacing: 1,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          height: 3,
          width: 60,
          decoration: BoxDecoration(
            color: const Color(0xFFC795A4),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }

  // بطاقة الإشعار بتصميم "الأسطر المنفصلة" واللمسات الجمالية
  Widget _buildAnimatedNotifyCard(Map<String, String> item, int index) {
    bool isRead = item['isRead'] == 'true';

    return Dismissible(
      key: Key(item['id']!),
      onDismissed: (_) => setState(() => _notifications.removeAt(index)),
      child: GestureDetector(
        onTap: () => setState(() => item['isRead'] = 'true'),
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isRead ? Colors.white.withOpacity(0.4) : Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isRead ? Colors.transparent : const Color(0xFFC795A4).withOpacity(0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // السطر الأول: الحالة والوقت
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item['time']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(
                    item['status']!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isRead ? Colors.grey : const Color(0xFFC795A4),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(height: 1, thickness: 0.5),
              ),

              // السطر الثاني: اسم العميل
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    item['customer']!,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.person_outline, size: 18, color: Colors.black54),
                ],
              ),

              const SizedBox(height: 10),

              // السطر الثالث: نوع الطلب
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFC795A4).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item['service']!,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF8E6B76)),
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.stars, size: 16, color: Color(0xFFC795A4)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hourglass_empty_rounded, size: 80, color: Colors.black.withOpacity(0.1)),
          const SizedBox(height: 16),
          const Text('بانتظار طلبات الجمال القادمة...', style: TextStyle(color: Colors.black38, fontSize: 16)),
        ],
      ),
    );
  }
}