// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pbl_stuhealth/bagian-home/InfoObatVitamin.dart';
import 'package:pbl_stuhealth/bagian-home/artikel-semua.dart';
import 'package:pbl_stuhealth/firebase-service/firebase.dart';
import 'package:pbl_stuhealth/firebase-service/firebase_auth_service.dart';
import 'package:pbl_stuhealth/profile/profileuser.dart';
import 'package:pbl_stuhealth/bagian-home/Edukasi-kesehatan.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pbl_stuhealth/tengah/intichat.dart';

class HalamanHome extends StatefulWidget {
  const HalamanHome({super.key});

  @override
  State<HalamanHome> createState() => _HalamanHomeState();
}

class _HalamanHomeState extends State<HalamanHome> with WidgetsBindingObserver {
  //slider
  final Databases databases = Databases();
  late Stream<QuerySnapshot> imageStream;
  int currentSliderIndex = 0;
  CarouselController carouselController = CarouselController();

  final FirebaseAuthService _authService = FirebaseAuthService();
  bool _shouldExit = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    var firebase = FirebaseFirestore.instance;
    imageStream = firebase.collection('slider').snapshots();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _shouldExit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final bodyHeight = mediaQueryHeight;
    final bodyWidth = mediaQueryWidth;
    return WillPopScope(
        onWillPop: () async {
          if (!_shouldExit) {
            final value = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    'Konfirmasi',
                    style: TextStyle(
                        fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                    textAlign: TextAlign.left,
                  ),
                  content: const Text(
                      'Apakah anda ingin keluar dari Aplikasi StuHealth?',
                      style: TextStyle(fontFamily: 'Poppins'),
                      textAlign: TextAlign.left),
                  actions: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 2, 128, 144)),
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: const Text(
                                'Tidak',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 2, 128, 144),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          //////////////////////////////////////
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 2, 128, 144)),
                                color: Color.fromARGB(255, 2, 128, 144),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: const Text(
                                'Ya',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            );

            if (value != null) {
              if (value) {
                // If true, exit the app
                SystemNavigator.pop();
                _shouldExit = true;
              }
              return Future.value(value);
            } else {
              return Future.value(false);
            }
          } else {
            // If shouldExit is true, exit the app without showing the dialog
            SystemNavigator.pop();
            return Future.value(true);
          }
        },
        child: Scaffold(
          body: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(64, 158, 158, 158),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(4, 4))
                    ]),
                height: bodyHeight * 0.135,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 40),
                      padding: const EdgeInsets.only(left: 20),
                      child: FutureBuilder(
                        future: _authService
                            .getUserDetails(_authService.getCurrentUser()!.uid),
                        builder: (context,
                            AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error.toString()}');
                          } else if (!snapshot.hasData ||
                              snapshot.data == null) {
                            return const Text('User details not found.');
                          } else {
                            Map<String, dynamic> userDetails = snapshot.data!;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Selamat Datang,',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  userDetails['username'],
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10, top: 20),
                      child: MaterialButton(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 40, bottom: 20),
                          child: Image.asset(
                            'img/icon/PersonLogo.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const profileuser(),
                              ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
////////////////////////////////////////////////////////  Bagian Bawah  /////////////////////////////////////////////////////
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: databases.getFaktaStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List faktaList = snapshot.data!.docs;

                      return ListView.builder(
                        padding: EdgeInsets.only(top: 0),
                        itemCount: faktaList.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot document = faktaList[index];

                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          String judulFakta = data['judul'];
                          String descFakta = data['desk'];

                          return Column(children: [
////////////////////////////////////////////////////////////////// Slide ///////////////////////////////////////////////////////////
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              height: bodyHeight * 0.2,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: imageStream,
                                builder: (_, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data!.docs.length > 1) {
                                    List<String> imgList = snapshot.data!.docs
                                        .map((sliderImage) =>
                                            (sliderImage['downloadUrl']
                                                as String?) ??
                                            '')
                                        .toList();

                                    return CustomSlider(imgList: imgList);
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                            ),

/////////////////////////////////////////////////////////////// bulatan 2 /////////////////////////////////////////////////////////

                            Container(
                              height: bodyHeight * 0.1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const artikelSemua()));
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 65,
                                          height: 65,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(100)),
                                              border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 157, 211, 255)),
                                              color: Colors.white),
                                          child: Image.asset(
                                              'img/ArtikelBerita.png'),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          width: bodyWidth * 0.25,
                                          child: const Text(
                                              'Artikel & Berita Kesehatan',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600)),
                                        )
                                      ],
                                    ),
                                  ),
