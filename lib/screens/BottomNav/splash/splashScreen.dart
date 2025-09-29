
import 'package:digifarm_new/const/clrUtils.dart';
import 'package:digifarm_new/screens/BottomNav/bottomNav.dart';
import 'package:digifarm_new/screens/auth/onboarding_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay for splash screen (e.g., 3 seconds)
    Future.delayed(Duration(seconds: 3), () {
      // Navigate to the next screen after the delay
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ClrUtils.bottomNav, // Set the background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo Image (use your logo file)
            Image.asset('assets/images/logo.png', width: 200, height: 200),
            
            // SizedBox(height: 20),
            // // Text for the app name
            // Text(
            //   'digifarm_new',
            //   style: TextStyle(
            //     fontSize: 32,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.white,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
