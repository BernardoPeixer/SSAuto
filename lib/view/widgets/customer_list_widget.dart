import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../states/customer_list_state.dart';

/// CREATION OF STATELESS WIDGET
class CustomerListWidget extends StatelessWidget {
  /// STATELESS WIDGET BUILDER
  const CustomerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomerListState(),
      child: Consumer<CustomerListState>(builder: (_, state, __) {
        if (state.listCustomer.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nenhum cliente cadastrado',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: state.listCustomer.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ExpansionTile(
                  title: Text(
                    state.listCustomer[index].customerName.length > 17
                        ? '${state.listCustomer[index].customerName.substring(
                            0,
                            17,
                          )}...'
                        : state.listCustomer[index].customerName,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          state.delete(
                            state.listCustomer[index],
                          );
                        },
                        icon: const Icon(Icons.delete_outline,
                            color: Colors.grey, size: 20),
                      ),
                    ],
                  ),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            'Telefone: ${state.listCustomer[index].
                            customerPhone}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            '${state.listCustomer[index].
                            customerCity} / ${state.listCustomer[index].
                            customerState}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'CNPJ: ${state.listCustomer[index].customerCnpj}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
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
