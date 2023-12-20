import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart' as local;
import 'package:pbl_stuhealth/Admin/AdminDocument/AdminEditKegiatanTambahKegiatan.dart';
import 'package:pbl_stuhealth/Admin/AdminDocument/AdminisiKotakJadwal.dart';

class AdminHalamanDocument extends StatefulWidget {
  const AdminHalamanDocument({super.key});

  @override
  State<AdminHalamanDocument> createState() => _AdminHalamanDocumentState();
}

class _AdminHalamanDocumentState extends State<AdminHalamanDocument> {
  late Stream<QuerySnapshot> kegiatanStream;

  @override
  void initState() {
    super.initState();
    kegiatanStream = FirebaseFirestore.instance
        .collection('kegiatan')
        .orderBy('tanggal_kegiatan', descending: false)
        .snapshots();
    local.initializeDateFormatting('id_ID', null);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final bodyHeight = mediaQueryHeight;
    return Scaffold(
      body: Column(
        children: [
          ///////////////////////////////////////////  Appbar  //////////////////////////////////////////
          Container(
              padding: const EdgeInsets.only(left: 25, top: 70),
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
              height: bodyHeight * 0.14,
              width: double.infinity,
              child: const Text(
                'Pemberitahuan Kegiatan',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                    color: Colors.black),
                textAlign: TextAlign.left,
              )),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 50, left: 50, top: 50),
                child: Image.asset('img/Document.png'),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, right: 5, left: 5),
                  color: const Color.fromARGB(255, 2, 128, 144),
                  child: const Text(
                    'Dapatkan informasi kegiatan atau program kesehatan kampus dengan cepat dan terpercaya',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10, right: 20),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: const Color.fromARGB(255, 2, 128, 144)),
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
                    'Edit Kegiatan',
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
                              const AdminEditKegiatanTambahKegiatan(),
                        ));
                  },
                ),
              ),
            ],
          ),

          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 20, top: 10),
            child: const Text(
              'Jadwal Kegiatan Kesehatan Kampus',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ),
          ),
///////////////////////////////////////////////////  Edit Kegiatan  ///////////////////////////////////////////////////////////

          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: kegiatanStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              return ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var document = snapshot.data!.docs[index];
                  var tanggalKegiatan =
                      (document['tanggal_kegiatan'] as Timestamp).toDate();

                  var judulKegiatan = document['judul'];
                  var deskripsiKegiatan = document['deskripsi'];
                  var posterKegiatan = document['image'];
                  var documentId = document.id;

                  return Padding(
                    padding: EdgeInsets.all(0),
                    child: Column(children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: KotakJadwalKegiatan(
                                  documentId: documentId,
                                  tanggalKegiatan: tanggalKegiatan,
                                  posterKegiatan: posterKegiatan,
                                  judulKegiatan: judulKegiatan,
                                  deskripsiKegiatan: deskripsiKegiatan),
                            )
                          ],
                        ),
                      )
                    ]),
                  );
                },
              );
            },
          ))
        ],
      ),
    );
  }
}

/////////////////////////////////////////////////////////////  Kotak Kotak  ///////////////////////////////////////////////////////////
class KotakJadwalKegiatan extends StatefulWidget {
  const KotakJadwalKegiatan({
    super.key,
    required this.documentId,
    required this.tanggalKegiatan,
    required this.posterKegiatan,
    required this.judulKegiatan,
    required this.deskripsiKegiatan,
  });

  final String documentId;
  final DateTime tanggalKegiatan;
  final String posterKegiatan;
  final String judulKegiatan;
  final String deskripsiKegiatan;

  @override
  State<KotakJadwalKegiatan> createState() => _KotakJadwalKegiatanState();
}

class _KotakJadwalKegiatanState extends State<KotakJadwalKegiatan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${DateFormat('EEEE, d MMMM y', 'id_ID').format(widget.tanggalKegiatan)}',
            // 'Tanggal Kegiatan: ${DateFormat('EEEE, d MMMM yyyy').format(widget.tanggalKegiatan)}',
            style: const TextStyle(
              color: Color.fromARGB(255, 2, 128, 144),
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
            ),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AdminIsiKotakJadwal(documentId: widget.documentId),
                    ));
              },
              child: Row(
                children: [
                  Image.network(
                    widget.posterKegiatan,
                    height: 80,
                    width: 80,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.judulKegiatan,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          widget.deskripsiKegiatan,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
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
