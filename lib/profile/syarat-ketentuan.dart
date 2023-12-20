// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, avoid_unnecessary_containers

import 'package:flutter/material.dart';

// ignore: camel_case_types
class syaratketentuan extends StatelessWidget {
  const syaratketentuan({super.key});

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
              'Syarat Ketentuan',
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
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: const Text(
                    'SYARAT DAN KETENTUAN PENGGUNA APLIKASI STUHEALTH',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  )),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                color: const Color.fromARGB(255, 2, 128, 144),
                height: 1,
                width: double.infinity,
              ),
///////////////////////////////////////////////////////  Isi Syarat dan ketentuan  //////////////////////////////////////////
              Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Text(
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.justify,
                      'Syarat dan Ketentuan Penggunaan Aplikasi StuHealth berisi semua peraturan dan ketentuan yang secara otomatis mengikat ketika Anda melakukan kunjungan, mengunduh, memasang, menggunakan Aplikasi StuHealth dan/atau menikmati semua fitur dan fasilitas yang disediakan pada Aplikasi StuHealth. Silakan membaca dengan seksama seluruh konten Syarat dan Ketentuan untuk dapat memahami batasan hak dan kewajiban Anda sebagai Pengguna Platform StuHealth. Bilamana tidak setuju dengan konten Syarat dan Ketentuan ini, Anda dapat berhenti mengakses Aplikasi StuHealth.')),
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Text(
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.justify,
                      'Syarat dan Ketentuan ini dapat kami perbaharui dari waktu ke waktu. Pembaruan tersebut akan berlaku setelah Kami tampilkan pada Platform Aplikasi StuHealth. Tanggung jawab Anda untuk meninjau Syarat dan Ketentuan secara berkala. Keberlanjutan Anda atas penggunaan Aplikasi StuHealth setelah adanya setiap pembaharuan tersebut, secara otomatis mengikat Anda.')),
              Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Text(
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w800),
                      textAlign: TextAlign.left,
                      'Penggunaan Aplikasi')),
              Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Text(
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.left,
                      '         1.1. Tujuan Aplikasi')),
              Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Text(
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.justify,
                      'Aplikasi ini ditujukan untuk membantu mahasiswa dalam memantau dan meningkatkan kesehatan mereka. Aplikasi ini tidak menggantikan nasihat medis profesional.')),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                    '         1.2. Pendaftaran'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                    'Anda dapat diminta untuk mendaftar atau membuat akun pengguna. Anda bertanggung jawab atas keamanan akun Anda dan semua aktivitas yang terjadi dalam akun tersebut.'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                    '         2.3. Penggunaan yang Dilarang'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                    'Anda setuju untuk tidak menggunakan Aplikasi ini untuk tujuan ilegal, melanggar hak orang lain, atau untuk mengirimkan informasi yang salah, menyesatkan, atau mengganggu.'),
              ),

              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.left,
                    'Privasi dan Keamanan Data'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                    '         2.1. Privasi'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                    'Kami akan menjaga privasi data Anda sesuai dengan Kebijakan Privasi kami. Dengan menggunakan Aplikasi ini, Anda menyetujui pengumpulan, penggunaan, dan pengungkapan data pribadi Anda sesuai dengan Kebijakan Privasi kami.'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                    '         2.2. Keamanan Data'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                    'Kami akan mengambil tindakan yang wajar untuk menjaga keamanan data Anda. Namun, Anda juga bertanggung jawab untuk menjaga kerahasiaan informasi pribadi Anda dan kata sandi.'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.left,
                    'Konten dan Hak Cipta'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                    '         3.1. Hak Cipta'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                    'Semua konten dalam Aplikasi ini, termasuk tetapi tidak terbatas pada teks, gambar, audio, video, grafik, dan elemen desain, dilindungi oleh hak cipta. Anda tidak diberikan hak untuk menggunakan atau mendistribusikan konten ini tanpa izin tertulis.'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                    '         3.2. Konten Pengguna'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                    'Jika Anda mengunggah atau berkontribusi dengan konten pengguna, Anda menyatakan bahwa Anda memiliki hak atau izin untuk melakukannya, dan Anda memberikan kami lisensi non-eksklusif untuk menggunakan konten tersebut dalam kaitan dengan Aplikasi.'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.left,
                    'Ganti Rugi dan Tanggung Jawab'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                    'Anda setuju untuk membebaskan kami dari segala tuntutan, gugatan, atau kerugian yang timbul dari penggunaan Aplikasi atau pelanggaran terhadap syarat dan ketentuan ini. Kami tidak bertanggung jawab atas kerugian atau kerusakan yang timbul akibat penggunaan Aplikasi.'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.left,
                    'Penutupan Akun'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                    'Kami berhak untuk menutup akun pengguna tanpa pemberitahuan jika ada pelanggaran terhadap syarat dan ketentuan ini atau jika kami menganggapnya perlu.'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.left,
                    'Hukum yang Berlaku'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                    'Syarat dan ketentuan ini diatur oleh hukum yang berlaku di wilayah hukum kami.'),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.left,
                    'Kontak'),
              ),

              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                    'Jika Anda memiliki pertanyaan atau masukan mengenai syarat dan ketentuan ini, silakan hubungi kami melalui Email kami yakni stuhealth.polibatam@gmail.com atau melalui akun media sosial Instagram kami @stu.health'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
