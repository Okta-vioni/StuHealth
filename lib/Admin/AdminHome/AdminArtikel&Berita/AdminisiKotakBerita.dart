// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: camel_case_types
class AdminisikotakBerita extends StatelessWidget {
  const AdminisikotakBerita({super.key});

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
            title: const Text(
              'Berita Kesehatan',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
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
                margin: const EdgeInsets.only(bottom: 10),
                child: Image.asset(
                  'img/no3.png',
                ),
              ),
////////////////////////////////////////////////  Judul  //////////////////////////////////////////////////////
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 10),
                child: const Text(
                  'Indonesia Jadi Negara Kedua dengan Beban TBC ',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                      fontSize: 25),
                ),
              ),
////////////////////////////////////////////////// Tanggal & Sumber ///////////////////////////////////////////////////
              Text(
                '4 November 2023',
                style: TextStyle(fontFamily: 'Poppins', color: Colors.grey),
              ),
//////////////////////////////////////////////  Isi text  ////////////////////////////////////////////////////////
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    'Pada tahun 2022 yang lalu, Kementerian Kesehatan bersama dengan seluruh tenaga kesehatan berhasil mendeteksi penderita Tuberkulosis (TBC) lebih dari 700 ribu kasus. Angka tersebut merupakan capaian tertinggi sejak TBC dinyatakan sebagai program prioritas nasional. Saat ini diketahui bahwa Indonesia menempati peringkat kedua setelah india terkait penyakit tuberkulosis (TBC), yaitu dengan jumlah kasus sebanyak 969 ribu dan kematian 93 ribu per tahun atau setara dengan 11 kematian per jam. Dikutip dari Global TB Report tahun 2022, juga diketahui bahwa jumlah kasus TBC terbanyak di dunia, menyerang kelompok usia produktif terutama pada usia 45 sampai 54 tahun. Merespon masalah tersebut, dr. Mohammad Syahril selaku Juru Bicara Kementerian Kesehatan RI menyampaikan bahwa kegiatan pendeteksian tertinggi TBC pada tahun 2022 tersebut menunjukkan komitmen yang dilakukan oleh pemerintah dan surveilans yang semakin gencar terhadap TBC. Hal ini dilakukan karena pendeteksian merupakan langkah awal untuk mengobati pasien TBC. Tidak berhenti sampai disitu, Budi Gunadi Sadikin selaku Menteri Kesehatan Republik Indonesia juga meminta seluruh jajaran kesehatan untuk memprioritaskan pencarian para penderita TBC, sehingga 90% dari total kasus TBC di Indonesia dapat terdeteksi di tahun 2024 mendatang. Strategi Nasional dalam Eliminasi TBC juga telah tertuang dalam Perpres nomor 67 tahun 2021 tentang Penanggulangan Tuberkulosis ada sejumlah strategi mengatasi TBC di Indonesia, dimana didalamnya diatur mulai dari penguatan komitmen, peningkatan akses layanan TBC, optimalisasi upaya promosi dan pencegahan TBC, pengobatan TBC dan pengendalian infeksi hingga pemanfaatan hasil riset dan teknologi.',
                    style:
                        TextStyle(fontFamily: 'Poppins', color: Colors.black),
                    textAlign: TextAlign.justify,
                  )),

              SizedBox(height: 50),
              Text('Sumber. Kemenkes RI',
                  style: TextStyle(fontFamily: 'Poppins', color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
