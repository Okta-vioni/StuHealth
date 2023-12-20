import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/SemuaArtikel.dart';
import 'package:pbl_stuhealth/Admin/AdminHome/AdminEdukasiKesehatan.dart';
import 'package:pbl_stuhealth/Admin/AdminHome/EditSlider.dart';
import 'package:pbl_stuhealth/Admin/AdminProfil/profileAdmin.dart';
import 'package:pbl_stuhealth/Admin/obat/obatPage.dart';
import 'package:pbl_stuhealth/firebase-service/firebase.dart';
import 'package:pbl_stuhealth/firebase-service/up.dart';

class AdminHalamanHome extends StatefulWidget {
  const AdminHalamanHome({super.key});

  @override
  State<AdminHalamanHome> createState() => _AdminHalamanHomeState();
}

class CustomSlider extends StatefulWidget {
  final List<String> imgList;

  const CustomSlider({super.key, required this.imgList});

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
              Image.asset(
                item,
                fit: BoxFit.cover,
                width: 1000.0,
                height: double.maxFinite,
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 2, 128, 144),
                        Color.fromARGB(13, 0, 132, 119)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _AdminHalamanHomeState extends State<AdminHalamanHome>
    with WidgetsBindingObserver {
  final Databases databases = Databases();
  late Stream<QuerySnapshot> imageStream;
  int currentSliderIndex = 0;
  CarouselController carouselController = CarouselController();
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Selamat Datang,',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'Unit Kesehatan Kampus',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10, top: 20),
                  child: MaterialButton(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 40, bottom: 20),
                      child: Image.asset(
                        'img/icon/Admin.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const profileAdmin(),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),

          ////////////////////////////////////////////////////////////////// Slide ///////////////////////////////////////////////////////////
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

                      //Display Data
                      return Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 20,
                                top: 20,
                                right: 20,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 2, 128, 144)),
                                  boxShadow: const [
                                    BoxShadow(
                                        color:
                                            Color.fromARGB(64, 158, 158, 158),
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                        offset: Offset(4, 4))
                                  ],
                                  color: Colors.white),
                              height: 40,
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              child: MaterialButton(
                                  child: const Text(
                                    'Edit Slider',
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
                                              const EditSlider(),
                                        ));
                                  }),
                            ),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 20),
                            height: bodyHeight * 0.2,
                            width: double.infinity,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: imageStream,
                              builder: (_, snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data!.docs.length > 1) {
                                  return CarouselSlider.builder(
                                      carouselController: carouselController,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (_, index, ___) {
                                        DocumentSnapshot sliderImage =
                                            snapshot.data!.docs[index];
                                        return Image.network(
                                          sliderImage['downloadUrl'],
                                          fit: BoxFit.cover,
                                        );
                                      },
                                      options: CarouselOptions(
                                          autoPlay: true,
                                          enlargeCenterPage: true,
                                          onPageChanged: (index, _) {
                                            setState(() {
                                              currentSliderIndex = index;
                                            });
                                          }));
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            )),
                        /////////////////////////////////////////////////////////////// bulatan 2 /////////////////////////////////////////////////////////
                        SizedBox(
                          height: bodyHeight * 0.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AdminartikelSemua(),
                                      ));
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 65,
                                      height: 65,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(100)),
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 157, 211, 255)),
                                          color: Colors.white),
                                      child:
                                          Image.asset('img/ArtikelBerita.png'),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
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
                                            const AdminInfoObatVitamin(),
                                      ));
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 65,
                                      height: 65,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
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
                                      margin: const EdgeInsets.only(left: 10),
                                      width: bodyWidth * 0.2,
                                      child: const Text('Info Obat & Vitamin',
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
                        ////////////////////////////////////////////////// Fakta Menarik //////////////////////////////////////////////////////////////
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                top: 20,
                                right: 20,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 2, 128, 144)),
                                  boxShadow: const [
                                    BoxShadow(
                                        color:
                                            Color.fromARGB(64, 158, 158, 158),
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                        offset: Offset(4, 4))
                                  ],
                                  color: Colors.white),
                              height: 40,
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              child: MaterialButton(
                                  child: const Text(
                                    'Edit Fakta',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromARGB(255, 2, 128, 144),
                                        fontFamily: 'Poppins',
                                        fontSize: 15),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (_) {
                                        return UpFakta(faktaId: document.id);
                                      }),
                                    );
                                  }),
                            ),
                          ],
                        ),

                        Column(
                          children: [
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
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          descFakta,
                                          style: const TextStyle(
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
                          ],
                        ),

                        Container(
                          margin: const EdgeInsets.only(
                              right: 20, left: 20, top: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: Image.asset(
                                      'img/icon/book.png',
                                      width: 28,
                                      height: 28,
                                    ),
                                  ),
                                  const Text(
                                    'Edukasi Kesehatan',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 2, 128, 144),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                              //////////////////////////////////////////////////////////////////// edukasi ////////////////////////////////////////////////////////////
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(40, 0, 168, 150),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            '1.  Panggilan Bantuan Darurat',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.justify,
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 15),
                                            child: const Text(
                                              'Langkah pertama adalah selalu memanggil nomor darurat (misalnya, 119 atau 112) jika situasi memerlukan bantuan medis profesional segera.',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
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
                                                    AdminEdukasiKesehatan(),
                                              ));
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
      )),
    );
  }
}
