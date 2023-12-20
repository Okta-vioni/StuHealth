// ignore_for_file: file_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminFormTambahDokter extends StatefulWidget {
  const AdminFormTambahDokter({super.key});

  @override
  State<AdminFormTambahDokter> createState() => _AdminFormTambahDokterState();
}

class _AdminFormTambahDokterState extends State<AdminFormTambahDokter> {
  var namaController = new TextEditingController();
  var kategoriController = new TextEditingController();
  var limitController = new TextEditingController();

  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  File? image;
  // String selectedStatus = 'Pilih Status';
  // late List<String> statusList = [
  //   'Pilih Status',
  //   'Tersedia',
  //   'Tidak Tersedia',
  // ];

  // void onChanged(String? value) {
  //   if (value != null) {
  //     setState(() {
  //       selectedStatus = value;
  //     });
  //   }
  // }

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
      Reference ref = storage.ref().child('foto_dokter/$imageName.jpg');
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
    String kategori = kategoriController.text;
    String limit = limitController.text;

    if (nama.isNotEmpty && kategori.isNotEmpty && limit.isNotEmpty
        // selectedStatus != 'Pilih Status' &&
        // image != null
        ) {
      try {
        //UPLOAD IMAGE TO FIREBASE STORAGE
        String imageUrl = await uploadImage();

        //ADD DATA TO FIRESTORE
        await firestore.collection('dokter').add({
          'nama': nama,
          'kategori': kategori,
          'limit': limit,
          'image': imageUrl,
          'status': limit.compareTo('0') > 0 ? 'Tersedia' : 'Tidak Tersedia',
          'timestamp': FieldValue.serverTimestamp(),
        });

        //CLEAR TEXT FIELDS AND IMAGE AFTER SUBMISSION
        namaController.clear();
        kategoriController.clear();
        limitController.clear();

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
                      submitData();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
