
import 'package:digifarm_new/firebase_options.dart';
import 'package:digifarm_new/routes/app_routes.dart';
import 'package:digifarm_new/screens/BottomNav/splash/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:device_preview/device_preview.dart';

import 'screens/dashboardAnalysis/predictive_analysis_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   runApp(
  DevicePreview(
    enabled: false,
    builder: (context) => MyApp(), // Wrap your app
  ),
);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor:  Colors.white, appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,)),

      debugShowCheckedModeBanner: false,

      initialRoute: AppRoutes.splash_screen,
      // home: SplashScreen(),
      getPages: AppRoutes.pages,
    );
  }
}


