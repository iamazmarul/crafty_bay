import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/product_list_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:crafty_bay/presentation/ui/widgets/category_item.dart';
import 'package:crafty_bay/presentation/ui/widgets/circle_icon_button.dart';
import 'package:crafty_bay/presentation/ui/widgets/banner_image_carousel.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_card_item.dart';
import 'package:crafty_bay/presentation/ui/widgets/section_title.dart';
import 'package:flutter/material.dart';
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
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              searchTextFormField,
              const SizedBox(
                height: 16,
              ),
              const ImageCarouselWidget(),
              const SizedBox(
                height: 16,
              ),
              SectionTitle(
                title: 'All Categories',
                onTabSeeAll: () {
                  Get.find<MainBottomNavController>().changeIndex(1);
                },
              ),
              CategoryList,
              SectionTitle(title: "Popular", onTabSeeAll: () {
                Get.to(ProductListScreen());
              }),
              const SizedBox(
                height: 8,
              ),
              ProductList,
              SectionTitle(title: "Special", onTabSeeAll: () {}),
              const SizedBox(
                height: 8,
              ),
              ProductList,
              SectionTitle(title: "New", onTabSeeAll: () {}),
              const SizedBox(
                height: 8,
              ),
              ProductList,
            ],
          ),
        ),
      ),
    );
  }

  SizedBox get ProductList {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        itemCount: 10,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const ProductCardItem();
        },
        separatorBuilder: (_, __) {
          return const SizedBox(
            width: 8,
          );
        },
      ),
    );
  }

  SizedBox get CategoryList {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        itemCount: 10,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const CategoryItem(
            title: 'Electronics',
          );
        },
        separatorBuilder: (_, __) {
          return const SizedBox(
            width: 8,
          );
        },
      ),
    );
  }

  TextFormField get searchTextFormField {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Search",
        filled: true,
        fillColor: Colors.grey.shade200,
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  AppBar get appBar {
    return AppBar(
      title: Image.asset(AssetsPath.navBarLogo),
      automaticallyImplyLeading: false,
      actions: [
        CircleIconButton(
          onTap: () {},
          iconData: Icons.person,
        ),
        const SizedBox(
          width: 8,
        ),
        CircleIconButton(
          onTap: () {},
          iconData: Icons.call,
        ),
        const SizedBox(
          width: 8,
        ),
        CircleIconButton(
          onTap: () {},
          iconData: Icons.notifications_active,
        ),
      ],
    );
  }
}

