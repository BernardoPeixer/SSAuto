import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/customer_model.dart';
import '../../states/customer_list_state.dart';

class CustomerListWidget extends StatelessWidget {
  const CustomerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomerListState(),
      child: Consumer<CustomerListState>(builder: (_, state, __) {
        if (state.listCustomer.isEmpty) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Nenhum cliente cadastrado',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          );
        }
        return ListView.builder(
          itemCount: state.listCustomer.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Card(
                  child: ExpansionTile(
                    title: Text(
                      state.listCustomer[index].company.length > 17
                          ? '${state.listCustomer[index].company.substring(0, 17)}...'
                          : state.listCustomer[index].company,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    children: [
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Fone: ${state.listCustomer[index].phone}'),
                            Text(
                                '${state.listCustomer[index].city} / ${state.listCustomer[index].state}'),
                            Text('Gerente: ${state.listCustomer[index].phone}'),
                            Text('Cnpj: ${state.listCustomer[index].cnpj}'),
                          ],
                        ),
                        leading: const Icon(Icons.car_rental),
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

//listCustomers[index].activity
