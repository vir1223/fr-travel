import '../models/paket_model.dart';
import 'package:flutter/material.dart';

final List<Paket> mockPaket = [
  Paket(
    id: 'U001',
    title: 'Umroh Plus Turkey',
    features: ['Saudia Airlines', 'Makan 3x Sehari', 'Bus Privat'],
    imageUrl: 'assets/images/placeholder_umroh.png', // Ganti dengan path aset Anda
    date: '18 Nov 2025',
    duration: '11 Hari',
    priceIDR: 47000000,
  ),
  Paket(
    id: 'U002',
    title: 'Umroh Reguler Hemat',
    features: ['Garuda Indonesia', 'Makan 2x Sehari', 'Bus Standard'],
    imageUrl: 'assets/images/placeholder_umroh.png',
    date: '05 Jan 2026',
    duration: '9 Hari',
    priceIDR: 28500000,
  ),
];

const Color kPrimaryColor = Color.fromARGB(255, 0, 191, 99);

