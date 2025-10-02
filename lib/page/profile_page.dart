import 'package:flutter/material.dart';
import 'package:fr_travel/page/home_page.dart';
import 'package:fr_travel/page/setting_page.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController firstController = TextEditingController();
  final TextEditingController lastController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  String? _dropdownValue = 'Pria';

  void dropdownCallBack(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      setState(() {
        birthDateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person_outline, size: 50, color: Colors.black),
              backgroundColor: Colors.grey[200],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Edit Profile',
                  style: GoogleFonts.inter(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 22),
                TextFormField(
                  controller: firstController,
                  decoration: InputDecoration(
                    labelText: 'First name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: lastController,
                  decoration: InputDecoration(
                    labelText: 'Last name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                DropdownButtonFormField(
                  items: [
                    DropdownMenuItem(value: "Pria", child: Text('Pria')),
                    DropdownMenuItem(value: "Wanita", child: Text('Wanita')),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: dropdownCallBack,
                  value: _dropdownValue,
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: birthDateController,
                  decoration: InputDecoration(
                    labelText: 'Tanggal Lahir',
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  readOnly: true,
                  onTap: () => _selectDate(),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 191, 99),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(8)),
                ),
              ),
              child: Text(
                'Selesai',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),

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
