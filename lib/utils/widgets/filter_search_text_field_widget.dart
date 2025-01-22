import 'package:flutter/material.dart';
import 'package:app_economize_mais/utils/app_scheme.dart';

class FilterSearchTextFieldWidget extends StatelessWidget {
  const FilterSearchTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(color: AppScheme.gray[3]!),
        ),
        contentPadding: const EdgeInsets.only(left: 30),
        hintText: 'Pesquisar',
        hintStyle: TextStyle(
          color: AppScheme.gray[3],
          fontSize: 12,
        ),
        suffixIcon: Icon(
          Icons.search,
          size: 16,
          color: AppScheme.gray[3],
        ),
      ),
      style: const TextStyle(fontSize: 12),
    );
  }
}
