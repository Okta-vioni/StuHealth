// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// ignore: camel_case_types
class AdminDetailArtikel extends StatefulWidget {
  final String documentId;
  const AdminDetailArtikel({super.key, required this.documentId});

  @override
  State<AdminDetailArtikel> createState() => _AdminDetailArtikelState();
}

class _AdminDetailArtikelState extends State<AdminDetailArtikel> {
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
          child: Container(
            margin: const EdgeInsets.only(top: 15),
            child: AppBar(
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(30))),
                backgroundColor: Colors.white,
                leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 2, 128, 144),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                title: Container(
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('artikel')
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
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      );
                    },
                  ),
                )),
          ),
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('artikel')
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
            var timestamp = (data['timestamp'] as Timestamp).toDate();

            var formattedDate =
                DateFormat('EEEE, d MMMM yyyy', 'id').format(timestamp);

            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Center(
                        child: Image.network(
                          data['image'],
                        ),
                      ),
                    ),
////////////////////////////////////////////////  Kotak List  ///////////////////////////////////////////////
                    Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, right: 10, left: 10),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(
                                color: const Color.fromARGB(255, 2, 128, 144))),
                        child: Text(
                          data['kategori'],
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 2, 128, 144)),
                        ),
                      ),
                    ),
/////////////////////////////////////////////////// Judul /////////////////////////////////////////////////
                    Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 10),
                      child: Text(
                        data['judul'],
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                            fontSize: 25),
                      ),
                    ),
/////////////////////////////////////////////////////////  Tanggal  ////////////////////////////////////////////
                    Text(
                      '$formattedDate',
                      style:
                          TextStyle(fontFamily: 'Poppins', color: Colors.grey),
                    ),
//////////////////////////////////////////////// Isi text ///////////////////////////////////////////////////////
//////////////////////////////////////////////// Isi text ///////////////////////////////////////////////////////
                    TextArtikel(IsiText: data['isi']),

//////////////////////////////////////////////////  Sumber  ///////////////////////////////////
                    SizedBox(
                      height: 50,
                    ),
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
