import 'package:flutter/material.dart';

class SearchText extends StatelessWidget {
  final TextEditingController _searchController;
  final Function(String)? onChanged;

  const SearchText({
    super.key,
    required TextEditingController searchController,
    this.onChanged,
  }) : _searchController = searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: const TextStyle(height: 0.1),
        controller: _searchController,
        decoration: InputDecoration(
            hintText: 'Search your destination',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: const BorderSide(
                width: 0.4,
              ),
            ),
            filled: true,
            fillColor: Colors.grey.shade50),
        onChanged: onChanged,
      ),
    );
  }
}
