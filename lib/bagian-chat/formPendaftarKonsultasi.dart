// ignore_for_file: file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pbl_stuhealth/firebase-service/firebase_auth_service.dart';
import 'package:pbl_stuhealth/tengah/inti.dart';

class FormPendaftaranKonsultasi extends StatefulWidget {
  final String documentId;
  const FormPendaftaranKonsultasi({super.key, required this.documentId});

  @override
  State<FormPendaftaranKonsultasi> createState() =>
      _FormPendaftaranKonsultasiState();
}

class _FormPendaftaranKonsultasiState extends State<FormPendaftaranKonsultasi> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //form konsultasi
  final TextEditingController jenisKelaminController = TextEditingController();
  final TextEditingController umurController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController jamController = TextEditingController();
  final TextEditingController report1Controller = TextEditingController();
  final TextEditingController report2Controller = TextEditingController();
  final TextEditingController report3Controller = TextEditingController();
  final TextEditingController report4Controller = TextEditingController();

  void updateJenisKelamin(String newValue) {
    jenisKelaminController.text = newValue;
  }

  void updateJam(String newValue) {
    jamController.text = newValue;
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService _authService = FirebaseAuthService();
    bool isChecked = false;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
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
              'Form Pendaftaran Konsultasi',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
//////////////////////////////////////////////////  Kotak Hijau  ///////////////////////////////////////////////
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 2, 128, 144)),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.error_sharp,
                            size: 20, color: Color.fromARGB(255, 2, 128, 144)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Informasi Tambahan',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 2, 128, 144)),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 20),
                      child: const Column(
                        children: [
                          Text(
                            '- Pilih jadwal konsultasi anda, dan jika terjadi perubahan waktu maka akan diinfokan melalui pesan chat.',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Color.fromARGB(255, 2, 128, 144)),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            '- Konsultasi dilakukan secara online melalui zoom dan berlangsung selama 30 menit per mahasiswa nya.',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Color.fromARGB(255, 2, 128, 144)),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            '- Mohon isi formulir ini dengan lengkap dan akurat, karena formulir ini akan membantu dokter dalam memahami kondisi kesehatan Anda dan memberikan perawatan yang sesuai.',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Color.fromARGB(255, 2, 128, 144)),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

