import 'package:cartzy/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:cartzy/presentation/state_holders/cart_delete_controller.dart';
import 'package:cartzy/presentation/state_holders/cart_list_controller.dart';
import 'package:cartzy/presentation/state_holders/create_cart_controller.dart';
import 'package:cartzy/data/utills/urls.dart';
import 'package:cartzy/presentation/ui/screens/email_verification_screen.dart';
import 'package:cartzy/presentation/ui/utils/snack_massage.dart';
import 'package:cartzy/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:cartzy/presentation/ui/widgets/icon_back_button.dart';
import 'package:cartzy/presentation/ui/widgets/product_amount_picker.dart';
import 'package:cartzy/presentation/ui/widgets/total_price_and_proceed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cartzy/data/models/add_to_cart.dart';
import 'package:lottie/lottie.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<void> _initializer() async {
    bool check = await Get.find<CartListController>().getCarts();
    if (check == false) {
      showSnackBarMassage('Please Login!', true);
      Get.to(() => const EmailVerificationScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    _initializer();
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
          title: Text('Cart',
            style: Theme.of(context,).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
          ),
          titleSpacing: 0,
          leading: IconBackButton(
            whereToBack: () {
              backToHome();
            },
          ),
        ),

        body: GetBuilder<CartListController>(
          builder: (cartListController) {
            return Visibility(
              visible: !cartListController.loading && !Get.find<CreateCartController>().loading,
              replacement: const CenteredCircularProgressIndicator(),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: cartListController.carts.isEmpty ? _buildLottieImage(context): ListView.separated(
                        itemBuilder: (context, index) {
                          return _buildProductCard(cartListController, index, context);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 8);
                        },
                        itemCount: cartListController.carts.length,
                      ),
                    ),
                  ),
                  _buildTotalPriceAndCheckout(cartListController),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLottieImage(BuildContext context) {
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

  Widget _buildProductCard(CartListController cartListController, int index, BuildContext context) {
    return Card(
      color: Colors.grey.shade50,
      elevation: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildProductImage(cartListController, index),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductTitleAndDeleteCartButton(cartListController, index, context),
                _buildSizeColorAndUnitPrice(cartListController, index, context),
                _buildTotalPriceAndItemCount(cartListController, index, context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalPriceAndItemCount(CartListController cartListController, int index, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('\$${cartListController.carts[index].price}',
          style: TextStyle(color: Colors.teal,
            fontWeight: FontWeight.w600,
          ),
        ),
        _buildQuantityCounter(cartListController, index, context),
      ],
    );
  }

  Widget _buildSizeColorAndUnitPrice(CartListController cartListController, int index, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color: ${cartListController.carts[index].color}    Size: ${cartListController.carts[index].size}',
          style: Theme.of(context,).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        Text(
          'Unit Price: \$${(double.parse(cartListController.carts[index].price.toString()) /
              double.parse(cartListController.carts[index].qty.toString()))}',
        ),
      ],
    );
  }

  Widget _buildQuantityCounter(CartListController cartListController, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6,),
      child: ProductAmountPicker(
        itemBuyingAmount: int.parse(cartListController.carts[index].qty ?? '0',),
        plusButtonOnPressed: () async {
          bool check = await Get.find<CreateCartController>().createCart(
            AddToCart(
              productId: cartListController.carts[index].productId,
              color: cartListController.carts[index].color,
              size: cartListController.carts[index].size,
              qty: int.parse(cartListController.carts[index].qty ?? '0',) + 1,
            ),
          );
          if (check) {
            await cartListController.getCarts();
          } else {
            bottomPopUpMessage(context, 'Please login to your profile!',);
            Get.to(() => const EmailVerificationScreen());
          }
        },
        minusButtonOnPressed: () async {
          if (int.parse(cartListController.carts[index].qty ?? '1',) > 1) {
            bool check = await Get.find<CreateCartController>().createCart(
              AddToCart(
                productId: cartListController.carts[index].productId,
                color: cartListController.carts[index].color,
                size: cartListController.carts[index].size,
                qty: int.parse(cartListController.carts[index].qty ?? '0',) - 1,
              ),
            );
            if (check) {
              await cartListController.getCarts();
            } else {
              bottomPopUpMessage(context, 'Please login to your profile!',);
              Get.to(() => const EmailVerificationScreen(),);
            }
          }
        },
      ),
    );
  }

  Widget _buildProductTitleAndDeleteCartButton(CartListController cartListController, int index, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            cartListController.carts[index].product?.title ?? 'Error',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context,).textTheme.labelLarge!.copyWith(color: Colors.black87,),
          ),
        ),
        GetBuilder<CartDeleteController>(
          builder: (cartDeleteController) {
            return Visibility(
              visible: !cartDeleteController.inProgress,
              replacement: CircularProgressIndicator(),
              child: IconButton(
                onPressed: () async {
                  bool check = await cartDeleteController.deleteACart(
                    productId: Get.find<CartListController>().carts[index].productId.toString(),);
                  if (check) {
                    bottomPopUpMessage(context, 'Deleted',);
                    _initializer();
                  } else {
                    bottomPopUpMessage(context, 'Please Login!',);
                    Get.to(const EmailVerificationScreen(),);
                  }
                },
                icon: Icon(Icons.delete_outlined, color: Colors.red.shade300,),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildProductImage(CartListController controller, int index) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            controller.carts[index].product?.image ?? Urls.dummyImage,
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      height: 90,
      width: 90,
    );
  }

  Widget _buildTotalPriceAndCheckout(CartListController controller) {
    return TotalPriceAndProceed(
      totalPrice: (controller.totalPrice),
      buttonOnTap: () {},
      buttonLabel: 'Checkout',
    );
  }
  void backToHome() {
    Get.find<BottomNavBarController>().backToHome();
  }
}
