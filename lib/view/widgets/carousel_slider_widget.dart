import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

/// CREATION OF STATELESS WIDGET
class CarouselSliderWidget extends StatelessWidget {
  /// LIST OF IMAGES PATHS
  final List<String> imagesPath;

  /// STATELESS WIDGET BUILDER
  const CarouselSliderWidget({super.key, required this.imagesPath});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180.0,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        enableInfiniteScroll: false,
      ),
      items: imagesPath.map((imagePath) {
        return Builder(
          builder: (context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(right: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
