import 'package:cartzy/presentation/ui/screens/product_list_screen.dart';
import 'package:cartzy/presentation/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(()=>ProductListScreen(categoryName: 'Electronics'));
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: AppColors.themeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16)
            ),
            child: Icon(Icons.computer, size: 48,),
          ),
          const SizedBox(height: 4,),
          Text('Electronics')
        ],
      ),
    );
  }
}

