import 'dart:async';
import 'package:flutter/material.dart';
import '../compontnt/customcontainer.dart';
import 'main_screen.dart';

/// SplashScreen — App start hone pe pehli screen.
///
/// Kya dikhata hai:
/// 1. App logo (existing bmi_logo.png)
/// 2. App name: "Fitness Tracker"
/// 3. Tagline: "Track your fitness journey"
///
/// Animation: FadeTransition + ScaleTransition (smooth entry)
/// 3 second ke baad automatically MainScreen pe navigate hota hai.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // SingleTickerProviderStateMixin — AnimationController ke liye zaroori hai
  // Ye vsync provide karta hai (screen refresh rate se sync)

  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // --- Animation Setup ---
    // Controller: 1.5 second mein animation complete hogi
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Fade: 0 (invisible) → 1 (fully visible)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeIn),
    );

    // Scale: 0.8 (80% size) → 1.0 (full size) with bounce effect
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutBack),
    );

    // Animation start karo
    _animController.forward();

    // 3 second ke baad MainScreen pe navigate karo
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    });
  }

  @override
  void dispose() {
    // AnimationController ko dispose karna zaroori hai — memory leak prevent
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Customcontainer(
        child: Center(
          // FadeTransition — opacity control
          child: FadeTransition(
            opacity: _fadeAnimation,
            // ScaleTransition — size control (nested inside fade)
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // --- Logo ---
                  Container(
                    decoration: const BoxDecoration(),
                    child: Image.asset(
                      'assets/images/bmi_logo.png',
                      width: 120,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // --- App Name ---
                  const Text(
                    'Fitness Tracker',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // --- Tagline ---
                  Text(
                    'Track your fitness journey',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}