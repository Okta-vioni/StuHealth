// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pbl_stuhealth/bagian-chat/formPendaftarKonsultasi.dart';
import 'package:pbl_stuhealth/bagian-chat/UserChatToAdmin.dart';
import 'package:pbl_stuhealth/tengah/inti.dart';

class HalamanChat extends StatefulWidget {
  const HalamanChat({super.key});

  @override
  State<HalamanChat> createState() => _HalamanChatState();
}

class _HalamanChatState extends State<HalamanChat> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //fetch doctor
  late Stream<QuerySnapshot> doctorStream;

  @override
  void initState() {
    super.initState();
    doctorStream = FirebaseFirestore.instance.collection('dokter').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final bodyHeight = mediaQueryHeight;
    return WillPopScope(
      onWillPop: () async {
        // Navigate to another page when the back button is pressed
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IntiAplikasi()),
        );

        // Return false to prevent the default system back navigation
        return false;
      },
      child: Scaffold(
          body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 70, left: 25),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
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
              'Konsultasi Kesehatan Mahasiswa',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                  color: Colors.black),
            ),
          ),
          ////////////////////////////////////////////////////////  Foto Atas  ///////////////////////////////////////////////
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: const Text(
                        'Mari Konsultasi Masalah Kesehatan mu!',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(35),
                      child: Image.asset('img/Forumchat.png'),
                    ),
                    Container(
                      width: double.infinity,
                      height: 2,
                      color: const Color.fromARGB(255, 2, 128, 144),
                    )
                  ]),
                ),

                //////////////////////////////////////////////////////////  Isi Bawah  ////////////////////////////////////////////////////////////////////

                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: const Text(
                          'Chat Dengan Unit Kesehatan Kampus',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Untuk keperluan emergency service, kebutuhan obat dan vitamin, peminjaman barang kesehatan dan pelayanan kesehatan.',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                        textAlign: TextAlign.justify,
                      ),
                      /////////////////////////////////////////////////////  Jam Operasi  ///////////////////////////////////////////////////////////
                      Container(
                        child: Text('Jam Operasional',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 15)),
                      ),
                      const Row(
                        children: [
                          Text('Senin - Jumat',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15)),
                          Text(' : Pukul ',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15)),
                          Text('10.00 - 17.00 WIB',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15))
                        ],
                      ),
                    ],
                  ),
                ),

                ////////////////////////////////////////////////////////  Chat  ////////////////////////////////////////////////////
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color: const Color.fromARGB(255, 2, 128, 144))),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          border: Border.all(
                              color: const Color.fromARGB(255, 2, 128, 144)),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.person_outlined,
                          color: Color.fromARGB(255, 2, 128, 144),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Error');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Text('Loading...');
                              }

                              var adminList = snapshot.data!.docs.where((doc) {
                                var data = doc.data() as Map<String, dynamic>;
                                var email = data['email'] as String;
                                return email.endsWith('@admin.com');
                              }).toList();

                              return ListView(
                                padding: EdgeInsets.all(0),
                                children: adminList
                                    .map<Widget>(
                                        (doc) => _buildAdminListItem(doc))
                                    .toList(),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ////////////////////////////////  Konsultasi Dokter  ///////////////////////////////
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 10),
                        child: const Text(
                          'Konsultasi Dengan Dokter',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        ),
                      ),
                      /////////////////////////////////////////  Jam Operasi  //////////////////////
                      Text('Jam Operasional',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 15)),
                      const Row(
                        children: [
                          Text('Senin & Jumat',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15)),
                          Text(' : Pukul ',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15)),
                          Text('10.00 - 16.00 WIB',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15))
                        ],
                      ),
                      ///////////////////////////////  Konsultasi Dengan Dokter  ////////////////////
                    ],
                  ),
                ),

                ///////////////////////////  Dokter  ////////////////////////////////////////////////////
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  padding: EdgeInsets.all(0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 500,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: doctorStream,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              return ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    var document = snapshot.data!.docs[index];
                                    var documentId = document.id;

                                    return Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 20),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 2, 128, 144)),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10))),
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                        child: Image.network(
                                                          document['image'],
                                                          width: 120,
                                                          height: 120,
                                                          fit: BoxFit
                                                              .cover, // This ensures the image fills the dimensions without stretching
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              document['nama'],
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 15),
                                                            ),
                                                            Text(
                                                              document[
                                                                  'kategori'],
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize: 12),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                                document[
                                                                    'status'],
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        2,
                                                                        128,
                                                                        144),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        15)),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                    'Tersedia untuk :',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            2,
                                                                            128,
                                                                            144),
                                                                        fontSize:
                                                                            12)),
                                                                SizedBox(
                                                                    width: 5),
                                                                Text(
                                                                    document[
                                                                        'limit'],
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            2,
                                                                            128,
                                                                            144),
                                                                        fontSize:
                                                                            12)),
                                                                SizedBox(
                                                                    width: 5),
                                                                Text('Orang',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            2,
                                                                            128,
                                                                            144),
                                                                        fontSize:
                                                                            12))
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                /////////////////////////////////////////////////  Tombol Konsultasi  //////////////////////////////////////////
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: document[
                                                                  'limit'] ==
                                                              '0'
                                                          ? Color.fromARGB(
                                                              122, 2, 128, 144)
                                                          : Color.fromARGB(
                                                              255,
                                                              2,
                                                              128,
                                                              144), // Change color as needed
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              bottom: Radius
                                                                  .circular(
                                                                      10))),
                                                  child: MaterialButton(
                                                    onPressed: document[
                                                                'limit'] ==
                                                            '0'
                                                        ? null // Button is disabled
                                                        : () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        FormPendaftaranKonsultasi(
                                                                  documentId:
                                                                      documentId,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                    minWidth: double.infinity,
                                                    // Change color as needed
                                                    child: Text(
                                                      'Daftar Konsultasi >>',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget _buildAdminListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      return MaterialButton(
          child: const Text(
            'Chat Unit Kesehatan Kampus',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 15),
          ),
          onPressed: () {
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserChatToAdmin(
                    receiverUserEmail: data['username'],
                    receiverUserID: data['uid'],
                  ),
                ),
              );
            }
          });
    } else {
      return Container();
    }
  }
}
