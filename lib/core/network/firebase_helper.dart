import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseHelper {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  // ✅ تسجيل مستخدم جديد
  static Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      log("Error signing up: $e");
      return null;
    }
  }

  // ✅ تسجيل الدخول
  static Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      log("Error signing in: $e");
      return null;
    }
  }

  // ✅ تسجيل الخروج
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  // ✅ رفع صورة إلى Firebase Storage
  static Future<String?> uploadImage(File image, String path) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage.ref().child('$path/$fileName.jpg');
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      log("Error uploading image: $e");
      return null;
    }
  }

  // ✅ إضافة بيانات إلى Firestore
  static Future<void> addData(
    String collection,
    String docId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection(collection).doc(docId).set(data);
    } catch (e) {
      log("Error adding data: $e");
    }
  }

  // ✅ تحديث بيانات في Firestore
  static Future<void> updateData(
    String collection,
    String docId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection(collection).doc(docId).update(data);
    } catch (e) {
      log("Error updating data: $e");
    }
  }

  // ✅ حذف بيانات من Firestore
  static Future<void> deleteData(String collection, String docId) async {
    try {
      await _firestore.collection(collection).doc(docId).delete();
    } catch (e) {
      log("Error deleting data: $e");
    }
  }

  // ✅ جلب بيانات من Firestore
  static Future<DocumentSnapshot?> getData(
    String collection,
    String docId,
  ) async {
    try {
      return await _firestore.collection(collection).doc(docId).get();
    } catch (e) {
      log("Error getting data: $e");
      return null;
    }
  }
}
