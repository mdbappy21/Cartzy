import 'package:cartzy/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:cartzy/presentation/state_holders/wish_list_controller.dart';
import 'package:cartzy/data/utills/urls.dart';
import 'package:cartzy/presentation/UI/widgets/icon_back_button.dart';
import 'package:cartzy/presentation/ui/utils/snack_massage.dart';
import 'package:cartzy/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:cartzy/presentation/ui/widgets/wish_product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cartzy/presentation/ui/screens/email_verification_screen.dart';
import 'package:lottie/lottie.dart';


class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  Future<void> _initializer() async {
    bool check = await Get.find<WishListController>().getUserWishes();
    if (check == false) {
      showSnackBarMassage('Please Login!', true);
      Get.to(() => const EmailVerificationScreen());
    }
  }

  @override
  void initState() {
    _initializer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (value, _) {
        backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Wish List',
            style: Theme.of(context,).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
          ),
          titleSpacing: 0,
          leading: IconBackButton(
            whereToBack: () {
              backToHome();
            },
          ),
        ),
        body: GetBuilder<WishListController>(
          builder: (controller) {
            return Visibility(
              visible: !controller.loading,
              replacement: const CenteredCircularProgressIndicator(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: LayoutBuilder(builder: (context, screen) {
                  if (controller.wishList.isNotEmpty) {
                    if (screen.maxWidth < 331) {
                      return GridView.builder(
                        itemCount: controller.wishList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return FittedBox(
                            child: WishProductCard(
                              title: controller.wishList[index].product?.title ??
                                  'Error',
                              price: controller.wishList[index].product?.price ??
                                  'Error',
                              star: controller.wishList[index].product?.star
                                  .toString() ??
                                  '0',
                              image: controller.wishList[index].product?.image ??
                                  Urls.dummyImage,
                              id: controller.wishList[index].productId ?? 0,
                            ),
                          );
                        },
                      );
                    } else {
                      return GridView.builder(
                        itemCount: controller.wishList.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5),
                        itemBuilder: (BuildContext context, int index) {
                          return WishProductCard(
                            title: controller.wishList[index].product?.title ??
                                'Error',
                            price: controller.wishList[index].product?.price ??
                                'Error',
                            star: controller.wishList[index].product?.star
                                .toString() ??
                                '0',
                            image: controller.wishList[index].product?.image ??
                                Urls.dummyImage,
                            id: controller.wishList[index].productId ?? 0,
                          );
                        },
                      );
                    }
                  } else {
                    return Align(
                      alignment: Alignment(0, -0.5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Lottie.asset('assets/lotteries/empty.json',
                            width: 250,
                            height: 300,
                            fit: BoxFit.scaleDown,
                          ),
                          const SizedBox(height: 8),
                          Text('Product List is empty', style: Theme
                              .of(context)
                              .textTheme
                              .titleLarge,),
                        ],
                      ),
                    );
                  }
                }
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  void backToHome() {
    Get.find<BottomNavBarController>().backToHome();
  }
}
