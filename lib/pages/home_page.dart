import 'package:flutter/material.dart';

import '../data/anime_data.dart';
import '../widgets/banner_widget.dart';
import '../theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'ANIMEKU',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      'Discover your anime world',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const CircleAvatar(
                  backgroundColor: AppColors.card,
                  child: Icon(Icons.notifications_none),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // SEARCH
            TextField(
              decoration: InputDecoration(
                hintText: 'Search your favorite anime...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // BANNER
            const BannerWidget(),

            const SizedBox(height: 28),

            // TRENDING
            const SectionTitle(title: 'Trending Now'),
            const SizedBox(height: 14),
            const AnimeList(
              titles: [
                'Solo Leveling',
                'Demon Slayer',
                'Jujutsu Kaisen',
                'Frieren',
              ],
            ),

            const SizedBox(height: 28),

            // POPULAR
            const SectionTitle(title: 'Popular Anime'),
            const SizedBox(height: 14),
            const AnimeList(
              titles: [
                'One Piece',
                'Naruto Shippuden',
                'Attack on Titan',
                'Spy x Family',
              ],
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}

// JUDUL BAGIAN
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
    );
  }
}

// KARTU ANIME
class AnimeList extends StatelessWidget {
  final List<String> titles;

  const AnimeList({super.key, required this.titles});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 155,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: titles.length,
        itemBuilder: (context, index) {
          final anime = animeList.firstWhere(
            (anime) => anime.title.startsWith(titles[index]),
          );

          return Container(
            width: 115,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(13),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  anime.posterUrl.startsWith('assets/')
                      ? Image.asset(
                          anime.posterUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.movie);
                          },
                        )
                      : Image.network(
                          anime.posterUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.movie);
                          },
                        ),

                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.9),
                        ],
                      ),
                    ),
                    child: Text(
                      titles[index],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
