import 'package:cloud_firestore/cloud_firestore.dart';

 class OurDatabase {
  static final db = FirebaseFirestore.instance;

  static Future create(String collection, String document, Map<String, dynamic> data) async {
    await db.collection(collection).doc(document).set(data);
  }

  static Future<Map<String, dynamic>?> read(String collection, String document) async {
    final snapshot = await db.collection(collection).doc(document).get();
    return snapshot.data();
  }

  static Future update(String collection, String document, Map<String, dynamic> data) async {
    await db.collection(collection).doc(document).update(data);
  }

  static Future replace(String collection, String document, Map<String, dynamic> data) async {
    await db.collection(collection).doc(document).set(data);
  }

  static Future delete(String collection, String document) async {
    await db.collection(collection).doc(document).delete();
  }
}