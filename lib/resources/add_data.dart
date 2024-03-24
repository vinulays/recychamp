import "dart:typed_data";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/foundation.dart";

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadImageToStorage(String fullName, Uint8List file) async {
    Reference ref = _storage.ref().child(fullName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapShot = await uploadTask;
    String downloadURL = await snapShot.ref.getDownloadURL();

    return downloadURL;
  }

  Future<String> saveData({
    required String email,
    required String name,
    required Uint8List file,
  }) async {
    String resp = "Some Error Occured";
    try {
      if (name.isNotEmpty || email.isNotEmpty) {
        String imgUrl = await uploadImageToStorage("profileimage", file);
        await _firestore.collection('User').add({
          'name': name,
          'email': email,
          'imageLink': imgUrl,
        });
        resp = 'success';
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
