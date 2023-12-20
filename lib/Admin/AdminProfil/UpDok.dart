import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pbl_stuhealth/Admin/AdminProfil/updateDok.dart';

class UpDokter extends StatefulWidget {
  UpDokter({required this.dokterId});
  final String dokterId;

  @override
  State<UpDokter> createState() => _UpDokterState();
}

class _UpDokterState extends State<UpDokter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('dokter')
            .doc(widget.dokterId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          var output = snapshot.data!.data();
          var namaValue = output!['nama'];
          var limitValue = output['limit'];
          var kategoriValue = output['kategori'];
          var imageValue = output['image'];
          var statusValue = output['status'];

          return UpdateFormDokter(
              docId: widget.dokterId,
              nama: namaValue,
              image: imageValue,
              kategori: kategoriValue,
              limit: limitValue,
              status: statusValue);
        },
      ),
    );
  }
}
