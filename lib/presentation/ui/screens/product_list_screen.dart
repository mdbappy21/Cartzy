import 'package:cartzy/data/models/category_model.dart';
import 'package:cartzy/presentation/state_holders/product_list_by_category_controller.dart';
import 'package:cartzy/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:cartzy/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProductListByCategoryController>().getNewProductListByCategory(widget.category.id!,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.categoryName ?? '')),
      body: GetBuilder<ProductListByCategoryController>(
        builder: (productListByCategoryController) {
          if (productListByCategoryController.inProgress) {
            return CenteredCircularProgressIndicator();
          }
          if (productListByCategoryController.errorMassage != null) {
            return Center(
              child: Text(productListByCategoryController.errorMassage!),
            );
          }

          if(productListByCategoryController.productList.isEmpty){
            return Align(
              alignment: const Alignment(0, -0.5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset('assets/lotteries/empty.json',
                    width: 250,
                    height: 300,
                    fit: BoxFit.scaleDown,
                  ),
                  const SizedBox(height: 8),
                  Text('Product List is empty',style: Theme.of(context).textTheme.titleLarge,),
                ],
              ),
            );
          }

          return GridView.builder(
            itemCount: productListByCategoryController.productList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              mainAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              return FittedBox(
                child: ProductCard(
                  product: productListByCategoryController.productList[index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
