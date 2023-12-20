import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pbl_stuhealth/profile/profileuser.dart';

class Umpanbalik extends StatefulWidget {
  const Umpanbalik({super.key});

  @override
  State<Umpanbalik> createState() => _UmpanbalikState();
}

class _UmpanbalikState extends State<Umpanbalik> {
  final TextEditingController a1Controller = TextEditingController();
  final TextEditingController a2Controller = TextEditingController();
  final TextEditingController a3Controller = TextEditingController();
  final TextEditingController b1Controller = TextEditingController();
  final TextEditingController b2Controller = TextEditingController();
  final TextEditingController c1Controller = TextEditingController();
  final TextEditingController c2Controller = TextEditingController();
  final TextEditingController d1Controller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void updatea1(String newValue) {
    a1Controller.text = newValue;
  }

  void updatea2(String newValue) {
    a2Controller.text = newValue;
  }

  void updateb1(String newValue) {
    b1Controller.text = newValue;
  }

  void updatec1(String newValue) {
    c1Controller.text = newValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
          leading: MaterialButton(
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 10),
              child: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 2, 128, 144),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              'Umpan Balik',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
///////////////////////////////////////////////  body  ///////////////////////////////////////////////////
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 20, bottom: 30, left: 20, right: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: const Color.fromARGB(255, 2, 128, 144),
                  ),
                ),
                child: const Text(
                  'Silakan berikan tanggapan Anda tentang aplikasi mobile StuHealth kami. Kami menghargai pendapat Anda dan akan menggunakan umpan balik Anda untuk meningkatkan layanan kami.',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    color: Color.fromARGB(255, 2, 128, 144),
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              ///////////////////////////////////////////////////////   Pertanyaan Umum   /////////////////////////////////////////////
              Container(
                margin: EdgeInsets.only(left: 20),
                width: double.infinity,
                child: Text(
                  'Pertanyaan Umum',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //////////////////////////////////////////////////  Soal Pertama  ///////////////////////////////////////////////////
                    const TextPertanyana(
                        pertanyaan:
                            'Bagaimana pendapat Anda tentang tampilan antarmuka aplikasi kami?'),
                    DropDownKl(
                      onValueChanged: updatea1,
                    ),
                    //////////////////////////////////////////////////  Soal Kedua  ///////////////////////////////////////////////////
                    const TextPertanyana(
                        pertanyaan: 'Apakah aplikasi kami mudah digunakan?'),
                    DropDown(onValueChanged: updatea2),
                    //////////////////////////////////////////////////  Soal Ketiga  ///////////////////////////////////////////////////
                    const TextPertanyana(
                        pertanyaan:
                            'Apakah Anda menemui masalah teknis saat menggunakan aplikasi? Jika ya, mohon jelaskan.'),

                    Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 2, 128, 144)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: a3Controller,
                        maxLines: 5, // Jumlah baris yang bisa dimasukkan
                        decoration: InputDecoration.collapsed(
                          hintText: 'Berikan Penjelasan',
                          hintStyle: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ///////////////////////////////////////////////////   Fitur Aplikasi  ///////////////////////////////////////////
              Container(
                margin: EdgeInsets.only(left: 20, top: 20),
                width: double.infinity,
                child: Text(
                  'Fitur Aplikasi',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ////////////////////////////////////////////////////  Soal Pertama  ////////////////////////////////////////
                    const TextPertanyana(
                        pertanyaan:
                            'Apakah fitur-fitur yang disediakan sangat membantu Anda?'),
                    DropDownBool(onValueChanged: updateb1),
                    const TextPertanyana(
                        pertanyaan:
                            'Apakah Anda memiliki saran atau komentar tambahan mengenai layanan kami?'),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 2, 128, 144)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: b2Controller,
                        maxLines: 5, // Jumlah baris yang bisa dimasukkan
                        decoration: InputDecoration.collapsed(
                          hintText: 'Berikan Penjelasan',
                          hintStyle: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /////////////////////////// Kepusan Layanan ///////////////////////////////////

              Container(
                margin: EdgeInsets.only(left: 20, top: 20),
                width: double.infinity,
                child: Text(
                  'Kepusan Layanan',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextPertanyana(
                            pertanyaan:
                                'Bagaimana pendapat Anda tentang kualitas layanan yang Anda terima melalui aplikasi kami?'),
                        DropDownKl(onValueChanged: updatec1),
                        const TextPertanyana(
                            pertanyaan:
                                'Apakah Anda memiliki saran atau komentar tambahan mengenai layanan kami?'),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 20),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 2, 128, 144)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: c2Controller,
                            maxLines: 5, // Jumlah baris yang bisa dimasukkan
                            decoration: InputDecoration.collapsed(
                              hintText: 'Berikan Penjelasan',
                              hintStyle: TextStyle(fontFamily: 'Poppins'),
                            ),
                          ),
                        ),
                      ])),

              ////////////////////////////////Tambahan//////////////////////////////

              Container(
                margin: EdgeInsets.only(left: 20, top: 20),
                width: double.infinity,
                child: Text(
                  'Tambahan',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextPertanyana(
                        pertanyaan:
                            'Apakah ada hal lain yang ingin Anda sampaikan atau saran yang ingin Anda berikan mengenai aplikasi mobile StuHealth kami?'),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 2, 128, 144)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: d1Controller,
                        maxLines: 5, // Jumlah baris yang bisa dimasukkan
                        decoration: InputDecoration.collapsed(
                          hintText: 'Berikan Penjelasan',
                          hintStyle: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                    top: 30, bottom: 30, left: 20, right: 20),
                decoration: const BoxDecoration(
                    color: const Color.fromARGB(255, 2, 128, 144),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(33, 0, 0, 0),
                          blurRadius: 2,
                          spreadRadius: 1,
                          offset: Offset(2, 2))
                    ]),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: MaterialButton(
                      child: const Text(
                        'Kirim Umpan Balik',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        _submitForm();
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    try {
      // Get the current user
      User? user = _auth.currentUser;

      // Check if the user is signed in
      if (user != null) {
        // Get the user data from the 'users' collection
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        // Check if the user exists in the 'users' collection
        if (userSnapshot.exists) {
          // Get the user data
          // Extract user information
          String? uid = user.email;
          String name = userSnapshot.get('username') ?? '';
          String nim = userSnapshot.get('nim') ?? '';
          String jurusan = userSnapshot.get('jurusan') ?? '';

          // Get the data from the text fields
          String a1 = a1Controller.text;
          String a2 = a2Controller.text;
          String a3 = a3Controller.text;
          String b1 = b1Controller.text;
          String b2 = b2Controller.text;
          String c1 = c1Controller.text;
          String c2 = c2Controller.text;
          String d1 = d1Controller.text;

          if (a1.isEmpty) {
            a1 = 'Sangat Baik';
          }
          if (a2.isEmpty) {
            a2 = 'Sangat Mudah';
          }
          if (b1.isEmpty) {
            b1 = 'Iya';
          }
          if (c1.isEmpty) {
            c1 = 'Sangat Baik';
          }

          // Store the data in Firebase
          await FirebaseFirestore.instance
              .collection('umpanbalik')
              .doc(uid)
              .set({
            'A1': a1,
            'A2': a2,
            'A3': a3,
            'B1': b1,
            'B2': b2,
            'C1': c1,
            'C2': c2,
            'D1': d1,
            'name': name,
            'nim': nim,
            'jurusan': jurusan,
          });

          // Clear the text fields
          a1Controller.clear();
          a2Controller.clear();
          a3Controller.clear();
          b1Controller.clear();
          b2Controller.clear();
          c1Controller.clear();

          //pop up
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => profileuser(),
                                ));
                          },
                          child: const Text(
                            'OK',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 0, 132, 119)),
                          )),
                    ],
                    title: Column(
                      children: [
                        Image.asset('img/umpanbalik.png'),
                        const Text('Berhasil Terkirim',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            )),
                      ],
                    ),
                    contentPadding: const EdgeInsets.all(20),
                    content: const Text(
                      'Terima kasih atas waktu Anda untuk mengisi formulir umpan balik ini.',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ));
        } else {
          // Handle case where user data doesn't exist in the 'users' collection
          print('User data not found in the "users" collection.');
        }
      }
    } catch (e) {
      // Handle errors
      print('Error submitting form: $e');
    }
  }
}

