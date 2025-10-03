import 'package:flutter/material.dart';
import '../data/mock_data.dart'; // Untuk kPrimaryColor

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  // Data chat dummy
  final List<Map<String, dynamic>> dummyMessages = const [
    {'text': 'Assalamualaikum, saya ingin bertanya tentang paket Umroh Plus Turkey.', 'isMe': true, 'time': '10:00'},
    {'text': 'Waalaikumsalam. Tentu, ada yang bisa kami bantu? Paket itu sangat populer!', 'isMe': false, 'time': '10:02'},
    {'text': 'Berapa harga termurah untuk keberangkatan Januari 2026?', 'isMe': true, 'time': '10:05'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildChatAppBar(context),
      body: Column(
        children: [
          // Daftar Pesan (Chat Bubbles)
          Expanded(
            child: ListView.builder(
              reverse: true, // Agar pesan terbaru di bawah
              padding: const EdgeInsets.all(16.0),
              itemCount: dummyMessages.length,
              itemBuilder: (context, index) {
                final message = dummyMessages.reversed.toList()[index];
                return _ChatMessageBubble(
                  text: message['text'],
                  isMe: message['isMe'],
                  time: message['time'],
                );
              },
            ),
          ),
          // Input Pesan
          _buildMessageInput(),
        ],
      ),
    );
  }

  // Widget Kustom AppBar
  PreferredSizeWidget _buildChatAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 1,
      title: const Row(
        children: [
          CircleAvatar(
            backgroundColor: kPrimaryColor, // Placeholder untuk gambar agen
            child: Icon(Icons.person, color: Colors.white),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Admin Travel', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('Online', style: TextStyle(fontSize: 12, color: kPrimaryColor)),
            ],
          ),
        ],
      ),
      actions: const [
        // Ikon Panggilan/Video
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(Icons.call, color: kPrimaryColor),
        ),
        Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(Icons.videocam, color: kPrimaryColor),
        ),
      ],
    );
  }

  // Widget Input Pesan
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          // Tombol Plus/Attach
          Icon(Icons.add, color: kPrimaryColor),
          const SizedBox(width: 8),
          
          // Input Text
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Tulis pesan...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          
          // Tombol Kirim
          Icon(Icons.send, color: kPrimaryColor),
        ],
      ),
    );
  }
}

// Widget Bubble Chat
class _ChatMessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String time;

  const _ChatMessageBubble({required this.text, required this.isMe, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            margin: const EdgeInsets.symmetric(vertical: 4),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
            decoration: BoxDecoration(
              color: isMe ? kPrimaryColor : Colors.grey.shade300,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: isMe ? const Radius.circular(12) : const Radius.circular(2),
                bottomRight: isMe ? const Radius.circular(2) : const Radius.circular(12),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(color: isMe ? Colors.white : Colors.black),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: isMe ? 0 : 8.0, right: isMe ? 8.0 : 0),
            child: Text(time, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
          ),
        ],
      ),
    );
  }
}