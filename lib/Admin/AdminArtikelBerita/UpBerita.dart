import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/updateBerita.dart';

class UpBerita extends StatefulWidget {
  UpBerita({required this.beritaId});
  final String beritaId;

  @override
  State<UpBerita> createState() => _UpBeritaState();
}

class _UpBeritaState extends State<UpBerita> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('berita')
            .doc(widget.beritaId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          var output = snapshot.data!.data();
          var judulValue = output!['judul'];
          var isiValue = output['isi'];
          var imageValue = output['image'];
          var sumberValue = output['sumber'];

          return UpdateFormBerita(
              docId: widget.beritaId,
              judul: judulValue,
              isi: isiValue,
              image: imageValue,
              sumber: sumberValue);
        },
      ),
    );
  }
}
