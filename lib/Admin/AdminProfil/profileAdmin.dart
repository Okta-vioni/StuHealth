// ignore_for_file: camel_case_types, duplicate_ignore, file_names

import 'package:flutter/material.dart';
import 'package:pbl_stuhealth/Admin/AdminProfil/AdminTambahDokter.dart';
import 'package:pbl_stuhealth/Admin/AdminProfil/AdminUbahPassword.dart';
import 'package:pbl_stuhealth/Admin/AdminProfil/AdminUmpanBalik.dart';
import 'package:pbl_stuhealth/Admin/Tengah/inti.dart';
import 'package:pbl_stuhealth/login/formlogin.dart';
import 'package:pbl_stuhealth/profile/kebijakan-privasi.dart';
import 'package:pbl_stuhealth/profile/syarat-ketentuan.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: camel_case_types
class profileAdmin extends StatefulWidget {
  const profileAdmin({super.key});

  @override
  State<profileAdmin> createState() => _profileAdminState();
}

class _profileAdminState extends State<profileAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 128, 144),
      appBar: AppBar(
        leading: MaterialButton(
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminIntiAplikasi(),
                  ));
            }),
        backgroundColor: const Color.fromARGB(255, 2, 128, 144),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 70),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(30)),
                        child: Container(
                          padding: const EdgeInsets.only(top: 30),
                          color: Colors.white,
                          child: Container(
                            padding: const EdgeInsets.only(left: 40, right: 40),
                            color: Colors.white,
                            width: double.infinity,
                            child: Column(
                              children: [
                                const Text('',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins',
                                        fontSize: 18)),
                                const Text(
                                  'Unit Kesehatan Mahasiswa',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Poppins',
                                      fontSize: 20),
                                ),
                                // const Text('1008110590',
                                //     style: TextStyle(
                                //         fontWeight: FontWeight.w500,
                                //         fontFamily: 'Poppins',
                                //         fontSize: 18)),
                                const Text('',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins',
                                        fontSize: 18)),
                                const SizedBox(
                                  height: 10,
                                ),

                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 0, 132, 119))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.mail,
                                              size: 30,
                                              color: Color.fromARGB(
                                                  255, 2, 128, 144)),
                                          Text('admin@admin.com',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins',
                                                fontSize: 10,
                                              ))
                                        ],
                                      ),
                                      Container(
                                        width: 2,
                                        height: 50,
                                        color: const Color.fromARGB(
                                            255, 2, 128, 144),
                                      ),
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.phone,
                                              size: 30,
                                              color: Color.fromARGB(
                                                  255, 2, 128, 144)),
                                          Text('-',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins',
                                                fontSize: 13,
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                  height: 30,
                                ),
                                const isiakun(
                                    icondepan: Icons.lock,
                                    text: 'Ubah Password',
                                    pindahhalaman: AdminUbahPassword()),
                                const isiakun(
                                    // ignore: deprecated_member_use
                                    icondepan: FontAwesomeIcons.userMd,
                                    text: 'Tambah Dokter',
                                    pindahhalaman: AdminTambahDokter()),
                                const isiakun(
                                    icondepan: Icons.error_sharp,
                                    text: 'Umpan Balik Aplikasi',
                                    pindahhalaman: AdminUmpanBalik()),
                                const isiakun(
                                    icondepan: Icons.description,
                                    text: 'Syarat dan Ketentuan',
                                    pindahhalaman: syaratketentuan()),
                                const isiakun(
                                    icondepan: Icons.shield,
                                    text: 'Kebijakan Privasi',
                                    pindahhalaman: kebijakanprivasi()),

//////////////////////////////////////////// Tombol Logout /////////////////////////////////////////////////////////////

                                Container(
                                  margin: const EdgeInsets.only(bottom: 120),
                                  child: MaterialButton(
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.logout,
                                          color:
                                              Color.fromARGB(255, 2, 128, 144),
                                          size: 30,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Text('Keluar',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Poppins',
                                                  color: Colors.red,
                                                  fontSize: 18)),
                                        ),
                                      ],
                                    ),
                                    onPressed: () async {
                                      bool confirm = await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                              'Konfirmasi',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700),
                                              textAlign: TextAlign.left,
                                            ),
                                            content: const Text(
                                              'Apakah anda ingin keluar dari akun anda?',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins'),
                                              textAlign: TextAlign.left,
                                            ),
                                            actions: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      2,
                                                                      128,
                                                                      144)),
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          30))),
                                                      child: MaterialButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(false);
                                                        },
                                                        child: const Text(
                                                          'Tidak',
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      2,
                                                                      128,
                                                                      144),
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 20),
                                                    Container(
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Color.fromARGB(
                                                                      255,
                                                                      2,
                                                                      128,
                                                                      144)),
                                                          color: Color.fromARGB(
                                                              255, 2, 128, 144),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          30))),
                                                      child: MaterialButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(true);
                                                        },
                                                        child: const Text(
                                                          'Ya',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                      if (confirm) {
                                        // User pressed 'Ya'
                                        // Add your logic here
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HalamanLogin(),
                                          ),
                                        );
                                        return Future.value(confirm);
                                      } else {
                                        // User pressed 'Tidak'
                                        // Add your logic here
                                        return Future.value(false);
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
///////////////////////////////////////////   Icon Bulat   //////////////////////////////////////////////////////////
                    Center(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            border: Border.all(
                                color: const Color.fromARGB(255, 2, 128, 144),
                                width: 5),
                            color: Colors.white,
                          ),
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            'img/icon/Admin.png',
                            scale: 2.5,
                          )),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/////////////////////////////////////////  Design Profile  ///////////////////////////////////////

class isiakun extends StatelessWidget {
  const isiakun(
      {super.key,
      required this.icondepan,
      required this.text,
      required this.pindahhalaman});

  final IconData icondepan;
  final String text;
  final Widget pindahhalaman;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
            child: Row(
              children: [
                Icon(
                  icondepan,
                  color: const Color.fromARGB(255, 2, 128, 144),
                  size: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(text,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontSize: 18)),
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => pindahhalaman,
                  ));
            }),
        Container(
          margin: const EdgeInsets.only(top: 15, bottom: 15),
          height: 1,
          width: 500,
          color: Colors.grey,
        ),
      ],
    );
  }
}
