import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pbl_stuhealth/firebase-service/firebase_auth_service.dart';
import 'package:pbl_stuhealth/tengah/intihome.dart';

// ignore: camel_case_types
class editprofile extends StatefulWidget {
  const editprofile({super.key});

  @override
  State<editprofile> createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  final FirebaseAuthService _authService = FirebaseAuthService();

// Add a TextEditingController for the email TextField
  final TextEditingController _emailController = TextEditingController();

  bool isChecked = false;

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
                margin: const EdgeInsets.only(top: 20, left: 10),
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
            FutureBuilder(
              future: _authService
                  .getUserDetails(_authService.getCurrentUser()!.email!),
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
                    const SizedBox(
                      height: 50,
                    ),
                    AbsorbPointer(
                      absorbing: !isChecked,
                      child: Opacity(
                          opacity: isChecked ? 1.0 : 0.5,
                          child: Container(
                            margin: const EdgeInsets.only(
                                right: 20, left: 20, bottom: 15),
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 15, bottom: 15, left: 20),
                                hintText: 'Nama Lengkap',
                                labelText: userDetails['username'],
                                hintStyle:
                                    const TextStyle(fontFamily: 'Poppins'),
                                labelStyle:
                                    const TextStyle(fontFamily: 'Poppins'),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 2, 128, 144)),
                                ),
                              ),
                            ),
                          )),
                    ),
                    AbsorbPointer(
                        absorbing: !isChecked,
                        child: Opacity(
                          opacity: isChecked ? 1.0 : 0.5,
                          child: Container(
                            margin: const EdgeInsets.only(
                                right: 20, left: 20, bottom: 15),
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 15, bottom: 15, left: 20),
                                hintText: 'NIM',
                                labelText: userDetails['nim'],
                                hintStyle:
                                    const TextStyle(fontFamily: 'Poppins'),
                                labelStyle:
                                    const TextStyle(fontFamily: 'Poppins'),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 2, 128, 144)),
                                ),
                              ),
                            ),
                          ),
                        )),
                    AbsorbPointer(
                        absorbing: !isChecked,
                        child: Opacity(
                          opacity: isChecked ? 1.0 : 0.5,
                          child: Container(
                            margin: const EdgeInsets.only(
                                right: 20, left: 20, bottom: 15),
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 15, bottom: 15, left: 20),
                                hintText: 'Nama Jurusan',
                                labelText: userDetails['jurusan'],
                                hintStyle:
                                    const TextStyle(fontFamily: 'Poppins'),
                                labelStyle:
                                    const TextStyle(fontFamily: 'Poppins'),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 2, 128, 144)),
                                ),
                              ),
                            ),
                          ),
                        )),
                    Container(
                      margin: const EdgeInsets.only(
                          right: 20, left: 20, bottom: 15),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                top: 15, bottom: 15, left: 20),
                            hintText: 'Email',
                            labelText: 'Email',
                            hintStyle: const TextStyle(fontFamily: 'Poppins'),
                            labelStyle: const TextStyle(fontFamily: 'Poppins'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                top: 15, bottom: 15, left: 20),
                            hintText: 'Nomor Telepon',
                            labelText: 'Nomor Telepon',
                            hintStyle: const TextStyle(fontFamily: 'Poppins'),
                            labelStyle: const TextStyle(fontFamily: 'Poppins'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 2, 128, 144)),
                            )),
                      ),
                    ),
                  ]);
                }
              },
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color.fromARGB(255, 2, 128, 144),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(33, 0, 0, 0),
                        blurRadius: 2,
                        spreadRadius: 1,
                        offset: Offset(2, 2))
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: MaterialButton(
                    onPressed: _updateEmail, // isi link tujuan
                    child: const Text(
                      'Simpan',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 20),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Function to update email
  void _updateEmail() async {
    // Get the current user
    User? currentUser = FirebaseAuthService().getCurrentUser();

    if (currentUser != null) {
      // Get the new email from the controller
      String newEmail = _emailController.text.trim();

      // Reauthenticate user before updating email
      AuthCredential credential = EmailAuthProvider.credential(
        email: currentUser.email!,
        password:
            "user_current_password", // Replace with the user's current password
      );

      try {
        // Reauthenticate the user
        await currentUser.reauthenticateWithCredential(credential);

        // Update the email
        await currentUser.updateEmail(newEmail);

        //message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Akun Sudah Terbuat'),
          ),
        );
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HalamanHome()));

        // Display a success message or navigate to another screen
        print('Email updated successfully to: $newEmail');
      } catch (e) {
        // Handle the error (display a message or log)
        print('Error during reauthentication or updating email: $e');
      }
    } else {
      // Handle the case where the current user is null
      print('No user found');
    }
  }
}
