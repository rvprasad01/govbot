import 'package:flutter/material.dart';
import 'chat.dart';
import 'profile.dart'; // Import the file where ChatScreen and ProfileScreen are defined

void main() {
  runApp(ChatBotApp());
}

class ChatBotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBody() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        CardWidget(
          description: 'Description for card 1',
          buttonText: 'Button 1',
          onPressed: () {
            // Action when button 1 is pressed
          },
        ),
        SizedBox(height: 16.0),
        CardWidget(
          description: 'Description for card 2',
          buttonText: 'Button 2',
          onPressed: () {
            // Action when button 2 is pressed
          },
        ),
        SizedBox(height: 16.0),
        CardWidget(
          description: 'Description for card 3',
          buttonText: 'Button 3',
          onPressed: () {
            // Action when button 3 is pressed
          },
        ),
        // Add more CardWidget instances as needed
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}

class CardWidget extends StatelessWidget {
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  CardWidget({
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
