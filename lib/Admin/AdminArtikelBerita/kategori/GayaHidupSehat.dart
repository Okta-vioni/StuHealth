// ignore_for_file: file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/EditArtikel.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/SemuaArtikel.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/SemuaBerita.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/detailArtikel.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/kategori/GangguanTidur.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/kategori/Mata.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/kategori/Pencernaan.dart';
import 'package:pbl_stuhealth/Admin/Tengah/inti.dart';

// ignore: camel_case_types
class AdminArtikelGaya extends StatefulWidget {
  const AdminArtikelGaya({super.key});

  @override
  State<AdminArtikelGaya> createState() => _AdminArtikelGayaState();
}

// ignore: camel_case_types
class _AdminArtikelGayaState extends State<AdminArtikelGaya> {
  late Stream<QuerySnapshot> artikelStream;
  String selectedCategory = 'Semua';

  @override
  void initState() {
    super.initState();
    artikelStream = FirebaseFirestore.instance
        .collection('artikel')
        .where('kategori', isEqualTo: 'Gaya Hidup Sehat')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final bodyHeight = mediaQueryHeight;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(bodyHeight * 0.09),
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
                    builder: (context) => const AdminIntiAplikasi(),
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
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
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
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.horizontal(left: Radius.circular(10)),
                        color: const Color.fromARGB(255, 2, 128, 144),
                        border: Border.all(
                            color: const Color.fromARGB(255, 2, 128, 144))),
                    child: MaterialButton(
                        child: const Text('Artikel',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w700)),
                        onPressed: () {}),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.horizontal(right: Radius.circular(10)),
                        color: Colors.white,
                        border: Border.all(
                            color: const Color.fromARGB(255, 2, 128, 144))),
                    child: MaterialButton(
                        child: const Text('Berita',
                            style: TextStyle(
                                color: Color.fromARGB(255, 2, 128, 144),
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w700)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AdminBeritaSemua(),
                              ));
                        }),
                  ),
                ),
              ],
            ),
//////////////////////////////////////////////  Edit Artikel  ///////////////////////////////////////////////////
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                top: 10,
              ),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border:
                      Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(64, 158, 158, 158),
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(4, 4))
                  ],
                  color: Colors.white),
              height: 40,
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: MaterialButton(
                  child: const Text(
                    'Edit Artikel',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 2, 128, 144),
                        fontFamily: 'Poppins',
                        fontSize: 15),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const EditArtikelTambahArtikel(),
                        ));
                  }),
            ),

//////////////////////////////////////////////// Semua , Hidup Sehat , Magh , Insomnia //////////////////////////////////////////////////////////

            const SizedBox(
              height: 10,
            ),

            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: const Row(
                children: [
                  PilihanArtikel(
                    kategori: 'Semua',
                    warnaText: Color.fromARGB(255, 2, 128, 144),
                    warnaKotak: Colors.white,
                    HalamanDituju: AdminartikelSemua(),
                  ),
                  PilihanArtikel(
                    kategori: 'Gaya Hidup Sehat',
                    warnaText: Colors.white,
                    warnaKotak: Color.fromARGB(255, 2, 128, 144),
                    HalamanDituju: AdminArtikelGaya(),
                  ),
                  PilihanArtikel(
                    kategori: 'Gangguan Tidur',
                    warnaText: Color.fromARGB(255, 2, 128, 144),
                    warnaKotak: Colors.white,
                    HalamanDituju: AdminArtikelTidur(),
                  ),
                  PilihanArtikel(
                    kategori: 'Kesehatan Mata',
                    warnaText: Color.fromARGB(255, 2, 128, 144),
                    warnaKotak: Colors.white,
                    HalamanDituju: AdminArtikelMata(),
                  ),
                  PilihanArtikel(
                    kategori: 'Gangguan Pencernaan',
                    warnaText: Color.fromARGB(255, 2, 128, 144),
                    warnaKotak: Colors.white,
                    HalamanDituju: AdminArtikelPencernaan(),
                  ),
                ],
              ),
            ),
///////////////////////////////////////////////// Kotak Artikel ///////////////////////////////////////////////////////////////////
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: artikelStream,
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
                    var judulArtikel = document['judul'];
                    var gambarArtikel = document['image'];
                    var documentId = document.id;

                    return Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Column(
                          children: [
                            Container(
                              child: KotakArtikel(
                                  documentId: documentId,
                                  gambarArtikel: gambarArtikel,
                                  judulArtikel: judulArtikel),
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
class PilihanArtikel extends StatefulWidget {
  const PilihanArtikel({
    super.key,
    required this.kategori,
    required this.warnaKotak,
    required this.warnaText,
    required this.HalamanDituju,
  });

  final String kategori;
  final Color warnaKotak;
  final Color warnaText;
  final Widget HalamanDituju;

  @override
  State<PilihanArtikel> createState() => _PilihanArtikelState();
}

class _PilihanArtikelState extends State<PilihanArtikel> {
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
        color: widget.warnaKotak,
      ),
      child: MaterialButton(
          child: Text(
            widget.kategori,
            style: TextStyle(
                color: widget.warnaText,
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => widget.HalamanDituju,
                ));
          }),
    );
  }
}

class KotakArtikel extends StatefulWidget {
  const KotakArtikel({
    super.key,
    required this.documentId,
    required this.gambarArtikel,
    required this.judulArtikel,
  });

  final String documentId;
  final String gambarArtikel;
  final String judulArtikel;

  @override
  State<KotakArtikel> createState() => _KotakArtikelState();
}

class _KotakArtikelState extends State<KotakArtikel> {
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
                  widget.gambarArtikel,
                  width: 80,
                  height: 80,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(widget.judulArtikel,
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
                        AdminDetailArtikel(documentId: widget.documentId)));
          }),
    );
  }
}
