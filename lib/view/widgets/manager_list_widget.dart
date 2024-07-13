import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/model/manager_model.dart';
import 'package:ss_auto/states/manager_list_state.dart';

/// CREATION OF STATELESS WIDGET
class ManagerListWidget extends StatelessWidget {
  /// STATELESS WIDGET BUILDER
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
            final manager = state.listManager[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Card(
                  child: ExpansionTile(
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/managerRegistrationPage',
                              arguments: Manager(
                                  managerName: manager.managerName,
                                  managerCity: manager.managerCity,
                                  managerCpf: manager.managerCpf,
                                  managerState: manager.managerState,
                                  managerPhone: manager.managerPhone,
                                  managerCommission: manager.managerCommission,
                                  managerEmail: manager.managerEmail,
                                  managerId: manager.managerId),
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.disabled_by_default_outlined,
                              color: Colors.grey, size: 20),
                        ),
                      ],
                    ),
                    title: Text(
                      state.listManager[index].managerName.length > 17
                          ? '${state.listManager[index].managerName.substring(
                              0,
                              17,
                            )}...'
                          : state.listManager[index].managerName,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    children: [
                      Column(
                        children: [
                          ListTile(
                            title: Text(
                              'Fone: ${state.listManager[index].managerPhone}',
                            ),
                          ),
                          ListTile(
                            title: Text(
                                '${state.listManager[index].managerCity} / ${state.listManager[index].managerState}'),
                          ),
                          ListTile(
                            title: Text(
                                'CPF: ${state.listManager[index].managerCpf}'),
                          ),
                        ],
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
