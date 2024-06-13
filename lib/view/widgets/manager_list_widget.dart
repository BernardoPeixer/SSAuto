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
            children: [Text('Nenhum gerente cadastrado')],
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
                      state.listManager[index].name.length > 17
                          ? '${state.listManager[index].name.substring(0, 17)}...'
                          : state.listManager[index].name,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    children: [
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Fone: ${state.listManager[index].phone}'),
                            Text(
                                '${state.listManager[index].city} / ${state.listManager[index].state}'),
                            Text('Email: ${state.listManager[index].email}'),
                            Text('Cpf: ${state.listManager[index].cpf}'),
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
