import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../model/customer_model.dart';
/// CREATION OF STATELESS WIDGET
class TypeAheadCustomersWidget extends StatelessWidget {
  /// CONTROLLER FROM TYPEAHEAD
  final TextEditingController controller;
  /// CUSTOMERS LIST
  final List<Customer> customerList;
  /// FUNCTION ON CUSTOMER IS SELECT IN DROPDOWN
  final void Function(Customer) onSelectCustomer;


  /// STATELESS WIDGET BUILDER
  const TypeAheadCustomersWidget({
    super.key,
    required this.controller,
    required this.customerList,
    required this.onSelectCustomer,
  });

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Customer>(
      controller: controller,
      suggestionsCallback: (pattern) async {
        return customerList
            .where((customer) =>
            customer.customerName.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
      },
      builder: (context, controller, focusNode) {
        return TextField(
          controller: controller,
          focusNode: focusNode,

          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: 'Selecione um cliente',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0),
            icon: const Icon(Icons.person),
          ),
        );
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion.customerName.toUpperCase()),
        );
      },
      onSelected: (suggestion) {
        controller.text = suggestion.customerName.toUpperCase();
        onSelectCustomer(suggestion);
      },
    );
  }
}
