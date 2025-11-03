import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_constants.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/features/profile/presentation/cubit/cubit.dart';
import 'package:plugdin/features/profile/presentation/cubit/state.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ProfileCubit>().fetchProfileInfo();
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
        title: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return Text(
              state.profileInfo.data?.name ?? '',
              style: context.h3.copyWith(
                fontSize: 18,
              ),
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
        'Home Screen',
      ),
    );
  }
}
