// ignore_for_file: non_constant_identifier_names, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminUmpanMasuk extends StatefulWidget {
  final String documentId;
  const AdminUmpanMasuk({super.key, required this.documentId});

  @override
  State<AdminUmpanMasuk> createState() => _AdminUmpanMasukState();
}

class _AdminUmpanMasukState extends State<AdminUmpanMasuk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
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
                'Umpan Masuk',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('umpanbalik')
              .doc(widget.documentId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            var data = snapshot.data!.data() as Map<String, dynamic>;

            return Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
///////////////////////////////////////////////////  Biodata  ///////////////////////////////////////////////////
                  const Text('Dari : ',
                      style: TextStyle(
                          color: Color.fromARGB(255, 2, 128, 144),
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w400)),
                  Text(data['name'],
                      style: TextStyle(
                          color: Color.fromARGB(255, 2, 128, 144),
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w700)),
                  Text(data['nim'],
                      style: TextStyle(
                          color: Color.fromARGB(255, 2, 128, 144),
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w700)),
                  Text(data['jurusan'],
                      style: TextStyle(
                          color: Color.fromARGB(255, 2, 128, 144),
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w700)),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    height: 1,
                    width: double.infinity,
                    color: const Color.fromARGB(255, 2, 128, 144),
                  ),
//////////////////////////////////////////////  Pertanyaan Umum ////////////////////////////////////////////
                  Expanded(
                      child: ListView(
                    padding: EdgeInsets.only(bottom: 20),
                    children: [
                      const Text('Pertanyaan Umum',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w700)),
                      const Pertanyaan(
                          IsiPertanyaan:
                              'Bagaimana pendapat Anda tentang tampilan antarmuka aplikasi kami?'),
                      KotakJawaban(IsiJawaban: data['A1']),

                      const Pertanyaan(
                          IsiPertanyaan:
                              'Apakah aplikasi kami mudah digunakan?'),
                      KotakJawaban(IsiJawaban: data['A2']),

                      const Pertanyaan(
                          IsiPertanyaan:
                              'Apakah Anda menemui masalah teknis saat menggunakan aplikasi? Jika ya, mohon jelaskan.'),
                      KotakJawaban(IsiJawaban: data['A3']),

////////////////////////////////////////////  Fitur Aplikasi  ///////////////////////////////////////////
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text('Fitur Aplikasi',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w700)),
                      ),

                      const Pertanyaan(
                          IsiPertanyaan:
                              'Apakah fitur-fitur yang disediakan sangat membantu Anda?'),
                      KotakJawaban(IsiJawaban: data['B1']),

                      const Pertanyaan(
                          IsiPertanyaan:
                              'Apakah Anda memiliki saran untuk meningkatkan fitur-fitur yang ada atau menambahkan fitur baru?'),
                      KotakJawaban(IsiJawaban: data['B2']),

////////////////////////////////////////////////  Kepuasan Layanan  /////////////////////////////////////////
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text('Kepuasan Layanan',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w700)),
                      ),

                      const Pertanyaan(
                          IsiPertanyaan:
                              'Bagaimana pendapat Anda tentang kualitas layanan yang Anda terima melalui aplikasi kami?'),
                      KotakJawaban(IsiJawaban: data['C1']),

                      const Pertanyaan(
                          IsiPertanyaan:
                              'Apakah Anda memiliki saran atau komentar tambahan mengenai layanan kami?'),
                      KotakJawaban(IsiJawaban: data['C2']),

/////////////////////////////////////////  Tambahan  ///////////////////////////////////////////
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text('Tambahan',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w700)),
                      ),

                      const Pertanyaan(
                          IsiPertanyaan:
                              'Apakah ada hal lain yang ingin Anda sampaikan atau saran yang ingin Anda berikan mengenai aplikasi mobile StuHealth kami?'),
                      KotakJawaban(IsiJawaban: data['D1']),
                    ],
                  ))
                ],
              ),
            );
          },
        ));
  }
}

//////////////////////////////////////////////  Pertanyaan  ////////////////////////////////////////////
class Pertanyaan extends StatelessWidget {
  const Pertanyaan({
    super.key,
    required this.IsiPertanyaan,
  });
  final String IsiPertanyaan;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text(IsiPertanyaan,
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w500)),
    );
  }
}

/////////////////////////////////////////////  Kotak Jawaban  ////////////////////////////////////////
class KotakJawaban extends StatelessWidget {
  const KotakJawaban({super.key, required this.IsiJawaban});

  final String IsiJawaban;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: const Color.fromARGB(255, 2, 128, 144))),
      child: Text(IsiJawaban,
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w500)),
    );
  }
}
