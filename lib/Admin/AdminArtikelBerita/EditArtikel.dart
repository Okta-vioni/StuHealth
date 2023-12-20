// ignore_for_file: file_names

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/KelolaArtikel.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/SemuaArtikel.dart';

class EditArtikelTambahArtikel extends StatefulWidget {
  const EditArtikelTambahArtikel({super.key});

  @override
  State<EditArtikelTambahArtikel> createState() =>
      _EditArtikelTambahArtikelState();
}

class _EditArtikelTambahArtikelState extends State<EditArtikelTambahArtikel> {
  var judulController = new TextEditingController();
  var isiController = new TextEditingController();

  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  File? image;
  String selectedKategori = 'Pilih Kategori';
  late List<String> kategoriList = [
    'Pilih Kategori',
    'Gaya Hidup Sehat',
    'Gangguan Tidur',
    'Kesehatan Mata',
    'Gangguan Pencernaan'
  ];

  void onChanged(String? value) {
    if (value != null) {
      setState(() {
        selectedKategori = value;
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

  Future<String> uploadImage() async {
    try {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = storage.ref().child('gambar_artikel/$imageName.jpg');
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

    if (judul.isNotEmpty &&
        isi.isNotEmpty &&
        selectedKategori != 'Pilih Kategori' &&
        image != null) {
      try {
        //UPLOAD IMAGE TO FIREBASE STORAGE
        String imageUrl = await uploadImage();

        //ADD DATA TO FIRESTORE
        await firestore.collection('artikel').add({
          'judul': judul,
          'isi': isi,
          'image': imageUrl,
          'kategori': selectedKategori,
          'timestamp': FieldValue.serverTimestamp(),
        });

        //CLEAR TEXT FIELDS AND IMAGE AFTER SUBMISSION
        judulController.clear();
        isiController.clear();
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
    // ignore: unnecessary_null_comparison
    if (kategoriList == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
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
                    builder: (context) => const AdminartikelSemua(),
                  ));
            },
            icon: const Icon(Icons.arrow_back),
            color: const Color.fromARGB(255, 2, 128, 144),
            iconSize: 25,
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Edit Artikel',
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
                            child: const Text('Tambah Artikel',
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
                            child: const Text('Kelola Artikel',
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
                                        const EditArtikelKelolaArtikel(),
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
                height: 20,
              ),
              if (image != null)
                Image.file(
                  image!,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              SizedBox(
                height: 10,
              ),
              // const UploadFotoArtikelTambahArtikel(),
              ///////////////////////////////////////////////////////  Kategori  /////////////////////////////////////////////
              const Text(
                'Kategori Artikel',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 2, 128, 144)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedKategori,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedKategori = newValue!;
                        });
                      },
                      items: kategoriList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontFamily: 'Poppins'),
                          ),
                        );
                      }).toList(),
                    ),
                  )),
              ///////////////////////////////////////////////////////////  Penjelasan  ///////////////////////////////////////////////
              const Text(
                'Isi Artikel',
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
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromARGB(255, 2, 128, 144)),
                child: MaterialButton(
                    child: const Text(
                      'Tambah Artikel',
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
