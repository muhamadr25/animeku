import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../data/anime_data.dart';
import '../data/favorite_service.dart';
import '../theme/app_colors.dart';

class TrendingSwiper extends StatefulWidget {
  const TrendingSwiper({super.key});

  @override
  State<TrendingSwiper> createState() => _TrendingSwiperState();
}

class _TrendingSwiperState extends State<TrendingSwiper> {
  String message = 'Geser kanan untuk suka, kiri untuk lewati';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          message,
          style: const TextStyle(color: Colors.white60, fontSize: 12),
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 250,
          child: CardSwiper(
            cardsCount: animeList.length,
            isLoop: false,
            numberOfCardsDisplayed: 2,

            onSwipe: (previousIndex, currentIndex, direction) {
              final anime = animeList[previousIndex];

              if (direction == CardSwiperDirection.right) {
                FavoriteService.instance.toggleFavorite(anime.id);

                setState(() {
                  message = '${anime.title} ditambahkan ke Favorite!';
                });
              } else if (direction == CardSwiperDirection.left) {
                setState(() {
                  message = '${anime.title} dilewati.';
                });
              }

              return true;
            },

            cardBuilder:
                (context, index, percentThresholdX, percentThresholdY) {
                  final anime = animeList[index];

                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primary, width: 1.5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Image.network(
                              anime.posterUrl,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: AppColors.secondary,
                                  child: const Center(
                                    child: Icon(
                                      Icons.movie,
                                      color: Colors.white70,
                                      size: 40,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    anime.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    anime.genre,
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 11,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    anime.description,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 10,
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  const Icon(
                                    Icons.favorite,
                                    color: Colors.pinkAccent,
                                    size: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
          ),
        ),
      ],
    );
  }
}
