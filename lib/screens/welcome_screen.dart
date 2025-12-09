import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2b8cee), // Primary
              Color(0xFF65C7F7),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
                      Container(
                        width: 192, // 48 * 4
                        height: 192,
                        margin: const EdgeInsets.only(bottom: 24),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuCZYTxmlg-YXtokoOYSKbWGddQyzTb0iXMKCO8UwjtstxiZ51ZeIeGPd3fvRT5Li80HAJa9rydACZpnBk4roh8CGQBVT81w0BZjitFjNpocNqPhItzV4D8usUtKaS7yaCrSQSzIX2xEzpY3r2Rj4pEI4UC8cWmhiWjg5QWrX_SuGH2xAk96kny4Lt0UEAEEvVHYrxiMTBqevqicvSOjF0OYez5AhEZVDQ3mY_sc4uvCecelbKrP8sxiH-ieEtwXAI6UNM2WObLDag'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      // Headline
                      const Text(
                        'Booking Lapangan Futsal Jadi Mudah',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Subheading
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          'Jadwalkan permainanmu dan temukan lapangan terbaik di sekitarmu dengan Kinglap.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/auth');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF2b8cee),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Mulai',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
