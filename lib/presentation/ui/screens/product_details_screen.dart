import 'package:cartzy/presentation/ui/utils/app_colors.dart';
import 'package:cartzy/presentation/ui/widgets/color_picker.dart';
import 'package:cartzy/presentation/ui/widgets/product_image_slider.dart';
import 'package:cartzy/presentation/ui/widgets/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: Column(
        children: [
          Expanded(
            child: _buildProductDetails(),
          ),
          _buildPriceAndAddToCardSection()
        ],
      ),
    );
  }

  Widget _buildProductDetails() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductImageSlider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNameAndQuantityCounter(),
                SizedBox(height: 4),
                _buildRatingAndReview(),
                SizedBox(height: 8),
                ColorPicker(
                  colors: [Colors.red, Colors.black, Colors.green, Colors.orange,],
                  onColorSelected: (color) {},
                ),
                SizedBox(height: 16),
                SizePicker(
                  sizes: ['M', 'L', 'XL', 'XXL'],
                  onSizeSelected: (String selectedSize) {},
                ),
                const SizedBox(height: 16),
                _buildDescriptionSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme
              .of(context)
              .textTheme
              .titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          '''This versatile shoe combines modern style with exceptional comfort. Crafted with a breathable mesh upper, cushioned insole, and durable non-slip rubber sole, it ensures all-day support and stability. Perfect for both casual outings and active use, it’s designed to keep you comfortable, stylish, and confident with every step.''',
          style: TextStyle(color: Colors.black45),
        ),
      ],
    );
  }

  Widget _buildNameAndQuantityCounter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            'Shoe 2025 latest model - New year spacial deal.',
            style: Theme
                .of(context)
                .textTheme
                .titleMedium,
          ),
        ),
        ItemCount(
          initialValue: 1,
          minValue: 0,
          maxValue: 20,
          decimalPlaces: 0,
          color: AppColors.themeColor,
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _buildRatingAndReview() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(Icons.star, color: Colors.amber, size: 16),
            Text(
              '3.8',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: () {},
          child: Text(
            'Review',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.themeColor,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Card(
          color: AppColors.themeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              Icons.favorite_outline_rounded,
              size: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceAndAddToCardSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price'),
              Text('\$100', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.themeColor
              ),)
            ],),
          SizedBox(width: 140,
            child: ElevatedButton(
              onPressed: () {}, style: ElevatedButton.styleFrom(
                fixedSize: Size(140, 50)
            ), child: Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}
