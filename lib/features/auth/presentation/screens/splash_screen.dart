import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_card_storage_app/features/cards/presentation/screens/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();

    // Navigate to Dashboard after a delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background subtle concentric circles (simulated with Container/BoxDecoration)
          Positioned.fill(
            child: Opacity(
              opacity: 0.03,
              child: Center(
                child: Container(
                  width: 600,
                  height: 600,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Color(0xFF5A46E6), Colors.white],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Icon
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5A46E6),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF5A46E6).withOpacity(0.3),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.bar_chart_rounded, size: 60, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 48),
                // Title
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.outfit(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2D3142),
                    ),
                    children: const [
                      TextSpan(text: 'Everyday '),
                      TextSpan(
                        text: 'Rewards',
                        style: TextStyle(color: Color(0xFF5A46E6)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'The Digital Curator of Your Value',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    color: Colors.black38,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 64),
                // Progress Bar
                SizedBox(
                  width: 200,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return LinearProgressIndicator(
                              value: _animation.value,
                              backgroundColor: const Color(0xFFE1E5ED),
                              color: const Color(0xFF5A46E6),
                              minHeight: 6,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'INITIALIZING VAULT',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black26,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Footer
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.verified_user, size: 16, color: Color(0xFF00B894)),
                    const SizedBox(width: 8),
                    Text(
                      'Bank-Grade Encryption',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  '© 2024 EVERYDAY REWARDS INC. ALL RIGHTS RESERVED.',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black12,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
