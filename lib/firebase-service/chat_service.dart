import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pbl_stuhealth/firebase-service/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverUsername, String message,
      [String? imageUrl]) async {
    try {
      // Get Current user info
      final String currentUserId = _firebaseAuth.currentUser!.uid;
      final String currentEmail = _firebaseAuth.currentUser!.email.toString();
      final Timestamp timestamp = Timestamp.now();

      // create a new message
      Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentEmail,
        receiverId: receiverUsername, // Use username instead of UID
        timestamp: timestamp,
        message: message,
      );

      // construct chat room id from user
      List<String> usernames = [currentUserId, receiverUsername];
      usernames.sort();
      String chatRoomId = usernames.join("_");

      // add new message to database
      await _firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .add(newMessage.toMap());
    } catch (e) {
      print('Error sending message: $e');
      // Handle error as needed
    }
  }

  Future<void> deleteMessage(
      String username, String otherUsername, String messageId,
      [bool? bool]) async {
    try {
      List<String> usernames = [username, otherUsername];
      usernames.sort();
      String chatRoomId = usernames.join('_');

      await _firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .doc(messageId)
          .delete();
    } catch (e) {
      print('Error deleting message: $e');
      // Handle error as needed
    }
  }

  Stream<QuerySnapshot> getMessages(String username, String otherUsername) {
    List<String> usernames = [username, otherUsername];
    usernames.sort();
    String chatRoomId = usernames.join('_');

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
