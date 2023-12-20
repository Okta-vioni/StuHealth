import 'package:flutter/material.dart';

class EditFakta extends StatefulWidget {
  const EditFakta({super.key});

  @override
  State<EditFakta> createState() => _EditFaktaState();
}

class _EditFaktaState extends State<EditFakta> {
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
            padding: const EdgeInsets.only(top: 20, left: 10),
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
              'Edit Fakta',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Judul',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
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
              child: const TextField(
                maxLines: 1, // Jumlah baris yang bisa dimasukkan
                decoration: InputDecoration.collapsed(
                  hintText: 'Berikan Judul',
                  hintStyle: TextStyle(fontFamily: 'Poppins'),
                ),
              ),
            ),
////////////////////////////////////////////////  Deskripsi  //////////////////////////////////////////////
            const Text(
              'Deskripsi',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
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
              child: const TextField(
                maxLines: 5, // Jumlah baris yang bisa dimasukkan
                decoration: InputDecoration.collapsed(
                  hintText: 'Berikan Penjelasan',
                  hintStyle: TextStyle(fontFamily: 'Poppins'),
                ),
              ),
            ),
//////////////////////////////////////////  Tombol  //////////////////////////////////////////////////////
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromARGB(255, 2, 128, 144),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(33, 0, 0, 0),
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(1, 1))
                ],
              ),
              child: MaterialButton(
                  child: const Text('Perbarui Fakta',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w700)),
                  onPressed: () {}),
            )
          ],
        ),
      ),
    );
  }
}
