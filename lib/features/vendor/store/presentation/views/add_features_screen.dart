import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/toast_helper.dart';
import 'package:plugdin/utils/widgets/back_arrow.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';
import 'package:plugdin/utils/widgets/filter_chip_widget.dart';

class AddFeaturesScreen extends StatefulWidget {
  const AddFeaturesScreen({super.key});

  @override
  State<AddFeaturesScreen> createState() => _AddFeaturesScreenState();
}

class _AddFeaturesScreenState extends State<AddFeaturesScreen> {
  @override
  void initState() {
    context.read<VendorStoreCubit>().getStoreFeatures();
    super.initState();
  }

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
          'Add Features',
          style: context.h3,
        ),
      ),
      body: BlocBuilder<VendorStoreCubit, VendorStoreState>(
        builder: (context, state) {
          if (state.allStoreFeatures.isLoading) {
            return const LoadingWidget();
          }
          if (state.allStoreFeatures.isFailure) {
            return PIErrorWidget(
              errorText:
                  state.allStoreFeatures.errorMessage ?? 'Something went wrong',
              onPressed: () {
                context.read<VendorStoreCubit>().getStoreFeatures();
              },
            );
          }
          if (state.allStoreFeatures.isEmpty) {
            return const EmptyWidget(
              text: 'No features available',
            );
          }
          final features = state.allStoreFeatures.data?.features ?? [];
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final feature = features[index];
              return PIFilterChipWidget(
                label: feature,
                onTap: () {
                  context.read<VendorStoreCubit>().addFeatureToRequest(
                    feature,
                  );
                },
                isSelected: state.featuresRequest.features.contains(feature),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemCount: features.length,
          );
        },
      ),
      bottomNavigationBar: BlocConsumer<VendorStoreCubit, VendorStoreState>(
        listener: (context, state) {
          if (state.updateFeaturesState.isLoaded) {
            context.pop();
            ToastHelper.showSuccessToast('Features updated successfully');
          } else if (state.updateFeaturesState.isFailure) {
            ToastHelper.showErrorToast(
              state.updateFeaturesState.errorMessage ?? 'Update failed',
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: PIButton(
              text: 'Update',
              onPressed: () {
                context.read<VendorStoreCubit>().updateStoreFeatures();
              },
              outsidePadding: const EdgeInsetsDirectional.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              isLoading: state.updateFeaturesState.isLoading,
            ),
          );
        },
      ),
    );
  }
}
