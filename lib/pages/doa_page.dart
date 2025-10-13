import 'package:flutter/material.dart';
import '../models/doa_model.dart';
import '../data/doa_data.dart';
import '../data/mock_data.dart'; // Untuk kPrimaryColor

class DoaPage extends StatelessWidget {
  const DoaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kumpulan Doa Umroh', style: TextStyle(color: Colors.white)),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: listDoaUmroh.length,
        itemBuilder: (context, index) {
          final doa = listDoaUmroh[index];
          return DoaCard(doa: doa);
        },
      ),
    );
  }
}

class DoaCard extends StatelessWidget {
  final Doa doa;
  
  const DoaCard({required this.doa, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul dan Lokasi
            Text(
              doa.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor),
            ),
            Text(
              'Lokasi: ${doa.location}',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontStyle: FontStyle.italic),
            ),
            const Divider(height: 20),

            // Teks Arab
            Text(
              doa.arabic,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 24,
                fontFamily: 'Amiri', // Gunakan font Arab yang sesuai
                fontWeight: FontWeight.w500,
                height: 1.8,
              ),
            ),
            const SizedBox(height: 15),

            // Teks Latin
            Text(
              'Bacaan Latin:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
            Text(
              doa.latin,
              style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 10),
            
            // Terjemahan
            Text(
              'Terjemahan:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
            Text(
              doa.translation,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}