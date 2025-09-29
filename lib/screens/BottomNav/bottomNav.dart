import 'package:digifarm_new/const/clrUtils.dart';
import 'package:digifarm_new/const/imgUtils.dart';
import 'package:digifarm_new/screens/BottomNav/tabs/HomeTab/home_screen.dart';
import 'package:digifarm_new/screens/comingsoon/coming_soon.dart';
import 'package:digifarm_new/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ComingSoonScreen(),
    ComingSoonScreen(),
    // Screen(title: 'Search'),
    // Screen(title: 'Favorites'),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ClrUtils.bottomNav,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              ImgUtils.homeIcon,
              color: _currentIndex == 0 ? Colors.white : Colors.grey[500],
              height: 24,
              width: 24,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImgUtils.shopIcon,
              color: _currentIndex == 1 ? Colors.white : Colors.grey[500],
              height: 24,
              width: 24,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImgUtils.cartIcon,
              color: _currentIndex == 2 ? Colors.white : Colors.grey[500],
              height: 24,
              width: 24,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              ImgUtils.accountIcon,
              color: _currentIndex == 3 ? Colors.white : Colors.grey[500],
              height: 24,
              width: 24,
            ),
            label: '',
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}

class Screen extends StatelessWidget {
  final String title;

  const Screen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.teal,
      ),
      body: Center(child: Text(title)),
    );
  }
}
