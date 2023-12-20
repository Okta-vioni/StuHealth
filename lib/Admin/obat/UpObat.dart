import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pbl_stuhealth/Admin/obat/updateObat.dart';

class UpObat extends StatefulWidget {
  UpObat({required this.obatId});
  final String obatId;

  @override
  State<UpObat> createState() => _UpObatState();
}

class _UpObatState extends State<UpObat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('obat')
            .doc(widget.obatId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          var output = snapshot.data!.data();
          var namaValue = output!['nama'];
          var definisiValue = output['definisi'];
          var imageValue = output['image'];
          var penjelasanValue = output['penjelasan'];

          return UpdateFormObat(
              docId: widget.obatId,
              nama: namaValue,
              penjelasan: penjelasanValue,
              image: imageValue,
              definisi: definisiValue);
        },
      ),
    );
  }
}
