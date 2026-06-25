import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';

class DestaquesSemanaWidget extends StatefulWidget {
  const DestaquesSemanaWidget({super.key});

  @override
  State<DestaquesSemanaWidget> createState() => _DestaquesSemanaWidgetState();
}

class _DestaquesSemanaWidgetState extends State<DestaquesSemanaWidget> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  final destaqueItems = [
    {
      'imageUrl': '',
      'assetUrl': 'assets/images/destaque_1.png',
    },
    {
      'imageUrl': '',
      'assetUrl': 'assets/images/destaque_2.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Destaques da semana',
            style: TextStyle(
              color: AppScheme.gray[4],
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 7),
          CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              height: 118,
              onPageChanged: (index, reason) =>
                  setState(() => _current = index),
            ),
            items: destaqueItems
                .map((destaque) => ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        destaque['assetUrl']!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: destaqueItems
                .asMap()
                .entries
                .map((entry) => GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == entry.key
                              ? AppScheme.brightGreen
                              : AppScheme.gray[3],
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
