// import 'package:flutter/material.dart';
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   bool _isPasswordVisible = false; // Track password visibility
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF1B1B2F), // Dark background
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Logo and Title
//                 Column(
//                   children: [
//                     Icon(
//                       Icons.link, // Replace with your custom logo
//                       color: Color(0xFFF72585),
//                       size: 80,
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       "your logo",
//                       style: TextStyle(
//                         color: Color(0xFFF72585),
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 30),
//                 // Login Card
//                 Container(
//                   padding: EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Color(0xFF162447),
//                     borderRadius: BorderRadius.circular(25),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.5),
//                         blurRadius: 10,
//                         offset: Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Login",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       // Email Input
//                       TextField(
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.mail, color: Colors.white70),
//                           hintText: "Email Address",
//                           hintStyle: TextStyle(color: Colors.white70),
//                           filled: true,
//                           fillColor: Color(0xFF1F4068),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       SizedBox(height: 20),
//                       // Password Input
//                       TextField(
//                         obscureText: !_isPasswordVisible, // Use visibility toggle
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.lock, color: Colors.white70),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _isPasswordVisible
//                                   ? Icons.visibility
//                                   : Icons.visibility_off,
//                               color: Colors.white70,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _isPasswordVisible = !_isPasswordVisible;
//                               });
//                             },
//                           ),
//                           hintText: "Password",
//                           hintStyle: TextStyle(color: Colors.white70),
//                           filled: true,
//                           fillColor: Color(0xFF1F4068),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       SizedBox(height: 10),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: Text(
//                           "Forgot Password",
//                           style: TextStyle(color: Colors.white70, fontSize: 14),
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       // Login Button
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             // Add your login action here
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xFFF72585),
//                             padding: EdgeInsets.symmetric(vertical: 15),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                           ),
//                           child: Text(
//                             "Login",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 // Divider with OR
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Divider(
//                         color: Colors.white24,
//                         thickness: 1,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       child: Text(
//                         "OR",
//                         style: TextStyle(color: Colors.white70),
//                       ),
//                     ),
//                     Expanded(
//                       child: Divider(
//                         color: Colors.white24,
//                         thickness: 1,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 // Social Media Icons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _buildSocialIcon(Icons.g_translate, Color(0xFFDB4437)), // Google
//                     SizedBox(width: 20),
//                     _buildSocialIcon(Icons.facebook, Color(0xFF4267B2)), // Facebook
//                     SizedBox(width: 20),
//                     _buildSocialIcon(Icons.alternate_email, Color(0xFF1DA1F2)), // Twitter
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSocialIcon(IconData icon, Color color) {
//     return Container(
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         shape: BoxShape.circle,
//       ),
//       child: Icon(icon, color: color),
//     );
//   }
// }

// ---------------------------------------------------------------------

// import 'package:flutter/material.dart';
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   bool _isPasswordVisible = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1B1F2A), // Dark background color
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Top Container with Custom Shape
//                 Stack(
//                   children: [
//                     // Top Shaped Container
//                     ClipPath(
//                       clipper: TopShapeClipper(),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Container(
//                           height: 200,
//                           width: double.infinity,
//                           color: const Color(0xFF23283A), // Dark gray color
//                           child: const Padding(
//                             padding: EdgeInsets.all(20),
//                             child: Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 "Login",
//                                 style: TextStyle(
//                                   fontSize: 28,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 // Bottom Container with Login Form
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF23283A), // Container background color
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           blurRadius: 10,
//                           offset: const Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Email Field
//                         TextField(
//                           decoration: InputDecoration(
//                             prefixIcon: const Icon(Icons.mail, color: Colors.white70),
//                             hintText: "Email Address",
//                             hintStyle: const TextStyle(color: Colors.white70),
//                             filled: true,
//                             fillColor: const Color(0xFF1B1F2A),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                         const SizedBox(height: 20),
//
//                         // Password Field
//                         TextField(
//                           obscureText: !_isPasswordVisible,
//                           decoration: InputDecoration(
//                             prefixIcon: const Icon(Icons.lock, color: Colors.white70),
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _isPasswordVisible
//                                     ? Icons.visibility
//                                     : Icons.visibility_off,
//                                 color: Colors.white70,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _isPasswordVisible = !_isPasswordVisible;
//                                 });
//                               },
//                             ),
//                             hintText: "Password",
//                             hintStyle: const TextStyle(color: Colors.white70),
//                             filled: true,
//                             fillColor: const Color(0xFF1B1F2A),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                           style: const TextStyle(color: Colors.white),
//                         ),
//
//                         const SizedBox(height: 10),
//
//                         // Forgot Password
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: TextButton(
//                             onPressed: () {},
//                             child: const Text(
//                               "Forgot Password?",
//                               style: TextStyle(color: Colors.white70),
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(height: 20),
//
//                         // Login Button
//                         ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.pinkAccent, // Button background color
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 100, vertical: 15),
//                           ),
//                           child: const Text(
//                             "Login",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // OR Divider
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Expanded(
//                       child: Divider(
//                         color: Colors.white70,
//                         thickness: 0.5,
//                         endIndent: 10,
//                       ),
//                     ),
//                     const Text(
//                       "OR",
//                       style: TextStyle(color: Colors.white70),
//                     ),
//                     const Expanded(
//                       child: Divider(
//                         color: Colors.white70,
//                         thickness: 0.5,
//                         indent: 10,
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Social Media Icons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _buildSocialMediaIcon(Icons.g_mobiledata, Colors.red),
//                     const SizedBox(width: 20),
//                     _buildSocialMediaIcon(Icons.facebook, Colors.blue),
//                     const SizedBox(width: 20),
//                     _buildSocialMediaIcon(Icons.ac_unit, Colors.lightBlue),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Helper method to build social media icons
//   Widget _buildSocialMediaIcon(IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: const BoxDecoration(
//         color: Colors.white10,
//         shape: BoxShape.circle,
//       ),
//       child: Icon(icon, size: 30, color: color),
//     );
//   }
// }
//
// // Custom Clipper for the Top Container
// class TopShapeClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, size.height); // Start from the top-left
//     path.lineTo(size.width * 0.75, size.height); // Bottom-right corner
//     path.quadraticBezierTo(
//       size.width, // Control point x
//       size.height * 0.5, // Control point y
//       size.width * 0.5, // End point x
//       0, // End point y
//     );
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

import 'package:flutter/material.dart';
import 'package:project_practice/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Service/login_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isPasswordVisible = false; // Toggle visibility of the password field
  final LoginService _loginService = LoginService();
  bool _isLoading = false; // To show loading state during API call

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // void _handleLogin() {
  //   final String username = _usernameController.text.trim();
  //   final String password = _passwordController.text.trim();
  //
  //   // Simple validation
  //   if (username.isEmpty || password.isEmpty) {
  //     _showSnackbar("Username and password cannot be empty");
  //     return;
  //   }
  //
  //   // Simulate login process (replace with actual API call)
  //   if (username == "admin" && password == "1234") {
  //     _showSnackbar("Login Successful!");
  //     // Navigate to dashboard or home screen
  //     Navigator.pushReplacementNamed(context, '/home');
  //   } else {
  //     _showSnackbar("Invalid username or password");
  //   }
  // }

  void _handleLogin() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    // Simple validation
    if (username.isEmpty || password.isEmpty) {
      _showSnackbar("Username and password cannot be empty");
      return;
    }

    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      // Call the login service
      final Map<String, dynamic> userData = await _loginService.login(username, password);
      int userId = userData['id'];

      // Check if the user is a "Customer"
      if (userData['role'] == 'CUSTOMER') {
        _showSnackbar("Login Successful!");

        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('userId', userId);

        // Navigate to home/dashboard screen
        Navigator.pushReplacementNamed(context, '/home', arguments: userId);
      } else {
        _showSnackbar("Only customers can log in.");
      }
    } catch (e) {
      _showSnackbar("Login failed: $e");
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }



  // Method to display a Snackbar
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/background.png'),
                  fit: BoxFit.fill
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 30,
                    width: 80,
                    height: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/light-1.png')
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 140,
                    width: 80,
                    height: 150,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/light-2.png')
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 40,
                    top: 45,
                    width: 80,
                    height: 150,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/clock.png')
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(top: 65),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: AppColors.background,
                            fontSize: 40,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(143, 148, 251, 0.2),
                          blurRadius: 20.0,
                          offset: Offset(0, 10),
                        ),
                      ]
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
                          ),
                          child: TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 15),
                              border: InputBorder.none,
                              hintText: "Username",
                              hintStyle: TextStyle(color: Colors.grey[400])
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            obscureText: !_isPasswordVisible,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15), // Adjust vertical padding
                              // contentPadding: EdgeInsets.only(left: 15),
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 45),
                  // GestureDetector(
                  //   onTap: () {
                  //
                  //   },
                  //   child: Container(
                  //     height: 50,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       gradient: LinearGradient(
                  //         colors: [
                  //           AppColors.secondary,
                  //           AppColors.secondary.withOpacity(0.6)
                  //         ],
                  //       ),
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         "Login",
                  //         style: TextStyle(
                  //           color: AppColors.background,
                  //           fontWeight: FontWeight.bold
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, // Make the background transparent
                      elevation: 0, // Remove the default elevation
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.zero, // Remove any extra padding from the button
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.secondary,
                            AppColors.secondary.withOpacity(0.6),
                          ],
                        ),
                      ),
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: AppColors.background,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  // TextButton(
                  //   onPressed: () {  },
                  //   child: Text(
                  //     "Sign Up",
                  //     style: TextStyle(
                  //         color: AppColors.secondary,
                  //         fontWeight: FontWeight.bold
                  //     ),
                  //   ),
                  // ),
                  TextButton(
                    onPressed: () {
                      // Add your button tap action here, e.g., navigating to a new screen or triggering a signup
                      Navigator.pushNamed(context, "/register");
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.secondary, padding: EdgeInsets.zero, // Remove any extra padding from the button
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
