import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digifarm_new/const/clrUtils.dart';
import 'package:digifarm_new/const/size_utils.dart';
import 'package:digifarm_new/routes/app_routes.dart';
import 'package:digifarm_new/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String _name = 'Shariq';
  String _email = 'Shariq123@gmail.com';

  // Function to fetch user data from Firestore
  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Get user data from Firestore
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userData.exists) {
          print('User data fetched: ${userData.data()}');
          setState(() {
            _name = userData['name'] ?? 'No Name';
            _email = user.email ?? 'No Email';
          });
        } else {
          setState(() {
            _name = 'No Name';
            _email = user.email ?? 'No Email';
          });
        }
      } catch (e) {
        print("Error fetching user data: $e");
      }
    } else {
      print("User is not logged in.");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();  // Fetch user data when the screen is initialized
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF325B47), // Dark green background
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF325B47),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _pickImage, // Trigger image picker on tap
            child: Material(
              elevation: 8, // Elevation for shadow effect
              shape: CircleBorder(),
              child: CircleAvatar(
                radius: 90, // Size of the avatar
                backgroundColor: Colors.grey.shade200,
                backgroundImage: _image != null
                    ? FileImage(_image!)
                    : null, // Display picked image
                child: _image == null
                    ? Icon(
                  Icons.camera_alt,
                  color: Colors.grey.shade700,
                  size: 30,
                )
                    : null, // Display icon if no image
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: ScreenSizeUtil.getHeight(context) * 0.4,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildProfileField(
                    icon: Icons.person_outline,
                    label: _name, // Display fetched name
                  ),
                  const SizedBox(height: 10),
                  _buildProfileField(
                    icon: Icons.calendar_today_outlined,
                    label: 'May 06, 2002', // Static, you can fetch date from Firestore too
                  ),
                  const SizedBox(height: 10),
                  _buildProfileField(
                    icon: Icons.email_outlined,
                    label: _email, // Display fetched email
                  ),
                  const SizedBox(height: 10),
                  _buildProfileField(
                    icon: Icons.assignment_outlined,
                    label: 'Field supervisor', // Static, can be fetched from Firestore too
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed(AppRoutes.login);
                       // Ensure proper logout
                    },
                    child: CustomButton(
                      title: 'Logout',
                      color: ClrUtils.green2,
                      width: ScreenSizeUtil.getWidth(context) * 0.6,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileField({required IconData icon, required String label}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.black54),
        const SizedBox(width: 10),
        Container(
          width: ScreenSizeUtil.getWidth(context) * 0.65,
          child: Text(
            label,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
