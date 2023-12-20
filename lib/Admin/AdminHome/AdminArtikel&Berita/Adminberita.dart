// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/EditBerita.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/SemuaArtikel.dart';
import 'package:pbl_stuhealth/Admin/AdminHome/AdminArtikel&Berita/AdminisiKotakBerita.dart';
import 'package:pbl_stuhealth/Admin/Tengah/inti.dart';

// ignore: camel_case_types
class Adminberita extends StatefulWidget {
  const Adminberita({super.key});

  @override
  State<Adminberita> createState() => _AdminberitaState();
}

// ignore: camel_case_types
class _AdminberitaState extends State<Adminberita> {
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
                  fontSize: 18,
                  fontFamily: 'Poppins',
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
                        color: Colors.white,
                        border: Border.all(
                            color: const Color.fromARGB(255, 2, 128, 144))),
                    child: MaterialButton(
                        child: const Text('Artikel',
                            style: TextStyle(
                                color: Color.fromARGB(255, 2, 128, 144),
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w700)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AdminartikelSemua(),
                              ));
                        }),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 2, 128, 144),
                        border: Border.all(
                            color: const Color.fromARGB(255, 2, 128, 144))),
                    child: MaterialButton(
                        child: const Text('Berita',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w700)),
                        onPressed: () {}),
                  ),
                ),
              ],
            ),
//////////////////////////////////////////////  Edit Berita  ///////////////////////////////////////////////////
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
                    'Edit Berita',
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
                          builder: (context) => const EditBeritaTambahBerita(),
                        ));
                  }),
            ),
///////////////////////////////////////////////// Kotak Berita ///////////////////////////////////////////////////////////////////
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(bottom: 30),
                children: [
                  KotakArtikel(
                      GambarArtikel: 'img/Demam.jpeg',
                      JudulArtikel:
                          'Indonesia Jadi Negara Kedua dengan Beban TBC ',
                      HalamanArtikel: AdminisikotakBerita()),
                  KotakArtikel(
                      GambarArtikel: 'img/Demam.jpeg',
                      JudulArtikel:
                          'Indonesia Jadi Negara Kedua dengan Beban TBC ',
                      HalamanArtikel: AdminisikotakBerita()),
                  KotakArtikel(
                      GambarArtikel: 'img/Demam.jpeg',
                      JudulArtikel:
                          'Indonesia Jadi Negara Kedua dengan Beban TBC ',
                      HalamanArtikel: AdminisikotakBerita()),
                  KotakArtikel(
                      GambarArtikel: 'img/Demam.jpeg',
                      JudulArtikel:
                          'Indonesia Jadi Negara Kedua dengan Beban TBC ',
                      HalamanArtikel: AdminisikotakBerita()),
                  KotakArtikel(
                      GambarArtikel: 'img/Demam.jpeg',
                      JudulArtikel:
                          'Indonesia Jadi Negara Kedua dengan Beban TBC ',
                      HalamanArtikel: AdminisikotakBerita()),
                  KotakArtikel(
                      GambarArtikel: 'img/Demam.jpeg',
                      JudulArtikel:
                          'Indonesia Jadi Negara Kedua dengan Beban TBC ',
                      HalamanArtikel: AdminisikotakBerita()),
                  KotakArtikel(
                      GambarArtikel: 'img/Demam.jpeg',
                      JudulArtikel:
                          'Indonesia Jadi Negara Kedua dengan Beban TBC ',
                      HalamanArtikel: AdminisikotakBerita()),
                ],
              ),
            )
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
    required this.HalamanDituju,
  });

  final String judul;
  final Color warnaKotak;
  final Widget HalamanDituju;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.all(2),
        height: 40,
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
              style: const TextStyle(
                  color: Color.fromARGB(255, 2, 128, 144),
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HalamanDituju,
                  ));
            }),
      ),
    );
  }
}

class KotakArtikel extends StatelessWidget {
  const KotakArtikel({
    super.key,
    required this.GambarArtikel,
    required this.JudulArtikel,
    required this.HalamanArtikel,
  });

  final String GambarArtikel;
  final String JudulArtikel;
  final Widget HalamanArtikel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
                child: Image.asset(
                  GambarArtikel,
                  width: 80,
                  height: 80,
                ),
              ),
              Expanded(
                child: Text(JudulArtikel,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
              )
            ],
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HalamanArtikel,
                ));
          }),
    );
  }
}
