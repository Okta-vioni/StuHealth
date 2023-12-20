import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pbl_stuhealth/Admin/AdminChat/AdminPengajuanKonsultasi.dart';

class AdminKonsultasi extends StatefulWidget {
  const AdminKonsultasi({super.key});

  @override
  State<AdminKonsultasi> createState() => _AdminKonsultasiState();
}

class _AdminKonsultasiState extends State<AdminKonsultasi> {
  final user = FirebaseAuth.instance.currentUser!;
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
              'Formulir Masuk',
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
                FirebaseFirestore.instance.collection('konsultasi').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              List<QueryDocumentSnapshot> document = snapshot.data!.docs;
              return Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: ListView(
                  padding: EdgeInsets.only(top: 0),
                  children: document.map((doc) {
                    String nama = doc['nama'];
                    String documentId = doc.id;

                    return KolomKonsultasiChat(
                      Nama: nama,
                      documentId: documentId,
                    );
                  }).toList(),
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////  Kolom Konsultasi Chat /////////////////////////////////////////////////
class KolomKonsultasiChat extends StatefulWidget {
  const KolomKonsultasiChat(
      {super.key, required this.Nama, required this.documentId});

  final String Nama;
  final String documentId;
  @override
  State<KolomKonsultasiChat> createState() => _KolomKonsultasiChatState();
}

class _KolomKonsultasiChatState extends State<KolomKonsultasiChat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminPengajuanKonsultasi(
                  documentId: widget.documentId,
                ),
              ));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.Nama,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w700)),
                  const Text('Telah mengajukan konsultasi kesehatan.',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 12))
                ],
              ),
            ),
            Icon(Icons.chevron_right_outlined),
          ],
        ),
      ),
    );
  }
}
