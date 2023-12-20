import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pbl_stuhealth/firebase-service/firebase_auth_service.dart';
import 'package:pbl_stuhealth/login/formlogin.dart';

class BuatAkun extends StatefulWidget {
  const BuatAkun({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BuatAkunState createState() => _BuatAkunState();
}

class _BuatAkunState extends State<BuatAkun> {
  //Eye Icon Password
  bool _obscureText = true; // State to toggle password visibility

  //error
  String? _errorMessage;

  //Text Controllers
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _namaJurusanController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nomorHpController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _nimController.dispose();
    _namaJurusanController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nomorHpController.dispose();
    super.dispose();
  }

  void updateNamaJurusan(String newValue) {
    _namaJurusanController.text = newValue;
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              size: 40,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HalamanLogin()));
            }),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Image.asset(
                'img/Sing-in.png',
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(31, 0, 0, 0),
                    offset: Offset(0, -2),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        right: 20, left: 20, bottom: 30, top: 30),
                    child: Column(
                      children: [
                        const Center(
                          child: Text(
                            'Buat Akun',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 25),
                          ),
                        ),
                        if (_errorMessage !=
                            null) // Display error message if not null
                          Container(
                            margin: EdgeInsets.only(),
                            child: Text(
                              _errorMessage ?? '', // Display the error message
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                color: Colors
                                    .red, // Set the color to red for error messages
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 15),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 20),
                        hintText: 'Nama Lengkap',
                        labelText: 'Nama Lengkap',
                        hintStyle: const TextStyle(fontFamily: 'Poppins'),
                        labelStyle: const TextStyle(fontFamily: 'Poppins'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(20),
                              right: Radius.circular(20)),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 2, 128, 144)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 15),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      controller: _nimController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 20),
                        hintText: 'NIM',
                        labelText: 'NIM',
                        hintStyle: const TextStyle(fontFamily: 'Poppins'),
                        labelStyle: const TextStyle(fontFamily: 'Poppins'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(20),
                              right: Radius.circular(20)),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 2, 128, 144)),
                        ),
                      ),
                    ),
                  ),
                  DropDownJurusan(
                    onValueChanged: updateNamaJurusan,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 15),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 20),
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
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 2, 128, 144)),
                          )),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 15),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 20),
                          hintText: 'Password',
                          labelText: 'Password',
                          hintStyle: const TextStyle(fontFamily: 'Poppins'),
                          labelStyle: const TextStyle(fontFamily: 'Poppins'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Color.fromARGB(255, 2, 128, 144),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(20),
                                right: Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 2, 128, 144)),
                          )),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                    ),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      controller: _nomorHpController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 20),
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
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 2, 128, 144)),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap Mengisi Nomor Telepon';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          activeColor: const Color.fromARGB(255, 2, 128, 144),
                          onChanged: (newValue) {
                            if (newValue != null) {
                              setState(() {
                                isChecked = newValue;
                              });
                            }
                          },
                        ),
                        const Expanded(
                            child: Text(
                          'Saya setuju dengan Ketentuan Layanan dan Kebijakan Privasi',
                          style: TextStyle(fontFamily: 'Poppins'),
                          textAlign: TextAlign.left,
                        )),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(30, 20, 30, 50),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(33, 0, 0, 0),
                              blurRadius: 2,
                              spreadRadius: 1,
                              offset: Offset(2, 2))
                        ]),
                    child: AbsorbPointer(
                      absorbing: !isChecked,
                      child: Opacity(
                        opacity: isChecked
                            ? 1.0
                            : 0.5, // Atur opasitas berdasarkan isChecked
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: MaterialButton(
                            height: 50,
                            color: const Color.fromARGB(255, 2, 128, 144),
                            onPressed: () {
                              if (isChecked) {
                                _signUp();
                                // Handle aksi ketika checkbox ditekan di sini
                                // Misalnya, navigasi atau tindakan lainnya.
                              }
                            },
                            child: const Text(
                              'Daftar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isStrongPassword(String password) {
    // Check if the password has at least 6 characters
    if (password.length < 6) {
      return false;
    }

    // Check if the password contains at least 1 uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return false;
    }

    // Check if the password contains at least 1 number
    if (!password.contains(RegExp(r'[0-9]'))) {
      return false;
    }

    return true;
  }

  void _signUp() async {
    String username = _usernameController.text.toUpperCase();
    String nim = _nimController.text;
    String jurusan = _namaJurusanController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String nohp = _nomorHpController.text;

    setState(() {
      _errorMessage = null;
    });

    // Check if any of the required fields are empty
    if (username.isEmpty ||
        nim.isEmpty ||
        jurusan.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        nohp.isEmpty) {
      setState(() {
        _errorMessage = 'Pastikan semuanya sudah terisi';
        isChecked = false;
      });
      return;
    }

    // Check if the 'jurusan' is "Pilih Jurusan"
    if (jurusan == "Pilih Jurusan") {
      setState(() {
        _errorMessage = 'Silahkan Pilih Jurusan';
        isChecked = false;
      });
      return;
    }

    // Check if the password is strong (at least 6 characters, 1 uppercase, 1 number)
    if (!isStrongPassword(password)) {
      setState(() {
        _errorMessage =
            'Password harus terdiri dari minimal 6 karakter, harus ada huruf kapital, dan harus ada angka';
        isChecked = false;
      });
      print(
          'Password must have at least 6 characters, 1 uppercase letter, and 1 number.');
      return;
    }

    // Check if the email, nim, username, and nohp already exist in the database
    bool emailExists = await _checkIfEmailExists(email);
    bool nimExists = await _checkIfNimExists(nim);
    bool nohpExists = await _checkIfNohpExists(nohp);

    if (emailExists || nimExists || nohpExists) {
      setState(() {
        _errorMessage = 'NIM, Email, atau Nomor Telepon anda sudah terdaftar';
        isChecked = false;
      });
      print(
          'Email, nim, username, or nohp already exists. Please choose a different one.');
      return;
    }

    User? user = await _auth.signUpWithEmailAndPassword(
        username, nim, jurusan, email, password, nohp);

    if (user != null) {
      setState(() {
        _errorMessage = 'Akun sudah terbuat';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Akun Sudah Terbuat'),
        ),
      );
      print('Akun Sudah Terbuat');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const HalamanLogin()));
    } else {
      setState(() {
        _errorMessage = 'Check kembali NIM atau No Telepon!';
        isChecked = false;
      });
      print('Failed to create the account');
    }
  }

  Future<bool> _checkIfEmailExists(String email) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking email existence: $e');
      return false;
    }
  }

  Future<bool> _checkIfNimExists(String nim) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('nim', isEqualTo: nim)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking nim existence: $e');
      return false;
    }
  }

  Future<bool> _checkIfNohpExists(String nohp) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('nohp', isEqualTo: nohp)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking nohp existence: $e');
      return false;
    }
  }
  // Implement a method to check if the nohp already exists in the database
  // You can use Firebase Firestore or any other database to perform this check
  // Return true if the nohp exists, false otherwise
}

