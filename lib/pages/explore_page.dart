import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../theme/app_colors.dart';
import '../data/anime_data.dart';
import '../data/favorite_service.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  bool isFinished = false;

  String swipeMessage = 'Swipe right to like, left to skip';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Discover Anime',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Find Your Next Favorite Anime',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              swipeMessage,
              style: const TextStyle(color: Colors.white60),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            Expanded(
              child: isFinished
                  ? const Center(
                      child: Text(
                        'You have explored all anime!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : CardSwiper(
                      cardsCount: animeList.length,
                      isLoop: false,
                      numberOfCardsDisplayed: 2,

                      onSwipe: (previousIndex, currentIndex, direction) {
                        final anime = animeList[previousIndex];

                        if (direction == CardSwiperDirection.right) {
                          FavoriteService.instance.toggleFavorite(anime.id);

                          setState(() {
                            swipeMessage =
                                '${anime.title} ditambahkan ke Favorite!';
                          });
                        } else if (direction == CardSwiperDirection.left) {
                          setState(() {
                            swipeMessage = '${anime.title} dilewati.';
                          });
                        }

                        return true;
                      },

                      onEnd: () {
                        setState(() {
                          isFinished = true;
                          swipeMessage = 'Semua anime sudah dijelajahi!';
                        });
                      },

                      cardBuilder:
                          (
                            context,
                            index,
                            percentThresholdX,
                            percentThresholdY,
                          ) {
                            final anime = animeList[index];

                            return Container(
                              decoration: BoxDecoration(
                                color: AppColors.card,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 1.5,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: anime.posterUrl.startsWith('assets/')
                                      ? Image.asset(
                                          anime.posterUrl,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return const Icon(Icons.movie, size: 90);
                                          },
                                        )
                                      : Image.network(
                                          anime.posterUrl,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return const Icon(Icons.movie, size: 90);
                                          },
                                        ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          Text(
                                            anime.title,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          const SizedBox(height: 8),

                                          Text(
                                            anime.genre,
                                            style: const TextStyle(
                                              color: AppColors.primary,
                                            ),
                                          ),

                                          const SizedBox(height: 12),

                                          Text(
                                            anime.description,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),

                                          const SizedBox(height: 20),

                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(
                                                Icons.close,
                                                color: Colors.redAccent,
                                                size: 35,
                                              ),
                                              Icon(
                                                Icons.favorite,
                                                color: Colors.pinkAccent,
                                                size: 35,
                                              ),
                                            ],
                                          ),
                                        ],
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
        ),
      ),
    );
  }
}
