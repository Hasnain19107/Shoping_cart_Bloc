import 'package:flutter/material.dart';

class ProductTags extends StatelessWidget {
  final String? category;
  final String? brand;

  const ProductTags({
    super.key,
    this.category,
    this.brand,
  });

  @override
  Widget build(BuildContext context) {
    if ((category?.isEmpty ?? true) && (brand?.isEmpty ?? true)) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 8,
      children: [
        if (category?.isNotEmpty ?? false)
          Chip(
            label: Text(category!.toUpperCase()),
            backgroundColor: const Color.fromRGBO(33, 150, 243, 0.1),
          ),
        if (brand?.isNotEmpty ?? false)
          Chip(
            label: Text(brand!),
            backgroundColor: const Color.fromRGBO(158, 158, 158, 0.1),
          ),
      ],
    );
  }
}
