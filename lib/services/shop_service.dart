import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recychamp/models/product.dart';


class ShopService {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  ShopService(
      {required FirebaseStorage storage, required FirebaseFirestore firestore})
      : _firestore = firestore,
        _storage = storage;

  Future<List<Product>> getProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('products')
          .orderBy("createdAt", descending: true)
          .get(const GetOptions(source: Source.server));
      List<Product> products = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();

        Product product = Product(
          // id: doc.id,
          name: data['name'],
          price: data['price'],
          imageUrl: data['imageUrl'],
        );
        products.add(product);
      }

      return products;
    } catch (e) {
      throw Exception('Failed to fetch challenges: $e');
    }
  }

  Future<void> addProducts(Map<String, dynamic> formData) async {
    try {
      await _firestore.collection("products").add({
        "name": formData['name'],
        "price": formData["price"],
        "imageUrl": formData["imageUrl"],
      });
    } catch (e) {
      rethrow;
    }
  }

  // * update challenge in firebsae
  // Future<void> updateChallenge(Map<String, dynamic> formData) async {
  //   try {
  //     DocumentReference challengeRef =
  //         _firestore.collection("challenges").doc(formData["id"]);

  //     await challengeRef.update({
  //       "title": formData['title'],
  //       "description": formData["description"],
  //       "location": formData["location"],
  //       "country": formData["country"],
  //       "rules": formData["rules"],
  //       "startDateTime": DateTime(
  //           formData["startDate"]
  //               .year, // * combining selected dates and times to create the timestamp
  //           formData["startDate"].month,
  //           formData["startDate"].day,
  //           formData["startTime"].hour,
  //           formData["startTime"].minute),
  //       "endDateTime": DateTime(
  //           formData["endDate"].year,
  //           formData["endDate"].month,
  //           formData["endDate"].day,
  //           formData["endTime"].hour,
  //           formData["endTime"].minute),
  //       "maximumParticipants": int.parse(
  //           formData["maximumParticipants"]), // * converting string to integer
  //       "difficulty": formData["difficulty"],
  //       "imageURL": formData["imageURL"],
  //       "categoryId": formData["categoryId"],
  //       "type": formData["type"]
  //     });
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
