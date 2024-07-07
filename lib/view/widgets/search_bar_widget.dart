import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 12),
          border: InputBorder.none,
          hintText: 'Procure por modelo',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
            size: 24,
          ),
        ),
      ),
    );
  }
}
