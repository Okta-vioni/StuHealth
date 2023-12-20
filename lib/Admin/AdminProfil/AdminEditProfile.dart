// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names, camel_case_types, duplicate_ignore

import 'package:flutter/material.dart';

// ignore: camel_case_types
class Admineditprofile extends StatefulWidget {
  const Admineditprofile({super.key});

  @override
  State<Admineditprofile> createState() => _AdmineditprofileState();
}

class _AdmineditprofileState extends State<Admineditprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          leading: MaterialButton(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 2, 128, 144),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              'Edit Profile',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20, bottom: 15),
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Nama Lengkap',
                  labelText: 'Nama Lengkap',
                  hintStyle: const TextStyle(fontFamily: 'Poppins'),
                  labelStyle: const TextStyle(fontFamily: 'Poppins'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(20), right: Radius.circular(20)),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 2, 128, 144)),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20, bottom: 15),
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'NIM',
                  labelText: 'NIM',
                  hintStyle: const TextStyle(fontFamily: 'Poppins'),
                  labelStyle: const TextStyle(fontFamily: 'Poppins'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(20), right: Radius.circular(20)),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 2, 128, 144)),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20, bottom: 15),
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Nama Jurusan',
                  labelText: 'Nama Jurusan',
                  hintStyle: const TextStyle(fontFamily: 'Poppins'),
                  labelStyle: const TextStyle(fontFamily: 'Poppins'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(20), right: Radius.circular(20)),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 2, 128, 144)),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20, bottom: 15),
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email',
                    hintStyle: const TextStyle(fontFamily: 'Poppins'),
                    labelStyle: const TextStyle(fontFamily: 'Poppins'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20)),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 2, 128, 144)),
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20, bottom: 15),
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    hintStyle: const TextStyle(fontFamily: 'Poppins'),
                    labelStyle: const TextStyle(fontFamily: 'Poppins'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20)),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 2, 128, 144)),
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                right: 20,
                left: 20,
              ),
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Nomor Telepon',
                    labelText: 'Nomor Telepon',
                    hintStyle: const TextStyle(fontFamily: 'Poppins'),
                    labelStyle: const TextStyle(fontFamily: 'Poppins'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20)),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 2, 128, 144)),
                    )),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 30, right: 30, top: 150),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color.fromARGB(255, 2, 128, 144),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(64, 158, 158, 158),
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(4, 4))
                  ]),
              child: MaterialButton(
                onPressed: () {}, // isi link tujuan
                child: const Text(
                  'Simpan',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
