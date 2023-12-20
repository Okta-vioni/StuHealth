import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pbl_stuhealth/firebase-service/updateform.dart';

class UpFakta extends StatefulWidget {
  UpFakta({required this.faktaId});
  final String faktaId;

  @override
  State<UpFakta> createState() => _UpFaktaState();
}

class _UpFaktaState extends State<UpFakta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Edit Fakta"),
      // ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('fakta')
            .doc(widget.faktaId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          var output = snapshot.data!.data();
          var judulValue = output!['judul'];
          var deskValue = output['desk'];

          // print(titleValue);
          // print(descValue);

          return UpForm(
            judul: judulValue,
            desk: deskValue,
            fakta: widget.faktaId,
          );
        },
      ),
    );
  }
}
