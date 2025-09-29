import 'package:digifarm_new/screens/BottomNav/bottomNav.dart';
import 'package:digifarm_new/screens/BottomNav/splash/splashScreen.dart';
import 'package:digifarm_new/screens/auth/login_screen1.dart';
import 'package:digifarm_new/screens/auth/signup_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String splash_screen = '/splashscreen';
  static const String homescreen = '/homescreen';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String bottomNav = '/bottomNav';

  static List<GetPage> pages = [
// User View Routes
    GetPage(
      name: login,
      page: () => LoginScreen1(),
    ),
    GetPage(
      name: bottomNav,
      page: () => BottomNavScreen(),
    ),
    GetPage(
      name: splash_screen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: signup,
      page: () => SignupScreen(),
    ),

  ];
}