///////////////////////////////////////////////////////////  Data Diri Mahasiswa  ////////////////////////////////////////////
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Data Diri Mahasiswa',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey)),
                    Container(
                      width: double.infinity,
                      height: 2,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
///////////////////////////////////////////////////////// Data Form Pendaftaran ///////////////////////////////////////////////////////
              FutureBuilder(
                future: _authService
                    .getUserDetails(_authService.getCurrentUser()!.uid),
                builder:
                    (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error.toString()}');
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Text('User details not found.');
                  } else {
                    Map<String, dynamic> userDetails = snapshot.data!;
                    return Column(children: [
                      AbsorbPointer(
                          absorbing: !isChecked,
                          child: Opacity(
                            // ignore: dead_code
                            opacity: isChecked ? 1.0 : 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text('Nama',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ),
                                Container(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          top: 10, bottom: 10, left: 20),
                                      hintText: 'nama',
                                      labelText: userDetails['username'],
                                      hintStyle: const TextStyle(
                                          fontFamily: 'Poppins'),
                                      labelStyle: const TextStyle(
                                          fontFamily: 'Poppins'),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 2, 128, 144)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      AbsorbPointer(
                          absorbing: !isChecked,
                          child: Opacity(
                            // ignore: dead_code
                            opacity: isChecked ? 1.0 : 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text('NIM',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ),
                                Container(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          top: 10, bottom: 10, left: 20),
                                      hintText: 'NIM',
                                      labelText: userDetails['nim'],
                                      hintStyle: const TextStyle(
                                          fontFamily: 'Poppins'),
                                      labelStyle: const TextStyle(
                                          fontFamily: 'Poppins'),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 2, 128, 144)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      AbsorbPointer(
                          absorbing: !isChecked,
                          child: Opacity(
                            // ignore: dead_code
                            opacity: isChecked ? 1.0 : 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text('Jurusan',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ),
                                Container(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          top: 10, bottom: 10, left: 20),
                                      hintText: 'Nama Jurusan',
                                      labelText: userDetails['jurusan'],
                                      hintStyle: const TextStyle(
                                          fontFamily: 'Poppins'),
                                      labelStyle: const TextStyle(
                                          fontFamily: 'Poppins'),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 2, 128, 144)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      DropDownKelamin(
                        IsiForm: 'Jenis Kelamin',
                        onValueChanged: updateJenisKelamin,
                      ),
                      DataDiriMahasiswaNomor(
                          IsiForm: 'Umur', controller: umurController),
                      AbsorbPointer(
                          absorbing: !isChecked,
                          child: Opacity(
                            // ignore: dead_code
                            opacity: isChecked ? 1.0 : 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text('Nomor Telepon',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ),
                                Container(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          top: 10, bottom: 10, left: 20),
                                      hintText: 'No HP',
                                      labelText: userDetails['nohp'],
                                      hintStyle: const TextStyle(
                                          fontFamily: 'Poppins'),
                                      labelStyle: const TextStyle(
                                          fontFamily: 'Poppins'),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 2, 128, 144)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      DataDiriMahasiswaTanggalKonsultasi(
                        IsiForm: 'Tanggal Konsultasi',
                        controller: tanggalController,
                      ),
                      DropDownKelaminJamKonsultasi(
                        IsiForm: 'Jam Konsultasi',
                        onValueChanged: updateJam,
                      )
                    ]);
                  }
                },
              ),
///////////////////////////////////////////////////////////  Informasi Medis  ////////////////////////////////////////////
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Informasi Medis',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey)),
                    Container(
                      width: double.infinity,
                      height: 2,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
///////////////////////////////////////////////////////// Data Form Informasi Medis ///////////////////////////////////////////////////////
              InformasiMedis(
                  PertanyaanForm:
                      'Apakah Anda memiliki riwayat kesehatan yang relevan, seperti alergi, penyakit kronis, atau operasi sebelumnya? (Jelaskan jika ada)',
                  IsiKotak: 'Harap diisi',
                  controller: report1Controller),
              InformasiMedis(
                PertanyaanForm:
                    'Apa keluhan kesehatan yang Anda alami? (Jelaskan dengan singkat)',
                IsiKotak: 'Harap diisi',
                controller: report2Controller,
              ),
              InformasiMedis(
                PertanyaanForm:
                    'Apakah keluhan ini semakin memburuk atau stabil?',
                IsiKotak: 'Harap diisi',
                controller: report3Controller,
              ),
              InformasiMedis(
                PertanyaanForm:
                    'Apakah Anda sedang mengonsumsi obat-obatan atau suplemen tertentu? (Jelaskan jenis dan dosisnya)',
                IsiKotak: 'Harap diisi',
                controller: report4Controller,
              ),

/////////////////////////////////////////////////////  Tombol  ////////////////////////////////////////
              Container(
                margin: const EdgeInsets.only(top: 30),
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(70, 0, 0, 0),
                          blurRadius: 2,
                          spreadRadius: 1,
                          offset: Offset(2, 2))
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Color.fromARGB(255, 2, 128, 144)),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: MaterialButton(
                      minWidth: double.infinity,
                      child: Text(
                        'Daftar',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        try {
                          _daftar();
                        } catch (e) {}
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _daftar() async {
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
          String? uid = user.uid;
          String name = userSnapshot.get('username') ?? '';
          String nim = userSnapshot.get('nim') ?? '';
          String jurusan = userSnapshot.get('jurusan') ?? '';
          String nohp = userSnapshot.get('nohp') ?? '';

          // Get the data from the text fields
          String jenisKelamin = jenisKelaminController.text;
          String umur = umurController.text;
          String tanggal = tanggalController.text;
          String jam = jamController.text;
          String report1 = report1Controller.text;
          String report2 = report2Controller.text;
          String report3 = report3Controller.text;
          String report4 = report4Controller.text;

          // Check if any of the required fields is empty
          if (jenisKelamin.isEmpty ||
              umur.isEmpty ||
              tanggal.isEmpty ||
              jam.isEmpty ||
              report1.isEmpty ||
              report2.isEmpty ||
              report3.isEmpty ||
              report4.isEmpty) {
            // Show a Snackbar indicating that all fields must be filled
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Isi semua kolom'),
              ),
            );
            return; // Exit the method early, preventing further execution
          }

          // Get the 'nama dokter' from the 'dokter' collection
          DocumentSnapshot dokterSnapshot = await FirebaseFirestore.instance
              .collection('dokter')
              .doc(widget
                  .documentId) // Assuming widget.documentId is the correct ID
              .get();
          String namaDokter = dokterSnapshot.get('nama') ?? '';
          String limitDokter = dokterSnapshot.get('limit') ?? '';

          // Store the data in Firebase
          await FirebaseFirestore.instance
              .collection('konsultasi')
              .doc(uid)
              .set({
            'uid': uid,
            'nama': name,
            'nim': nim,
            'jurusan': jurusan,
            'nohp': nohp,
            'jenis kelamin': jenisKelamin,
            'umur': umur,
            'tanggal': tanggal,
            'jam': jam,
            'report 1': report1,
            'report 2': report2,
            'report 3': report3,
            'report 4': report4,
            'nama dokter': namaDokter,
          });

          //Decrement limit
          if (dokterSnapshot.exists &&
              // ignore: unnecessary_null_comparison
              limitDokter != null &&
              // ignore: unnecessary_type_check
              limitDokter is String) {
            String currentLimitString = limitDokter;

            //conver string to int
            int currentLimit = int.tryParse(currentLimitString) ?? 0;

            // Decrement
            int newLimit = currentLimit > 0 ? currentLimit - 1 : 0;

            //Update 'limit' field
            await FirebaseFirestore.instance
                .collection('dokter')
                .doc(widget.documentId)
                .update({
              'limit': newLimit.toString(),
              'status': newLimit > 0 ? 'Tersedia' : 'Tidak Tersedia',
            });
          }

          // Show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Form submitted successfully!'),
            ),
          );

          //pop up
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              actions: [
                TextButton(
                    onPressed: () async {
                      //push page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const IntiAplikasi(),
                        ),
                      );
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 2, 128, 144)),
                    ))
              ],
              title: Column(
                children: [
                  Image.asset('img/notifkonsul.png'),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text('Berhasil Terkirim!',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  const Text(
                    'Terima kasih sudah mengisi formulir ini. Jadwal konsultasi Anda akan diatur dan dikirim melalui pesan chat oleh Unit Kesehatan Kampus.',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          );
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

//////////////////////////////////////////////////////////  Design Data Diri Mahasiswa  //////////////////////////////////////////////
class DataDiriMahasiswaTanggalKonsultasi extends StatefulWidget {
  const DataDiriMahasiswaTanggalKonsultasi({
    super.key,
    required this.IsiForm,
    required this.controller,
  });

  final String IsiForm;
  final TextEditingController controller;

  @override
  State<DataDiriMahasiswaTanggalKonsultasi> createState() =>
      _DataDiriMahasiswaTanggalKonsultasiState();
}

class _DataDiriMahasiswaTanggalKonsultasiState
    extends State<DataDiriMahasiswaTanggalKonsultasi> {
  // Add a field to store the selected date
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 5),
          child: Text(
            widget.IsiForm,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: widget.controller,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration.collapsed(
              // Use the selected date if available, otherwise use the default hint
              hintText: _selectedDate != null
                  ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                  : widget.IsiForm,
              hintStyle: const TextStyle(fontFamily: 'Poppins'),
            ),
            readOnly: true,
            onTap: () {
              pickDate();
            },
          ),
        ),
      ],
    );
  }

  DateTime? tanggalKegiatan;

  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != tanggalKegiatan) {
      setState(() {
        tanggalKegiatan = pickedDate;
        widget.controller.text =
            DateFormat('dd/MM/yyyy').format(tanggalKegiatan!);
      });
    }
  }
}

