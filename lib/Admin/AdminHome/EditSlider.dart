// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditSlider extends StatefulWidget {
  const EditSlider({super.key});

  @override
  State<EditSlider> createState() => _EditSliderState();
}

class _EditSliderState extends State<EditSlider> {
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
            color: const Color.fromARGB(255, 0, 132, 119),
            iconSize: 25,
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Edit Slide',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontWeight: FontWeight.w900),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(right: 20, left: 20),
          child: const Column(
            children: [UploadFoto()],
          ),
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////  Upload Foto & Kelola Slide  ////////////////////////////////////////////////////
class UploadFoto extends StatefulWidget {
  const UploadFoto({super.key});

  @override
  State<UploadFoto> createState() => _UploadFotoState();
}

class _UploadFotoState extends State<UploadFoto> {
  File? image;

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);

    if (imagePicked != null) {
      image = File(imagePicked.path);
      setState(() {});
    }
  }

  Future<void> uploadImageToFirebase() async {
    if (image != null) {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var imageName = DateTime.now().microsecondsSinceEpoch.toString();
      Reference ref =
          FirebaseStorage.instance.ref().child('images/$imageName.jpg');
      await ref.putFile(image!);
      String downloadUrl = await ref.getDownloadURL();

      //Save downloadUrl to Firebase
      await firebaseFirestore
          .collection('slider')
          .add({'downloadUrl': downloadUrl}).whenComplete(() =>
              showSnackBar("Gambar sukses diunggah!", Duration(seconds: 3)));

      setState(() {});
    } else {
      showSnackBar("Pilih gambar terlebih dahulu!", Duration(seconds: 3));
    }
  }

  //snackbar for showing errors
  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Tambah Slide',
          style: TextStyle(
              fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w900),
        ),
        image != null
            ? Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 0, 132, 119)),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Image.file(
                        image!,
                        fit: BoxFit.cover,
                      )),
                ),
              )
            : Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 0, 132, 119)),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: MaterialButton(
                  onPressed: () async {
                    await getImage();
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        color: Colors.grey,
                      ),
                      Text(
                        'Please select an image',
                        style: TextStyle(
                            fontFamily: 'Poppins', color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
        Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(right: 20, left: 20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color.fromARGB(255, 0, 132, 119),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(64, 158, 158, 158),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(4, 4))
              ],
            ),
            child: MaterialButton(
              onPressed: () {
                uploadImageToFirebase();
              },
              child: const Text('Upload Slide',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.w900)),
            )),

/////////////////////////////////////////  Kekola Slide  /////////////////////////////////////
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Kelola Slide',
          style: TextStyle(
              fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w900),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          height: 1,
          width: double.infinity,
          color: Colors.grey,
        ),
        Container(
          margin: const EdgeInsets.only(right: 20, left: 20),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('#',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w500)),
              Text('Slide',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w500)),
              Text('Aksi',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          height: 1,
          width: double.infinity,
          color: Colors.grey,
        ),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('slider').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
              return Column(
                children: documents.map((doc) {
                  String imageUrl = doc['downloadUrl'];
                  String documentId = doc.id;

                  return KolomKelolaAksi(
                    GambarSlider: imageUrl,
                    documentId: documentId,
                  );
                }).toList(),
              );
            }),
      ],
    );
  }
}

////////////////////////////////////////////////////////// KolomKelolaAksi ////////////////////////////////////////////////////////////
class KolomKelolaAksi extends StatefulWidget {
  const KolomKelolaAksi(
      {super.key, required this.GambarSlider, required this.documentId});

  final String GambarSlider;
  final String documentId;
  @override
  State<KolomKelolaAksi> createState() => _KolomKelolaAksiState();
}

class _KolomKelolaAksiState extends State<KolomKelolaAksi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('#',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w500)),
          SizedBox(
            height: 80,
            width: 160,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Image.network(
                widget.GambarSlider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 132, 119),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(33, 0, 0, 0),
                            blurRadius: 1,
                            spreadRadius: 1,
                            offset: Offset(1, 1))
                      ],
                      border: Border.all(
                          color: const Color.fromARGB(255, 0, 132, 119)),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: MaterialButton(
                      onPressed: () {
                        deleteImage();
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.delete, color: Colors.white),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Hapus',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900))
                        ],
                      ))),
            ],
          )
        ],
      ),
    );
  }

  Future<void> deleteImage() async {
    bool confirmDeletion = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi'),
            content: Text('Kamu yakin ingin menghapus gambar ini?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Delete'),
              ),
            ],
          );
        });

    if (confirmDeletion == true) {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      FirebaseStorage firebaseStorage = FirebaseStorage.instance;

      //Delete data from Firestore
      await firebaseFirestore
          .collection('slider')
          .doc(widget.documentId)
          .delete();

      //Extract filename from URL
      String fileName = widget.GambarSlider.split('/').last;

      //Delete image from Firebase Storage
      await firebaseStorage.ref('images/$fileName').delete();

      showSnackBar("Gambar berhasil dihapus!", Duration(seconds: 3));
    }
  }

  //snackbar for showing errors
  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
