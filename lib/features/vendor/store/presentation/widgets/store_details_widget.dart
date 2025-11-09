import 'package:flutter/material.dart';
import 'package:plugdin/constants/app_text_style.dart';

class StoreDetailsWidget extends StatelessWidget {
  const StoreDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Company Name',
          style: context.h2.copyWith(
            fontSize: 24,
          ),
        ),
        Text(
          'Primary Category',
          style: context.b2,
        ),
        const SizedBox(height: 4),
        Text(
          'Location',
          style: context.b3,
        ),
        const SizedBox(height: 4),
        Text(
          'Business Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          style: context.l2,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
