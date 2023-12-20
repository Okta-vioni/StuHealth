import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UpdateForm extends StatefulWidget {
  UpdateForm({
    required this.docId,
    required this.judul,
    required this.deskripsi,
    required this.link,
    required this.image,
    required this.tanggal,
  });

  final String docId;
  final String judul;
  final String deskripsi;
  final String link;
  final String image;
  final DateTime tanggal;

  @override
  State<UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  final judulController = TextEditingController();
  final deskripsiController = TextEditingController();
  final linkController = TextEditingController();
  final tanggalController = TextEditingController();

  DateTime? tanggalKegiatan;
  File? image;

  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != tanggalKegiatan) {
      setState(() {
        tanggalKegiatan = pickedDate;
        tanggalController.text =
            DateFormat('dd/MM/yyyy').format(tanggalKegiatan!);
      });
    }
  }

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  Future<void> updateData() async {
    String judul = judulController.text;
    String deskripsi = deskripsiController.text;
    String link = linkController.text;
    if (judul.isEmpty || deskripsi.isEmpty || link.isEmpty) {
      return;
    }

    final Timestamp tanggalTimestamp = Timestamp.fromDate(tanggalKegiatan!);

    await FirebaseFirestore.instance
        .collection('kegiatan')
        .doc(widget.docId)
        .update({
      'judul': judulController.text,
      'deskripsi': deskripsiController.text,
      'tanggal_kegiatan': tanggalTimestamp,
      'link': linkController.text,
    });

    if (image != null) {
      final storageRef =
          FirebaseStorage.instance.ref().child('poster/${widget.docId}.jpg');
      await storageRef.putFile(image!);
      final imageUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('kegiatan')
          .doc(widget.docId)
          .update({
        'image': imageUrl,
      });
    }

    Navigator.pop(context);
  }

  @override
  void initState() {
    judulController.text = widget.judul;
    deskripsiController.text = widget.deskripsi;
    linkController.text = widget.link;
    tanggalController.text = DateFormat('dd/MM/yyyy').format(widget.tanggal);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
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
            color: const Color.fromARGB(255, 2, 128, 144),
            iconSize: 25,
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Edit Kegiatan',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ////////////////////////////////////////////////////  Nama  ////////////////////////////////////////////////
              const Text('Judul',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: judulController,
                  maxLines: 1, // Jumlah baris yang bisa dimasukkan
                  decoration: InputDecoration.collapsed(
                    hintText: 'Masukkan judul kegiatan',
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ),

              ///////////////////////////////////////////////////////////  Deskripsi  ///////////////////////////////////////////////
              const Text(
                'Deskripsi',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: deskripsiController,
                  maxLines: 10, // Jumlah baris yang bisa dimasukkan
                  decoration: InputDecoration.collapsed(
                    hintText: 'Masukkan deskripsi kegiatan',
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ),

////////////////////////////////////////////////////////// Tanggal Kegiatan /////////////////////////////////////////////////////////
              const Text(
                'Tanggal Kegiatan',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(children: [
                  Expanded(
                    child: TextFormField(
                      controller: tanggalController,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Pilih tanggal kegiatan',
                        hintStyle: TextStyle(fontFamily: 'Poppins'),
                      ),
                      readOnly: true,
                    ),
                  ),
                  IconButton(
                    onPressed: pickDate,
                    icon: Icon(Icons.date_range),
                  )
                ]),
              ),

              ///////////////////////////////////////////////////////////  Link  ///////////////////////////////////////////////
              const Text(
                'Link',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: linkController,
                  maxLines: 4, // Jumlah baris yang bisa dimasukkan
                  decoration: InputDecoration.collapsed(
                    hintText: 'Masukkan link kegiatan',
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ),
              ////////////////////////////////////////////////////  Foto  /////////////////////////////////////////////////////
              const Text(
                'Poster Kegiatan',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromARGB(255, 2, 128, 144),
                ),
                child: MaterialButton(
                    onPressed: getImage,
                    child: Text(
                      'Pilih gambar',
                      style:
                          TextStyle(fontFamily: 'Poppins', color: Colors.white),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              if (image != null)
                Image.file(
                  image!,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              if (widget.image.isNotEmpty)
                SizedBox(
                  height: 20,
                ),
              const Text(
                'Gambar Sebelumnya',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Image.network(
                widget.image,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),

///////////////////////////////////////////////////////////  Text  ////////////////////////////////////////////

              Container(
                margin: const EdgeInsets.only(top: 50, bottom: 10),
                child: const Row(
                  children: [
                    Icon(Icons.error, color: Color.fromARGB(255, 2, 128, 144)),
                    Text(
                      'Pastikan semua data yang diimput valid',
                      style: TextStyle(
                          color: Color.fromARGB(255, 2, 128, 144),
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
              ),
////////////////////////////////////////////////////////  Tombol  ///////////////////////////////////////////////////////
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(33, 0, 0, 0),
                          blurRadius: 2,
                          spreadRadius: 1,
                          offset: Offset(2, 2))
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Color.fromARGB(255, 2, 128, 144)),
                child: MaterialButton(
                    child: const Text(
                      'Update Kegiatan',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    onPressed: updateData),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
