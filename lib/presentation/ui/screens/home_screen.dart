import 'package:cartzy/presentation/UI/screens/email_verification_screen.dart';
import 'package:cartzy/presentation/state_holders/auth_controller.dart';
import 'package:cartzy/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:cartzy/presentation/state_holders/category_list_controller.dart';
import 'package:cartzy/presentation/state_holders/new_product_list_controller.dart';
import 'package:cartzy/presentation/state_holders/popular_product_list_controller.dart';
import 'package:cartzy/presentation/state_holders/profile_info_cache_controller.dart';
import 'package:cartzy/presentation/state_holders/read_profile_controller.dart';
import 'package:cartzy/presentation/state_holders/special_product_list_controller.dart';
import 'package:cartzy/presentation/ui/screens/complete_profile_screen.dart';
import 'package:cartzy/presentation/ui/utils/assets_path.dart';
import 'package:cartzy/presentation/ui/utils/snack_massage.dart';
import 'package:cartzy/presentation/ui/widgets/centered_circular_progress_indicator.dart';
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
        SectionHeader(title: 'Popular', onTap: () {

        }),
        SizedBox(
          height: 180,
          child: GetBuilder<PopularProductListController>(
            builder: (popularProductListController) {
              return Visibility(
                visible: !popularProductListController.inProgress,
                replacement: CenteredCircularProgressIndicator(),
                child: HorizontalProductListView(
                  productList: popularProductListController.productList,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSpacialProductSection() {
    return Column(
      children: [
        SectionHeader(title: 'Spacial', onTap: () {}),
        SizedBox(
          height: 180,
          child: GetBuilder<SpecialProductListController>(
            builder: (specialProductListController) {
              return Visibility(
                visible: !specialProductListController.inProgress,
                replacement: CenteredCircularProgressIndicator(),
                child: HorizontalProductListView(
                  productList: specialProductListController.productList,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNewProductSection() {
    return Column(
      children: [
        SectionHeader(title: 'New', onTap: () {}),
        SizedBox(
          height: 180,
          child: GetBuilder<NewProductListController>(
            builder: (newProductListController) {
              return Visibility(
                visible: !newProductListController.inProgress,
                replacement: CenteredCircularProgressIndicator(),
                child: HorizontalProductListView(
                  productList: newProductListController.productList,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      children: [
        SectionHeader(
          title: 'Categories',
          onTap: () {
            Get.find<BottomNavBarController>().selectCategory();
          },
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: GetBuilder<CategoryListController>(
            builder: (categoryListController) {
              return Visibility(
                visible: !categoryListController.inProgress,
                replacement: CenteredCircularProgressIndicator(),
                child: HorizontalCategoriesListView(
                  categoryList: categoryListController.categoryList,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leadingWidth: 120,
      leading: SvgPicture.asset(AssetsPath.appLeading, fit: BoxFit.contain),
      actions: [
        AppBarIconButton(
          iconData: Icons.person,
          onTap: () async {
            String? accessToken = AuthController.accessToken;

            if (accessToken != null) {
              final readProfileController = Get.find<ReadProfileController>();

              bool success = await readProfileController.getProfileDetails(
                accessToken,
              );

              if (success) {
                final profile = await ProfileInfoCacheController.getProfile();

                if (profile != null) {
                  Get.to(
                    CompleteProfileScreen(
                      heading: 'Update Profile',
                      readProfileData: profile,
                    ),
                  );
                } else {
                  showSnackBarMassage(
                    'Profile not found. Please complete your profile.',
                  );
                }
              } else {
                showSnackBarMassage('Failed to fetch profile data.');
              }
            } else {
              showSnackBarMassage('Please Login!');
              Get.to(() => const EmailVerificationScreen());
            }
          },
        ),
        const SizedBox(width: 12),
        AppBarIconButton(iconData: Icons.notifications_active, onTap: () {}),
        const SizedBox(width: 12),
        AppBarIconButton(
          iconData: Icons.logout,
          onTap: () {
            Get.find<AuthController>().clearUserData();
            AuthController.accessToken=null;
            Get.to(EmailVerificationScreen());
          },
        ),
        const SizedBox(width: 12),
      ],
    );
  }
}
