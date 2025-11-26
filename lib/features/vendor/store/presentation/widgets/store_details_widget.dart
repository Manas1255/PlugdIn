import 'package:flutter/material.dart';
import 'package:plugdin/constants/app_text_style.dart';

class StoreDetailsWidget extends StatelessWidget {
  const StoreDetailsWidget({
    required this.companyName,
    required this.primaryCategory,
    required this.location,
    required this.businessDescription,
    super.key,
  });
  final String companyName;
  final String primaryCategory;
  final String location;
  final String businessDescription;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          companyName,
          style: context.h2.copyWith(
            fontSize: 24,
          ),
        ),
        Text(
          primaryCategory,
          style: context.b2,
        ),
        const SizedBox(height: 4),
        Text(
          location,
          style: context.b3,
        ),
        const SizedBox(height: 4),
        Text(
          businessDescription,
          style: context.l2,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
