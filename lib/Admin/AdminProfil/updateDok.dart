// ignore_for_file: file_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateFormDokter extends StatefulWidget {
  UpdateFormDokter({
    required this.docId,
    required this.nama,
    required this.image,
    required this.kategori,
    required this.limit,
    required this.status,
  });

  final String docId;
  final String nama;
  final String image;
  final String kategori;
  final String limit;
  final String status;

  @override
  State<UpdateFormDokter> createState() => _UpdateFormDokterState();
}

class _UpdateFormDokterState extends State<UpdateFormDokter> {
  var namaController = new TextEditingController();
  var kategoriController = new TextEditingController();
  var limitController = new TextEditingController();

  final firestore = FirebaseFirestore.instance;
  File? image;
  late List<String> statusList;

  @override
  void initState() {
    super.initState();
    namaController.text = widget.nama;
    kategoriController.text = widget.kategori;
    limitController.text = widget.limit;
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
    String kategori = kategoriController.text;
    String limit = limitController.text;

    if (nama.isEmpty || kategori.isEmpty || limit.isEmpty) {
      return;
    }

    await FirebaseFirestore.instance
        .collection('dokter')
        .doc(widget.docId)
        .update({
      'nama': namaController.text,
      'kategori': kategoriController.text,
      'limit': limitController.text,
      'status': limitController.text.compareTo('0') > 0
          ? 'Tersedia'
          : 'Tidak Tersedia',
    });

    if (image != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('foto_dokter/${widget.docId}.jpg');
      await storageRef.putFile(image!);
      final imageUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('dokter')
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
            padding: const EdgeInsets.only(top: 20, left: 20),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: const Color.fromARGB(255, 2, 128, 144),
            iconSize: 25,
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Text(
              'Tambah Dokter',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ////////////////////////////////////////////////////  Nama  ////////////////////////////////////////////////
              const Text(
                'Nama Dokter',
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
                'Foto',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 2, 128, 144),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: MaterialButton(
                    onPressed: getImage,
                    child: Text(
                      'Pilih gambar',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    )),
              ),

              SizedBox(
                height: 10,
              ),
              if (image != null)
                Image.file(
                  image!,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              SizedBox(
                height: 20,
              ),
              ///////////////////////////////////////////////////////  Kategori  /////////////////////////////////////////////
              const Text(
                'Kategori',
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
                  controller: kategoriController,
                  maxLines: 1, // Jumlah baris yang bisa dimasukkan
                  decoration: InputDecoration.collapsed(
                    hintText: 'Berikan Kategori Dokter',
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ),
              ///////////////////////////////////////////////////////////  Limit Konsultasi  ///////////////////////////////////////////////
              const Text(
                'Limit Konsultasi',
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
                  controller: limitController,
                  maxLines: 1, // Jumlah baris yang bisa dimasukkan
                  keyboardType: TextInputType.number,

                  decoration: InputDecoration.collapsed(
                    hintText: 'Berikan Limit Konsultasi',
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ),
///////////////////////////////////////////////////////////////  Tombol  //////////////////////////////////////////////////////////
              Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 2, 128, 144),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                width: double.infinity,
                child: MaterialButton(
                    child: const Text('Tambah',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700)),
                    onPressed: () {
                      updateData();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
