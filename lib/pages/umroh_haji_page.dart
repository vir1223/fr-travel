import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/paket_model.dart';
import 'detail_paket_page.dart'; // Navigasi ke Halaman Detail

const Color kPrimaryColor = Color.fromARGB(255, 0, 191, 99);

class UmrohHajiPage extends StatelessWidget {
  const UmrohHajiPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold dengan AppBar kustom (Search Bar)
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // Ikon kembali
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          // Implementasi Search Bar Kustom
          height: 40,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Cari...',
              hintStyle: TextStyle(color: Colors.white70),
              prefixIcon: Icon(Icons.search, color: Colors.white),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: mockPaket.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          childAspectRatio: 0.55, 
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (context, index) {
          final paket = mockPaket[index];
          return ProductCard(
            paket: paket,
            onDetailsPressed: () {
              // Navigasi dengan membawa data paket
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => DetailPaketPage(paket: paket),
              ));
            },
          );
        },
      ),
    );
  }
}

// Widget ProductCard (Komponen yang diulang)
class ProductCard extends StatelessWidget {
    final Paket paket;
    final VoidCallback onDetailsPressed;

    const ProductCard({required this.paket, required this.onDetailsPressed, super.key});
    
    @override
    Widget build(BuildContext context) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        elevation: 4.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Placeholder Gambar Produk
            Container(
              height: 120, 
              decoration: BoxDecoration(
                color: Colors.black, // Placeholder
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              ),
            ),
            
            // Konten Teks
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(paket.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),

                  ...paket.features.map((feature) => Text('• $feature', style: const TextStyle(fontSize: 13))).toList(),
                  const SizedBox(height: 12),
                  
                  // Tombol SELENGKAPNYA
                  ElevatedButton(
                    onPressed: onDetailsPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                      minimumSize: const Size(double.infinity, 35),
                    ),
                    child: const Text('SELENGKAPNYA', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
}