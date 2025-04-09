import 'package:carousel_slider/carousel_slider.dart';
import 'package:cartzy/data/models/slider_model.dart';
import 'package:cartzy/presentation/state_holders/slider_list_controller.dart';
import 'package:cartzy/presentation/ui/utils/app_colors.dart';
import 'package:cartzy/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBannerSlider extends StatefulWidget {
  const HomeBannerSlider({super.key});

  @override
  State<HomeBannerSlider> createState() => _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<HomeBannerSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SliderListController>(
      builder: (SliderListController) {
        return Visibility(
          visible: !SliderListController.inProgress,
          replacement: const SizedBox(
            height: 200,
            child: CenteredCircularProgressIndicator(),
          ),
          child: Column(
            children: [
              _buildCarouselSlider(SliderListController),
              const SizedBox(height: 8),
              _buildCarouselDots(SliderListController),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCarouselSlider(SliderListController SliderListController,) {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 0.9,
        height: 180,
        onPageChanged: (index, reason) {
          _selectedIndex.value = index;
        },
      ),
      items: SliderListController.sliders.map((slider) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: _buildSliderProperties(slider, context),
            );
          },
        );
      },).toList(),
    );
  }

  Widget _buildSliderProperties(SliderModel slider, BuildContext context) {
    return Stack(
      children: [
        _buildSliderImage(slider, context),
        _buildPriceDiscountText(slider, context),
        _buildBuybutton(),
      ],
    );
  }

  Widget _buildSliderImage(SliderModel slider, BuildContext context) {
    return Image.network(
      slider.image ?? '',
      width: MediaQuery.of(context).size.width * 0.95, height: 180,
      fit: BoxFit.fitHeight,
      alignment: Alignment(0.8, 0.8),
    );
  }

  Widget _buildPriceDiscountText(SliderModel slider, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 4),
        Align(
          alignment: Alignment.center,
          child: Text(
            slider.price ?? '',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.themeColor,
                fontWeight: FontWeight.w600
            ),
          ),
        ),
        SizedBox(height: 16)
      ],
    );
  }

  Widget _buildBuybutton() {
    return Positioned(
      bottom: 16,
      right: 16,
      child: SizedBox(
        width: 120,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.themeColor,
          ),
          onPressed: () {},
          child: Text('Buy Now'),
        ),
      ),
    );
  }

  Widget _buildCarouselDots(SliderListController SliderListController) {
    return ValueListenableBuilder(
      valueListenable: _selectedIndex,
      builder: (context, currentIndex, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < SliderListController.sliders.length; i++)
              Container(
                height: 12,
                width: 12,
                margin: EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  color:
                      _selectedIndex.value == i ? AppColors.themeColor : null,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
              ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }
}
