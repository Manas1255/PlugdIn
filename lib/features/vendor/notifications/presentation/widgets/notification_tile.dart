import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/utils/helpers/date_time_formatter.dart';
import 'package:plugdin/utils/widgets/core_widgets/images/cached_network_image_widget.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    required this.title,
    required this.body,
    required this.onDeletePress,
    this.dateTime,
    this.image,
    this.isRead = false,
    this.onTap,
    super.key,
  });

  final String title;
  final String body;
  final String? image;
  final DateTime? dateTime;
  final bool isRead;
  final VoidCallback onDeletePress;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          CustomSlidableAction(
            padding: EdgeInsets.zero,
            onPressed: (context) {
              onDeletePress();
            },
            backgroundColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 8,
                bottom: 16,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AssetPaths.binIcon,
                    height: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
            bottom: 16,
          ),
          child: Container(
            padding: const EdgeInsetsDirectional.all(
              20,
            ),
            decoration: BoxDecoration(
              color: isRead
                  ? AppColors.white
                  : AppColors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(
                12,
              ),
              border: isRead
                  ? null
                  : Border.all(
                      color: AppColors.primaryColor.withOpacity(0.3),
                      width: 1,
                    ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      if (image != null)
                        PICNIWidget(
                          imageUrl: image!,
                          height: 32,
                          width: 32,
                        )
                      else
                        Container(
                          padding: const EdgeInsetsDirectional.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.secondaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            AssetPaths.bellIcon,
                          ),
                        ),

                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: context.b1.copyWith(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              body,
                              style: context.l2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    if (!isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.secondaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    if (!isRead) const SizedBox(width: 8),
                    Text(
                      PIDateTimeFormatter.formatTime(dateTime),
                      style: context.l2.copyWith(
                        fontWeight: isRead
                            ? FontWeight.normal
                            : FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