///////////////////////////////////////////////  Text  /////////////////////////////////////////////////
class TextPertanyana extends StatelessWidget {
  const TextPertanyana({super.key, required this.pertanyaan});

  final String pertanyaan;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
      child: Text(
        pertanyaan,
        style: const TextStyle(
            fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 15),
      ),
    );
  }
}

/////////////////////////////////////////////////////////  DropDown  ////////////////////////////////////////////////

class DropDown extends StatefulWidget {
  final ValueChanged<String> onValueChanged;

  const DropDown({super.key, required this.onValueChanged});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String pertanyaanpertama = 'Sangat Mudah';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          padding: const EdgeInsets.only(left: 10),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          isExpanded: true,
          iconEnabledColor: const Color.fromARGB(255, 2, 128, 144),
          iconSize: 30,
          ////////////////////////////////////////////////////////////////////////////////////
          value: pertanyaanpertama, // Nilai awal dropdown
          onChanged: (String? newValue) {
            setState(() {
              pertanyaanpertama = newValue!;
              widget.onValueChanged(
                  newValue); // Notify the parent class about the value change
            });
          },
          items: <String>[
            'Sangat Mudah',
            'Mudah',
            'Cukup',
            'Sulit',
            'Sangat Sulit'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 15)),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class DropDownBool extends StatefulWidget {
  final ValueChanged<String> onValueChanged;

  const DropDownBool({super.key, required this.onValueChanged});

  @override
  State<DropDownBool> createState() => _DropDownBoolState();
}

