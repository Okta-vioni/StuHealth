import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pbl_stuhealth/Admin/AdminDocument/AdminUpdateKegiatan.dart';

class UpKegiatan extends StatefulWidget {
  UpKegiatan({required this.kegiatanId});
  final String kegiatanId;

  @override
  State<UpKegiatan> createState() => _UpKegiatanState();
}

class _UpKegiatanState extends State<UpKegiatan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('kegiatan')
            .doc(widget.kegiatanId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          var output = snapshot.data!.data();
          var judulValue = output!['judul'];
          var deskripsiValue = output['deskripsi'];
          var linkValue = output['link'];
          var tanggalValue = (output['tanggal_kegiatan'] as Timestamp).toDate();
          var imageValue = output['image'];

          return UpdateForm(
              docId: widget.kegiatanId,
              judul: judulValue,
              deskripsi: deskripsiValue,
              link: linkValue,
              image: imageValue,
              tanggal: tanggalValue);
        },
      ),
    );
  }
}
