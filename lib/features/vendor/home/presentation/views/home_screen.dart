import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_constants.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/features/vendor/profile/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/profile/presentation/cubit/state.dart';
import 'package:plugdin/utils/widgets/core_widgets/images/cached_network_image_widget.dart';

class VendorHomeScreen extends StatefulWidget {
  const VendorHomeScreen({super.key});

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {
  @override
  void initState() {
    context.read<VendorProfileCubit>().fetchProfileInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: PICNIWidget(
          imageUrl: AppConstants.appPlaceHolderSellerImage,
          borderRadius: BorderRadius.circular(100),
        ),
        title: BlocBuilder<VendorProfileCubit, VendorProfileState>(
          builder: (context, state) {
            return Text(
              state.profileInfo.data?.personName ?? '',
              style: context.h3,
            );
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              right: 16,
            ),
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.secondaryColor,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              AssetPaths.bellIcon,
            ),
          ),
        ],
      ),
      body: Text(
        'Welcomeeee ',
      ),
    );
  }
}
