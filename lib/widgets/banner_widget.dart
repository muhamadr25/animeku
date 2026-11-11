import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../theme/app_colors.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  final List<Map<String, String>> banners = const [
    {
      'title': 'Solo Leveling',
      'subtitle': 'The Weakest Hunter Becomes the Strongest',
      'image': 'assets/images/banners/solo_leveling_banner.jpg',
    },
    {
      'title': 'Demon Slayer',
      'subtitle': 'The Journey of Tanjiro Kamado',
      'image': 'assets/images/banners/demon_slayer_banner.jpg',
    },
    {
      'title': 'Jujutsu Kaisen',
      'subtitle': 'Enter the World of Curses',
      'image': 'assets/images/banners/jujutsu_kaisen_banner.jpg',
    },
    {
      'title': 'Blue Lock',
      'subtitle': 'The Road to Becoming the Best Striker',
      'image': 'assets/images/banners/blue_lock_banner.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        enlargeCenterPage: true,
        viewportFraction: 0.88,
        aspectRatio: 16 / 9,
      ),
      items: banners.map((banner) {
        return Builder(
          builder: (context) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      banner['image']!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.white,
                            size: 40,
                          ),
                        );
                      },
                    ),

                    Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0.85),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            banner['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            banner['subtitle']!,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
