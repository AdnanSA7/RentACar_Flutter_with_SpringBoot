import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Service/user_service.dart';
import 'colors.dart';
import 'custom_app_bar.dart';
import 'model/user.dart';

class ProfilePage extends StatefulWidget {

  final int userId;

  const ProfilePage({super.key, required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  late int _userId;

  final UserService _userService = UserService();
  User? _user;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserIdFromLocalStorage();
    // _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final userData = await _userService.findUserById(_userId);
      setState(() {
        _user = User.fromJson(userData);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  // Load userId from local storage
  Future<void> _loadUserIdFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final storedUserId = prefs.getInt('userId'); // getInt directly returns an int

    if (storedUserId != null) {
      setState(() {
        _userId = storedUserId; // Directly use storedUserId without parsing
      });
      _fetchUserData(); // Fetch the user data after loading the userId
    } else {
      setState(() {
        _error = "User ID not found in local storage";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: "Profile",
        gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
        ),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(
        child: Text(
          'Error: $_error',
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
      )
          : _user != null
          ? Container(
        margin: EdgeInsets.only(top: 50),
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CircleAvatar(
              radius: 45,
              child: Text(
                _user!.firstName[0],
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 25),
            // _buildUserInfoCard('ID', _user!.id),
            _buildUserInfoCard('First Name', _user!.firstName),
            _buildUserInfoCard('Last Name', _user!.lastName),
            _buildUserInfoCard('Email', _user!.email),
            _buildUserInfoCard('Role', _user!.role),
            _buildUserInfoCard('Phone', _user!.phone),
            const SizedBox(height: 20),
            // You can add more widgets here if needed
          ],
        ),
      )
          : const Center(child: Text('User not found')),
    );
  }

  // Helper method to create the card layout for each field
  Widget _buildUserInfoCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
