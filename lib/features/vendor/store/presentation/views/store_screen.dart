import 'package:flutter/material.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/features/vendor/store/presentation/widgets/store_details_widget.dart';
import 'package:plugdin/features/vendor/store/presentation/widgets/store_header_widget.dart';

class VendorStoreScreen extends StatelessWidget {
  const VendorStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '@username',
          style: context.h3.copyWith(
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 24,
          vertical: 20,
        ),
        child: Column(
          children: [
            StoreHeaderWidget(),
            const SizedBox(height: 16),
            StoreDetailsWidget(),
          ],
        ),
      ),
    );
  }
}
