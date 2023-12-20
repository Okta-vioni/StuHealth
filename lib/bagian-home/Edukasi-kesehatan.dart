// ignore_for_file: file_names
import 'package:flutter/material.dart';

class EdukasiKesehatan extends StatelessWidget {
  const EdukasiKesehatan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
            backgroundColor: Colors.white,
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
                'Edukasi Kesehatan',
                style: TextStyle(
                    color: Color.fromARGB(255, 2, 128, 144),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700),
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PROSEDUR PERTOLONGAN PERTAMA',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Berikut ini beberapa prosedur pertolongan pertama yang perlu diketahui oleh mahasiswa:',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 10,
              ),
              JudulText(Judul: '1. Panggil Bantuan Darurat'),
              IsiEdukasi(
                  IsiBawah:
                      'Langkah pertama adalah selalu memanggil nomor darurat (misalnya, 119 atau 112) jika situasi memerlukan bantuan medis profesional segera.'),
              JudulText(Judul: '2. Evaluasi Keamanan'),
              IsiEdukasi(
                  IsiBawah:
                      'Pastikan area sekitar aman untuk Anda dan orang yang cedera. Jika ada bahaya, pastikan untuk mengamankannya terlebih dahulu sebelum memberikan pertolongan.'),
              JudulText(Judul: '3. Cek Respons'),
              IsiEdukasi(
                  IsiBawah:
                      'Cobalah berbicara dengan orang yang cedera. Tanyakan apakah mereka baik-baik saja dan jika mereka tidak merespons, periksa apakah mereka sadar dengan memberi tepukan ringan pada bahu dan memanggil nama mereka.'),
              JudulText(Judul: '4. Periksa Pernapasan'),
              IsiEdukasi(
                  IsiBawah:
                      'Pastikan bahwa orang tersebut sedang bernapas. Anda dapat melihat dada naik dan turun, mendengarkan napas, atau merasakan napas di hidung atau mulut mereka. Jika mereka tidak bernapas, mulailah CPR.'),
              JudulText(Judul: '5. CPR (Cardiopulmonary Resuscitation)'),
              IsiEdukasi(
                  IsiBawah:
                      'Jika orang tersebut tidak bernapas atau tidak memiliki detak jantung yang terasa, Anda harus memulai CPR. CPR terdiri dari kompresi dada yang dalam dan cepat (30 kompresi) diikuti dengan dua napas buatan (respirasi) hingga bantuan medis tiba. Ikuti panduan CPR yang diperbarui, dan jika Anda tidak terlatih, lakukan kompresi dada saja.'),
              JudulText(Judul: '6. Hentikan Perdarahan'),
              IsiEdukasi(
                  IsiBawah:
                      'Jika seseorang mengalami perdarahan berat, gunakan kain bersih atau pembalut steril untuk menekan luka dan menghentikan perdarahan. Tekan dengan kuat dan tahan tekanan selama beberapa menit.'),
              JudulText(Judul: '7. Perlakuan Terhadap Luka'),
              IsiEdukasi(
                  IsiBawah:
                      'Bersihkan luka dengan air bersih jika mungkin, dan tutup dengan perban steril atau kain bersih. Jangan mencoba mengeluarkan benda asing dari luka.'),
              JudulText(Judul: '8. Gangguan Pernapasan'),
              IsiEdukasi(
                  IsiBawah:
                      'Jika seseorang tersedak, berikan tindakan Heimlich untuk menghilangkan benda asing dari saluran pernapasan mereka. Jika seseorang memiliki asma atau alergi, bantu mereka menggunakan inhaler atau epinefrin jika diperlukan.'),
              JudulText(Judul: '9. Patah Tulang'),
              IsiEdukasi(
                  IsiBawah:
                      'Imobilisasi anggota tubuh yang patah dengan pembalut, kayu, atau apa pun yang tersedia untuk mengurangi gerakan dan nyeri.'),
              JudulText(Judul: '10. Luka Bakar'),
              IsiEdukasi(
                  IsiBawah:
                      'Dinginkan luka bakar dengan air dingin selama setidaknya 10-20 menit. Jangan gunakan es atau bahan kimia lainnya.'),
              JudulText(Judul: '11. Reaksi Alergi'),
              IsiEdukasi(
                  IsiBawah:
                      'Jika seseorang mengalami reaksi alergi yang parah (anafilaksis), berikan epinefrin jika tersedia dan jika mereka memiliki resepnya.'),
              JudulText(Judul: '12. Hipoglikemia (Gula Darah Rendah)'),
              IsiEdukasi(
                  IsiBawah:
                      'Berikan sumber gula cepat, seperti permen atau minuman manis, kepada seseorang yang mengalami hipoglikemia.'),
              JudulText(Judul: '13. Serangan Jantung atau Stroke'),
              IsiEdukasi(
                  IsiBawah:
                      'Bantu seseorang yang mengalami serangan jantung atau stroke dengan memanggil bantuan darurat dan memberikan pertolongan yang sesuai dengan tanda dan gejala yang mereka alami.'),
              JudulText(Judul: '14. Luka Tumpul'),
              IsiEdukasi(
                  IsiBawah:
                      'Luka tumpul seperti pada kepala, tulang belakang, atau punggung, Jangan menggerakkan korban jika Anda mencurigai cedera pada kepala, tulang belakang, atau punggung. Panggil bantuan dan tunggu petugas medis datang.'),
              JudulText(Judul: '15. Gangguan Pernapasan Anak'),
              IsiEdukasi(
                  IsiBawah:
                      'Pertolongan pertama untuk anak-anak melibatkan CPR yang disesuaikan dengan ukuran mereka dan menghindari risiko tersedak atau kecelakaan lainnya.'),
            ],
          ),
        ),
      ),
    );
  }
}

class JudulText extends StatelessWidget {
  const JudulText({super.key, required this.Judul});

  final String Judul;
  @override
  Widget build(BuildContext context) {
    return Text(Judul,
        style: TextStyle(
            fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 14));
  }
}

class IsiEdukasi extends StatelessWidget {
  const IsiEdukasi({super.key, required this.IsiBawah});

  final String IsiBawah;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
      child: Text(
        IsiBawah,
        style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
