import 'package:flutter/material.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Container
          Container(
            color: const Color(0xFFFFFBEA), // Light background color
          ),
          // Scrollable Profile Content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Picture
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/profile_pic.jpg'),
                    ),
                    const SizedBox(height: 16),
                    // Name
                    const Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Bio
                    const Text(
                      'Flutter Developer | Tech Enthusiast',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    // Edit Profile Button
                    ElevatedButton(
                      onPressed: () {
                        // Add edit profile functionality
                      },
                      child: const Text('Edit Profile'),
                    ),
                    const SizedBox(height: 16),
                    // Logout Button
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LogInPage(),
                          ),
                        );
                      },
                      child: const Text('Logout'),
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
