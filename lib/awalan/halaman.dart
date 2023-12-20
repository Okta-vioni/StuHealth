import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login/formlogin.dart';
import 'package:typeweight/typeweight.dart';

////////////////////////////////////////////////////// pertama //////////////////////////////////
////////////////////////////////////////////////////// pertama //////////////////////////////////
////////////////////////////////////////////////////// pertama //////////////////////////////////

class HalamanAwal extends StatelessWidget {
  const HalamanAwal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],
      appBar: AppBar(backgroundColor: Colors.teal[400], elevation: 0),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Image.asset('img/no1.png'),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: Offset(1, 1))
                  ]),
              child: const Column(
                children: [
                  ContainerIcon(
                    warnaiconpertama: Color.fromARGB(255, 2, 128, 144),
                    warnaiconkedua: Color.fromARGB(100, 0, 132, 119),
                    warnaiconketiga: Color.fromARGB(100, 0, 132, 119),
                  ),
                  ContainerText(
                      judul: 'Edukasi Kesehatan',
                      deskripsi:
                          ' Dapatkan beragam informasi kesehatan dengan mudah dan cepat.'),
                  ContainerTombol(
                      text: 'Lanjut', pindahHalaman: '/HalamanKedua'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////// kedua //////////////////////////////////
////////////////////////////////////////////////////// kedua //////////////////////////////////
////////////////////////////////////////////////////// kedua //////////////////////////////////

class HalamanKedua extends StatelessWidget {
  const HalamanKedua({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 128, 144),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 128, 144),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Image.asset('img/no2.png'),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: Offset(1, 1))
                  ]),
              child: const Column(
                children: [
                  ContainerIcon(
                      warnaiconpertama: Color.fromARGB(100, 0, 132, 119),
                      warnaiconkedua: Color.fromARGB(255, 2, 128, 144),
                      warnaiconketiga: Color.fromARGB(100, 0, 132, 119)),
                  ContainerText(
                      judul: 'Konsultasi Kesehatan',
                      deskripsi:
                          ' Mahasiswa dapat berkonsultasi secara online dengan pihak Unit Kesehatan Kampus.'),
                  ContainerTombol(
                    text: 'Lanjut',
                    pindahHalaman: '/HalamanKetiga',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////// ketiga //////////////////////////////////
////////////////////////////////////////////////////// ketiga //////////////////////////////////
////////////////////////////////////////////////////// ketiga //////////////////////////////////

class HalamanKetiga extends StatelessWidget {
  const HalamanKetiga({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 102, 141),
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 5, 102, 141),
          elevation: 0),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Image.asset('img/no3.png'),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 4,
                        spreadRadius: 1,
                        offset: Offset(1, 1))
                  ]),
              child: Column(
                children: [
                  const ContainerIcon(
                    warnaiconpertama: Color.fromARGB(100, 0, 132, 119),
                    warnaiconkedua: Color.fromARGB(100, 0, 132, 119),
                    warnaiconketiga: Color.fromARGB(255, 2, 128, 144),
                  ),
                  const ContainerText(
                      judul: 'Cari Lokasi',
                      deskripsi:
                          'Kamu dapat mencari fasilitas kesehatan terdekat.'),
                  const SizedBox(
                    height: 18,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(33, 0, 0, 0),
                              blurRadius: 2,
                              spreadRadius: 1,
                              offset: Offset(2, 2))
                        ]),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: MaterialButton(
                          height: 50,
                          padding: const EdgeInsets.only(
                              left: 120, right: 120, top: 15, bottom: 15),
                          color: const Color.fromARGB(255, 2, 128, 144),
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool('firstLaunch', false);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const HalamanLogin()));
                          },
                          child: const Text(
                            'Lanjut',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins'),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///////////////////////////////////// Desain /////////////////////////////////////////////
//////////////////////////////////// Desain /////////////////////////////////////////////
/////////////////////////////////// Desain /////////////////////////////////////////////

class ContainerIcon extends StatelessWidget {
  const ContainerIcon({
    super.key,
    required this.warnaiconpertama,
    required this.warnaiconkedua,
    required this.warnaiconketiga,
  });

  final Color warnaiconpertama;
  final Color warnaiconkedua;
  final Color warnaiconketiga;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(top: 30, left: 160, right: 160, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.circle,
            color: warnaiconpertama,
            size: 10,
          ),
          Icon(
            Icons.circle,
            color: warnaiconkedua,
            size: 10,
          ),
          Icon(
            Icons.circle,
            color: warnaiconketiga,
            size: 10,
          ),
        ],
      ),
    );
  }
}

class ContainerText extends StatelessWidget {
  const ContainerText({
    super.key,
    required this.judul,
    required this.deskripsi,
  });

  final String judul;
  final String deskripsi;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 35, right: 35, bottom: 10),
      child: Column(
        children: [
          Text(
            judul,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: TypeWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            deskripsi,
            style: const TextStyle(fontSize: 18, fontFamily: 'Poppins'),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 68,
          )
        ],
      ),
    );
  }
}

class ContainerTombol extends StatelessWidget {
  const ContainerTombol({
    super.key,
    required this.text,
    required this.pindahHalaman,
  });

  final String text;
  final String pindahHalaman;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(33, 0, 0, 0),
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(2, 2))
          ]),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: MaterialButton(
          height: 50,
          padding:
              const EdgeInsets.only(left: 120, right: 120, top: 15, bottom: 15),
          color: const Color.fromARGB(255, 2, 128, 144),
          onPressed: () {
            Navigator.pushNamed(context, pindahHalaman);
          },
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins'),
          ),
        ),
      ),
    );
  }
}
