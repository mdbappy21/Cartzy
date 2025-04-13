import 'package:cartzy/presentation/ui/utils/app_colors.dart';
import 'package:cartzy/presentation/ui/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({super.key});

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  int _quantity=1;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          _buildProductImage(),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Title of Product",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          _buildColorAndSize(context),
                        ],
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                  ],
                ),
                _buildPriceAndCounter(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorAndSize(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        Text("Color : Red", style: Theme.of(context).textTheme.bodySmall,),
        Text("Size : XL", style: Theme.of(context).textTheme.bodySmall,),
      ],
    );
  }

  Widget _buildPriceAndCounter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('\$ 100', style: Theme.of(context).textTheme.titleMedium),
        ItemCount(
          initialValue: _quantity,
          minValue: 0,
          maxValue: 20,
          decimalPlaces: 0,
          color: AppColors.themeColor,
          onChanged: (value) {
            _quantity=value.toInt();
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildProductImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        AssetsPath.dummyProductImg,
        height: 80,
        width: 80,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
