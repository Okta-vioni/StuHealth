// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pbl_stuhealth/Admin/obat/KelolaInformasi.dart';
import 'package:pbl_stuhealth/Admin/obat/obatPage.dart';

class EditInformasiTambahInfo extends StatefulWidget {
  const EditInformasiTambahInfo({super.key});

  @override
  State<EditInformasiTambahInfo> createState() =>
      _EditInformasiTambahInfoState();
}

class _EditInformasiTambahInfoState extends State<EditInformasiTambahInfo> {
  var namaController = new TextEditingController();
  var definisiController = new TextEditingController();
  var penjelasanController = new TextEditingController();

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
      Reference ref = storage.ref().child('gambar_obat/$imageName.jpg');
      await ref.putFile(image!);
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      print('Error uploading image: $error');
      throw Exception('Failed to upload image');
    }
  }

  void submitData() async {
    String nama = namaController.text;
    String definisi = definisiController.text;
    String penjelasan = penjelasanController.text;

    if (nama.isNotEmpty &&
        definisi.isNotEmpty &&
        penjelasan.isNotEmpty &&
        image != null) {
      try {
        //UPLOAD IMAGE TO FIREBASE STORAGE
        String imageUrl = await uploadImage();

        //ADD DATA TO FIRESTORE
        await firestore.collection('obat').add({
          'nama': nama,
          'definisi': definisi,
          'image': imageUrl,
          'penjelasan': penjelasan,
          'timestamp': FieldValue.serverTimestamp(),
        });

        //CLEAR TEXT FIELDS AND IMAGE AFTER SUBMISSION
        namaController.clear();
        definisiController.clear();
        penjelasanController.clear();
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
              SizedBox(
                height: 20,
              ),
              ///////////////////////////////////////////////////////  Pengertian  /////////////////////////////////////////////
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
                  onPressed: submitData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
