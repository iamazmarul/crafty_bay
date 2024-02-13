import 'package:crafty_bay/data/models/product_model.dart';
import 'package:crafty_bay/presentation/state_holders/brand_product_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/product_details_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_card.dart';
import 'package:crafty_bay/presentation/ui/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandProductListScreen extends StatefulWidget {
  final int brandId;
  final String remarkName;

  const BrandProductListScreen(
      {super.key, required this.remarkName, required this.brandId});

  @override
  State<BrandProductListScreen> createState() =>
      _BrandProductListScreenState();
}

class _BrandProductListScreenState extends State<BrandProductListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Get.find<BrandProductListController>()
          .getProductsByBrand(widget.brandId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: widget.remarkName,
          elevation: 1,
        ),
      ),
      body: GetBuilder<BrandProductListController>(
          builder: (brandProductListController) {
            List<ProductData> productData =
                brandProductListController.productModel.data ?? [];
            if (brandProductListController.getBrandProductsListInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return productData.isEmpty
                ? const Center(
              child: Text('No data availables!'),
            )
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                itemCount: productData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => ProductDetailsScreen(
                        productId: productData[index].id!,
                      ));
                    },
                    child: FittedBox(
                      child: ProductCard(
                        productData: productData[index],
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
