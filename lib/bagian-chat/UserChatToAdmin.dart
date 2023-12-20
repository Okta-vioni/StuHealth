import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pbl_stuhealth/firebase-service/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserChatToAdmin extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;

  const UserChatToAdmin({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserID,
  });

  @override
  State<UserChatToAdmin> createState() => _UserChatToAdminState();
}

class _UserChatToAdminState extends State<UserChatToAdmin> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          widget.receiverUserEmail,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              fontSize: 18,
              color: Colors.white),
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
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        children: [
          // Text(
          //   data['senderId'],
          // ),
          ChatBubble(
            message: data['message'],
            isUser: (data['senderId'] == _firebaseAuth.currentUser!.uid),
            timestamp: data['timestamp'],
            imageUrl: null,
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
                    hintText: 'Enter Message', border: InputBorder.none),
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
}

////////////////////////////////////////////////  Chat Bubble  /////////////////////////
class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final Timestamp timestamp;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isUser,
    required this.timestamp,
    required imageUrl,
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
