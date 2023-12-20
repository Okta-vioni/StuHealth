import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class AdminUbahPassword extends StatefulWidget {
  const AdminUbahPassword({super.key});

  @override
  State<AdminUbahPassword> createState() => _AdminUbahPasswordState();
}

class _AdminUbahPasswordState extends State<AdminUbahPassword> {
  //Eye Icon Password
  bool _obscureText = true; // State to toggle password visibility
  bool _obscureText2 = true; // State to toggle password visibility

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  Future<void> reauthenticate(User user) async {
    try {
      // Create an instance of AuthCredential using the user's current email and password
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPasswordController.text,
      );

      // Reauthenticate the user with the provided credentials
      await user.reauthenticateWithCredential(credential);
    } catch (e) {
      print("Error reauthenticating: $e");

      // Handle reauthentication failure
      String errorMessage =
          'Autentikasi ulang gagal. Periksa password Anda saat ini dan coba lagi.';

      if (e is FirebaseAuthException) {
        if (e.code == 'wrong-password') {
          errorMessage =
              'Password saat ini salah. Silakan periksa dan coba lagi.';
        }
      }

      // Display an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );

      // Stop further execution if reauthentication fails
      throw Exception("Reauthentication failed");
    }
  }

  Future<void> changePassword() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      // Check if the current password field is empty
      if (currentPasswordController.text.isEmpty) {
        // Display an error message for an empty current password
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Isi kolom password Saat Ini'),
          ),
        );
        return;
      }

      // Reauthenticate the user before changing the password
      await reauthenticate(user!);

      // Check if the new password field is empty
      if (newPasswordController.text.isEmpty) {
        // Display an error message for an empty new password
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Isi kolom password'),
          ),
        );
        return;
      }

      // Validate the new password
      if (!isValidPassword(newPasswordController.text)) {
        // Display an error message for invalid password format
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Password harus terdiri dari minimal 6 karakter, harus ada huruf kapital, dan harus ada angka',
            ),
          ),
        );
        return;
      }

      // Update the user's password
      await user.updatePassword(newPasswordController.text);
      print("Password berhasil diperbarui");

      // Display a success message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password berhasil diperbarui'),
        ),
      );

      // Optionally, you can navigate to a different screen upon success
      Navigator.pop(context); // Navigate back to the previous screen
    } catch (e) {
      // Handle other specific error cases if needed

      // Display an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengubah kata sandi'),
        ),
      );
    }
  }

  // Function to validate the password format
  bool isValidPassword(String password) {
    // Password must have at least one capital letter, one number, and be at least 6 characters long
    final RegExp passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*\d).{6,}$');
    return passwordRegExp.hasMatch(password);
  }

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
              'Ubah Password',
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
                controller: currentPasswordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(top: 15, bottom: 15, left: 20),
                    hintText: 'Password Saat Ini',
                    labelText: 'Password Saat Ini',
                    hintStyle: const TextStyle(fontFamily: 'Poppins'),
                    labelStyle: const TextStyle(fontFamily: 'Poppins'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 2, 128, 144)),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Color.fromARGB(255, 2, 128, 144),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
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
                controller: newPasswordController,
                obscureText: _obscureText2,
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(top: 15, bottom: 15, left: 20),
                    hintText: 'Password baru',
                    labelText: 'Password baru',
                    hintStyle: const TextStyle(fontFamily: 'Poppins'),
                    labelStyle: const TextStyle(fontFamily: 'Poppins'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 2, 128, 144)),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText2 ? Icons.visibility_off : Icons.visibility,
                        color: Color.fromARGB(255, 2, 128, 144),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText2 = !_obscureText2;
                        });
                      },
                    )),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                  onPressed: changePassword, // isi link tujuan
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
