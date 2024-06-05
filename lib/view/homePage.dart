import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ss_auto/view/widgets/myBottomAppBar.dart';
import 'package:ss_auto/view/widgets/centerContainersHomePage.dart';
import 'package:ss_auto/view/widgets/myFloatingActionButton.dart';

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
            flex: 5,
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
                          children: [],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CenterContainersHomePage(
                      title: 'Aluguéis:',
                      statistic: '197',
                      subtitle: 'Automóveis',
                      color: orange,
                      width: MediaQuery.of(context).size.width / 2.3,
                      height: MediaQuery.of(context).size.height / 5,
                      titleFontSize: 15,
                      subtitleFontSize: 16,
                      statisticFontSize: 25,
                    ),
                    CenterContainersHomePage(
                      title: 'Receita Estimada:',
                      statistic: 'R\$198.879',
                      subtitle: 'Pendente',
                      color: orange,
                      width: MediaQuery.of(context).size.width / 2.3,
                      height: MediaQuery.of(context).size.height / 5,
                      titleFontSize: 15,
                      subtitleFontSize: 16,
                      statisticFontSize: 25,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: orange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.height / 6,
                      child: const Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Frota em Operação:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MyFloatingActionButton(
        color: blue,
      ),
      bottomNavigationBar: const MyBottomAppBar(),
    );
  }
}
