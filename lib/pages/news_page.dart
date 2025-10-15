import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import untuk membuka link berita
import 'package:intl/intl.dart'; // Import intl
import '../services/news_service.dart';
import '../models/news_model.dart';
import '../data/mock_data.dart'; // Untuk kPrimaryColor

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<NewsArticle>> _newsFuture;

  @override
  void initState() {
    super.initState();
    // Panggil service saat halaman dimuat
    _newsFuture = NewsService().fetchUmrohHajiNews();
  }
  
  // Helper untuk memformat tanggal
  String _formatDate(String? isoDate) {
    if (isoDate == null) return '';
    try {
      final dateTime = DateTime.parse(isoDate).toLocal();
      return DateFormat('dd MMMM yyyy HH:mm', 'id_ID').format(dateTime);
    } catch (e) {
      return isoDate;
    }
  }

  // Helper untuk membuka URL
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka link berita.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berita Haji & Umroh', style: TextStyle(color: Colors.white)),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: _newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: kPrimaryColor));
          } else if (snapshot.hasError) {
            // Tampilkan error
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 50),
                    const SizedBox(height: 10),
                    Text(snapshot.error.toString(), textAlign: TextAlign.center),
                  ],
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ditemukan berita seputar Haji dan Umroh.'));
          } else {
            // Tampilkan daftar berita
            return ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final article = snapshot.data![index];
                return _buildNewsCard(article);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildNewsCard(NewsArticle article) {
    return GestureDetector(
      onTap: () => _launchUrl(article.url),
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.only(bottom: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Berita (jika ada)
              if (article.urlToImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    article.urlToImage!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(), // Hide if image fails
                  ),
                ),
              if (article.urlToImage != null) const SizedBox(height: 10),

              // Judul
              Text(
                article.title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),

              // Detail (Sumber & Tanggal)
              Text(
                '${article.sourceName} - ${_formatDate(article.publishedAt)}',
                style: TextStyle(fontSize: 12, color: kPrimaryColor),
              ),
              const SizedBox(height: 8),

              // Deskripsi
              Text(
                article.description,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}