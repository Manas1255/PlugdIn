import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_constants.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/features/customer/home/presentation/cubit/cubit.dart';
import 'package:plugdin/features/customer/home/presentation/cubit/state.dart';
import 'package:plugdin/features/customer/home/presentation/widgets/vendor_card_widget.dart';
import 'package:plugdin/features/customer/profile/presentation/cubit/cubit.dart';
import 'package:plugdin/features/customer/profile/presentation/cubit/state.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  @override
  void initState() {
    context.read<CustomerProfileCubit>().fetchProfileInfo();
    context.read<CustomerHomeCubit>().fetchAllVendors();
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
        title: BlocBuilder<CustomerProfileCubit, CustomerProfileState>(
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
      body: BlocBuilder<CustomerHomeCubit, CustomerHomeState>(
        builder: (context, state) {
          if (state.allVendors.isLoading) {
            return const LoadingWidget();
          }
          if (state.allVendors.isFailure) {
            return PIErrorWidget(
              errorText:
                  state.allVendors.errorMessage ?? 'Something went wrong',
              onPressed: () {
                context.read<CustomerHomeCubit>().fetchAllVendors();
              },
            );
          }
          if (state.allVendors.isEmpty) {
            return const EmptyWidget(
              text: 'No Vendors Found',
            );
          }
          return Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Featured',
                  style: context.h1,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final vendor = state.allVendors.data?.vendors[index];
                      return VendorCardWidget(
                        companyName: vendor?.companyName ?? '',
                        primaryCategory: vendor?.primaryCategory ?? '',
                        location: vendor?.address ?? '',
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 8,
                      );
                    },
                    itemCount: state.allVendors.data?.vendors.length ?? 0,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
