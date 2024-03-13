import 'package:recychamp/models/article_model.dart';
import 'package:recychamp/services/article_service.dart';

class ArticleRepo {
  final ArticleService _articleServise;

  ArticleRepo({required ArticleService articleServise})
      : _articleServise = articleServise;

  Future<List<Article>> getArticles() async {
    return _articleServise.getArticles();
  }

  Future<void> addArticle(Map<String, dynamic> formData) async {
    await _articleServise.addArticle(formData);
  }

  Future<void> updateArticle(Map<String, dynamic> formData) async {
    await _articleServise.updateArticle(formData);
  }
}
