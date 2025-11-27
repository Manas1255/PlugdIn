import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/state.dart';
import 'package:plugdin/go_router/exports.dart';
import 'package:plugdin/utils/widgets/core_widgets/button.dart';
import 'package:plugdin/utils/widgets/core_widgets/error_widget.dart';
import 'package:plugdin/utils/widgets/core_widgets/loading_widget.dart';
import 'package:plugdin/utils/widgets/core_widgets/no_data_widget.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorStoreCubit, VendorStoreState>(
      builder: (context, state) {
        if (state.vendorStoreInfo.isLoading) {
          return const LoadingWidget();
        }
        if (state.vendorStoreInfo.isFailure) {
          return PIErrorWidget(
            onPressed: () {
              context.read<VendorStoreCubit>().getVendorStoreInfo();
            },
            errorText:
                state.vendorStoreInfo.errorMessage ??
                'Unexpected error occurred',
          );
        }
        if (state.vendorStoreInfo.isEmpty) {
          return const EmptyWidget(
            text: 'No store details found.',
          );
        }
        return Scaffold(
          body: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Features',
                  style: context.b1.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child:
                      state.vendorStoreInfo.data?.features != null &&
                          state.vendorStoreInfo.data!.features.isNotEmpty
                      ? ListView.separated(
                          itemCount:
                              state.vendorStoreInfo.data!.features.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            return Text(
                              state.vendorStoreInfo.data!.features[index],
                              style: context.b2,
                            );
                          },
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: PIButton(
              text: 'Add Features',
              onPressed: () {
                context.pushNamed(
                  AppRouteNames.addFeaturesScreen,
                );
              },
              outsidePadding: const EdgeInsetsDirectional.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
            ),
          ),
        );
      },
    );
  }
}
