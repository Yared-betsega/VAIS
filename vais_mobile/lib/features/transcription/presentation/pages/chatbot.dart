import 'package:flutter/material.dart';
import 'audio_chatbot.dart'; // Make sure this path matches where your TranscribePage is located.
import 'text_chatbot.dart'; // Make sure this path matches where your SecondPage is located.

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    AudioChatbotPage(title: "VAIS"),
    TextChatbotPage(title: "VAIS"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            label: 'በድምጽ ጠይቅ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'በጽሁፍ ጠይቅ',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}
