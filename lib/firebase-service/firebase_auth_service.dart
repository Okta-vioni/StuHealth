import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //instance of auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUpWithEmailAndPassword(String username, String nim,
      String jurusan, String email, String password, String nohp) async {
    try {
      // Validate 'nohp' to ensure it contains only numbers
      if (int.tryParse(nim) != null && int.tryParse(nohp) != null) {
        // 'nim' and 'nohp' are valid numbers, proceed with Firestore update
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // Get the UID of the newly created user
        String uid = credential.user!.uid;

        // Add user details to Firestore
        await addUserDetails(username, nim, jurusan, email, nohp, uid);

        // Return the user
        return credential.user;
      } else {
        // 'nim' or 'nohp' is not a valid number, handle the error as needed
        print('Invalid nim or nohp');
        return null;
      }
    } catch (e) {
      print('Error during registration: $e');
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Sama seperti bagian SignUp, saya merubah UserCredential.user! menjadi _auth.currentUser!
      await _firestore.collection('user').doc(_auth.currentUser!.uid).set({
        'uid': _auth.currentUser!.uid,
        'email': email,
      }, SetOptions(merge: true));
      return credential.user; // Return the user if login is successful
    } catch (e) {
      print('Error during login: $e');
      return null; // Return null in case of an error
    }
  }

  Future<void> addUserDetails(String username, String nim, String jurusan,
      String email, String nohp, String uid) async {
    try {
      // Validate 'nohp' to ensure it contains only numbers
      if (int.tryParse(nim) != null) {
        if (int.tryParse(nohp) != null) {
          // 'nohp' is a valid number, proceed with Firestore update
          await FirebaseFirestore.instance.collection('users').doc(uid).set({
            'uid': uid,
            'username': username,
            'nim': nim,
            'jurusan': jurusan,
            'email': email,
            'nohp': nohp,
          });
          print('User details added to Firestore.');
        } else {
          // 'nohp' is not a valid number, handle the error as needed
          print('Invalid phone number: $nohp');
        }
      } else {
        // 'nim' is not a valid number, handle the error as needed
        print('Invalid nim: $nim');
      }
    } catch (e) {
      print('Error adding user details to Firestore: $e');
    }
  }

  Future<Map<String, dynamic>?> getUserDetails(String email) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').doc(email).get();

      if (snapshot.exists) {
        return snapshot.data();
      } else {
        print('User details not found for email: $email');
        return null;
      }
    } catch (e) {
      print('Error getting user details from Firestore: $e');
      return null;
    }
  }

  Future<void> updateUserNohp(String uid, String newNohp) async {
    try {
      // Validate 'newNohp' to ensure it contains only numbers
      if (int.tryParse(newNohp) != null) {
        // 'newNohp' is a valid number, proceed with Firestore update
        await _firestore.collection('users').doc(uid).update({
          'nohp': newNohp,
        });
        print('Nomor Telepon updated in Firestore.');
      } else {
        // 'newNohp' is not a valid number, handle the error as needed
        print('Invalid phone number: $newNohp');
      }
    } catch (e) {
      print('Error updating Nomor Telepon in Firestore: $e');
      throw e; // Rethrow the exception to handle it in the calling function
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
