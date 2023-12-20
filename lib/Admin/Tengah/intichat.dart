import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pbl_stuhealth/Admin/AdminChat/AdminChatToUser.dart';

class AdminHalamanChat extends StatefulWidget {
  const AdminHalamanChat({super.key});

  @override
  State<AdminHalamanChat> createState() => _AdminHalamanChatState();
}

class _AdminHalamanChatState extends State<AdminHalamanChat> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final bodyHeight = mediaQueryHeight;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 25, top: 70),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(64, 158, 158, 158),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(4, 4))
                ]),
            height: bodyHeight * 0.14,
            width: double.infinity,
            child: const Text(
              'Pesan Masuk',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Error');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading...');
                }
                return ListView(
                  padding: const EdgeInsets.all(0),
                  children: snapshot.data!.docs
                      .map<Widget>((doc) => _buildUserListItem(doc))
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserListItem(QueryDocumentSnapshot<Object?> document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chat_rooms')
            .doc(_auth.currentUser!.uid + '_' + data['uid'])
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .limit(1)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          var lastMessage = snapshot.data!.docs.firstOrNull;

          print(
              'lastMessage: $lastMessage'); // Add this line to print the content

          String lastMessageText = lastMessage?['message'] ?? 'Belum ada pesan';

          return Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminChatToUser(
                      receiverUserEmail: data['username'],
                      receiverUserID: data['uid'],
                      chatBot: '',
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        border: Border.all(
                          color: const Color.fromARGB(255, 2, 128, 144),
                        )),
                    child: const Icon(
                      Icons.person,
                      size: 30,
                      color: Color.fromARGB(255, 2, 128, 144),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['username'],
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          lastMessageText,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          _formatTimestamp(lastMessage?['timestamp']),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }

  String _formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) {
      return '';
    }

    DateTime dateTime = timestamp.toDate();
    String formattedTime =
        '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';

    return formattedTime;
  }
}
