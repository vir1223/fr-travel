import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Import flutter_map
import 'package:latlong2/latlong.dart'; // Import LatLng dari latlong2
import '../data/mock_data.dart'; 

class LiveLocationPage extends StatelessWidget {
  const LiveLocationPage({super.key});

  // Koordinat Hardcode untuk lokasi saat ini (Contoh: Mekkah)
  final LatLng _currentLocation = const LatLng(21.4225, 39.8262);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Location', style: TextStyle(color: Colors.white)),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // Widget Flutter Map
          FlutterMap(
            options: MapOptions(
              initialCenter: _currentLocation,
              initialZoom: 14.0,
            ),
            children: [
              // Tile Layer (Menampilkan Peta OSM)
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.yourcompany.yourappname', // Ganti dengan package name Anda
              ),
              
              // Marker Layer (Menampilkan Pin Lokasi)
              MarkerLayer(
                markers: [
                  Marker(
                    point: _currentLocation,
                    width: 80,
                    height: 80,
                    child: Icon(
                      Icons.location_on,
                      color: kPrimaryColor, // Warna Pin
                      size: 40.0,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Teks Lokasi di bagian bawah
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: const Text(
                "Lokasi saat ini: Mekkah, Arab Saudi (Via OpenStreetMap)",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kPrimaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}