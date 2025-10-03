import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import 'pembayaran_page.dart'; // Import PendaftaranFinalData dan myTripsList

class TripkuPage extends StatelessWidget {
  const TripkuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tripku', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: myTripsList.isEmpty
          ? const Center(
              child: Text(
                'Anda belum memiliki Trip yang terdaftar.',
                style: TextStyle(color: Colors.black54),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: myTripsList.length,
              itemBuilder: (context, index) {
                final trip = myTripsList[index];
                return _buildTripCard(context, trip);
              },
            ),
    );
  }

  Widget _buildTripCard(BuildContext context, PendaftaranFinalData trip) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  trip.paket.title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text('TERDAFTAR', style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ],
            ),
            const Divider(),
            _buildTripDetailRow(Icons.calendar_today, 'Tanggal Keberangkatan', trip.paket.date),
            _buildTripDetailRow(Icons.access_time, 'Durasi', trip.paket.duration),
            _buildTripDetailRow(Icons.person, 'Jamaah Utama', trip.dataPribadi['namaLengkap'] ?? '-'),
            const SizedBox(height: 10),
            
            // Tombol Live Location (tanpa toggle)
            ElevatedButton.icon(
              onPressed: () {
                // Navigasi ke Live Location Page
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const LiveLocationPage()));
              },
              icon: const Icon(Icons.location_on, size: 18),
              label: const Text('Live Location'),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: kPrimaryColor, size: 20),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }
}