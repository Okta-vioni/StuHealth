import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pbl_stuhealth/firebase-service/chat_service.dart';

class AdminChatToUser extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  final String chatBot;

  const AdminChatToUser({
    super.key, // Fix key parameter
    required this.chatBot,
    required this.receiverUserEmail,
    required this.receiverUserID,
  });

  @override
  State<AdminChatToUser> createState() => _AdminChatToUserState();
}

class _AdminChatToUserState extends State<AdminChatToUser> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    // Set the initial text of _messageController to the value of chatBot
    _messageController.text = widget.chatBot;
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.receiverUserID,
        _messageController.text,
      );

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.receiverUserEmail,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Color.fromARGB(255, 2, 128, 144),
        elevation: 5,
        shadowColor: Colors.white,
      ),
      body: Column(
        children: [
          // Message List
          Expanded(
            child: _buildMessageList(),
          ),
          // User Input
          _buildMessageInput(),
        ],
      ),
    );
  }

  // Build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
        widget.receiverUserID,
        _firebaseAuth.currentUser!.uid,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        // Reverse the list of messages to show the latest at the bottom
        List reversedMessages = List.from(snapshot.data!.docs.reversed);

        return ListView(
          reverse:
              true, // Set reverse to true to show the latest messages at the bottom
          children: reversedMessages
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  // Build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

    if (data == null ||
        data['message'] == null ||
        data['timestamp'] == null ||
        data['senderId'] == null) {
      return Container(); // Return an empty container or handle it appropriately
    }

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    // Check if 'message' is not null before accessing its value

    return Container(
      alignment: alignment,
      child: Column(
        children: [
          GestureDetector(
            onLongPress: () {
              _showDeleteConfirmationDialog(
                  document.id); // Pass the document ID
            },
            child: ChatBubble(
              message: data['message'],
              isUser: (data['senderId'] == _firebaseAuth.currentUser!.uid),
              timestamp: data['timestamp'],
            ),
          ),
        ],
      ),
    );
  }

  // Build message input
  Widget _buildMessageInput() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 0),
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 10),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.grey)),
              child: TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Enter Message',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(Icons.send_outlined),
          )
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(String messageId) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus Pesan?',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Apakah kamu yakin ingin menghapus pesan ini?',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 15),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 2, 128, 144),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: MaterialButton(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    onPressed: () async {
                      await _chatService.deleteMessage(
                        widget.receiverUserID,
                        _firebaseAuth.currentUser!.uid,
                        messageId,
                        true, // Delete for everyone
                      );
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Hapus Pesan',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

//////////////////////////////////////////////// Chat Bubble /////////////////////////
class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final Timestamp timestamp;

  ChatBubble({
    super.key,
    required this.message,
    required this.isUser,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat.Hm().format(timestamp.toDate());

    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 350),
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
              borderRadius: isUser
                  ? BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))
                  : BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
              color: isUser
                  ? const Color.fromARGB(255, 2, 128, 144)
                  : Colors.white,
            ),
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: isUser
                        ? Colors.white
                        : const Color.fromARGB(255, 2, 128, 144),
                  ),
                ),
                Text(
                  formattedTime,
                  style: TextStyle(
                    fontSize: 10,
                    color: isUser ? Colors.white : Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
