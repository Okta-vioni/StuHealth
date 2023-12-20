import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/KelolaBerita.dart';

class UpdateFormBerita extends StatefulWidget {
  UpdateFormBerita({
    required this.docId,
    required this.judul,
    required this.isi,
    required this.image,
    required this.sumber,
  });

  final String docId;
  final String judul;
  final String isi;
  final String image;
  final String sumber;

  @override
  State<UpdateFormBerita> createState() => _UpdateFormBeritaState();
}

class _UpdateFormBeritaState extends State<UpdateFormBerita> {
  final judulController = TextEditingController();
  final isiController = TextEditingController();
  final sumberController = TextEditingController();

  final firestore = FirebaseFirestore.instance;

  File? image;

  @override
  void initState() {
    super.initState();
    judulController.text = widget.judul;
    isiController.text = widget.isi;
    sumberController.text = widget.sumber;
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
    String isi = isiController.text;
    if (judul.isEmpty || isi.isEmpty) {
      return;
    }

    await FirebaseFirestore.instance
        .collection('berita')
        .doc(widget.docId)
        .update({
      'judul': judulController.text,
      'isi': isiController.text,
      'sumber': sumberController.text,
    });

    if (image != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('gambar_berita/${widget.docId}.jpg');
      await storageRef.putFile(image!);
      final imageUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('berita')
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
                    builder: (context) => const EditBeritaKelolaBerita(),
                  ));
            },
            icon: const Icon(Icons.arrow_back),
            color: const Color.fromARGB(255, 2, 128, 144),
            iconSize: 25,
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Edit Berita',
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
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ////////////////////////////////////////////////////  Judul  ////////////////////////////////////////////////
              const Text(
                'Judul',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
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
                    hintText: 'Berikan Judul',
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ),
              ////////////////////////////////////////////////////  Foto  /////////////////////////////////////////////////////
              const Text(
                'Poster/Gambar',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),

              Container(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromARGB(255, 2, 128, 144),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(64, 158, 158, 158),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(4, 4))
                    ],
                  ),
                  child: MaterialButton(
                    onPressed: getImage,
                    child: const Text('Pilih Gambar',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.w700)),
                  )),
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
              if (widget.image.isNotEmpty)
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
              SizedBox(
                height: 10,
              ),
              ///////////////////////////////////////////////////////  Sumber/Penulis  /////////////////////////////////////////////
              const Text(
                'Sumber/Penulis',
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
                  controller: sumberController,
                  maxLines: 1, // Jumlah baris yang bisa dimasukkan
                  decoration: InputDecoration.collapsed(
                    hintText: 'Berikan Sumber/Penulis',
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ),

              ///////////////////////////////////////////////////////////  Penjelasan  ///////////////////////////////////////////////
              const Text(
                'Isi Berita',
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
                  controller: isiController,
                  maxLines: 20, // Jumlah baris yang bisa dimasukkan
                  decoration: InputDecoration.collapsed(
                    hintText: 'Berikan Penjelasan',
                    hintStyle: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ),
////////////////////////////////////////////////////////  Tombol  ///////////////////////////////////////////////////////
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Color.fromARGB(255, 2, 128, 144)),
                child: MaterialButton(
                    child: const Text(
                      'Tambah Berita',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
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