class _DropDownBoolState extends State<DropDownBool> {
  String pertanyaanpertama = 'Iya';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          padding: const EdgeInsets.only(left: 10),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          isExpanded: true,
          iconEnabledColor: const Color.fromARGB(255, 2, 128, 144),
          iconSize: 30,
          ////////////////////////////////////////////////////////////////////////////////////
          value: pertanyaanpertama, // Nilai awal dropdown
          onChanged: (String? newValue) {
            setState(() {
              pertanyaanpertama = newValue!;
              widget.onValueChanged(
                  newValue); // Notify the parent class about the value change
            });
          },
          items: <String>[
            'Iya',
            'Tidak',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 15)),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class DropDownKl extends StatefulWidget {
  final ValueChanged<String> onValueChanged;

  const DropDownKl({super.key, required this.onValueChanged});

  @override
  State<DropDownKl> createState() => _DropDownKlState();
}

class _DropDownKlState extends State<DropDownKl> {
  String pertanyaanpertama = 'Sangat Baik';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          padding: const EdgeInsets.only(left: 10),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          isExpanded: true,
          iconEnabledColor: const Color.fromARGB(255, 2, 128, 144),
          iconSize: 30,
          ////////////////////////////////////////////////////////////////////////////////////
          value: pertanyaanpertama, // Nilai awal dropdown
          onChanged: (String? newValue) {
            setState(() {
              pertanyaanpertama = newValue!;
              widget.onValueChanged(
                  newValue); // Notify the parent class about the value change
            });
          },
          items: <String>[
            'Sangat Baik',
            'Baik',
            'Cukup',
            'Kurang Baik',
            'Tidak Baik'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 15)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
