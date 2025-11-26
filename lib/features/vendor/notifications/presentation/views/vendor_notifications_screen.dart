import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/features/vendor/notifications/presentation/widgets/notification_tile.dart';
import 'package:plugdin/utils/widgets/back_arrow.dart';

class VendorNotificationsScreen extends StatelessWidget {
  const VendorNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: BackArrowIcon(
          onTap: () {
            context.pop();
          },
        ),
        title: Text(
          'Notifications',
          style: context.h3,
        ),
      ),
      body: Column(
        children: [
          NotificationTile(
            title: 'New Order Received',
            body: 'You have a new order from John Doe.',
            onDeletePress: () {},
            dateTime: DateTime.now(),
          ),

          NotificationTile(
            title: 'New Order Received',
            body: 'You have a new order from John Doe.',
            onDeletePress: () {},
            dateTime: DateTime.now(),
          ),
        ],
      ),
    );
  }
}
