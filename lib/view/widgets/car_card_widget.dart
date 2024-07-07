import 'dart:io';

import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  final String imagePath;
  final String brand;
  final String model;
  final String year;
  final String status;
  final double price;
  final Function() onTap;

  const CarCard({
    super.key,
    required this.imagePath,
    required this.brand,
    required this.model,
    required this.year,
    required this.status,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(16.0),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              child: Image.file(
                File(
                  imagePath,
                ),
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$brand $model',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Ano: $year',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status: $status',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'R\$ $price',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
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
  }
}