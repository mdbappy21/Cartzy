import 'package:flutter/material.dart';

import 'package:cartzy/presentation/ui/utils/app_colors.dart';

class ProductAmountPicker extends StatelessWidget {
  const ProductAmountPicker({
    super.key,
    required this.itemBuyingAmount, required this.plusButtonOnPressed, required this.minusButtonOnPressed,
  });

  final int itemBuyingAmount;
  final VoidCallback plusButtonOnPressed;
  final VoidCallback minusButtonOnPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: minusButtonOnPressed,
          iconSize: 18,
          padding: const EdgeInsets.all(4),
          constraints: const BoxConstraints(maxHeight: 30, maxWidth: 30),
          icon: const Icon(
            Icons.horizontal_rule,
            color: Colors.white,
          ),
          style: IconButton.styleFrom(
              backgroundColor: AppColors.themeColor.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.5))),
        ),
        Text(itemBuyingAmount.toString(),
            style: const TextStyle(
                color: AppColors.themeColor,
                fontWeight: FontWeight.w700,
                fontSize: 16)),
        IconButton(
          onPressed: plusButtonOnPressed,
          iconSize: 18,
          padding: const EdgeInsets.all(4),
          constraints: const BoxConstraints(maxHeight: 30, maxWidth: 30),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          style: IconButton.styleFrom(
              backgroundColor: AppColors.themeColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.5))),
        ),
      ],
    );
  }
}