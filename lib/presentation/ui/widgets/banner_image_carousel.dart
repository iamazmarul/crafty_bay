import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';

class ImageCarouselWidget extends StatefulWidget {
  const ImageCarouselWidget({
    super.key,
    this.height,
  });

  final double? height;

  @override
  State<ImageCarouselWidget> createState() => _ImageCarouselWidgetState();
}

class _ImageCarouselWidgetState extends State<ImageCarouselWidget> {
  final ValueNotifier<int> _valueNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: widget.height ?? 180.0,
              onPageChanged: (index, reason) {
                _valueNotifier.value = index;
              },
          viewportFraction: 1,
          ),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 1.0),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'text $i',
                      style: const TextStyle(fontSize: 16.0),
                    ));
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 6,),
        ValueListenableBuilder(
          valueListenable: _valueNotifier,
          builder: (context, index, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 5; i++) Container(
                  height: 14,
                  width: 14,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: i == index ? AppColors.primaryColor : Colors.white,
                    border: Border.all(
                      color: i == index ? AppColors.primaryColor : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                )
              ],
            );
          }
        )
      ],
    );
  }
}
