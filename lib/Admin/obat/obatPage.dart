// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pbl_stuhealth/Admin/Tengah/inti.dart';
import 'package:pbl_stuhealth/Admin/obat/DetailInformasi.dart';
import 'package:pbl_stuhealth/Admin/obat/EditInformasi.dart';

class AdminInfoObatVitamin extends StatefulWidget {
  const AdminInfoObatVitamin({super.key});

  @override
  State<AdminInfoObatVitamin> createState() => _AdminInfoObatVitaminState();
}

class _AdminInfoObatVitaminState extends State<AdminInfoObatVitamin> {
  late Stream<QuerySnapshot> obatStream;
  String selectedAlpabet = 'Semua';

  @override
  void initState() {
    super.initState();
    obatStream = FirebaseFirestore.instance.collection('obat').snapshots();
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
                    builder: (context) => const AdminIntiAplikasi(),
                  ));
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 20,
              color: Color.fromARGB(255, 2, 128, 144),
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Info Obat & Vitamin',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cari Berdasarkan Abjad',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ////////////////////////////////////////////////////////////// DropDown //////////////////////////////////////////////////////////
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: DropDownAbjad(onChanged: (String value) {
                    setState(() {
                      selectedAlpabet = value;
                    });
                  }),
                ),
                //////////////////////////////////////////////////////////  Edit Informasi  /////////////////////////////////////////////////////
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: const Color.fromARGB(255, 2, 128, 144)),
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
                              'Edit Informasi',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 2, 128, 144),
                                  fontFamily: 'Poppins',
                                  fontSize: 15),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EditInformasiTambahInfo(),
                                  ));
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),

//////////////////////////////////////////////////////// Kotak Obat & Vitamin ///////////////////////////////////////////////////
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: obatStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                var filterDocs = snapshot.data!.docs;

                if (selectedAlpabet != 'Semua') {
                  filterDocs = snapshot.data!.docs
                      .where((doc) => doc['nama'].startsWith(selectedAlpabet))
                      .toList();
                }

                return ListView.builder(
                  itemCount: filterDocs.length,
                  itemBuilder: (context, index) {
                    if (index < filterDocs.length) {
                      var document = filterDocs[index];
                      var namaObat = document['nama'];
                      var fotoObat = document['image'];
                      var documentId = document.id;

                      return Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Column(children: [
                          Container(
                            child: KotakInfo(
                                documentId: documentId,
                                FotoObatVitamin: fotoObat,
                                NamaObatdanVitamin: namaObat),
                          )
                        ]),
                      );
                    } else {
                      return Container(
                        child: const Text('Tidak ada informasi yang tersedia.'),
                      );
                    }
                  },
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////////////////// Design DropDown  ///////////////////////////////////////////////////////
class DropDownAbjad extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const DropDownAbjad({required this.onChanged, super.key});

  @override
  State<DropDownAbjad> createState() => _DropDownAbjadState();
}

class _DropDownAbjadState extends State<DropDownAbjad> {
  String first = 'Semua';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          padding: const EdgeInsets.only(left: 10, right: 10),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          iconEnabledColor: const Color.fromARGB(255, 2, 128, 144),
          iconSize: 30,
          value: first,
          onChanged: (String? newValue) {
            setState(() {
              first = newValue ?? 'Semua';
            });
            widget.onChanged(newValue ?? 'Semua');
          },
          items: <String>[
            'Semua',
            'A',
            'B',
            'C',
            'D',
            'E',
            'F',
            'G',
            'H',
            'I',
            'J',
            'K',
            'L',
            'M',
            'N',
            'O',
            'P',
            'Q',
            'R',
            'S',
            'T',
            'U',
            'V',
            'W',
            'X',
            'Y',
            'Z',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////  Design Kotak Info Obat  /////////////////////////////////////////////////////
class KotakInfo extends StatefulWidget {
  const KotakInfo({
    super.key,
    required this.documentId,
    required this.FotoObatVitamin,
    required this.NamaObatdanVitamin,
  });

  final String documentId;
  final String FotoObatVitamin;
  final String NamaObatdanVitamin;

  @override
  State<KotakInfo> createState() => _KotakInfoState();
}

class _KotakInfoState extends State<KotakInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: prefer_const_constructors
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
          color: Colors.white),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AdminIsiKotakInfoObat(documentId: widget.documentId),
              ));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              widget.FotoObatVitamin,
              width: 100,
              height: 100,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              widget.NamaObatdanVitamin,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
