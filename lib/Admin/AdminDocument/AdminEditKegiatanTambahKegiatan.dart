// ignore_for_file: file_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pbl_stuhealth/Admin/AdminDocument/AdminEditKegiatanKelolaKegiatan.dart';

class AdminEditKegiatanTambahKegiatan extends StatefulWidget {
  const AdminEditKegiatanTambahKegiatan({super.key});

  @override
  State<AdminEditKegiatanTambahKegiatan> createState() =>
      _AdminEditKegiatanTambahKegiatanState();
}

class _AdminEditKegiatanTambahKegiatanState
    extends State<AdminEditKegiatanTambahKegiatan> {
  var judulController = new TextEditingController();
  var deskripsiController = new TextEditingController();
  var linkController = new TextEditingController();
  var tanggalController = new TextEditingController();

  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  File? image;
  DateTime? tanggalKegiatan;

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

  void submitData() async {
    String judul = judulController.text;
    String deskripsi = deskripsiController.text;
    String link = linkController.text;

    if (judul.isNotEmpty &&
        deskripsi.isNotEmpty &&
        link.isNotEmpty &&
        image != null &&
        tanggalKegiatan != null) {
      try {
        //UPLOAD IMAGE TO FIREBASE STORAGE
        String imageUrl = await uploadImage();

        //ADD DATA TO FIRESTORE
        await firestore.collection('kegiatan').add({
          'judul': judul,
          'deskripsi': deskripsi,
          'link': link,
          'image': imageUrl,
          'tanggal_kegiatan': tanggalKegiatan,
        });

        //CLEAR TEXT FIELDS AND IMAGE AFTER SUBMISSION
        judulController.clear();
        deskripsiController.clear();
        linkController.clear();
        tanggalController.clear();
        setState(() {
          image = null;
          tanggalKegiatan = null;
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
              content: Text('Tolong isi semua kolom dan upload poster.'),
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

  Future<String> uploadImage() async {
    try {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = storage.ref().child('poster/$imageName.jpg');
      await ref.putFile(image!);
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      print('Error mengunggah gambar: $error');
      throw Exception('Gagal mengunggah.');
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
                        child: MaterialButton(
                            child: const Text('Tambah Kegiatan',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
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
                        child: MaterialButton(
                            child: const Text('Kelola Kegiatan',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 2, 128, 144),
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AdminEditKegiatanKelolaKegiatan(),
                                  ));
                            }),
                      ),
                    ),
                  ],
                ),
              ),
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
                      'Tambah Kegiatan',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 18,
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
