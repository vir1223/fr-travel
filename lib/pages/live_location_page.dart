import 'package:flutter/material.dart';
import '../data/mock_data.dart'; // Untuk kPrimaryColor

// Jika Anda sudah install google_maps_flutter, ganti Container ini dengan GoogleMap
// import 'package:google_maps_flutter/google_maps_flutter.dart'; 

class LiveLocationPage extends StatelessWidget {
  const LiveLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Location', style: TextStyle(color: Colors.white)),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder untuk Peta
            Container(
              height: 400,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map, size: 50, color: Colors.black54),
                    SizedBox(height: 10),
                    Text(
                      "Placeholder Peta",
                      style: TextStyle(color: Colors.black54),
                    ),
                    Text(
                      "Tambahkan 'google_maps_flutter' untuk peta nyata",
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Lokasi saat ini: Mekkah, KSA", // Data Hardcode
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}