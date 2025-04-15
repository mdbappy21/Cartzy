import 'package:cartzy/data/models/product_details_model.dart';
import 'package:cartzy/presentation/state_holders/add_to_cart_controller.dart';
import 'package:cartzy/presentation/state_holders/auth_controller.dart';
import 'package:cartzy/presentation/state_holders/product_details_controller.dart';
import 'package:cartzy/presentation/state_holders/wishlist_addition_controller.dart';
import 'package:cartzy/presentation/ui/screens/email_verification_screen.dart';
import 'package:cartzy/presentation/ui/screens/review_screen.dart';
import 'package:cartzy/presentation/ui/utils/app_colors.dart';
import 'package:cartzy/presentation/ui/utils/snack_massage.dart';
import 'package:cartzy/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:cartzy/presentation/ui/widgets/color_picker.dart';
import 'package:cartzy/presentation/ui/widgets/product_image_slider.dart';
import 'package:cartzy/presentation/ui/widgets/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String _selectedColor = '';
  String _selectedSize = '';
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    Get.find<ProductDetailsController>().getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: GetBuilder<ProductDetailsController>(
        builder: (productDetailsController) {
          if (productDetailsController.inProgress) {
            return CenteredCircularProgressIndicator();
          }
          if (productDetailsController.errorMassage != null) {
            return Center(child: Text(productDetailsController.errorMassage!));
          }

          return Visibility(
            visible: !productDetailsController.inProgress,
            replacement: CenteredCircularProgressIndicator(),
            child: Column(
              children: [
                Expanded(
                  child: _buildProductDetails(productDetailsController.product!,productId:widget.productId
                      .toString() ??
                      '1'),
                ),
                _buildPriceAndAddToCardSection(productDetailsController.product!),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductDetails(ProductDetailsModel productDetails,{required String productId}) {
    List<String> colors=productDetails.color!.split(',');
    List<String> size=productDetails.size!.split(',');
    _selectedColor=colors.first;
    _selectedSize=size.first;

    return SingleChildScrollView(
      child: Column(
        children: [
          ProductImageSlider(
            sliderUrls: [
              productDetails.img1!,
              productDetails.img2!,
              productDetails.img3!,
              productDetails.img4!,
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNameAndQuantityCounter(productDetails),
                SizedBox(height: 4),
                _buildRatingAndReview(productDetails, productId: productId),
                SizedBox(height: 8),
                ColorPicker(
                  colorNames: colors,
                  onColorSelected: (color) {
                    _selectedColor;
                  },
                ),
                SizedBox(height: 16),
                SizePicker(
                  sizes: size,
                  onSizeSelected: (String selectedSize) {
                    _selectedSize;
                  },
                ),
                const SizedBox(height: 16),
                _buildDescriptionSection(productDetails),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _buildDescriptionSection(ProductDetailsModel productDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(productDetails.des ?? '', style: TextStyle(color: Colors.black45)),
      ],
    );
  }

  Widget _buildNameAndQuantityCounter(ProductDetailsModel productDetails) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            productDetails.product?.title ?? '',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ItemCount(
          initialValue: _quantity,
          minValue: 1,
          maxValue: 20,
          decimalPlaces: 0,
          color: AppColors.themeColor,
          onChanged: (value) {
            _quantity = value.toInt();
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildRatingAndReview(ProductDetailsModel productDetails,{required String productId}) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(Icons.star, color: Colors.amber, size: 16),
            Text(
              '${productDetails.product?.star}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black54,
                fontSize: 20,
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            Get.to(() => const ReviewScreen());
          },
          child: Text(
            'Reviews',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(color:AppColors.themeColor,fontSize: 18),
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: ()async {
            bool added = await Get.find<WishlistAdditionController>()
                .addToWishList(productId: productId);
            if (added) {
              showSnackBarMassage('Added to the wishlist!');
            } else {
              showSnackBarMassage( 'You have to Login');
              Get.to(() => const EmailVerificationScreen());
            }
          },
          // color: AppColors.themeColor,
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: Container(
            height: 24,
            width: 24,
            color: AppColors.themeColor,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(
                  Icons.favorite_outline_rounded, size: 16, color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceAndAddToCardSection(ProductDetailsModel productDetails) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price'),
              Text(
                '\$${productDetails.product?.price}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child: GetBuilder<AddToCartController>(
              builder: (addToCartController) {
                return Visibility(
                  visible: !addToCartController.inProgress,
                  replacement: const CenteredCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: _onTapAddToCart,
                    style: ElevatedButton.styleFrom(fixedSize: Size(140, 50)),
                    child: Text('Add to Cart'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onTapAddToCart() async {
    bool isLoggedInUser = Get.find<AuthController>().isLoggedInUser();
    if (isLoggedInUser) {
      final result = await Get.find<AddToCartController>().addToCart(
          widget.productId, _selectedColor, _selectedSize, _quantity);
      if (result) {
        if (mounted) {
          showSnackBarMassage('Added to cart');
        }
      } else {
        if (mounted) {
          showSnackBarMassage(Get.find<AddToCartController>().errorMassage!, true,);
        }
      }
    } else {
      Get.to(() => EmailVerificationScreen());
    }
  }
}
