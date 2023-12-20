// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pbl_stuhealth/Admin/obat/obatPage.dart';

class AdminIsiKotakInfoObat extends StatefulWidget {
  final String documentId;
  const AdminIsiKotakInfoObat({super.key, required this.documentId});

  @override
  State<AdminIsiKotakInfoObat> createState() => _AdminIsiKotakInfoObatState();
}

class _AdminIsiKotakInfoObatState extends State<AdminIsiKotakInfoObat> {
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
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30))),
              leading: IconButton(
                padding: const EdgeInsets.only(top: 20),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminInfoObatVitamin(),
                      ));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: Color.fromARGB(255, 0, 132, 119),
                ),
              ),
              title: Container(
                child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('obat')
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
                      data['nama'],
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    );
                  },
                ),
              )),
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('obat')
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
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(20),
                        child: Image.network(data['image'])),
///////////////////////////////////////////////////  Dalam Kotak HIjau  ////////////////////////////////////////////////////////
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 2, 128, 144)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Colors.white),
                      child: Text(
                        data['definisi'],
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                        textAlign: TextAlign.justify,
                      ),
                    ),
////////////////////////////////////////////////////  Luar Kotak Hijau  ///////////////////////////////////////////////////////
                    TextArtikel(IsiText: data['penjelasan']),
                  ],
                ),
              ),
            );
          },
        ));
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
        textAlign: TextAlign.justify,
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
