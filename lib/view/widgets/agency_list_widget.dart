import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../states/agency_list_state.dart';

class AgencyListWidget extends StatelessWidget {
  const AgencyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AgencyListState(),
      child: Consumer<AgencyListState>(builder: (_, state, __) {
        if (state.listAgency.isEmpty) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Nenhuma agência cadastrada',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              )
            ],
          );
        }
        return ListView.builder(
          itemCount: state.listAgency.length,
          itemBuilder: (context, index) {
            final agency = state.listAgency[index];
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

                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            state.deleteAgency(agency);
                          },
                          icon: const Icon(Icons.delete_outlined,
                              color: Colors.grey, size: 20),
                        ),
                      ],
                    ),
                    title: Text(
                      agency.agencyName.length > 17
                          ? '${agency.agencyName.substring(0, 17)}...'
                          : agency.agencyName,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    children: [
                      Column(
                        children: [
                          ListTile(
                            title: Text(
                                'Gerente: ${agency.managerCode}'),
                          ),
                          ListTile(
                            title: Text(
                                '${agency.agencyCity} / ${agency.agencyState}'),
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
