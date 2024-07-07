import 'dart:io';

import 'package:flutter/material.dart';

class AddPhotosButtonWidget extends StatelessWidget {
  final List<File> carImages;
  final void Function(BuildContext) showImageSourceDialog;
  final void Function(int) removeCarImage;

  const AddPhotosButtonWidget({
    super.key,
    required this.carImages,
    required this.showImageSourceDialog,
    required this.removeCarImage,
  });

  @override
  Widget build(BuildContext context) {
    return carImages.isNotEmpty
        ? SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (carImages.length >= 5) ? 5 : carImages.length + 1,
              itemBuilder: (context, index) {
                if (carImages.length < 5 && index >= carImages.length) {
                  return Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add, size: 40,),
                      color: const Color(0xFFca122e),
                      onPressed: () async {
                        showImageSourceDialog(context);
                      },
                    ),
                  );
                }

                final carImage = carImages[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Stack(
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              carImage,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              removeCarImage(index);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: MediaQuery.of(context).size.width / 1,
              height: 120,
              color: Colors.white,
              child: IconButton(
                onPressed: () async {
                  showImageSourceDialog(context);
                },
                icon: const Icon(
                  Icons.add,
                  color: Color(0xFFca122e),
                  size: 40,
                ),
              ),
            ),
          );
  }
}
