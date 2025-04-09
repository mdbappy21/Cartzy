import 'package:cartzy/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:cartzy/presentation/state_holders/slider_list_controller.dart';
import 'package:cartzy/presentation/ui/utils/assets_path.dart';
import 'package:cartzy/presentation/ui/widgets/export_import_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    Get.find<SliderListController>().getSliderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              SearchTextField(textEditingController: TextEditingController()),
              const SizedBox(height: 16),
              HomeBannerSlider(),
              const SizedBox(height: 16),
              _buildCategoriesSection(),
              const SizedBox(height: 16),
              _buildPopularProductSection(),
              const SizedBox(height: 16),
              _buildNewProductSection(),
              const SizedBox(height: 16),
              _buildSpacialProductSection(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularProductSection() {
    return Column(
      children: [
        SectionHeader(title: 'Popular', onTap: () {}),
        SizedBox(height: 180, child: HorizontalProductListView()),
      ],
    );
  }

  Widget _buildSpacialProductSection() {
    return Column(
      children: [
        SectionHeader(title: 'Spacial', onTap: () {}),
        SizedBox(height: 180, child: HorizontalProductListView()),
      ],
    );
  }

  Widget _buildNewProductSection() {
    return Column(
      children: [
        SectionHeader(title: 'New', onTap: () {}),
        SizedBox(height: 180, child: HorizontalProductListView()),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      children: [
        SectionHeader(title: 'Categories', onTap: () {
          Get.find<BottomNavBarController>().selectCategory();
        }),
        const SizedBox(height: 8),
        SizedBox(height: 120, child: _buildCategoriesListView()),
      ],
    );
  }

  Widget _buildCategoriesListView() {
    return HorizontalCategoriesListView();
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leadingWidth: 120,
      leading: SvgPicture.asset(AssetsPath.appLeading, fit: BoxFit.contain),
      actions: [
        AppBarIconButton(iconData: Icons.person, onTap: () {}),
        const SizedBox(width: 8),
        AppBarIconButton(iconData: Icons.phone, onTap: () {}),
        const SizedBox(width: 8),
        AppBarIconButton(iconData: Icons.notifications_active, onTap: () {}),
        const SizedBox(width: 8),
      ],
    );
  }
}
