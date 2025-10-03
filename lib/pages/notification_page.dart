import 'package:flutter/material.dart';
import '../data/mock_data.dart'; // Untuk kPrimaryColor

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  final List<Map<String, dynamic>> dummyNotifications = const [
    {'title': 'Pembayaran Berhasil!', 'subtitle': 'Pembayaran paket Umroh Plus Turkey Anda telah diverifikasi.', 'icon': Icons.check_circle, 'isRead': false},
    {'title': 'Seat Tersedia', 'subtitle': 'Paket Umroh Reguler memiliki ketersediaan kursi baru.', 'icon': Icons.notifications_active, 'isRead': true},
    {'title': 'Dokumen Diproses', 'subtitle': 'Dokumen paspor Anda sedang diproses oleh tim kami.', 'icon': Icons.folder_open, 'isRead': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: dummyNotifications.length,
        itemBuilder: (context, index) {
          final notif = dummyNotifications[index];
          return Container(
            color: notif['isRead'] ? Colors.white : Colors.lightGreen.shade50, // Highlight notif yang belum dibaca
            child: ListTile(
              leading: Icon(notif['icon'], color: kPrimaryColor),
              title: Text(notif['title'], style: TextStyle(fontWeight: notif['isRead'] ? FontWeight.normal : FontWeight.bold)),
              subtitle: Text(notif['subtitle']),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () {
                // Aksi saat notifikasi diklik
              },
            ),
          );
        },
      ),
    );
  }
}