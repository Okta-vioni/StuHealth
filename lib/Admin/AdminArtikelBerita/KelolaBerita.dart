// ignore_for_file: file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/EditBerita.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/SemuaBerita.dart';
import 'package:pbl_stuhealth/Admin/AdminArtikelBerita/UpBerita.dart';

class EditBeritaKelolaBerita extends StatefulWidget {
  const EditBeritaKelolaBerita({super.key});

  @override
  State<EditBeritaKelolaBerita> createState() => _EditBeritaKelolaBeritaState();
}

class _EditBeritaKelolaBeritaState extends State<EditBeritaKelolaBerita> {
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
            children: [
              /////////////////////////////////////  Tombol Atas  //////////////////////////////////////////////////
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
                            color: Colors.white,
                            border: Border.all(
                                color: const Color.fromARGB(255, 2, 128, 144))),
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: MaterialButton(
                            child: const Text('Tambah Berita',
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
                                        const EditBeritaTambahBerita(),
                                  ));
                            }),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(10)),
                            color: const Color.fromARGB(255, 2, 128, 144),
                            border: Border.all(
                                color: const Color.fromARGB(255, 2, 128, 144))),
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: MaterialButton(
                            child: const Text('Kelola Berita',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700)),
                            onPressed: () {}),
                      ),
                    ),
                  ],
                ),
              ),

              /////////////////////////////////////  Bagian Atas Kotak  /////////////////////////////////////////////
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 60),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('#',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
                    Text('Judul',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
                    Text('Gambar',
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
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              ),

              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('berita')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    List<QueryDocumentSnapshot> document = snapshot.data!.docs;
                    return Column(
                      children: document.map((doc) {
                        String imageUrl = doc['image'];
                        String judul = doc['judul'];
                        String documentId = doc.id;

                        return KolomKelolaAksi(
                          judulBerita: judul,
                          gambarBerita: imageUrl,
                          documentId: documentId,
                        );
                      }).toList(),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////// KolomKelolaAksi ////////////////////////////////////////////////////////////
class KolomKelolaAksi extends StatefulWidget {
  const KolomKelolaAksi(
      {super.key,
      required this.judulBerita,
      required this.gambarBerita,
      required this.documentId});

  final String judulBerita;
  final String gambarBerita;
  final String documentId;

  @override
  State<KolomKelolaAksi> createState() => _KolomKelolaAksiState();
}

class _KolomKelolaAksiState extends State<KolomKelolaAksi> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                  width: 80,
                  child: Text(
                    widget.judulBerita,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  )),
              SizedBox(
                height: 50,
                width: 50,
                child: Image.network(
                  widget.gambarBerita,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  /////////////////////////////////////// Aksi Edit ///////////////////////////////////////////////
                  Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(33, 0, 0, 0),
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(1, 1))
                          ],
                          color: Colors.white,
                          border: Border.all(
                              color: const Color.fromARGB(255, 2, 128, 144)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return UpBerita(beritaId: widget.documentId);
                            }));
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.edit,
                                  color: Color.fromARGB(255, 2, 128, 144)),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Edit',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 2, 128, 144),
                                      fontFamily: 'Poppins',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700))
                            ],
                          ))),
                  const SizedBox(
                    height: 10,
                  ),
                  ///////////////////////////////////////// Aksi Hapus ////////////////////////////////////////////
                  Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 2, 128, 144),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(33, 0, 0, 0),
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(1, 1))
                          ],
                          border: Border.all(
                              color: const Color.fromARGB(255, 2, 128, 144)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: MaterialButton(
                          onPressed: () {
                            deleteBerita();
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
                                      fontWeight: FontWeight.w700))
                            ],
                          ))),
                ],
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          height: 1,
          width: double.infinity,
          color: Colors.grey,
        ),
      ],
    );
  }

  Future<void> deleteBerita() async {
    bool confirmDeletion = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi'),
            content: Text('Kamu yakin ingin menghapus artikel ini?'),
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

      //DELETE DATA FROM FIRESTORE
      await firebaseFirestore
          .collection('berita')
          .doc(widget.documentId)
          .delete();

      String fileName = widget.gambarBerita.split('/').last;
      await firebaseStorage.ref('gambar_berita/$fileName').delete();
      showSnackBar('Gambar berhasil dihapus!', Duration(seconds: 3));
    }
  }

  //snackbar for showing errors
  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
