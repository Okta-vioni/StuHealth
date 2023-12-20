import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpForm extends StatefulWidget {
  UpForm({
    required this.judul,
    required this.desk,
    required this.fakta,
  });

  final String judul;
  final String desk;
  final String fakta;

  @override
  State<UpForm> createState() => _UpFormState();
}

class _UpFormState extends State<UpForm> {
  final judulController = TextEditingController();
  final deskController = TextEditingController();

  @override
  void initState() {
    judulController.text = widget.judul;
    deskController.text = widget.desk;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: AppBar(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          leading: IconButton(
            padding: const EdgeInsets.only(top: 20),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: const Color.fromARGB(255, 0, 132, 119),
            iconSize: 25,
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Edit Fakta',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Judul',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 0, 132, 119)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: judulController,
                maxLines: 1, // Jumlah baris yang bisa dimasukkan
                decoration: const InputDecoration.collapsed(
                  hintText: 'Masukkan judul fakta',
                  hintStyle: TextStyle(fontFamily: 'Poppins'),
                ),
              ),
            ),
////////////////////////////////////////////////  Deskripsi  //////////////////////////////////////////////
            const Text(
              'Deskripsi',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 0, 132, 119)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: deskController,
                maxLines: 5, // Jumlah baris yang bisa dimasukkan
                decoration: const InputDecoration.collapsed(
                  hintText: 'Masukkan deskripsi fakta',
                  hintStyle: TextStyle(fontFamily: 'Poppins'),
                ),
              ),
            ),
//////////////////////////////////////////  Tombol  //////////////////////////////////////////////////////
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromARGB(255, 0, 132, 119),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(33, 0, 0, 0),
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(1, 1))
                ],
              ),
              child: MaterialButton(
                  child: const Text('Perbarui Fakta',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15)),
                  onPressed: () {
                    var collection =
                        FirebaseFirestore.instance.collection('fakta');
                    collection.doc(widget.fakta).update({
                      'judul': judulController.text,
                      'desk': deskController.text,
                    });
                    Navigator.pop(context);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
