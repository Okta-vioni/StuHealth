// ignore_for_file: file_names

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/KelolaBerita.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/SemuaBerita.dart';

class EditBeritaTambahBerita extends StatefulWidget {
  const EditBeritaTambahBerita({super.key});

  @override
  State<EditBeritaTambahBerita> createState() => _EditBeritaTambahBeritaState();
}

class _EditBeritaTambahBeritaState extends State<EditBeritaTambahBerita> {
  var judulController = new TextEditingController();
  var sumberController = new TextEditingController();
  var isiController = new TextEditingController();

  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  File? image;

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  Future<String> uploadImage() async {
    try {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = storage.ref().child('gambar_berita/$imageName.jpg');
      await ref.putFile(image!);
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      print('Error uploading image: $error');
      throw Exception('Failed to upload image');
    }
  }

  void submitData() async {
    String judul = judulController.text;
    String isi = isiController.text;
    String sumber = sumberController.text;

    if (judul.isNotEmpty &&
        isi.isNotEmpty &&
        sumber.isNotEmpty &&
        image != null) {
      try {
        //UPLOAD IMAGE TO FIREBASE STORAGE
        String imageUrl = await uploadImage();

        //ADD DATA TO FIRESTORE
        await firestore.collection('berita').add({
          'judul': judul,
          'isi': isi,
          'image': imageUrl,
          'sumber': sumber,
          'timestamp': FieldValue.serverTimestamp(),
        });

        //CLEAR TEXT FIELDS AND IMAGE AFTER SUBMISSION
        judulController.clear();
        isiController.clear();
        sumberController.clear();
        setState(() {
          image = null;
        });

        //SHOW SUCCESS DIALOG
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Sukses'),
                content: Text('Data berhasil ditambahkan!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  )
                ],
              );
            });
      } catch (error) {
        print('Error uploading data: $error');
        //SHOW ERROR DIALOG
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Terjadi Kesalahan'),
                content: Text('Gagal menambahkan data kegiatan.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            });
      }
    } else {
      //SHOW AN ERROR MESSAGES
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Terjadi Kesalahan'),
              content: Text('Tolong isi semua kolom dan unggah gambar.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    }
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
                    builder: (context) => const AdminBeritaSemua(),
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
                            child: const Text('Tambah Berita',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 13,
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
                            child: const Text('Kelola Berita',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 2, 128, 144),
                                    fontFamily: 'Poppins',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EditBeritaKelolaBerita(),
                                  ));
                            }),
                      ),
                    ),
                  ],
                ),
              ),
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
              SizedBox(height: 20),
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
                          fontWeight: FontWeight.w700),
                    ),
                    onPressed: submitData),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
