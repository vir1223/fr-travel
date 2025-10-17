// lib/services/firestore_service.dart (Pastikan sudah direvisi)

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  final CollectionReference _userCollection = 
      FirebaseFirestore.instance.collection('users');

  // Menyimpan/Mengupdate data detail pengguna
  Future<void> saveUserProfile(String uid, UserProfile profile) async {
    // Digunakan oleh _saveProfile()
    await _userCollection.doc(uid).set(profile.toJson(), SetOptions(merge: true));
  }

  // Mengambil data detail pengguna
  Future<UserProfile?> getUserProfile(String uid) async {
    // Digunakan oleh _loadProfileData()
    final doc = await _userCollection.doc(uid).get();
    if (doc.exists) {
      return UserProfile.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>);
    }
    return null;
  }
  // Tidak ada method getPackages()
}