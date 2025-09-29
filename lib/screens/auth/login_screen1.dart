import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digifarm_new/const/clrUtils.dart';
import 'package:digifarm_new/const/imgUtils.dart';
import 'package:digifarm_new/screens/BottomNav/bottomNav.dart';
import 'package:digifarm_new/screens/auth/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen1 extends StatefulWidget {
  @override
  State<LoginScreen1> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen1> {
  bool _isPasswordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; // A flag to control loader visibility


  // Login function
  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog("Email and Password cannot be empty");
      return;
    }
    setState(() {
      _isLoading = true; // Show loader
    });
    try {
      // Sign in with email and password using FirebaseAuth
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if the user is authenticated
      if (userCredential.user != null) {
        // Fetch user data from Firestore (optional, if needed)
        var userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if (userData.exists) {
          // User authenticated successfully, navigate to BottomNavScreen
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
            return BottomNavScreen();
          }));
        } else {
          // If user data is not found in Firestore
          _showErrorDialog("User data not found in Firestore");
        }
      }
    } catch (error) {
      // Handle login errors
      _showErrorDialog("Invalid Email or Password");
      print("Login Error: $error");
    }
  }

  // Show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImgUtils.login), // Replace with your background image
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            color: Colors.grey.withOpacity(0.1),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png', // Replace with your logo asset
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Email Field
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Password Field
                    TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Handle Forgot Password
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Login Button
                    _isLoading
                        ? SpinKitWaveSpinner(
                      color: Colors.white, // Choose your loader color
                      size: 80.0, // Adjust size as needed
                    )
                        : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ClrUtils.bottomNav,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return SignupScreen(); // Navigate to SignUp screen
                                }));
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: ClrUtils.green3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:digifarm_new/screens/auth/signup_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:digifarm_new/const/clrUtils.dart';
// import 'package:digifarm_new/const/imgUtils.dart';
// import 'package:digifarm_new/screens/BottomNav/bottomNav.dart';
//
// class LoginScreen1 extends StatefulWidget {
//   @override
//   State<LoginScreen1> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen1> {
//   bool _isPasswordVisible = false;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   // Login function
//   Future<void> _login() async {
//     String email = _emailController.text;
//     String password = _passwordController.text;
//
//     if (email.isEmpty || password.isEmpty) {
//       _showErrorDialog("Email and Password cannot be empty");
//       return;
//     }
//
//     // Add your API call here for login
//     // Example: await API_Services().login(email, password);
//
//     // If login is successful, navigate to the next screen (BottomNavScreen)
//     // For now, just navigate to BottomNavScreen directly as a placeholder
//     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
//       return BottomNavScreen();
//     }));
//   }
//
//   // Show error dialog
//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Error'),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(ImgUtils.login),
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//           Container(
//             color: Colors.grey.withOpacity(0.1),
//           ),
//           Center(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     // Logo and Title
//                     Column(
//                       children: [
//                         Image.asset(
//                           'assets/images/logo.png', // Replace with your logo asset
//                           height: 100,
//                           width: 100,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 40),
//                     // Login Form
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Login',
//                           style: TextStyle(
//                             fontSize: 24,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         // Email Field
//                         TextField(
//                           controller: _emailController,
//                           decoration: InputDecoration(
//                             hintText: 'Enter your email',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             filled: true,
//                             fillColor: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         // Password Field
//                         TextField(
//                           controller: _passwordController,
//                           obscureText: !_isPasswordVisible,
//                           decoration: InputDecoration(
//                             hintText: 'Password',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             filled: true,
//                             fillColor: Colors.white,
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _isPasswordVisible
//                                     ? Icons.visibility
//                                     : Icons.visibility_off,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _isPasswordVisible = !_isPasswordVisible;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         // Forgot Password
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: TextButton(
//                             onPressed: () {
//                               // Handle Forgot Password
//                             },
//                             child: Text(
//                               'Forgot Password?',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     // Login Button
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: _login,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: ClrUtils.bottomNav,
//                           padding: const EdgeInsets.symmetric(vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: Text(
//                           'Login',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     // Register Text
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Don't have an account?",
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) {
//                                   return SignupScreen();
//                                 }));
//                           },
//                           child: Text(
//                             'Register',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: ClrUtils.green3,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:digifarm_new/const/clrUtils.dart';
// // import 'package:digifarm_new/controllers/signup_controller.dart';
// // import 'package:digifarm_new/routes/app_routes.dart';
// // import 'package:digifarm_new/screens/BottomNav/bottomNav.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// //
// // class LoginScreen1 extends StatelessWidget {
// //   final SignupController signupController = Get.put(SignupController());
// //
// //   LoginScreen1({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: SingleChildScrollView(
// //         child: Container(
// //           child: Column(
// //             children: <Widget>[
// //               Container(
// //                 margin: const EdgeInsets.only(top: 50),
// //                 child: const Center(
// //                   child: Text(
// //                     "Login",
// //                     style: TextStyle(
// //                       color: Colors.black,
// //                       fontSize: 40,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(30.0),
// //                 child: Column(
// //                   children: <Widget>[
// //                     Container(
// //                       padding: const EdgeInsets.all(5),
// //                       decoration: BoxDecoration(
// //                         color: Colors.white,
// //                         borderRadius: BorderRadius.circular(10),
// //                         boxShadow: [
// //                           BoxShadow(
// //                             color: const Color.fromRGBO(143, 148, 251, .2),
// //                             blurRadius: 20.0,
// //                             offset: const Offset(0, 10),
// //                           )
// //                         ],
// //                       ),
// //                       child: Column(
// //                         children: <Widget>[
// //                           Obx(
// //                                 () => Container(
// //                               padding: const EdgeInsets.all(8.0),
// //                               decoration: BoxDecoration(
// //                                 border: Border(
// //                                   bottom: BorderSide(
// //                                     color: Colors.grey.shade100,
// //                                   ),
// //                                 ),
// //                               ),
// //                               child: TextField(
// //                                 controller: signupController.emailController,
// //                                 onChanged: signupController.validateEmail,
// //                                 keyboardType: TextInputType.emailAddress,
// //                                 decoration: InputDecoration(
// //                                   errorText: signupController.isEmailValid.value
// //                                       ? null
// //                                       : 'Enter a valid email',
// //                                   border: InputBorder.none,
// //                                   hintText: "Email",
// //                                   hintStyle: TextStyle(color: Colors.grey[400]),
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                           Obx(
// //                                 () => Container(
// //                               padding: const EdgeInsets.all(8.0),
// //                               child: TextField(
// //                                 controller: signupController.passwordController,
// //                                 onChanged: signupController.validatePassword,
// //                                 keyboardType: TextInputType.visiblePassword,
// //                                 decoration: InputDecoration(
// //                                   errorText: signupController
// //                                       .isPasswordValid.value
// //                                       ? null
// //                                       : 'Password must be at least 6 characters',
// //                                   border: InputBorder.none,
// //                                   hintText: "Password",
// //                                   hintStyle: TextStyle(color: Colors.grey[400]),
// //                                 ),
// //                                 obscureText: true,
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     const SizedBox(height: 10),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.end,
// //                       children: [
// //                         GestureDetector(
// //                           onTap: () {
// //                             // Implement forgot password functionality here
// //                           },
// //                           child: const Text(
// //                             "Forgot Password?",
// //                             style: TextStyle(
// //                               color: Color.fromRGBO(143, 148, 251, 1),
// //                             ),
// //                           ),
// //                         )
// //                       ],
// //                     ),
// //                     const SizedBox(height: 30),
// //                     GestureDetector(
// //                       onTap: () {
// //                         signupController.isLoading.value = true;
// //                         FirebaseAuth.instance
// //                             .signInWithEmailAndPassword(
// //                           email: signupController.emailController.text.trim(),
// //                           password: signupController.passwordController.text
// //                               .trim(),
// //                         )
// //                             .then((result) async {
// //                           // Fetch user data from Firestore
// //                           var userData = await FirebaseFirestore.instance
// //                               .collection('users')
// //                               .doc(result.user?.uid)
// //                               .get();
// //
// //                           if (userData.exists) {
// //                             signupController.isLoading.value = false;
// //                             print("Login Successful: ${userData.data()}");
// //                             Get.toNamed(AppRoutes.bottomNav);
// //                             Get.snackbar(
// //                               "Login Successful",
// //                               "Welcome back!",
// //                               snackPosition: SnackPosition.TOP,
// //                             );
// //                           } else {
// //                             signupController.isLoading.value = false;
// //                             print("User data not found");
// //                             Get.snackbar(
// //                               "Error",
// //                               "User data not found. Please register.",
// //                               snackPosition: SnackPosition.TOP,
// //                             );
// //                           }
// //                         }).catchError((error) {
// //                           signupController.isLoading.value = false;
// //                           Get.snackbar(
// //                             "Error",
// //                             "Invalid Email or Password",
// //                             snackPosition: SnackPosition.TOP,
// //                           );
// //                           print("Error: $error");
// //                         });
// //                       },
// //                       child: Container(
// //                         height: 50,
// //                         decoration: BoxDecoration(
// //                           borderRadius: BorderRadius.circular(10),
// //                           gradient: LinearGradient(
// //                             colors: [
// //                               ClrUtils.primaryColor,
// //                               const Color.fromRGBO(143, 148, 251, .6),
// //                             ],
// //                           ),
// //                         ),
// //                         child: Center(
// //                           child: Obx(
// //                                 () => signupController.isLoading.value
// //                                 ? const SizedBox(
// //                               height: 24,
// //                               width: 24,
// //                               child: CircularProgressIndicator(
// //                                 strokeWidth: 2,
// //                                 color: Colors.white,
// //                               ),
// //                             )
// //                                 : const Text(
// //                               "Login",
// //                               style: TextStyle(
// //                                 color: Colors.white,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                     const SizedBox(height: 50),
// //                     GestureDetector(
// //                       onTap: () {
// //                         // Navigate to SignUp screen
// //                         Get.toNamed(AppRoutes.signup);
// //                       },
// //                       child: const Text(
// //                         "Create Account",
// //                         style: TextStyle(
// //                           color: Color.fromRGBO(143, 148, 251, 1),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               )
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
