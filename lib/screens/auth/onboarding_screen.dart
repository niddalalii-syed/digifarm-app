import 'package:digifarm_new/const/imgUtils.dart';
import 'package:digifarm_new/const/size_utils.dart';
import 'package:digifarm_new/routes/app_routes.dart';
import 'package:digifarm_new/screens/BottomNav/bottomNav.dart';
import 'package:digifarm_new/screens/auth/login_screen1.dart';
import 'package:digifarm_new/screens/auth/signup_screen.dart';
import 'package:digifarm_new/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  bool isLoading = false;

  void handleLogin() {
    setState(() {
      isLoading = true; // Show the spinner
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false; // Hide the spinner
      });

      // Navigate to the BottomNavScreen
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return LoginScreen1();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Stack(
  
  children: [
     Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    opacity: 1,
                    image: AssetImage(ImgUtils.login),
                    fit: BoxFit.fill,
                    
                  ),
                ),
              ),
    Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 150),
        child: isLoading
            ? Center(
              child: SpinKitWaveSpinner(
                        color: Colors.white,
                        size: 80,
                      ),
            )
            : Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Login Button with Spinner Logic
            InkWell(
              onTap: handleLogin,
              child: CustomButton(
                title: 'Login',
                color: Colors.black,
                height: 76,
                width: ScreenSizeUtil.getWidth(context) * 0.5,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            SizedBox(height: 10),
            // Sign Up Button (no spinner logic here)
            GestureDetector(
              onTap: (){
                Get.offAllNamed(AppRoutes.signup);
              },
              child: CustomButton(
                title: 'Sign up',
                color: Colors.black,
                height: 76,
                width: ScreenSizeUtil.getWidth(context) * 0.5,
                borderRadius: BorderRadius.circular(50),
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