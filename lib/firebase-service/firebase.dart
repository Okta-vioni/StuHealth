import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

class Databases {
  final CollectionReference fakta =
      FirebaseFirestore.instance.collection('fakta');

  Stream<QuerySnapshot> getFaktaStream() {
    final faktaStream =
        fakta.orderBy('timestamp', descending: true).snapshots();
    return faktaStream;
  }
}