class DropDownKelamin extends StatefulWidget {
  final ValueChanged<String> onValueChanged;

  const DropDownKelamin({
    super.key,
    required this.IsiForm,
    required this.onValueChanged,
  });

  final String IsiForm;
  @override
  State<DropDownKelamin> createState() => _DropDownKelaminState();
}

class _DropDownKelaminState extends State<DropDownKelamin> {
  String pertanyaanpertama = 'Jenis Kelamin';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 5),
          child: Text(widget.IsiForm,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w500,
              )),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              style: const TextStyle(
                  fontFamily: 'Poppins', fontSize: 15, color: Colors.grey),
              padding: const EdgeInsets.only(left: 10),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              isExpanded: true,
              iconEnabledColor: const Color.fromARGB(255, 2, 128, 144),
              iconSize: 30,
              ////////////////////////////////////////////////////////////////////////////////////
              value: pertanyaanpertama, // Nilai awal dropdown
              onChanged: (String? newValue) {
                setState(() {
                  pertanyaanpertama = newValue!;
                  widget.onValueChanged(newValue);
                });
              },
              items: <String>['Jenis Kelamin', 'Laki - Laki', 'Perempuan']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: value == 'Pilih Jurusan'
                          ? const Color.fromARGB(255, 102, 96, 96)
                          : Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class DropDownKelaminJamKonsultasi extends StatefulWidget {
  const DropDownKelaminJamKonsultasi({
    super.key,
    required this.IsiForm,
    required this.onValueChanged,
  });

  final String IsiForm;
  final ValueChanged<String> onValueChanged;
  @override
  State<DropDownKelaminJamKonsultasi> createState() =>
      _DropDownKelaminJamKonsultasiState();
}

