import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _messages = [];
  final stt.SpeechToText _speech = stt.SpeechToText();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _messages[index],
                    style: TextStyle(fontSize: 16.0),
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.grey[200],
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: _speech.isListening ? Icon(Icons.mic_none) : Icon(Icons.mic),
                    onPressed: _toggleListening,
                    color: Colors.blue,
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      _sendMessage(_textController.text);
                    },
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String message) async {
    setState(() {
      _messages.add("You: $message");
      _textController.clear();
    });

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/chat/'), // Replace with your Django API URL
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'query': message,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final String answer = data['answer'];
        setState(() {
          _messages.add("GovBot: $answer");
        });
      } else {
        throw Exception('Failed to send message');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _toggleListening() async {
    if (!_speech.isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('status: $val'),
        onError: (val) => print('error: $val'),
      );
      if (available) {
        _speech.listen(
          onResult: (val) => setState(() {
            _textController.text = val.recognizedWords;
          }),
        );
      }
    } else {
      _speech.stop();
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: ChatScreen(),
  ));
}
