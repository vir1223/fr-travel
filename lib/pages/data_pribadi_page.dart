import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/paket_model.dart';
import 'ringkasan_pesanan_page.dart';

class DataPribadiPage extends StatefulWidget {
  final Paket paket; // Menerima paket yang didaftar
  const DataPribadiPage({required this.paket, super.key});

  @override
  State<DataPribadiPage> createState() => _DataPribadiPageState();
}

class _DataPribadiPageState extends State<DataPribadiPage> {
  // Controllers untuk mengambil input pengguna
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _kewarganegaraanController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _pasporController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _alamatController.dispose();
    _kewarganegaraanController.dispose();
    _tanggalLahirController.dispose();
    _pasporController.dispose();
    super.dispose();
  }

  // Fungsi untuk membuat objek data yang akan diteruskan
  void _lanjutkanPendaftaran() {
    final Map<String, String> dataPribadi = {
      'namaLengkap': _namaController.text,
      'alamat': _alamatController.text,
      'kewarganegaraan': _kewarganegaraanController.text,
      'tanggalLahir': _tanggalLahirController.text,
      'nomorPaspor': _pasporController.text,
    };

    // Navigasi ke Ringkasan dengan membawa data paket dan data pribadi
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => RingkasanPesananPage(
        paket: widget.paket,
        dataPribadi: dataPribadi,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Isi Data Pribadi', 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kPrimaryColor)),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildTextField('Nama Lengkap', 'Sesuai KTP/Paspor/SIM', _namaController),
                  _buildTextField('Alamat', 'Sesuai KTP/Paspor/SIM', _alamatController),
                  _buildTextField('Kewarganegaraan', 'Isi Data', _kewarganegaraanController),
                  _buildTextField('Tanggal Lahir', 'DD/MM/YYYY', _tanggalLahirController),
                  _buildTextField('Nomor Paspor', 'Tuliskan Nomor Paspor', _pasporController),
                  const SizedBox(height: 100), // Ruang agar tombol tidak menutupi
                ],
              ),
            ),
          ),
          
          // Tombol Lanjutkan (Fixed di bawah)
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0, left: 16, right: 16),
            child: ElevatedButton(
              onPressed: _lanjutkanPendaftaran,
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Lanjutkan', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk setiap Input Field
  Widget _buildTextField(String label, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: const TextStyle(color: Colors.black),
          contentPadding: const EdgeInsets.only(bottom: 5, top: 10),
          isDense: true,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0.5),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
          ),
        ),
      ),
    );
  }
}