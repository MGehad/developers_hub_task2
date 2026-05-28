import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepo {
  FirestoreRepo._();

  static final FirestoreRepo _instance = FirestoreRepo._();

  static FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  // Public access point
  static FirestoreRepo get instance => _instance;

  static Future<DocumentReference<Map<String, dynamic>>> createCollection({
    required String collectionName,
    required Map<String, dynamic> data,
  }) async => await _firestore.collection(collectionName).add(data);

  static Future<QuerySnapshot<Map<String, dynamic>>> getData({
    required String collectionName,
  }) async => await _firestore.collection(collectionName).get();
}
