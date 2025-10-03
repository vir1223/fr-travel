import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Tambahkan package intl di pubspec.yaml
import '../data/mock_data.dart';
import '../models/paket_model.dart';
import 'pembayaran_page.dart'; // Navigasi ke Pembayaran

class RingkasanPesananPage extends StatelessWidget {
  final Paket paket;
  final Map<String, String> dataPribadi;

  const RingkasanPesananPage({
    required this.paket,
    required this.dataPribadi,
    super.key,
  });

  // Data biaya tambahan hardcode
  static const int asuransi = 3000000;
  static const int ppn = 0; // PPN 0% untuk paket umroh/haji dummy
  
  // Total Pembayaran
  int get totalPembayaran => paket.priceIDR + asuransi + ppn;

  // Helper untuk memformat harga (membutuhkan package intl: ^0.18.1)
  String formatRupiah(int amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'IDR ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ringkasan Pesanan', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Bagian A: Ringkasan Paket ---
                  _buildSectionTitle('Paket yang Dipilih'),
                  _buildPackageCard(context),
                  const Divider(height: 30),

                  // --- Bagian B: Data Pribadi ---
                  _buildSectionTitle('Data Jamaah'),
                  ...dataPribadi.entries.map((entry) => _buildDetailRow(entry.key.toUpperCase(), entry.value)).toList(),
                  const Divider(height: 30),

                  // --- Bagian C: Detail Biaya ---
                  _buildSectionTitle('Rincian Biaya'),
                  _buildDetailRow('Harga Paket', formatRupiah(paket.priceIDR), isTotal: false),
                  _buildDetailRow('Asuransi Perjalanan', formatRupiah(asuransi), isTotal: false),
                  _buildDetailRow('PPN (0%)', formatRupiah(ppn), isTotal: false),
                  const SizedBox(height: 10),
                  // Total
                  _buildDetailRow('TOTAL PEMBAYARAN', formatRupiah(totalPembayaran), isTotal: true),
                ],
              ),
            ),
          ),
          
          // --- Tombol Pembayaran (Fixed di Bawah) ---
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0, left: 16, right: 16, top: 10),
            child: ElevatedButton(
              onPressed: () {
                // Navigasi ke Halaman Pembayaran, bawa semua data yang sudah final
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => PembayaranPage(
                    paket: paket,
                    dataPribadi: dataPribadi,
                    totalHarga: totalPembayaran,
                  ),
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Pembayaran', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
  
  // --- Helper Widgets ---

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
              color: isTotal ? kPrimaryColor : Colors.black54,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              fontSize: isTotal ? 16 : 14,
              color: isTotal ? kPrimaryColor : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kPrimaryColor.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          // Placeholder Gambar Kecil
          Container(width: 60, height: 60, color: Colors.black54, margin: const EdgeInsets.only(right: 12)),
          
          // Info Paket
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  paket.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  'Tanggal: ${paket.date}',
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
                Text(
                  '${paket.duration} | ${formatRupiah(paket.priceIDR)}',
                  style: TextStyle(fontSize: 13, color: kPrimaryColor, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}