import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

class CustomAnimatedDropdown<T> extends StatelessWidget {
  final List<T> items;
  final String Function(T) itemAsString;
  final String? hintText;
  final void Function(T?)? onChanged;

  const CustomAnimatedDropdown({
    super.key,
    required this.items,
    required this.itemAsString,
    this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: CustomDropdown<T>.search(
          hintText: hintText ?? 'Select an item',
          items: items,
          excludeSelected: false,
          onChanged: onChanged,
          decoration: CustomDropdownDecoration(
            hintStyle: const TextStyle(),
            listItemDecoration: ListItemDecoration(
              selectedColor: Colors.blue.withOpacity(0.3),
            ),
            searchFieldDecoration: const SearchFieldDecoration(
                hintStyle: TextStyle(fontSize: 13, color: Colors.deepPurple)),
          ),
        ),
      ),
    );
  }
}
