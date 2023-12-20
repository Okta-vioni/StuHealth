// ignore_for_file: file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pbl_stuhealth/Admin/obat/EditInformasi.dart';
import 'package:pbl_stuhealth/Admin/obat/UpObat.dart';
import 'package:pbl_stuhealth/Admin/obat/obatPage.dart';

class EditInformasiKelolaInfo extends StatefulWidget {
  const EditInformasiKelolaInfo({super.key});

  @override
  State<EditInformasiKelolaInfo> createState() =>
      _EditInformasiKelolaInfoState();
}

class _EditInformasiKelolaInfoState extends State<EditInformasiKelolaInfo> {
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
                            child: const Text('Tambah Info',
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
                                        const EditInformasiTambahInfo(),
                                  ));
                            }),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(10)),
                            color: Color.fromARGB(255, 2, 128, 144),
                            border: Border.all(
                                color: Color.fromARGB(255, 2, 128, 144))),
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: MaterialButton(
                            child: const Text('Kelola Info',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
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
                  stream:
                      FirebaseFirestore.instance.collection('obat').snapshots(),
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
                        String nama = doc['nama'];
                        String documentId = doc.id;

                        return KolomKelolaAksi(
                            NamaProduk: nama,
                            FotoProduk: imageUrl,
                            documentId: documentId);
                      }).toList(),
                    );
                  })
              ////////////////////////////////////  Kotak Kotak  ///////////////////////////////////////////////////
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////// KolomKelolaAksi ////////////////////////////////////////////////////////////
class KolomKelolaAksi extends StatefulWidget {
  const KolomKelolaAksi({
    super.key,
    required this.NamaProduk,
    required this.FotoProduk,
    required this.documentId,
  });

  final String NamaProduk;
  final String FotoProduk;
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
              Text(widget.NamaProduk,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 50,
                width: 80,
                child: Image.network(
                  widget.FotoProduk,
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
                              return UpObat(obatId: widget.documentId);
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
                            deleteObat();
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

  Future<void> deleteObat() async {
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
          .collection('obat')
          .doc(widget.documentId)
          .delete();

      String fileName = widget.FotoProduk.split('/').last;
      await firebaseStorage.ref('gambar_obat/$fileName').delete();
      showSnackBar('Gambar berhasil dihapus!', Duration(seconds: 3));
    }
  }

  //snackbar for showing errors
  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
