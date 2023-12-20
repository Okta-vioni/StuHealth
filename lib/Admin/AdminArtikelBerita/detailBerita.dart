// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// ignore: camel_case_types
class AdminDetailBerita extends StatefulWidget {
  final String documentId;
  const AdminDetailBerita({super.key, required this.documentId});

  @override
  State<AdminDetailBerita> createState() => _AdminDetailBeritaState();
}

class _AdminDetailBeritaState extends State<AdminDetailBerita> {
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
                        .collection('berita')
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
              .collection('berita')
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
                      child: Image.network(
                        data['image'],
                      ),
                    ),
////////////////////////////////////////////////  Judul  //////////////////////////////////////////////////////
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
////////////////////////////////////////////////// Tanggal & Sumber ///////////////////////////////////////////////////
                    Text(
                      '$formattedDate',
                      style:
                          TextStyle(fontFamily: 'Poppins', color: Colors.grey),
                    ),
//////////////////////////////////////////////  Isi text  ////////////////////////////////////////////////////////
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          data['isi'],
                          style: TextStyle(
                              fontFamily: 'Poppins', color: Colors.black),
                          textAlign: TextAlign.justify,
                        )),

                    SizedBox(height: 50),
                    Text('Sumber: ${data['sumber']}',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: Colors.grey)),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
