// lib/models/news_model.dart

class NewsArticle {
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final String? publishedAt;
  final String? sourceName;

  NewsArticle({
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage,
    this.publishedAt,
    this.sourceName,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? 'Judul Tidak Tersedia',
      description: json['description'] ?? 'Deskripsi Tidak Tersedia',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      sourceName: json['source'] != null ? json['source']['name'] : 'Sumber Tidak Diketahui',
    );
  }
}