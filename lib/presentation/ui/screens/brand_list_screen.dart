import 'package:crafty_bay/presentation/state_holders/brand_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/brand_product_list_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/brand_card.dart';
import 'package:crafty_bay/presentation/ui/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandListScreen extends StatelessWidget {
  const BrandListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: 'Brands',
          elevation: 1,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Get.find<BrandController>().getBrand();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child:
          GetBuilder<BrandController>(builder: (brandController) {
            if (brandController.getBrandInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return GridView.builder(
              itemCount: brandController.brandModel.data?.length ?? 0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => BrandProductListScreen(
                        brandId: index + 1,
                        remarkName: brandController
                            .brandModel.data![index].brandName ??
                            ''));
                  },
                  child: FittedBox(
                    child: BrandCard(
                      brandData: brandController
                          .brandModel.data![index],
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
