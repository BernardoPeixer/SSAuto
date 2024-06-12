import 'package:flutter/material.dart';

import '../../model/customer_model.dart';

class CustomerListWidget extends StatelessWidget {
  final int tileQuantity;

  final List<Customer> listCustomers;

  const CustomerListWidget(
      {super.key, required this.tileQuantity, required this.listCustomers});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tileQuantity,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Card(
              child: ExpansionTile(
                title: Text(
                  listCustomers[index].company.length > 17
                      ? '${listCustomers[index].company.substring(0, 17)}...'
                      : listCustomers[index].company,
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                children: [
                  ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Fone: ${listCustomers[index].phone}'),
                        Text(
                            '${listCustomers[index].city} / ${listCustomers[index].state}'),
                        Text('Gerente: ${listCustomers[index].phone}'),
                        Text('Cnpj: ${listCustomers[index].cnpj}'),
                      ],
                    ),
                    leading: Icon(Icons.car_rental),
                  ),
                ],
              ),
            ),
          ]),
        );
      },
    );
  }
}

//listCustomers[index].activity