///////////////////////////////////////////////  Dropdown  /////////////////////////////////////

class DropDownJurusan extends StatefulWidget {
  final ValueChanged<String> onValueChanged;

  const DropDownJurusan({super.key, required this.onValueChanged});

  @override
  State<DropDownJurusan> createState() => _DropDownJurusanState();
}

class _DropDownJurusanState extends State<DropDownJurusan> {
  String pertanyaanpertama = 'Pilih Jurusan';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      padding: const EdgeInsets.only(left: 10),
      margin: const EdgeInsets.only(bottom: 15, left: 30, right: 30),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 2, 128, 144)),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            padding: const EdgeInsets.only(left: 10),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            isExpanded: true,

            iconEnabledColor: const Color.fromARGB(255, 2, 128, 144),
            iconSize: 30,
            value: pertanyaanpertama, // Selected value
            onChanged: (String? newValue) {
              setState(() {
                pertanyaanpertama = newValue!;
                widget.onValueChanged(
                    newValue); // Notify the parent class about the value change
              });
            },
            items: <String>[
              'Pilih Jurusan',
              //MB
              'Diploma 3 Akuntansi',
              'Sarjana Terapan Akuntansi Manajerial',
              'Sarjana Terapan Administrasi Bisnis Terapan',
              'Sarjana Terapan Logistik Perdagangan Internasional',
              'Sarjana Terapan Administrasi Bisnis Terapan (International Class)',
              'Program Studi D2 Jalur Cepat Distribusi Barang',
              //Elektro
              'Diploma 3 Teknik Elektronika Manufaktur',
              'Diploma 3 Teknik Instrumentasi',
              'Sarjana Terapan Teknologi Rekayasa Elektronika',
              'Sarjana Terapan Teknik Mekatronika',
              'Sarjana Terapan Teknologi Rekayasa Pembangkit Energi',
              'Sarjana Terapan Teknik Robotika',
              //Informatika
              'Diploma 3 Teknik Informatika',
              'Diploma 3 Teknologi Geomatika',
              'Sarjana Terapan Animasi',
              'Sarjana Terapan Teknologi Rekayasa Multimedia',
              'Sarjana Terapan Rekayasa Keamanan Siber',
              'Sarjana Terapan Rekayasa Perangkat Lunak',
              //Mesin
              'Diploma 3 Teknik Mesin',
              'Diploma 3 Teknik Perawatan Pesawat Udara',
              'Sarjana Terapan Teknologi Rekayasa Konstruksi Perkapalan',
              'Sarjana Terapan Teknologi Rekayasa Pengelasan dan Fabrikasi',
              'Program Profesi Insinyur (PSPPI)',
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
    );
  }
}
