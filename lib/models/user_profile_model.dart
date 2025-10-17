// lib/models/user_profile_model.dart (Pastikan sudah seperti ini)

import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String firstName;
  final String lastName;
  final String phone;
  final String gender;
  final String birthDate;
  final String email; 
  final String photoUrl; 
  
  UserProfile({
    required this.email,
    this.photoUrl = '',
    this.firstName = 'Nama',
    this.lastName = 'Pengguna',
    this.phone = '080000000000',
    this.gender = 'Pria',
    this.birthDate = '2000-01-01',
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'gender': gender,
      'birthDate': birthDate,
      'photoUrl': photoUrl,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  factory UserProfile.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    // ... (logic for parsing fields)
    return UserProfile(
      firstName: data['firstName'] ?? 'Nama',
      lastName: data['lastName'] ?? 'Pengguna',
      email: data['email'] ?? 'unknown@email.com',
      phone: data['phone'] ?? '080000000000',
      gender: data['gender'] ?? 'Pria',
      birthDate: data['birthDate'] ?? '2000-01-01',
      photoUrl: data['photoUrl'] ?? '',
    );
  }
}