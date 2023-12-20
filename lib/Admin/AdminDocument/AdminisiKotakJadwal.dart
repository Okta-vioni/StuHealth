// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// ignore: camel_case_types
class AdminIsiKotakJadwal extends StatefulWidget {
  final String documentId;
  const AdminIsiKotakJadwal({super.key, required this.documentId});

  @override
  State<AdminIsiKotakJadwal> createState() => _AdminIsiKotakJadwalState();
}

// ignore: camel_case_types
class _AdminIsiKotakJadwalState extends State<AdminIsiKotakJadwal> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id', null);
  }

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
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('kegiatan')
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
                  return Text(
                    data['judul'],
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  );
                },
              )),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('kegiatan')
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
          var timestamp = (data['tanggal_kegiatan'] as Timestamp).toDate();

          var formattedDate =
              DateFormat('EEEE, d MMMM yyyy', 'id').format(timestamp);

          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Image.network(data['image'])),
                  SizedBox(
                    height: 20,
                  ),
                  ///////////////////////////////////////////////////////////////  Kotak  ////////////////////////////////////////////////////////////

                  TextArtikel(IsiText: 'Tanggal Kegiatan: $formattedDate'),

                  TextArtikel(IsiText: 'Deskripsi Kegiatan: '),
                  ListTextArtikel(ListText: data['deskripsi']),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 2, 128, 144),
                    ),
                    margin: EdgeInsets.only(top: 30, bottom: 20),
                    height: 2,
                    width: double.infinity,
                  ),
                  const Text(
                    'Link Kegiatan',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Link(
                      target: LinkTarget.blank,
                      uri: Uri.parse(data['link']),
                      builder: (context, followLink) => GestureDetector(
                            onTap: followLink,
                            child: Text(
                              data['link'],
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 2, 128, 144),
                                  fontSize: 15,
                                  decoration: TextDecoration.underline),
                            ),
                          )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TextArtikel extends StatelessWidget {
  const TextArtikel({super.key, required this.IsiText});

  final String IsiText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Text(
        IsiText,
        style: TextStyle(fontFamily: 'Poppins', fontSize: 15),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class ListTextArtikel extends StatelessWidget {
  const ListTextArtikel({super.key, required this.ListText});

  final String ListText;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        ListText,
        style: TextStyle(fontFamily: 'Poppins', fontSize: 15),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
