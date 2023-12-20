// ignore_for_file: non_constant_identifier_names, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pbl_stuhealth/Admin/AdminProfil/AdminUmpanMasuk.dart';
// import 'package:pbl_stuhealth/Admin/AdminProfil/AdminUmpanMasuk.dart';

class AdminUmpanBalik extends StatefulWidget {
  const AdminUmpanBalik({super.key});

  @override
  State<AdminUmpanBalik> createState() => _AdminUmpanBalikState();
}

class _AdminUmpanBalikState extends State<AdminUmpanBalik> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          leading: MaterialButton(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 2, 128, 144),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              'Lihat Umpan Balik Aplikasi',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(children: [
          const Row(
            children: [
              Icon(
                Icons.mail,
                color: Color.fromARGB(255, 2, 128, 144),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Umpan Balik',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 2, 128, 144),
                    fontSize: 18),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            height: 1,
            width: double.infinity,
            color: const Color.fromARGB(255, 2, 128, 144),
          ),
///////////////////////////////////////////  Kotak Notif  ///////////////////////////////////////////////////
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('umpanbalik').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              List<QueryDocumentSnapshot> document = snapshot.data!.docs;
              return ListView(
                children: document.map((doc) {
                  String nama = doc['name'];
                  String documentId = doc.id;

                  return KotakNotifikasi(
                    NamaPengirim: nama,
                    documentId: documentId,
                  );
                }).toList(),
              );
            },
          )),
        ]),
      ),
    );
  }
}

////////////////////////////////////////////  Kotak Notif  ///////////////////////////////////////////////////
class KotakNotifikasi extends StatefulWidget {
  const KotakNotifikasi({
    super.key,
    required this.NamaPengirim,
    required this.documentId,
  });

  final String NamaPengirim;
  final String documentId;
  @override
  State<KotakNotifikasi> createState() => _KotakNotifikasiState();
}

class _KotakNotifikasiState extends State<KotakNotifikasi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.NamaPengirim,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
                const Text(
                  'Telah Mengirim Umpan Balik Aplikasi.',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 13),
                )
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AdminUmpanMasuk(documentId: widget.documentId),
                    ));
              },
              icon: const Icon(Icons.chevron_right_outlined))
        ],
      ),
    );
  }
}
