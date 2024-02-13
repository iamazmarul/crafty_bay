import 'package:crafty_bay/application/utility/app_colors.dart';
import 'package:crafty_bay/data/models/brand_model.dart';
import 'package:flutter/material.dart';

class BrandCard extends StatelessWidget {
  final BrandData brandData;
  const BrandCard({
    super.key, required this.brandData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8)),
              child: Image.network(brandData.brandImg ?? '', width: 40,
                height: 40,),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              brandData.brandName.toString(),
              style: TextStyle(
                  fontSize: 15,
                  color: AppColors.primaryColor,
                  letterSpacing: 0.4),
            )
          ],
        ),
      ),
    );
  }
}
