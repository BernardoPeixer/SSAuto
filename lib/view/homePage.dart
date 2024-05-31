import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Color blue = const Color(0xff011329);
    Color orange = const Color(0xffD3393A);
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.5,
                    decoration: BoxDecoration(
                      color: blue,
                    ),
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/splash/logo_300x529-removebg-preview.png'),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 3.5 - 20,
                left: (MediaQuery.of(context).size.width -
                        MediaQuery.of(context).size.width / 1.3) /
                    2,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: MediaQuery.of(context).size.height / 6,
                  decoration: BoxDecoration(
                    color: orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Unidade:',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
