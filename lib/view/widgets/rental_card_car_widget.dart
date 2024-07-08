import 'dart:io';
import 'package:flutter/material.dart';

class RentalCardCarWidget extends StatelessWidget {
  final String imagePath;
  final String vehicleModel;
  final String vehicleYear;
  final double vehicleDailyCost;
  final void Function() onPressed;

  const RentalCardCarWidget({
    super.key,
    required this.imagePath,
    required this.vehicleModel,
    required this.vehicleYear,
    required this.vehicleDailyCost,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Container(
        height: 130,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Container(
                  width: 120,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      File(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicleModel.length > 10
                          ? "${vehicleModel.substring(0, 10)}..."
                          : vehicleModel,
                      style: const TextStyle(
                        color: Color(0xFFca122e),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Anos: $vehicleYear',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF797979),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 105,
                          height: 30,
                          child: Center(
                            child: Text(
                              'R\$ $vehicleDailyCost/dia',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 24,
                          child: FilledButton(
                            style: const ButtonStyle(
                              padding:
                                  WidgetStatePropertyAll<EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(horizontal: 4),
                              ),
                              backgroundColor: WidgetStatePropertyAll<Color>(
                                Color(0xFFca122e),
                              ),
                            ),
                            onPressed: onPressed,
                            child: const Text(
                              'ALUGUE AGORA',
                              style: TextStyle(fontSize: 12),
                            ),
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
      ),
    );
  }
}
