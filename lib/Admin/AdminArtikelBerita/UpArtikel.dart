import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/updateArtikel.dart';

class UpArtikel extends StatefulWidget {
  UpArtikel({required this.artikelId});
  final String artikelId;

  @override
  State<UpArtikel> createState() => _UpArtikelState();
}

class _UpArtikelState extends State<UpArtikel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('artikel')
            .doc(widget.artikelId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          var output = snapshot.data!.data();
          var judulValue = output!['judul'];
          var isiValue = output['isi'];
          var kategoriValue = output['kategori'];
          var imageValue = output['image'];

          return UpdateFormArtikel(
              docId: widget.artikelId,
              judul: judulValue,
              isi: isiValue,
              image: imageValue,
              kategori: kategoriValue);
        },
      ),
    );
  }
}
