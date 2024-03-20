import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recychamp/models/article_model.dart';

class ArticleService {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  ArticleService(
      {required FirebaseFirestore firestore, required FirebaseStorage storage})
      : _firestore = firestore,
        _storage = storage;

  Future<List<Article>> getArticles() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('articles')
          .get(const GetOptions(source: Source.server));
      List<Article> articles = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();

        Article article = Article(
          articleTitle: data['articleTitle'],
          description: data['description'],
          articleImage: data['articleImage'],
          articleType: data['articleType'],
          content: data['content']
        );

        articles.add(article);
      }

      return articles;
    } catch (e) {
      throw Exception('Failed to fetch articles: $e');
    }
  }

  Future<void> addArticle(Map<String, dynamic> formData) async {
    try {
      await _firestore.collection("articles").add({
        "articleTitle": formData['articleTitle'],
        "description": formData["description"],
        "articleImage": formData["articleImage"],
        "articleType": formData["articleType"],
        "content": formData["content"]
      });
    } catch (e) {
      rethrow;
    }
  }

  // * update challenge in firebsae
  Future<void> updateArticle(Map<String, dynamic> formData) async {
    try {
      DocumentReference articleRef =
          _firestore.collection("articles").doc(formData["id"]);

      await articleRef.update({
        "articleTitle": formData['articleTitle'],
        "description": formData["description"],
        "articleImage": formData["articleImage"],
        "articleType": formData["articleType"],
         "content": formData["content"]
      });
    } catch (e) {
      rethrow;
    }
  }
}
