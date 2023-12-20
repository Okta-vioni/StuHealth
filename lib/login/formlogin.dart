import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pbl_stuhealth/Admin/Tengah/inti.dart';
import 'package:pbl_stuhealth/firebase-service/firebase_auth_service.dart';
import 'package:pbl_stuhealth/login/formbuatakun.dart';
import 'package:pbl_stuhealth/login/lupapassword.dart';
import 'package:pbl_stuhealth/tengah/inti.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HalamanLogin extends StatefulWidget {
  const HalamanLogin({super.key});

  @override
  State<HalamanLogin> createState() => _HalamanLoginState();
}

class _HalamanLoginState extends State<HalamanLogin>
    with WidgetsBindingObserver {
  //Eye Icon Password
  bool _obscureText = true; // State to toggle password visibility

  //error
  String? _errorMessage;

  //Text Controllers
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  //exitbutton
  bool _shouldExit = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _shouldExit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!_shouldExit) {
          final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  'Konfirmasi',
                  style: TextStyle(
                      fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                ),
                content: const Text(
                    'Apakah anda ingin keluar dari Aplikasi StuHealth?',
                    style: TextStyle(fontFamily: 'Poppins'),
                    textAlign: TextAlign.left),
                actions: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 2, 128, 144)),
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text(
                              'Tidak',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 2, 128, 144),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        //////////////////////////////////////
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 2, 128, 144)),
                              color: Color.fromARGB(255, 2, 128, 144),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: MaterialButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool('loggedIn', false);
                              Navigator.of(context).pop(true);
                            },
                            child: const Text(
                              'Ya',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
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

          if (value != null) {
            if (value) {
              // If true, exit the app
              SystemNavigator.pop();
              _shouldExit = true;
            }
            return Future.value(value);
          } else {
            return Future.value(false);
          }
        } else {
          // If shouldExit is true, exit the app without showing the dialog
          SystemNavigator.pop();
          return Future.value(true);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 50,
                  ),
                  child: Image.asset(
                    'img/LogoSH.png',
                    height: 50,
                    width: 50,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Image.asset('img/StuHealthWord.png')),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 50, left: 50),
                  child: const Text(
                    'Aplikasi Mobile Kesehatan Mahasiswa',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                    child: Image.asset('img/Login.png')),
              ]),
              //////////////////////////////////////////////////////////// Column Formulir ///////////////////////////////////////////////////////////////
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(top: 15, bottom: 15),
                                hintText: 'Masukkan Email',
                                labelText: 'Masukkan Email',
                                labelStyle: const TextStyle(
                                    fontFamily: 'Poppins', fontSize: 15),
                                hintStyle: const TextStyle(
                                    fontFamily: 'Poppins', fontSize: 15),
                                prefixIcon: Container(
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 10),
                                  child: const Icon(
                                    Icons.person_outline,
                                    size: 30,
                                    color: Color.fromARGB(255, 2, 128, 144),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 0, 132,
                                        119), // Set the border color for unfocused state
                                    width:
                                        1.0, // Set the border width for unfocused state
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 0, 132,
                                        119), // Set the border color for focused state
                                    width:
                                        1.0, // Set the border width for focused state
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                controller: _passwordController,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                ),
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(
                                      top: 15, bottom: 15),
                                  hintText: 'Masukkan Password',
                                  labelText: 'Masukkan Password',
                                  labelStyle: const TextStyle(
                                      fontFamily: 'Poppins', fontSize: 15),
                                  hintStyle: const TextStyle(
                                      fontFamily: 'Poppins', fontSize: 15),
                                  prefixIcon: Container(
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 10),
                                    child: const Icon(
                                      Icons.key,
                                      size: 30,
                                      color: Color.fromARGB(255, 2, 128, 144),
                                    ),
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
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 0, 132,
                                          119), // Set the border color for unfocused state
                                      width:
                                          1.0, // Set the border width for unfocused state
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 0, 132,
                                          119), // Set the border color for focused state
                                      width:
                                          1.0, // Set the border width for focused state
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Display error message below password field
                    if (_errorMessage !=
                        null) // Display error message if not null
                      const SizedBox(height: 10), // Add some spacing
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        _errorMessage ?? '', // Display the error message
                        style: const TextStyle(
                            color: Colors
                                .red, // Set the color to red for error messages
                            fontFamily: "Poppins",
                            fontSize: 12),
                      ),
                    ),
                    //////////////////////////////////////////////////////////// Masuk ke Main Menu ///////////////////////////////////////////////////////////////
                    Container(
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 20),
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(33, 0, 0, 0),
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  offset: Offset(2, 2))
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: MaterialButton(
                                color: const Color.fromARGB(255, 2, 128, 144),
                                height: 50,
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                ),
                                onPressed: _signIn,
                                child: const Text(
                                  'Masuk',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Poppins'),
                                )),
                          ),
                        )),
                    //////////////////////////////////////////////////////////// link Lupa PW ///////////////////////////////////////////////////////////////
                    Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LupaPassword()));
                            },
                            child: const Text(
                              'Lupa Password?',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins'),
                            ))),
                    //////////////////////////////////////////////////////////// Link Untuk Daftar ///////////////////////////////////////////////////////////////
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Belum memiliki akun?',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BuatAkun(),
                              ),
                            );
                          },
                          child: const Text(
                            'Daftar',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins',
                              // Tambahkan dekorasi underline
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _errorMessage = null;
    });

    if (user != null) {
      print('User signed in');

      // Check if the user is an admin (for example, using their email)
      if (email.toLowerCase() == 'admin@admin.com') {
        // Assuming the login is successful, set firstLaunch to false
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('loggedIn', false);
        // Navigate to the admin page
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AdminIntiAplikasi()));
      } else {
        // Assuming the login is successful, set firstLaunch to false
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('loggedIn', true);
        // Navigate to the regular user page
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const IntiAplikasi()));
      }
    } else {
      setState(() {
        _errorMessage = 'Email atau password yang anda masukkan salah!';
      });
      print('Login failed');
    }
  }
}
