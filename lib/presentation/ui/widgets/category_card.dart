import 'package:cartzy/data/models/category_model.dart';
import 'package:cartzy/presentation/ui/screens/product_list_screen.dart';
import 'package:cartzy/presentation/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key, required this.categoryModel,
  });

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(()=>ProductListScreen(category: categoryModel));
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: AppColors.themeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16)
            ),
            child: Image.network(
              categoryModel.categoryImg ?? '',
              width: 48,
              fit: BoxFit.fitHeight,
              alignment: Alignment(0.8, 0.8),
            ),
          ),
          const SizedBox(height: 4,),
          Text(categoryModel.categoryName??'')
        ],
      ),
    );
  }
}

