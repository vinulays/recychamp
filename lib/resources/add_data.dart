import "dart:typed_data";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/foundation.dart";

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadImageToStorage(String fullName, Uint8List file) async {
    Reference ref = _storage.ref().child(fullName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapShot = await uploadTask;
    String downloadURL = await snapShot.ref.getDownloadURL();

    return downloadURL;
  }

  Future<String> saveData({
    required String name,
    required Uint8List file,
    required String userId,
  }) async {
    String resp = "Some Error Occured";
    try {
      if (name.isNotEmpty) {
        String imgUrl = await uploadImageToStorage("profileimage", file);
        await _firestore.collection('users')
        .doc(userId)
        .set({
          'username': name,
          'photoUrl': imgUrl,
          'role': 'parent'
        });
        resp = 'success';
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }

