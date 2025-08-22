import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SortableDropdown extends StatelessWidget {
  const SortableDropdown({
    super.key,
    this.initialValue,
    this.sortOptions = const [
      'Name',
      'Higher Price',
      'Lower Price',
      'Sale',
    ],
    this.onChanged,
  });
  final List<String> sortOptions;
  final String? initialValue;
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
      initialValue: initialValue,
      items: _buildDropdownMenuItem(),
      onChanged: onChanged,
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownMenuItem() {
    return sortOptions
        .map(
          (option) => DropdownMenuItem(value: option, child: Text(option)),
        )
        .toList();
  }
}
