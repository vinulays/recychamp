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
          .get(const GetOptions(source: Source.server));
      List<Product> products = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();

        Product product = Product(
          productId: doc.id,
          name: data['name'],
          price:double.parse(data['price']
                .toString()),
          imageUrl: data['imageUrl'],
          description: data["description"]
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

 
}
