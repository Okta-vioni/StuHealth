// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/EditArtikel.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/SemuaArtikel.dart';
import 'package:pbl_stuhealth/Admin/AdminHome/AdminArtikel&Berita/Adminartikel-insomnia.dart';
import 'package:pbl_stuhealth/Admin/AdminHome/AdminArtikel&Berita/Adminartikel-magh.dart';
import 'package:pbl_stuhealth/Admin/AdminHome/AdminArtikel&Berita/Adminberita.dart';
import 'package:pbl_stuhealth/Admin/AdminHome/AdminArtikel&Berita/AdminisiKotakArtikel-HidupSehat.dart';
import 'package:pbl_stuhealth/Admin/Tengah/inti.dart';

// ignore: camel_case_types
class AdminartikelHidupSehat extends StatefulWidget {
  const AdminartikelHidupSehat({super.key});

  @override
  State<AdminartikelHidupSehat> createState() => _AdminartikelHidupSehatState();
}

// ignore: camel_case_types
class _AdminartikelHidupSehatState extends State<AdminartikelHidupSehat> {
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
            padding: const EdgeInsets.only(top: 20, left: 18),
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
                                builder: (context) => const Adminberita(),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PilihanArtikel(
                    judul: 'Semua',
                    warnaText: Color.fromARGB(255, 2, 128, 144),
                    warnaKotak: Color.fromARGB(0, 0, 134, 119),
                    HalamanDituju: AdminartikelSemua(),
                  ),
                  PilihanArtikel(
                    judul: 'Hidup Sehat',
                    warnaText: Colors.white,
                    warnaKotak: Color.fromARGB(255, 2, 128, 144),
                    HalamanDituju: AdminartikelHidupSehat(),
                  ),
                  PilihanArtikel(
                    judul: 'Magh',
                    warnaText: Color.fromARGB(255, 2, 128, 144),
                    warnaKotak: Color.fromARGB(0, 0, 132, 119),
                    HalamanDituju: AdminartikelMagh(),
                  ),
                  PilihanArtikel(
                    judul: 'Insomnia',
                    warnaText: Color.fromARGB(255, 2, 128, 144),
                    warnaKotak: Color.fromARGB(0, 0, 132, 119),
                    HalamanDituju: AdminartikelInsomnia(),
                  ),
                ],
              ),
            ),
///////////////////////////////////////////////// Kotak Artikel ///////////////////////////////////////////////////////////////////
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(bottom: 30),
                children: [
                  KotakArtikel(
                      GambarArtikel: 'img/poster3.jpeg',
                      JudulArtikel: 'Menjaga Kesehatan Di Bulan Suci',
                      HalamanArtikel: AdminisikotakArtikelHidupSehat()),
                  KotakArtikel(
                      GambarArtikel: 'img/poster3.jpeg',
                      JudulArtikel: 'Menjaga Kesehatan Di Bulan Suci',
                      HalamanArtikel: AdminisikotakArtikelHidupSehat()),
                  KotakArtikel(
                      GambarArtikel: 'img/poster3.jpeg',
                      JudulArtikel: 'Menjaga Kesehatan Di Bulan Suci',
                      HalamanArtikel: AdminisikotakArtikelHidupSehat()),
                  KotakArtikel(
                      GambarArtikel: 'img/poster3.jpeg',
                      JudulArtikel: 'Menjaga Kesehatan Di Bulan Suci',
                      HalamanArtikel: AdminisikotakArtikelHidupSehat()),
                  KotakArtikel(
                      GambarArtikel: 'img/poster3.jpeg',
                      JudulArtikel: 'Menjaga Kesehatan Di Bulan Suci',
                      HalamanArtikel: AdminisikotakArtikelHidupSehat()),
                  KotakArtikel(
                      GambarArtikel: 'img/poster3.jpeg',
                      JudulArtikel: 'Menjaga Kesehatan Di Bulan Suci',
                      HalamanArtikel: AdminisikotakArtikelHidupSehat()),
                  KotakArtikel(
                      GambarArtikel: 'img/poster3.jpeg',
                      JudulArtikel: 'Menjaga Kesehatan Di Bulan Suci',
                      HalamanArtikel: AdminisikotakArtikelHidupSehat()),
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
    required this.warnaText,
  });

  final String judul;
  final Color warnaKotak;
  final Widget HalamanDituju;
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
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HalamanDituju,
                ));
          }),
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
