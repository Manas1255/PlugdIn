import 'package:flutter/material.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class StoreHeaderWidget extends StatelessWidget {
  const StoreHeaderWidget({
    required this.reviewCount,
    required this.rating,
    required this.listingCount,
    required this.companyLogo,
    super.key,
  });

  final int reviewCount;
  final double rating;
  final int listingCount;
  final String companyLogo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PICNIWidget(
          imageUrl: companyLogo,
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
                    '$reviewCount',
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
                    '$rating',
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
                    '$listingCount',
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
