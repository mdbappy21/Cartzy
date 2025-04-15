import 'package:cartzy/presentation/state_holders/wish_list_controller.dart';
import 'package:cartzy/presentation/state_holders/wish_list_item_delete_controller.dart';
import 'package:cartzy/presentation/ui/screens/email_verification_screen.dart';
import 'package:cartzy/presentation/UI/screens/product_details_screen.dart';
import 'package:cartzy/presentation/ui/utils/app_colors.dart';

// import 'package:cartzy/presentation/UI/widgets/bottom_popup_message.dart';
import 'package:cartzy/presentation/ui/utils/assets_path.dart';
import 'package:cartzy/presentation/ui/utils/snack_massage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../../utils/theme_colors.dart';

class WishProductCard extends StatelessWidget {
  const WishProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.star,
    required this.image,
    required this.id,
  });

  final String title;
  final String price;
  final String star;
  final String image;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: SizedBox(
        width: 110,
        height: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Get.to(() => ProductDetailsScreen(productId: id));
              },
              child: Container(
                height: 81,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: AppColors.themeColor,
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                title,
                maxLines: 1,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall!.copyWith(color: Colors.black54),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$price\$',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.black87,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 17,
                      ),
                      Text(
                        star,
                        style: Theme.of(
                          context,
                        ).textTheme.labelSmall!.copyWith(color: Colors.black54),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      bool check =
                          await Get.find<WishListItemDeleteController>().delete(
                            productId: id.toString(),
                          );
                      if (check) {
                        Get.find<WishListController>().getUserWishes();
                        showSnackBarMassage('Delete');
                      } else {
                        showSnackBarMassage('Please Login!');
                        Get.to(() => const EmailVerificationScreen());
                      }
                    },
                    child: GetBuilder<WishListItemDeleteController>(
                      builder: (controller) {
                        return Visibility(
                          visible: !controller.inProgress,
                          replacement: Container(
                            height: 17,
                            width: 17,
                            decoration: BoxDecoration(
                              color: AppColors.themeColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(
                              Icons.refresh_rounded,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                          child: Container(
                            height: 17,
                            width: 17,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(
                              Icons.delete_outline_rounded,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
