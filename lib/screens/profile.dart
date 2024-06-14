import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blueAccent, // Customize app bar color
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, size: 50, color: Colors.blueAccent), // User icon
                SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87, // Text color
                      ),
                    ),
                    Text(
                      'JohnDoe',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Email:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87, // Text color
                      ),
                    ),
                    Text(
                      'johndoe@example.com',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: () {
                // Action to change password
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Customize button color
              ),
              icon: Icon(Icons.lock_open),
              label: Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton.icon(
              onPressed: () {
                // Action to logout
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent, // Customize button color
              ),
              icon: Icon(Icons.logout),
              label: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            // Add other profile options and details as needed
          ],
        ),
      ),
    );
  }
}
