// ignore_for_file: camel_case_types, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:pbl_stuhealth/firebase-service/firebase_auth_service.dart';
import 'package:pbl_stuhealth/login/formlogin.dart';
// import 'package:pbl_stuhealth/profile/edit-profile.dart';
import 'package:pbl_stuhealth/profile/kebijakan-privasi.dart';
import 'package:pbl_stuhealth/profile/syarat-ketentuan.dart';
import 'package:pbl_stuhealth/profile/ubah-email.dart';
import 'package:pbl_stuhealth/profile/ubah-nohp.dart';
import 'package:pbl_stuhealth/profile/ubah-password.dart';
import 'package:pbl_stuhealth/profile/umpan-balik.dart';
import 'package:pbl_stuhealth/tengah/inti.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class profileuser extends StatefulWidget {
  const profileuser({super.key});

  @override
  State<profileuser> createState() => _profileuserState();
}

class _profileuserState extends State<profileuser> {
  //change page route
  final FirebaseAuthService _authService = FirebaseAuthService();

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
                    builder: (context) => const IntiAplikasi(),
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
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: Container(
                          padding: const EdgeInsets.only(top: 30),
                          color: Colors.white,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, bottom: 100, top: 20),
                            color: Colors.white,
                            width: double.infinity,
                            child: Column(
                              children: [
                                FutureBuilder(
                                  future: _authService.getUserDetails(
                                      _authService.getCurrentUser()!.uid),
                                  builder: (context,
                                      AsyncSnapshot<Map<String, dynamic>?>
                                          snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text(
                                          'Error: ${snapshot.error.toString()}');
                                    } else if (!snapshot.hasData ||
                                        snapshot.data == null) {
                                      return const Text(
                                          'User details not found.');
                                    } else {
                                      Map<String, dynamic> userDetails =
                                          snapshot.data!;
                                      return Column(
                                        children: [
                                          Text(
                                            userDetails['username'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Poppins',
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            userDetails['nim'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Poppins',
                                              fontSize: 18,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            userDetails['jurusan'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Poppins',
                                              fontSize: 18,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 2, 128, 144),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  child: MaterialButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    editEmail(),
                                                          ));
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons.mail,
                                                          size: 30,
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 2, 128, 144),
                                                        ),
                                                        Text(
                                                          userDetails['email'],
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 13,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 2,
                                                  height: 50,
                                                  color: const Color.fromARGB(
                                                      255, 2, 128, 144),
                                                ),
                                                Expanded(
                                                  child: MaterialButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    editnohp(),
                                                          ));
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons.phone,
                                                          size: 30,
                                                          color: Color.fromARGB(
                                                              255, 0, 132, 119),
                                                        ),
                                                        Text(
                                                          userDetails['nohp'],
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 13,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                isiakun(
                                    icondepan: Icons.lock,
                                    text: 'Ubah Password',
                                    pindahhalaman: UbahPassword()),

                                isiakun(
                                    icondepan: Icons.error_outline,
                                    text: 'Umpan Balik Aplikasi',
                                    pindahhalaman: Umpanbalik()),
                                isiakun(
                                    icondepan: Icons.description,
                                    text: 'Syarat dan Ketentuan',
                                    pindahhalaman: syaratketentuan()),
                                isiakun(
                                    icondepan: Icons.security,
                                    text: 'Kebijakan Privasi',
                                    pindahhalaman: kebijakanprivasi()),

                                //////////////////////////////////////////// Tombol Logout /////////////////////////////////////////////////////////////

                                Container(
                                  // margin: const EdgeInsets.only(bottom: 5),
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
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setBool('loggedIn', false);
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
                            'img/icon/PersonLogo.png',
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
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          height: 1,
          width: 500,
          color: Colors.grey,
        ),
      ],
    );
  }
}
