import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pbl_stuhealth/login/formlogin.dart';

class LupaPassword extends StatefulWidget {
  const LupaPassword({super.key});

  @override
  State<LupaPassword> createState() => _LupaPasswordState();
}

class _LupaPasswordState extends State<LupaPassword> {
  final _emailController = TextEditingController();
  String? errorMessage; // Variable to hold error message

  @override
  void dispose() {
    _emailController.dispose(); // TODO: implement dispose
    super.dispose();
  }

  Future<void> passwordReset() async {
    String email = _emailController.text.trim();

    // Check if the email exists in Firestore before attempting password reset
    bool emailExists = await checkIfEmailExistsInFirestore(email);

    if (emailExists) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        // Reset email sent
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HalamanLogin()));
      } on FirebaseAuthException catch (e) {
        print('Firebase Auth Exception: ${e.message}');
      }
    } else {
      setState(() {
        _emailController.text = '';
        errorMessage = 'Pengguna dengan email ini tidak ditemukan';
      });
    }
  }

  Future<bool> checkIfEmailExistsInFirestore(String email) async {
    try {
      // Assume your users' collection is named 'users' and the field containing emails is 'email'
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: email)
              .get();

      // If the querySnapshot has any documents, the email exists in the collection
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking email in Firestore: $e');
      return false; // Return false if an error occurs, indicating email doesn't exist
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final bodyHeight = mediaQueryHeight;

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
            SizedBox(
              height: bodyHeight * 0.25,
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20, bottom: 5),
              child: const Center(
                child: Text(
                  'Lupa Password',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 30),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 40, right: 40, bottom: 30),
              child: const Text(
                'Masukkan Email Anda, kami akan mengirimkan link password reset',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20, bottom: 5),
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
                      const EdgeInsets.only(top: 15, bottom: 15, left: 15),
                  hintText: 'Masukkan Email',
                  labelText: 'Masukkan Email',
                  labelStyle:
                      const TextStyle(fontFamily: 'Poppins', fontSize: 15),
                  hintStyle:
                      const TextStyle(fontFamily: 'Poppins', fontSize: 15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 2, 128,
                          144), // Set the border color for unfocused state
                      width: 1.0, // Set the border width for unfocused state
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 2, 128,
                          144), // Set the border color for focused state
                      width: 1.0, // Set the border width for focused state
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 3, bottom: 3),
              child: errorMessage != null
                  ? Text(
                      errorMessage!,
                      style: const TextStyle(
                          color: Colors.red,
                          fontFamily: 'Popins',
                          fontSize: 13),
                    )
                  : Container(), // This container won't take space when errorMessage is null
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, left: 30, right: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(33, 0, 0, 0),
                      blurRadius: 2,
                      spreadRadius: 1,
                      offset: Offset(2, 2))
                ],
              ),
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: MaterialButton(
                  height: 50,
                  color: const Color.fromARGB(255, 2, 128, 144),
                  onPressed: passwordReset,
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
