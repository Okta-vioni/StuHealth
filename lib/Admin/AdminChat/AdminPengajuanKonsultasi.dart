import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pbl_stuhealth/Admin/AdminChat/AdminChatToUser.dart';

class AdminPengajuanKonsultasi extends StatefulWidget {
  final String documentId;
  const AdminPengajuanKonsultasi({super.key, required this.documentId});

  @override
  State<AdminPengajuanKonsultasi> createState() =>
      _AdminPengajuanKonsultasiState();
}

class _AdminPengajuanKonsultasiState extends State<AdminPengajuanKonsultasi> {
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
              'Pengajuan Konsultasi',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('konsultasi')
                .doc(widget.documentId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData || !snapshot.data!.exists) {
                // The document doesn't exist
                return Container(
                  padding: EdgeInsets.only(top: 250),
                  alignment: Alignment.center,
                  child: Text(
                    'Data Sudah Tidak Tersedia',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 102, 102, 102)),
                  ),
                );
              }

              var data = snapshot.data!.data() as Map<String, dynamic>;

              return Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///////////////////////////////////////////////////  Identitas Mahasiswa  ///////////////////////////////////////////////////

                    const Text('Identitas Mahasiswa',
                        style: TextStyle(
                            color: Color.fromARGB(255, 2, 128, 144),
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w700)),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      height: 1,
                      width: double.infinity,
                      color: const Color.fromARGB(255, 2, 128, 144),
                    ),
                    //////////////////////////////////////////////  Biodata ////////////////////////////////////////////
                    const Pertanyaan(IsiPertanyaan: 'Nama Lengkap :'),
                    KotakJawaban(IsiJawaban: data['nama']),

                    const Pertanyaan(IsiPertanyaan: 'NIM :'),
                    KotakJawaban(IsiJawaban: data['nim']),

                    const Pertanyaan(IsiPertanyaan: 'Jenis Kelamin :'),
                    KotakJawaban(IsiJawaban: data['jenis kelamin']),

                    const Pertanyaan(IsiPertanyaan: 'Umur :'),
                    KotakJawaban(IsiJawaban: data['umur']),

                    const Pertanyaan(IsiPertanyaan: 'Nomor Telepon:'),
                    KotakJawaban(IsiJawaban: data['nohp']),

                    ///////////////////////////////////////////////////  Identitas Mahasiswa  ///////////////////////////////////////////////////
                    const SizedBox(height: 20),
                    const Text('Informasi Medis',
                        style: TextStyle(
                            color: Color.fromARGB(255, 2, 128, 144),
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w700)),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      height: 1,
                      width: double.infinity,
                      color: const Color.fromARGB(255, 2, 128, 144),
                    ),
                    //////////////////////////////////////////////////////  Pertanyaan Medis  //////////////////////////////////
                    const Pertanyaan(
                        IsiPertanyaan:
                            'Apakah Anda memiliki riwayat kesehatan yang relevan, seperti alergi, penyakit kronis, atau operasi sebelumnya? (Jelaskan jika ada)'),
                    KotakJawaban(IsiJawaban: data['report 1']),

                    const Pertanyaan(
                        IsiPertanyaan:
                            'Apa keluhan kesehatan yang Anda alami? (Jelaskan dengan singkat)'),
                    KotakJawaban(IsiJawaban: data['report 2']),

                    const Pertanyaan(
                        IsiPertanyaan:
                            'Apakah keluhan ini semakin memburuk atau stabil?'),
                    KotakJawaban(IsiJawaban: data['report 3']),

                    const Pertanyaan(
                        IsiPertanyaan:
                            'Apakah Anda sedang mengonsumsi obat-obatan atau suplemen tertentu? (Jelaskan jenis dan dosisnya)'),
                    KotakJawaban(IsiJawaban: data['report 4']),
                    ///////////////// Janji Temu ///////////////////////
                    const SizedBox(height: 20),
                    const Text('Pengajuan Janji Temu',
                        style: TextStyle(
                            color: Color.fromARGB(255, 2, 128, 144),
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w700)),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      height: 1,
                      width: double.infinity,
                      color: const Color.fromARGB(255, 2, 128, 144),
                    ),
                    const Pertanyaan(IsiPertanyaan: 'Dengan Dokter:'),
                    KotakJawaban(IsiJawaban: data['nama dokter']),

                    const Pertanyaan(IsiPertanyaan: 'Pada tanggal:'),
                    KotakJawaban(IsiJawaban: data['tanggal']),

                    const Pertanyaan(IsiPertanyaan: 'Jam:'),
                    KotakJawaban(IsiJawaban: data['jam']),

                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                        'Segera kirim pesan untuk mengatur jadwal konsultasi mahasiswa.',
                        style: TextStyle(
                            color: Color.fromARGB(255, 2, 128, 144),
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Color.fromARGB(255, 2, 128, 144)),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AdminChatToUser(
                                        receiverUserEmail: data['nama'],
                                        receiverUserID: data['uid'],
                                        chatBot:
                                            'Terima kasih telah mengajukan konsultasi kesehatan melalui aplikasi kami. Pengajuan konsultasi kesehatan anda diterima, kami akan segera meninjau informasi yang Anda berikan dan akan menghubungi Anda dalam waktu singkat untuk menentukan jadwal konsultasi yang sesuai. Berikut data atau informasi kesehatan yang anda isi diform pengajuan: Nama: ${data['nama']}, NIM: ${data['nim']}, Jenis Kelamin: ${data['jenis kelamin']}, Umur: ${data['umur']}, Nomor Telepon: ${data['nohp']}, Janji temu dengan dokter: ${data['nama dokter']}, pada tanggal: ${data['tanggal']} dan jam: ${data['jam']}.',
                                      ),
                                    ));
                              },
                              child: const Text('Terima',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                color: Color.fromARGB(255, 255, 17, 0)),
                            child: MaterialButton(
                              onPressed: () async {
                                //delete document
                                await FirebaseFirestore.instance
                                    .collection('konsultasi')
                                    .doc(widget.documentId)
                                    .delete();

                                //navigatorpush
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AdminChatToUser(
                                        receiverUserEmail: data['nama'],
                                        receiverUserID: data['uid'],
                                        chatBot:
                                            'Terima kasih telah mengajukan konsultasi kesehatan melalui aplikasi kami. Mohon maaf pengajuan konsultasi kesehatan anda ditolak, silahkan ajukan kembali!',
                                      ),
                                    ));
                              },
                              child: const Text('Tolak',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Color.fromARGB(255, 2, 128, 144)),
                      child: MaterialButton(
                        onPressed: () async {
                          //delete document
                          await FirebaseFirestore.instance
                              .collection('konsultasi')
                              .doc(widget.documentId)
                              .delete();

                          //navigatorpush
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminChatToUser(
                                  receiverUserEmail: data['nama'],
                                  receiverUserID: data['uid'],
                                  chatBot: 'Konsultasi kamu selesai',
                                ),
                              ));
                        },
                        child: const Text('Selesai',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

//////////////////////////////////////////////  Pertanyaan  ////////////////////////////////////////////
class Pertanyaan extends StatelessWidget {
  const Pertanyaan({
    super.key,
    required this.IsiPertanyaan,
  });
  final String IsiPertanyaan;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Text(IsiPertanyaan,
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w500)),
    );
  }
}

/////////////////////////////////////////////  Kotak Jawaban  ////////////////////////////////////////
class KotakJawaban extends StatelessWidget {
  const KotakJawaban({super.key, required this.IsiJawaban});

  final String IsiJawaban;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 10),
      child: Text(IsiJawaban,
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w700)),
    );
  }
}
