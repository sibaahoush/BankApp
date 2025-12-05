import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.text, required this.selected});
  final String text;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: SelectedCategoryItem(text: text),
      secondChild: NotSelectedCategoryItem(text: text),
      crossFadeState:
          selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: Durations.short4,
    );
  }
}

class NotSelectedCategoryItem extends StatelessWidget {
  const NotSelectedCategoryItem({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w500, height: 1.2),
        ),
      ),
    );
  }
}

class SelectedCategoryItem extends StatelessWidget {
  const SelectedCategoryItem({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
