// lib/services/news_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/news_model.dart';

// Load API key from environment variables
final String newsApiKey = dotenv.env['NEWS_API_KEY'] ?? '';

class NewsService {
  final String _baseUrl = 'https://newsapi.org/v2/everything';

  Future<List<NewsArticle>> fetchUmrohHajiNews() async {
    // Parameter pencarian:
    // q=haji OR umroh (Mencari berita yang mengandung salah satu kata)
    // language=id (Berita berbahasa Indonesia)
    // sortBy=publishedAt (Diurutkan berdasarkan tanggal terbaru)
    final url = Uri.parse(
      '$_baseUrl?q=(haji OR umroh) AND (indonesia)&language=id&sortBy=publishedAt&apiKey=$newsApiKey'
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        
        if (data['status'] == 'ok' && data['articles'] != null) {
          List<dynamic> articlesJson = data['articles'];
          
          return articlesJson
              .map((json) => NewsArticle.fromJson(json))
              .toList();
        } else {
          // Tangani kasus ketika API mengembalikan status OK tetapi tanpa artikel
          throw Exception(data['message'] ?? 'Gagal memuat berita. Data tidak lengkap.');
        }
      } else {
        // Tangani error status code HTTP (e.g., 401 Unauthorized, 404 Not Found)
        throw Exception('Gagal memuat berita. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      // Tangani error jaringan atau parsing
      print('Error di NewsService: $e');
      // Anda bisa mengembalikan list kosong atau throw error
      throw Exception('Gagal memuat berita: Pastikan API Key benar dan internet terhubung.');
    }
  }
}