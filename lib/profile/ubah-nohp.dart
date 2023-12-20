import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pbl_stuhealth/firebase-service/firebase_auth_service.dart';

// ignore: camel_case_types
class editnohp extends StatefulWidget {
  const editnohp({super.key});

  @override
  State<editnohp> createState() => _editnohpState();
}

class _editnohpState extends State<editnohp> {
  final FirebaseAuthService _authService = FirebaseAuthService();

// Add a TextEditingController for the email TextField
  final TextEditingController _nohpController = TextEditingController();

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
              'Edit Nomor Telepon',
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
                    Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          userDetails['nohp'],
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        right: 20,
                        left: 20,
                      ),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        controller: _nohpController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                top: 15, bottom: 15, left: 20),
                            hintText: 'Nomor Telepon',
                            labelText: 'Nomor Telepon Baru',
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
                    onPressed: _updateNohp, // isi link tujuan
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
  void _updateNohp() async {
    // Get the current user
    User? currentUser = FirebaseAuthService().getCurrentUser();

    // Get the new phone number from the controller
    String newNohp = _nohpController.text.trim();

    try {
      // Update the phone number using the authService
      await FirebaseAuthService().updateUserNohp(currentUser!.uid, newNohp);

      // Show a success message or navigate to another screen if needed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nomor Telepon berhasil diperbarui'),
          duration: const Duration(seconds: 2),
        ),
      );

      // You may also choose to navigate back or to another screen
      Navigator.pop(context);
    } catch (e) {
      // Handle any errors that might occur during the update process
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memperbarui Nomor Telepon: ${e.toString()}'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
