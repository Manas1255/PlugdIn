import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/go_router/exports.dart';
import 'package:plugdin/utils/widgets/core_widgets/button.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Features'),
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
