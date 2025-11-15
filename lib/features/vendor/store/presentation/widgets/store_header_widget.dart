import 'package:flutter/material.dart';
import 'package:plugdin/constants/app_constants.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class StoreHeaderWidget extends StatelessWidget {
  const StoreHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PICNIWidget(
          imageUrl: AppConstants.appPlaceHolderSellerImage,
          height: 80,
          width: 80,
          borderRadius: BorderRadius.circular(100),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    '120',
                    style: context.h3.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Reviews',
                    style: context.l3,
                  ),
                ],
              ),

              Column(
                children: [
                  Text(
                    '14.2',
                    style: context.h3.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Rating',
                    style: context.l3,
                  ),
                ],
              ),

              Column(
                children: [
                  Text(
                    '30',
                    style: context.h3.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Listing',
                    style: context.l3,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
