import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

// Import Services & Models untuk Firestore
import '../services/firestore_service.dart';
import '../models/user_profile_model.dart';

// Import Pages (asumsi Anda memiliki HomePage dan SettingPage)
import 'home_page.dart'; 
import 'setting_page.dart'; 

// Warna Primer Anda
const Color primaryColor = Color.fromARGB(255, 0, 191, 99);

// Data Default (Digunakan jika data Firestore belum ada)
const String defaultGender = 'Pria';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Instance Service & Auth
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final FirestoreService _firestoreService = FirestoreService();
  
  // State dan Keys
  final _formKey = GlobalKey<FormState>();
  UserProfile? _loadedProfile;
  bool _isLoading = true; 

  // Controllers
  final TextEditingController firstController = TextEditingController();
  final TextEditingController lastController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  String? _dropdownValue = defaultGender;
  

  @override
  void initState() {
    super.initState();
    if (currentUser != null) {
      _loadProfileData();
    } else {
      _isLoading = false; // Jika tidak ada pengguna yang login, hentikan loading
    }
  }

  @override
  void dispose() {
    firstController.dispose();
    lastController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    birthDateController.dispose();
    super.dispose();
  }
  
  // --- LOGIKA FIRESTORE: LOAD DATA ---
  Future<void> _loadProfileData() async {
    if (currentUser == null) return;
    
    try {
        final profile = await _firestoreService.getUserProfile(currentUser!.uid);
        
        // Jika data tidak ada di Firestore, buat objek default baru
        final profileToUse = profile ?? UserProfile(
          email: currentUser!.email ?? '',
          photoUrl: currentUser!.photoURL ?? '',
        );

        // Jika ini pengguna baru, simpan data default ke Firestore
        if (profile == null) {
            await _firestoreService.saveUserProfile(currentUser!.uid, profileToUse);
        }
        
        if (mounted) {
            setState(() {
              _loadedProfile = profileToUse;
              _isLoading = false;

              // Isi Controllers dengan data gabungan dari Auth dan Firestore
              emailController.text = profileToUse.email;
              firstController.text = profileToUse.firstName;
              lastController.text = profileToUse.lastName;
              phoneController.text = profileToUse.phone;
              birthDateController.text = profileToUse.birthDate;
              
              // Username dari Firebase Auth displayName (prioritas)
              usernameController.text = currentUser!.displayName ?? profileToUse.firstName; 
              _dropdownValue = profileToUse.gender;
            });
        }
    } catch (e) {
        if (mounted) {
            setState(() => _isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Gagal memuat profil: $e'), backgroundColor: Colors.red)
            );
        }
    }
  }

  // --- LOGIKA FIRESTORE: SAVE DATA ---
  void _saveProfile() async {
    if (currentUser == null || !_formKey.currentState!.validate()) return; // Validasi Form

    // 1. Siapkan objek UserProfile baru dari Controllers
    final newProfile = UserProfile(
      email: emailController.text, // Email tidak berubah
      photoUrl: currentUser!.photoURL ?? '',
      firstName: firstController.text.trim(),
      lastName: lastController.text.trim(),
      phone: phoneController.text.trim(),
      gender: _dropdownValue!,
      birthDate: birthDateController.text.trim(),
    );

    try {
      // 2. Simpan data detail ke Firestore
      await _firestoreService.saveUserProfile(currentUser!.uid, newProfile);

      // 3. Update display name di Firebase Auth (untuk username)
      if (currentUser!.displayName != usernameController.text.trim()) {
         await currentUser!.updateDisplayName(usernameController.text.trim());
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil berhasil diperbarui dan disimpan di Firestore!'))
        );
      }
    } catch (e) {
      if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menyimpan profil: $e'), backgroundColor: Colors.red)
         );
      }
    }
  }

  // Helper untuk Dropdown
  void dropdownCallBack(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

  // Helper untuk Date Picker
  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(birthDateController.text) ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        birthDateController.text = picked.toString().split(" ")[0];
      });
    }
  }
  
  // Helper untuk Bottom Nav
  Widget _buildNavButton(BuildContext context, IconData icon, String label, Widget? page, bool isActive) {
      return Expanded(
        child: ElevatedButton(
          onPressed: isActive ? () {} : () {
            if (page != null) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => page));
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isActive ? primaryColor.withOpacity(0.5) : primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: const RoundedRectangleBorder(),
            padding: EdgeInsets.zero
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 31, color: Colors.white),
              Text(label, style: const TextStyle(fontSize: 10)),
            ],
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    // Tampilkan Loading Indicator saat data sedang diambil
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: primaryColor)),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profil', style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Form( // Membungkus UI dengan Form untuk validasi
          key: _formKey,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[200],
                // Menggunakan photoURL dari data yang dimuat
                backgroundImage: _loadedProfile?.photoUrl != null && _loadedProfile!.photoUrl.isNotEmpty 
                                ? NetworkImage(_loadedProfile!.photoUrl) as ImageProvider<Object>
                                : null,
                child: (_loadedProfile?.photoUrl == null || _loadedProfile!.photoUrl.isEmpty) 
                      ? const Icon(Icons.person_outline, size: 50, color: Colors.black) 
                      : null,
              ),
              const SizedBox(height: 20),
              Text(
                'Edit Profile',
                style: GoogleFonts.inter(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 22),
              
              // --- Form Fields ---
              TextFormField(
                controller: firstController,
                decoration: const InputDecoration(labelText: 'First name', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Nama depan wajib diisi' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: lastController,
                decoration: const InputDecoration(labelText: 'Last name', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Username wajib diisi' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email (Dari Login)',
                  border: OutlineInputBorder(),
                  fillColor: Color(0xFFEFEFEF), filled: true, // Menandakan read-only
                ),
                readOnly: true,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder()),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                items: const [
                  DropdownMenuItem(value: "Pria", child: Text('Pria')),
                  DropdownMenuItem(value: "Wanita", child: Text('Wanita')),
                ],
                decoration: const InputDecoration(labelText: 'Gender', border: OutlineInputBorder()),
                onChanged: dropdownCallBack,
                value: _dropdownValue,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: birthDateController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Lahir',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: _selectDate,
              ),
              // --- End Form Fields ---

              const SizedBox(height: 30),
              
              // Tombol Selesai (Simpan)
              ElevatedButton(
                onPressed: _saveProfile, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  'Selesai',
                  style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(color: primaryColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavButton(context, Icons.settings, 'Setting', const SettingPage(), false),
            _buildNavButton(context, Icons.home_outlined, 'Home', const HomePage(), false),
            _buildNavButton(context, Icons.person_outline_outlined, 'Profile', null, true),
          ],
        ),
      ),
    );
  }
}