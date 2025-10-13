import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:fr_travel/pages/home_page.dart';
import 'package:fr_travel/pages/setting_page.dart';
import 'package:google_fonts/google_fonts.dart';

// Warna Primer Anda
const Color primaryColor = Color.fromARGB(255, 0, 191, 99);

const String defaultFirstName = 'Nama';
const String defaultLastName = 'Pengguna';
const String defaultPhone = '081234567890';
const String defaultGender = 'Pria';
const String defaultBirthDate = '2000-01-01';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // 1. Dapatkan pengguna yang sedang login
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Controllers
  final TextEditingController firstController = TextEditingController();
  final TextEditingController lastController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  String? _dropdownValue = defaultGender;
  
  // Variabel untuk menyimpan Photo URL (opsional, jika Anda punya)
  String _photoUrl = ''; 
  

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  void _loadProfileData() {
    if (currentUser != null) {
      // 2. Mengisi Controller dengan data dari Firebase Auth:
      
      // Menggunakan displayName Firebase (jika ada) atau email sebagai fallback
      String fullName = currentUser!.displayName ?? currentUser!.email!.split('@')[0];
      
      // Karena Firebase tidak memisahkan nama depan/belakang, kita hardcode sisa data
      firstController.text = defaultFirstName; 
      lastController.text = defaultLastName;
      
      // Mengisi Email dan Username dari data login
      emailController.text = currentUser!.email ?? 'Tidak Ada Email';
      usernameController.text = fullName; 

      // Data yang lain tetap menggunakan hardcode lokal
      phoneController.text = defaultPhone;
      birthDateController.text = defaultBirthDate; 
      _dropdownValue = defaultGender;
      _photoUrl = currentUser!.photoURL ?? '';
      
      // Jika Anda menyimpan data detail di Firestore, Anda akan memanggil fungsi fetch data di sini.
    } else {
      // Jika pengguna tidak login (sangat jarang jika Auth Wrapper berfungsi)
      emailController.text = 'Pengguna Belum Login';
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

  void dropdownCallBack(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      // Menggunakan initialDate dari controller jika valid, atau DateTime.now()
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
  
  void _saveProfile() {
    // 3. (Opsional) Mengupdate Display Name di Firebase Auth
    // Ini adalah satu-satunya data yang bisa diupdate TANPA Firestore/DB
    if (currentUser != null && currentUser!.displayName != usernameController.text) {
      currentUser!.updateDisplayName(usernameController.text);
    }

    // --- LOGIKA PENYIMPANAN DATA LAIN DI SINI ---
    // Di aplikasi nyata, data ini (Nama Depan, Telepon, Gender, Tanggal Lahir) 
    // akan disimpan ke Firestore atau Database lain menggunakan User UID
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil berhasil diperbarui! (Data hanya email/username yang terintegrasi Firebase)'))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
              backgroundImage: _photoUrl.isNotEmpty ? NetworkImage(_photoUrl) : null,
              child: _photoUrl.isEmpty ? const Icon(Icons.person_outline, size: 50, color: Colors.black) : null,
            ),
            const SizedBox(height: 20),
            Text(
              'Edit Profile',
              style: GoogleFonts.inter(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 22),
            
            // --- Form Fields ---
            TextFormField(
              controller: firstController,
              decoration: const InputDecoration(labelText: 'First name', border: OutlineInputBorder()),
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
            ),
            const SizedBox(height: 15),
            
            // Email (Biasanya dibuat read-only)
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email (Dari Login)',
                border: OutlineInputBorder(),
              ),
              readOnly: true, // Email dari Firebase biasanya tidak bisa diubah langsung di sini
            ),
            const SizedBox(height: 15),
            
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            
            // Gender Dropdown
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
            
            // Tanggal Lahir
            TextFormField(
              controller: birthDateController,
              decoration: const InputDecoration(
                labelText: 'Tanggal Lahir',
                filled: true,
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
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
      
      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(color: Color.fromARGB(255, 0, 191, 99)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SettingPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 191, 99),
                foregroundColor: Colors.white,
              ),
              child: Column(
                children: [
                  Icon(Icons.settings, size: 31, color: Colors.white),
                  Text('Setting'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 191, 99),
                foregroundColor: Colors.white,
              ),
              child: Column(
                children: [
                  Icon(Icons.home_outlined, size: 31, color: Colors.white),
                  Text('Home'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(100, 0, 191, 99),
                foregroundColor: Colors.white,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.person_outline_outlined,
                    size: 31,
                    color: Colors.white,
                  ),
                  Text('Profile'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}