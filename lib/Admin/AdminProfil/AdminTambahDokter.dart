import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pbl_stuhealth/Admin/AdminProfil/UpDok.dart';
import 'package:pbl_stuhealth/Admin/AdminProfil/editDokter.dart';
import 'package:pbl_stuhealth/Admin/AdminProfil/profileAdmin.dart';

class AdminTambahDokter extends StatefulWidget {
  const AdminTambahDokter({super.key});

  @override
  State<AdminTambahDokter> createState() => _AdminTambahDokterState();
}

class _AdminTambahDokterState extends State<AdminTambahDokter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          margin: const EdgeInsets.only(top: 15),
          child: AppBar(
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
            backgroundColor: Colors.white,
            leading: IconButton(
                padding: EdgeInsets.only(left: 20),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 2, 128, 144),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => profileAdmin(),
                      ));
                }),
            title: const Text(
              'Tambah Dokter',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 30),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border:
                      Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(64, 158, 158, 158),
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(4, 4))
                  ],
                  color: Colors.white),
              height: 40,
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: MaterialButton(
                  child: const Text(
                    'Tambah Dokter',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 2, 128, 144),
                        fontFamily: 'Poppins',
                        fontSize: 15),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminFormTambahDokter(),
                        ));
                  }),
            ),
            Text(
              'List Dokter',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 15),
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('dokter').snapshots(),
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
                    String status = doc['status'];
                    String documentId = doc.id;

                    return KotakEditDokter(
                        documentId: documentId,
                        fotoDokter: imageUrl,
                        namaDokter: nama,
                        statusDokter: status);
                  }).toList(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class KotakEditDokter extends StatefulWidget {
  const KotakEditDokter({
    super.key,
    required this.documentId,
    required this.fotoDokter,
    required this.namaDokter,
    required this.statusDokter,
  });

  final String documentId;
  final String fotoDokter;
  final String namaDokter;
  final String statusDokter;

  @override
  State<KotakEditDokter> createState() => _KotakEditDokterState();
}

class _KotakEditDokterState extends State<KotakEditDokter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          border: Border.all(color: Color.fromARGB(255, 2, 128, 144))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
              child: Image.network(
                widget.fotoDokter,
                width: 80,
                height: 80,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 2),
                  child: Text(widget.namaDokter,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 2, 0, 5),
                  child: Text(widget.statusDokter,
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 15)),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(60, 2, 128, 144),
                            blurRadius: 2,
                            spreadRadius: 1,
                            offset: Offset(2, 2))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border:
                          Border.all(color: Color.fromARGB(255, 2, 128, 144))),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return UpDokter(dokterId: widget.documentId);
                        }));
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 2, 128, 144),
                      )),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(60, 244, 67, 54),
                            blurRadius: 2,
                            spreadRadius: 1,
                            offset: Offset(2, 2))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.red)),
                  child: IconButton(
                      onPressed: () {
                        deleteData();
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> deleteData() async {
    bool confirmDeletion = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi'),
            content: Text('Kamu yakin ingin menghapus data ini?'),
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
          .collection('dokter')
          .doc(widget.documentId)
          .delete();

      String fileName = widget.fotoDokter.split('/').last;
      await firebaseStorage.ref('foto_dokter/$fileName').delete();
      showSnackBar('Gambar berhasil dihapus!', Duration(seconds: 3));
    }
  }

  //snackbar for showing errors
  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
