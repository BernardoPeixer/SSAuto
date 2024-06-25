import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/manager_list_state.dart';

class ManagerListWidget extends StatelessWidget {
  const ManagerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ManagerListState(),
      child: Consumer<ManagerListState>(builder: (_, state, __) {
        if (state.listManager.isEmpty) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Nenhum gerente cadastrado',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              )
            ],
          );
        }
        return ListView.builder(
          itemCount: state.listManager.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Card(
                  child: ExpansionTile(
                    title: Text(
                      state.listManager[index].managerName.length > 17
                          ? '${state.listManager[index].managerName.substring(0, 17)}...'
                          : state.listManager[index].managerName,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    children: [
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Fone: ${state.listManager[index].managerPhone}'),
                            Text(
                                '${state.listManager[index].managerCity} / ${state.listManager[index].managerState}'),
                            Text('Cpf: ${state.listManager[index].managerCpf}'),
                          ],
                        ),
                        leading: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Clientes:'),
                            Text('4'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            );
          },
        );
      }),
    );
  }
}
