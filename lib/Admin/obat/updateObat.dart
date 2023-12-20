// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pbl_stuhealth/Admin/obat/KelolaInformasi.dart';
import 'package:pbl_stuhealth/Admin/obat/obatPage.dart';

class UpdateFormObat extends StatefulWidget {
  UpdateFormObat({
    required this.docId,
    required this.nama,
    required this.image,
    required this.definisi,
    required this.penjelasan,
  });

  final String docId;
  final String nama;
  final String image;
  final String definisi;
  final String penjelasan;

  @override
  State<UpdateFormObat> createState() => _UpdateFormObatState();
}

class _UpdateFormObatState extends State<UpdateFormObat> {
  var namaController = new TextEditingController();
  var definisiController = new TextEditingController();
  var penjelasanController = new TextEditingController();

  final firestore = FirebaseFirestore.instance;
  File? image;

  @override
  void initState() {
    super.initState();
    namaController.text = widget.nama;
    definisiController.text = widget.definisi;
    penjelasanController.text = widget.penjelasan;
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
    String nama = namaController.text;
    String definisi = definisiController.text;
    String penjelasan = penjelasanController.text;

    if (nama.isEmpty || definisi.isEmpty || penjelasan.isEmpty) {
      return;
    }

    await FirebaseFirestore.instance
        .collection('obat')
        .doc(widget.docId)
        .update({
      'nama': namaController.text,
      'definisi': definisiController.text,
      'penjelasan': penjelasanController.text,
    });

    if (image != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('gambar_obat/${widget.docId}.jpg');
      await storageRef.putFile(image!);
      final imageUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('obat')
          .doc(widget.docId)
          .update({
        'image': imageUrl,
      });
    }

    Navigator.pop(context);
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminInfoObatVitamin(),
                  ));
            },
            icon: const Icon(Icons.arrow_back),
            color: const Color.fromARGB(255, 2, 128, 144),
            iconSize: 25,
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Edit Informasi',
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
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /////////////////////////////////////////  Tombol Atas  /////////////////////////////////////////////////////////
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(10)),
                            color: const Color.fromARGB(255, 2, 128, 144),
                            border: Border.all(
                                color: const Color.fromARGB(255, 2, 128, 144))),
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: MaterialButton(
                            child: const Text('Tambah Info',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700)),
                            onPressed: () {}),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(10)),
                            color: Colors.white,
                            border: Border.all(
                                color: const Color.fromARGB(255, 2, 128, 144))),
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: MaterialButton(
                            child: const Text('Kelola Info',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 2, 128, 144),
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EditInformasiKelolaInfo(),
                                  ));
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              ////////////////////////////////////////////////////  Nama  ////////////////////////////////////////////////
              const Text(
                'Nama Obat/vitamin',
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
                  controller: namaController,
                  maxLines: 1, // Jumlah baris yang bisa dimasukkan
                  decoration: InputDecoration.collapsed(
                    hintText: 'Berikan Nama',
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ),
              ////////////////////////////////////////////////////  Foto  /////////////////////////////////////////////////////
              const Text(
                'Foto Obat/Vitamin',
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
              ), ///////////////////////////////////////////////////////  Pengertian  /////////////////////////////////////////////
              const Text(
                'Pengertian Singkat Obat/Vitamin',
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
                  controller: definisiController,
                  maxLines: 10, // Jumlah baris yang bisa dimasukkan
                  decoration: InputDecoration.collapsed(
                    hintText: 'Berikan Pengertian Singkat',
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ),
              ///////////////////////////////////////////////////////////  Penjelasan  ///////////////////////////////////////////////
              const Text(
                'Penjelasan Obat/Vitamin',
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
                  controller: penjelasanController,
                  maxLines: 20, // Jumlah baris yang bisa dimasukkan
                  decoration: InputDecoration.collapsed(
                    hintText: 'Berikan Penjelasan',
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ),
////////////////////////////////////////////////////////  Tombol  ///////////////////////////////////////////////////////
              Container(
                margin: EdgeInsets.only(top: 50),
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Color.fromARGB(255, 2, 128, 144)),
                child: MaterialButton(
                  child: const Text(
                    'Tambah Informasi',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  onPressed: updateData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
