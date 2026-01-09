import 'package:flutter/material.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class CustomerVendorStoreView extends StatelessWidget {
  const CustomerVendorStoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const EmptyWidget(
            text: 'Media not available for this vendor.',
          ),
          const SizedBox(height: 8),
          Text(
            'Store media is only available for your own store.',
            style: context.l3.copyWith(
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
