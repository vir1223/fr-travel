import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo Ahan',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                        Text(
                          'Sudah Siap untuk Beribadah Hari Ini?',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    IconButton(onPressed: (){}, icon: Icon(
                      Icons.notifications,
                      size: 55,
                      color: Color.fromARGB(255, 0, 191, 99),
                    ),)
                    
                  ],
                ),
                SizedBox(height: 75),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 67,
                            height: 67,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Color.fromARGB(255, 0, 191, 99),
                            ),
                            child: Image(
                              image: AssetImage('../../assets/icons/plane.png'),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'UMROH',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 67,
                            height: 67,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Color.fromARGB(255, 0, 191, 99),
                            ),
                            child: Image(
                              image: AssetImage('../../assets/icons/kabah.png'),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'HAJI',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 67,
                            height: 67,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Color.fromARGB(255, 0, 191, 99),
                            ),
                            child: Image(
                              image: AssetImage('../../assets/icons/trip.png'),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'MY TRIP',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ],  
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 67,
                            height: 67,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Color.fromARGB(255, 0, 191, 99),
                            ),
                            child: Image(
                              image: AssetImage('../../assets/icons/mark.png'),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'LIVE LOCATION',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('../../assets/images/home.png'),
                  colorFilter: ColorFilter.mode(
                    Color.fromARGB(129, 0, 0, 0),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 44),
                  Text(
                    'IBADAH',
                    style: GoogleFonts.poppins(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'UMROH&',
                    style: GoogleFonts.poppins(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'HAJI KHUSUS',
                    style: GoogleFonts.poppins(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 0, 191, 99),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                    child: Text(
                      'Selengkapnya',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 22),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Color.fromARGB(255, 0, 191, 99),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 0, 191, 99),
                            foregroundColor: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.settings,
                                size: 31,
                                color: Colors.white,
                              ),
                              Text('Setting'),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 0, 191, 99),
                            foregroundColor: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.home_outlined,
                                size: 31,
                                color: Colors.white,
                              ),
                              Text('Home'),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 0, 191, 99),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
