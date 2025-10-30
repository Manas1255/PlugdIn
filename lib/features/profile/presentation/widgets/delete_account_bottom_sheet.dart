import 'package:flutter/material.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/utils/widgets/core_widgets/button.dart';

class DeleteAccountBottomSheet extends StatefulWidget {
  const DeleteAccountBottomSheet({
    super.key,
  });

  static Future<void> show(BuildContext context, {required String requestId}) {
    return showModalBottomSheet(
      backgroundColor: AppColors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) => DeleteAccountBottomSheet(),
    );
  }

  @override
  State<DeleteAccountBottomSheet> createState() =>
      _DeleteAccountBottomSheetState();
}

class _DeleteAccountBottomSheetState extends State<DeleteAccountBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Are you sure?',
                  style: context.h3.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Are you sure you want to delete this item? Once deleted, it cannot be recovered and all related data will be permanently removed. Please confirm if you wish to proceed with this action.',
                  style: context.b2.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),
                PIButton(
                  text: 'Submit',
                  onPressed: () {
                    //delete account api call
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
