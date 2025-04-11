import 'package:cartzy/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:cartzy/presentation/state_holders/category_list_controller.dart';
import 'package:cartzy/presentation/ui/widgets/category_card.dart';
import 'package:cartzy/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (value,_){
        backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
          leading: IconButton(
            onPressed: backToHome,
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: ()async{
            Get.find<CategoryListController>().getCategoryList();
          },
          child: GetBuilder<CategoryListController>(
            builder: (CategoryListController) {
              if(CategoryListController.inProgress){
                return CenteredCircularProgressIndicator();
              }else if(CategoryListController.errorMassage != null){
                return Center(
                  child: Text(CategoryListController.errorMassage!),
                );
              }
              return GridView.builder(
                itemCount: CategoryListController.categoryList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return CategoryCard(
                    categoryModel: CategoryListController.categoryList[index],
                  );
                },
              );
            }
          ),
        ),
      ),
    );
  }
  void backToHome() {
    Get.find<BottomNavBarController>().backToHome();
  }
}