///////////////////////////////////////////////////////////////////////////////////////////
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const InfoObatVitamin()));
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 65,
                                          height: 65,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(100)),
                                              border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 157, 211, 255)),
                                              color: Colors.white),
                                          child: Image.asset(
                                            'img/ObatVitamin.png',
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          width: bodyWidth * 0.2,
                                          child: const Text(
                                              'Info Obat & Vitamin',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600)),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

/////////////////////////////////////////////// Konsultasi //////////////////////////////////////////////////////
                            Container(
                              margin: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromARGB(33, 0, 0, 0),
                                        blurRadius: 2,
                                        spreadRadius: 1,
                                        offset: Offset(2, 2))
                                  ],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: Color.fromARGB(255, 2, 128, 144)),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Image.asset(
                                      'img/Doctor.png',
                                      height: 150,
                                      width: 150,
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    margin: const EdgeInsets.only(
                                      left: 20,
                                      right: 30,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Ayo jadwalkan konsultasi mu segera ke Unit Kesehatan Kampus!',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 30,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Color.fromARGB(
                                                255, 255, 229, 0),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color.fromARGB(
                                                      70, 0, 0, 0),
                                                  blurRadius: 2,
                                                  spreadRadius: 1,
                                                  offset: Offset(2, 2))
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            child: MaterialButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const HalamanChat()));
                                              },
                                              child: const Text(
                                                'Daftar Sekarang',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 2, 128, 144),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Poppins'),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
////////////////////////////////////////////////// Fakta Menarik //////////////////////////////////////////////////////////////
                            Container(
                              margin:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: Image.asset(
                                          'img/icon/stars.png',
                                          width: 28,
                                          height: 28,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        'Fakta Menarik',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 2, 128, 144),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            40, 0, 168, 150),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          judulFakta,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          descFakta,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
//////////////////////////////////////////////////////////////////// edukasi ////////////////////////////////////////////////////////////
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 20, left: 20, top: 20),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: Image.asset(
                                          'img/icon/book.png',
                                          width: 28,
                                          height: 28,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        'Edukasi Kesehatan',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 2, 128, 144),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            40, 0, 168, 150),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'PROSEDUR PERTOLONGAN PERTAMA',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const Text(
                                          'Berikut ini beberapa prosedur pertolongan pertama yang perlu diketahui oleh mahasiswa',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.justify,
                                        ),
/////////////////////////////////////////////////////////////// Edukasi Bagian Kedua /////////////////////////////////////////////////
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                '1.  Panggilan Bantuan Darurat',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                textAlign: TextAlign.justify,
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 15),
                                                child: const Text(
                                                  'Langkah pertama adalah selalu memanggil nomor darurat (misalnya, 119 atau 112) jika situasi memerlukan bantuan medis profesional segera.',
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        MaterialButton(
                                            child: const Text(
                                              'Selengkapnya...',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 2, 128, 144),
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const EdukasiKesehatan()));
                                            })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]);
                        },
                      );
                    } else {
                      return const Text('Terjadi Kesalahan');
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}

///////////////////////////////////////////////////////////// Slider ///////////////////////////////////////////////////
class CustomSlider extends StatefulWidget {
  final List<String> imgList;

  const CustomSlider({required this.imgList});

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 3,
        enlargeCenterPage: true,
      ),
      items: widget.imgList.map((item) {
        return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.network(
                item,
                fit: BoxFit.cover,
                width: 1000.0,
                height: double.maxFinite,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
