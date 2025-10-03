import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/mock_data.dart';
import '../models/paket_model.dart';
import 'tripku_page.dart'; // Navigasi akhir

// Tambahkan model ini untuk menampung data yang akan diteruskan
class PendaftaranFinalData {
  final Paket paket;
  final Map<String, String> dataPribadi;
  final int totalHarga;

  PendaftaranFinalData({
    required this.paket,
    required this.dataPribadi,
    required this.totalHarga,
  });
}

// Global List Dummy untuk menyimpan trip yang berhasil didaftarkan
List<PendaftaranFinalData> myTripsList = []; 


class PembayaranPage extends StatefulWidget {
  final Paket paket;
  final Map<String, String> dataPribadi;
  final int totalHarga;

  const PembayaranPage({
    required this.paket,
    required this.dataPribadi,
    required this.totalHarga,
    super.key,
  });

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  String? _selectedMethod; // State untuk menyimpan metode pembayaran yang dipilih

  // Helper untuk memformat harga
  String formatRupiah(int amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'IDR ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  // --- Pop-up dan Aksi Final ---
  void _processPayment(BuildContext context) {
    if (_selectedMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mohon pilih metode pembayaran terlebih dahulu.')),
      );
      return;
    }

    // 1. SIMULASI PENDAFTARAN BERHASIL (Menambahkan data ke list hardcode)
    final finalData = PendaftaranFinalData(
      paket: widget.paket,
      dataPribadi: widget.dataPribadi,
      totalHarga: widget.totalHarga,
    );
    myTripsList.add(finalData); // Simpan ke list global

    // 2. Tampilkan Pop-up
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          content: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const Text(
              "Jazakumullahu khairan atas kepercayaan Anda. Pembayaran berhasil. Semoga perjalanan lancar!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(dialogContext); // Tutup dialog
                  // Ganti halaman saat ini dengan TripkuPage
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const TripkuPage()),
                    (route) => route.isFirst, // Kembali ke Home/MainPage
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  side: const BorderSide(color: Colors.grey),
                  minimumSize: const Size(150, 45),
                ),
                child: const Text('Selesai', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        );
      },
    );
  }
  // --- Akhir Pop-up dan Aksi Final ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Column(
        children: [
          _buildTotalSummary(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Pilih Metode Pembayaran'),
                  _buildPaymentOption(
                    'Transfer Bank (Dummy)', 
                    'Bayar melalui bank transfer', 
                    'BankTransfer',
                  ),
                  _buildPaymentOption(
                    'Kartu Kredit/Debit (Dummy)', 
                    'Visa, Mastercard, JCB', 
                    'CreditCard',
                  ),
                  const SizedBox(height: 100), // Spasi agar tidak terpotong
                ],
              ),
            ),
          ),
          
          // Tombol Bayar Sekarang
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0, left: 16, right: 16, top: 10),
            child: ElevatedButton(
              onPressed: () => _processPayment(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Text('Bayar Sekarang ${formatRupiah(widget.totalHarga)}', 
                style: const TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Total Pembayaran', style: TextStyle(fontSize: 14, color: Colors.black54)),
          const SizedBox(height: 4),
          Text(
            formatRupiah(widget.totalHarga),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kPrimaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, top: 8.0),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildPaymentOption(String title, String subtitle, String methodId) {
    bool isSelected = _selectedMethod == methodId;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = methodId;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? kPrimaryColor : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? kPrimaryColor : Colors.grey,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}