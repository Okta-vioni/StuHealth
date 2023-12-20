// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: camel_case_types
class AdminisikotakArtikelInsomnia extends StatelessWidget {
  const AdminisikotakArtikelInsomnia({super.key});

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
              'Artikel Kesehatan',
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
                child: Center(
                  child: Image.asset(
                    'img/poster1.jpeg',
                  ),
                ),
              ),
////////////////////////////////////////////////  Kotak List  ///////////////////////////////////////////////
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, right: 10, left: 10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      border: Border.all(
                          color: const Color.fromARGB(255, 2, 128, 144))),
                  child: const Text(
                    'Insomnia',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 2, 128, 144)),
                  ),
                ),
              ),
/////////////////////////////////////////////////// Judul /////////////////////////////////////////////////
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 10),
                child: const Text(
                  'Menjaga Kesehatan Di Bulan Suci Ramadhan',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                      fontSize: 25),
                ),
              ),
/////////////////////////////////////////////////////////  Tanggal  ////////////////////////////////////////////
              Text(
                '4 November 2023',
                style: TextStyle(fontFamily: 'Poppins', color: Colors.grey),
              ),

//////////////////////////////////////////////// Isi text ///////////////////////////////////////////////////////
//////////////////////////////////////////////// Isi text ///////////////////////////////////////////////////////
              TextArtikel(
                  IsiText:
                      'Seperti apa yang kita tahu bahwa apa perubahan tentang pola hidup manusia selama kita menjalani puasa Ramadhan, kehidupan yang dulu kita istirahatnya lebih banyak di malam hari sebagai seorang umat Islam biasanya ada aktivitas di luar makan sahur dsb, ada ibadah yang dilakukan di malam hari, makan juga ada batas waktunya sebelum fajar sehingga kita harus mempersiapkan diri dengan pola hidup kita tetap menjalani kehidupan seperti biasa tetapi tidak terganggu kualitas hidup misalnya ada keluhan pusing – pusing sedikit, laper itu pasti, haus itu pasti, tetapi kita harus bisa menjalani hidup kita dari fajar sampai adzan Maghrib itu dengan tetap fit dengan tanpa gangguan suatu apapun'),

              TextArtikel(
                  IsiText:
                      'Bugar ketika menjalani puasa Ramadhan itu wajib, bugar itu sendiri bisa dipengaruhi oleh 3 hal, yaitu '),
              ListTextArtikel(
                  ListText:
                      '(1) apa yang kita masukkan ke dalam tubuh baik nutrisi maupun makanan,'),
              ListTextArtikel(
                  ListText:
                      '(2) bagaimana kita membagi pola aktivitas dengan istirahat dan '),
              ListTextArtikel(
                  ListText:
                      '(3) menjaga tubuh dengan olahraga. Jadi ketiganya harus seimbang.'),

              TextArtikel(
                  IsiText:
                      'Selama bulan Ramadhan kita tetap melakukan aktivitas pokok seperti biasanya, aktivitas tambahan lainnya seperti Sholat Tarawih dan mengaji. Supaya badan kita tetap fit maka istirahat harus teratur, minimal bisa tidur 4 jam pada malam hari.'),

              TextArtikel(
                  IsiText:
                      'Ketika puasa, tubuh membutuhkan 2 liter cairan. Minum 2 liter pada saat buka puasa, menjelang Tarawih, setelah Tarawih dan pada saat sahur, disarankan tidak minum menjelang tidur karena akan mengganggu tidur kita. Tidak minum 1 jam sebelum tidur, karena dapat mengganggu tidur yang nantinya kita buang air kecil sehingga kita ketika tertidur bisa sedikit – sedikit bangun.'),

              TextArtikel(
                  IsiText:
                      'Yuuk jaga kesehatan di Bulan Suci Ramadhan…tetap waspada Covid-19 dan konsumsi makanan bergizi…'),
              ListTextArtikel(ListText: 'Terima Kasih ~'),
              ListTextArtikel(ListText: 'salam sehat selalu...'),

//////////////////////////////////////////////////  Sumber  ///////////////////////////////////
              SizedBox(
                height: 50,
              ),
              Text('Sumber. RS Ananda Purwokerto',
                  style: TextStyle(fontFamily: 'Poppins', color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}

class TextArtikel extends StatelessWidget {
  const TextArtikel({super.key, required this.IsiText});

  final String IsiText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Text(
        IsiText,
        style: TextStyle(fontFamily: 'Poppins', fontSize: 15),
        textAlign: TextAlign.justify,
      ),
    );
  }
}

class ListTextArtikel extends StatelessWidget {
  const ListTextArtikel({super.key, required this.ListText});

  final String ListText;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        ListText,
        style: TextStyle(fontFamily: 'Poppins', fontSize: 15),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
