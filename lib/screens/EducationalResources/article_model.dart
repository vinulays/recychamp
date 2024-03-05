class Article {
  final String articleImage;
  final String articleTitle;
  final String description;
  final DateTime modifiedDate;
  final String content;

  const Article(
      {required this.articleImage,
      required this.articleTitle,
      required this.description,
      required this.modifiedDate,
      required this.content});
}
