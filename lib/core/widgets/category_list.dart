import 'package:flutter/material.dart';

import 'category_item.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({
    super.key,
    required this.categories,
    this.onCategorySelected,
  });
  final List<String> categories;
  final Function(int selectedIndex)? onCategorySelected;

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      scrollDirection: Axis.horizontal,
      itemBuilder:
          (context, index) => GestureDetector(
            onTap: () {
              selectedIndex = index;
              setState(() {});
              widget.onCategorySelected!(index);
            },
            child: CategoryItem(
              text: widget.categories[index],
              selected: selectedIndex == index,
            ),
          ),
      separatorBuilder: (context, index) => SizedBox(width: 12),
      itemCount: widget.categories.length,
    );
  }
}
