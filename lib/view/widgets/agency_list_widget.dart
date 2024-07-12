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
          return const Center(
            child: Text(
              'Nenhuma agência cadastrada',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          );
        }
        return ListView.builder(
          itemCount: state.listAgency.length,
          itemBuilder: (context, index) {
            final agency = state.listAgency[index];
            final managers = state.getManagersForAgency(agency.managerCode!);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          agency.agencyName.length > 17
                              ? '${agency.agencyName.substring(0, 17)}...'
                              : agency.agencyName,
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
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
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Gerente: ${managers.map((manager) => manager.managerName).join(", ")}',
                    ),
                    Text(
                      '${agency.agencyCity} / ${agency.agencyState}',
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