class _DropDownKelaminJamKonsultasiState
    extends State<DropDownKelaminJamKonsultasi> {
  String pertanyaanpertama = 'Jam Konsultasi';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 5),
          child: Text(widget.IsiForm,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w500,
              )),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              style: const TextStyle(
                  fontFamily: 'Poppins', fontSize: 15, color: Colors.grey),
              padding: const EdgeInsets.only(left: 10),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              isExpanded: true,
              iconEnabledColor: const Color.fromARGB(255, 2, 128, 144),
              iconSize: 30,
              ////////////////////////////////////////////////////////////////////////////////////
              value: pertanyaanpertama, // Nilai awal dropdown
              onChanged: (String? newValue) {
                setState(() {
                  pertanyaanpertama = newValue!;
                  widget.onValueChanged(newValue);
                });
              },
              items: <String>[
                'Jam Konsultasi',
                '10:00 WIB',
                '11:00 WIB',
                '13:00 WIB',
                '14:00 WIB',
                '15:00 WIB'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: value == 'Pilih Jurusan'
                          ? const Color.fromARGB(255, 102, 96, 96)
                          : Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class DataDiriMahasiswaNomor extends StatefulWidget {
  const DataDiriMahasiswaNomor({
    super.key,
    required this.IsiForm,
    required this.controller,
  });

  final String IsiForm;
  final TextEditingController controller;

  @override
  State<DataDiriMahasiswaNomor> createState() => _DataDiriMahasiswaNomorState();
}

class _DataDiriMahasiswaNomorState extends State<DataDiriMahasiswaNomor> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 5),
          child: Text(widget.IsiForm,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w500,
              )),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: widget.controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration.collapsed(
              hintText: widget.IsiForm,
              hintStyle: const TextStyle(fontFamily: 'Poppins'),
            ),
          ),
        ),
      ],
    );
  }
}

class InformasiMedis extends StatefulWidget {
  const InformasiMedis({
    super.key,
    required this.PertanyaanForm,
    required this.IsiKotak,
    required this.controller,
  });

  final String PertanyaanForm;
  final String IsiKotak;
  final TextEditingController controller;

  @override
  State<InformasiMedis> createState() => _InformasiMedisState();
}

class _InformasiMedisState extends State<InformasiMedis> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 5),
          child: Text(widget.PertanyaanForm,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w500,
              )),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: widget.controller,
            maxLines: 5,
            decoration: InputDecoration.collapsed(
              hintText: widget.IsiKotak,
              hintStyle: const TextStyle(fontFamily: 'Poppins'),
            ),
          ),
        ),
      ],
    );
  }
}
