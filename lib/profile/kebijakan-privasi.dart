// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart';

// ignore: camel_case_types
class kebijakanprivasi extends StatelessWidget {
  const kebijakanprivasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          leading: MaterialButton(
              child: Container(
                margin: const EdgeInsets.only(top: 20, left: 10),
                child: const Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 2, 128, 144),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              'Kebijakan Privasi',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: const Text(
                    'KEBIJAKAN PRIVASI APLIKASI STUHEALTH',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  )),
              Container(
                color: const Color.fromARGB(255, 2, 128, 144),
                width: double.infinity,
                height: 1,
                margin: const EdgeInsets.only(top: 20, bottom: 20),
              ),
////////////////////////////////////////////////////////////  isi Kebijakan Privasi  ////////////////////////////////////////////////
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                    ' StuHealth adalah aplikasi jasa dan layanan informasi kesehatan mahasiswa. Pengguna akan diminta informasi pribadi, yang nantinya dapat digunakan oleh StuHealth dalam kegiatan operasional sehari-hari. Meskipun data yang dikumpulkan oleh Aplikasi StuHealth adalah data yang diwajibkan oleh pengguna.StuHealth akan menggunakan data tersebut sesuai dengan Kebijakan Privasi ini dibuat. Kebijakan P`rivasi ini tidak dapat dipisahkan dari ketentuan pengguna. '),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.left,
                    'Definisi'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                    '"Data Pribadi" adalah informasi milik Pengguna, yang mengidentifikasin keterangan terkait Pengguna yang bersangkutan ”Pengguna” merujuk pada Pengguna Layanan Aplikasi StuHealth '),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.left,
                    ' Kerahasiaan Kata Sandi '),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                    'Kata sandi milik pengguna merupakan tanggung jawab personal masing - masing pengguna. Aplikasi StuHealth tidak bertanggung jawab atas kerugian yang dapat ditimbulkan akibat kelalaian pengguna dalam menjaga kerahasiaan kode pin atau password-nya. '),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.left,
                    ' Keamanan Data Pribadi '),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                    'Setiap Data Pribadi yang Aplikasi StuHealth peroleh sesuai dengan ketentuan Kebijakan Privasi ini akan dilindungi dengan upaya terbaik melalui keamanan perangkat keamanan teruji. Meskipun demikian, Aplikasi StuHealth tidak menjamin kerahasiaan informasi yang Pengguna sampaikan tersebut, dalam keadaan dimana terdapat pihak-pihak lain yang mengambil dan memanfaatkan Data Pribadi tersebut dari Aplikasi StuHealth secara melawan hukum.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
