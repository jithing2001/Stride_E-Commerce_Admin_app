import 'package:cloud_firestore/cloud_firestore.dart';

class Update {
   updateOrder(final data, final status) async {
    // Get a reference to the collection
    CollectionReference ordersCollection = FirebaseFirestore.instance
        .collection('users')
        .doc('myorder')
        .collection('allOrders');

    QuerySnapshot querySnapshot = await ordersCollection
        .where('user', isEqualTo: data['user'])
        .where('productName', isEqualTo: data['productName'])
        .get();

    querySnapshot.docs.forEach((document) async {
      await document.reference.update({'status': status});
    });
  }
}
