import 'package:flutter/material.dart';

import '../models/anime_model.dart';
import 'anime_data.dart';

class FavoriteService extends ChangeNotifier {
  FavoriteService._();

  static final FavoriteService instance = FavoriteService._();

  // Menyimpan ID anime yang disukai
  final Set<int> _favoriteIds = {};

  // Mengecek apakah anime sudah disukai
  bool isFavorite(int animeId) {
    return _favoriteIds.contains(animeId);
  }

  // Menambahkan atau menghapus anime dari Favorite
  void toggleFavorite(int animeId) {
    if (_favoriteIds.contains(animeId)) {
      _favoriteIds.remove(animeId);
    } else {
      _favoriteIds.add(animeId);
    }

    notifyListeners();
  }

  // Mengambil daftar anime yang disukai
  List<AnimeModel> get favoriteAnime {
    return animeList.where((anime) => _favoriteIds.contains(anime.id)).toList();
  }
}
