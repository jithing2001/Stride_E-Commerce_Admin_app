import 'package:cloud_firestore/cloud_firestore.dart';

class Update {
  updateOrder(String user, String productName) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('myorder')
        .collection(user)
        .doc(productName)
        .update({'status': 'completed'});
  }
}
