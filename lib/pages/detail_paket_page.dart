import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/paket_model.dart';
import 'data_pribadi_page.dart'; // Navigasi ke Isi Data

class DetailPaketPage extends StatelessWidget {
  final Paket paket; // Menerima data paket

  const DetailPaketPage({required this.paket, super.key});

  // Helper untuk memformat harga
  String formatRupiah(int amount) {
    return 'IDR ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(paket.title),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Utama
            Container(height: 200, color: Colors.black, /* Ganti dengan Image.asset */),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${paket.title} ${paket.date.substring(paket.date.length - 4)}', // Umroh Plus Turkey 2025
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${paket.title} - Program ${paket.duration}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 15),

                  // Tanggal & Durasi (Grid 2 Kolom)
                  Row(
                    children: [
                      _InfoChip(icon: Icons.calendar_today, text: paket.date),
                      const SizedBox(width: 15),
                      _InfoChip(icon: Icons.access_time, text: paket.duration),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Harga & Seat
                  Row(
                    children: [
                      _PriceSeatChip(label: 'Harga', value: '${(paket.priceIDR / 1000000).toStringAsFixed(0)} JUTA', isPrimary: false),
                      const SizedBox(width: 15),
                      _PriceSeatChip(label: 'SEAT', value: '54', isPrimary: true), // Seat hardcode dummy
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Tombol Aksi
                  Row(
                    children: [
                      // Tombol Chat
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {/* Navigasi ke ChatPage */},
                          icon: const Icon(Icons.chat_bubble_outline, size: 18),
                          label: const Text('Chat dengan Agen'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange.shade700, 
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Tombol Daftar
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigasi ke Isi Data, bawa objek paket yang dipilih
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => DataPribadiPage(paket: paket),
                            ));
                          },
                          child: const Text('Daftar Umroh', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget Helper
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: kPrimaryColor, size: 20),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _PriceSeatChip extends StatelessWidget {
  final String label;
  final String value;
  final bool isPrimary;

  const _PriceSeatChip({required this.label, required this.value, required this.isPrimary});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: isPrimary ? Colors.white : Colors.grey.shade300,
        border: isPrimary ? Border.all(color: kPrimaryColor, width: 2) : null,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: isPrimary ? kPrimaryColor : Colors.black87, fontSize: 12)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: isPrimary ? kPrimaryColor : Colors.black)),
        ],
      ),
    );
  }
}