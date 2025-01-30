import 'package:flutter/material.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Map<String, String>> _favorites = [];

  List<Map<String, String>> get favorites => _favorites;

  void addFavorite(Map<String, String> book) {
    _favorites.add(book);
    notifyListeners();
  }

  void removeFavorite(Map<String, String> book) {
    _favorites.removeWhere((item) => item['title'] == book['title']);
    notifyListeners();
  }

  bool isFavorite(Map<String, String> book) {
    return _favorites.any((item) => item['title'] == book['title']);
  }
}
