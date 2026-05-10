import 'package:flutter/material.dart';
import 'dart:async'; 
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    _startSplashTimer();
  }

  
  void _startSplashTimer() {
    const splashDuration = Duration(seconds: 3);
    Timer(splashDuration, _navigateToNextScreen);
  }

  void _navigateToNextScreen() {
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.eco, 
              size: 100,
              color: Colors.lightGreenAccent,
            ),
            SizedBox(height: 24),
            
            
            Text(
              "AGRI-MONITOR",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Provincial Supply System",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.5,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 48),
            
            
            CircularProgressIndicator(
              color: Colors.lightGreenAccent,
            ),
          ],
        ),
      ),
    );
  }
}