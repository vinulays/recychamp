class Article {
  final String articleImage;
  final String articleTitle;
  final String description;
  final String content;
  final String articleType;
  final String? id;

  const Article({
    required this.articleImage,
    required this.articleTitle,
    required this.description,
    required this.content,
    required this.articleType,
    this.id,
  });
}
