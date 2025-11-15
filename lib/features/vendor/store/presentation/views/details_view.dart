import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/go_router/exports.dart';
import 'package:plugdin/utils/widgets/core_widgets/button.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Features',
            style: context.b1.copyWith(
              fontSize: 18,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: PIButton(
          text: 'Add Features',
          onPressed: () {
            context.pushNamed(
              AppRouteNames.addFeaturesScreen,
            );
          },
        ),
      ),
    );
  }
}
