// ignore_for_file: file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/detailBerita.dart';
import 'package:pbl_stuhealth/bagian-home/artikel-semua.dart';
import 'package:pbl_stuhealth/tengah/inti.dart';

// ignore: camel_case_types
class berita extends StatefulWidget {
  const berita({super.key});

  @override
  State<berita> createState() => _beritaState();
}

// ignore: camel_case_types
class _beritaState extends State<berita> {
  late Stream<QuerySnapshot> beritaStream;

  @override
  void initState() {
    super.initState();
    beritaStream = FirebaseFirestore.instance.collection('berita').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          leading: IconButton(
            padding: const EdgeInsets.only(top: 20, left: 20),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const IntiAplikasi(),
                  ));
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 20,
              color: Color.fromARGB(255, 2, 128, 144),
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Artikel & Berita Kesehatan',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.black),
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
//////////////////////////////////////////////// Artikel  &  Berita //////////////////////////////////////////////////////////
            Row(
              children: [
                Expanded(
                  child: Container(
                    // padding: const EdgeInsets.only(top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        color: Colors.white,
                        border: Border.all(
                            color: const Color.fromARGB(255, 2, 128, 144))),
                    child: MaterialButton(
                        child: const Text('Artikel',
                            style: TextStyle(
                                color: Color.fromARGB(255, 2, 128, 144),
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w600)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const artikelSemua(),
                              ));
                        }),
                  ),
                ),
                Expanded(
                  child: Container(
                    // // padding: const EdgeInsets.only(top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: const Color.fromARGB(255, 2, 128, 144),
                        border: Border.all(
                            color: const Color.fromARGB(255, 2, 128, 144))),
                    child: MaterialButton(
                        child: const Text('Berita',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w600)),
                        onPressed: () {}),
                  ),
                ),
              ],
            ),

///////////////////////////////////////////////// Kotak Berita ///////////////////////////////////////////////////////////////////
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: beritaStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var document = snapshot.data!.docs[index];
                    var judulBerita = document['judul'];
                    var gambarBerita = document['image'];
                    var documentId = document.id;

                    return Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Column(
                          children: [
                            Container(
                              child: KotakBerita(
                                  documentId: documentId,
                                  gambarBerita: gambarBerita,
                                  judulBerita: judulBerita),
                            )
                          ],
                        ));
                  },
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////  Design  /////////////////////////////////////////////////////////

class PilihanArtikel extends StatelessWidget {
  const PilihanArtikel({
    super.key,
    required this.judul,
    required this.warnaKotak,
    required this.warnaText,
  });

  final String judul;
  final Color warnaKotak;
  final Color warnaText;

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final bodyHeight = mediaQueryHeight;
    return Container(
      margin: const EdgeInsets.all(2),
      height: bodyHeight * 0.03,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 2, 128, 144),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: warnaKotak,
      ),
      child: MaterialButton(
          child: Text(
            judul,
            style: TextStyle(
                color: warnaText,
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          onPressed: () {}),
    );
  }
}

class KotakBerita extends StatefulWidget {
  const KotakBerita({
    super.key,
    required this.documentId,
    required this.gambarBerita,
    required this.judulBerita,
  });

  final String documentId;
  final String gambarBerita;
  final String judulBerita;

  @override
  State<KotakBerita> createState() => _KotakBeritaState();
}

class _KotakBeritaState extends State<KotakBerita> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(27, 0, 0, 0),
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(2, 2))
          ]),
      child: MaterialButton(
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 5),
                child: Image.network(
                  widget.gambarBerita,
                  width: 80,
                  height: 80,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(widget.judulBerita,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w500)),
              )
            ],
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AdminDetailBerita(documentId: widget.documentId)));
          }),
    );
  }
}
