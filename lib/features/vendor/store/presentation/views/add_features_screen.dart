import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/state.dart';
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
                onTap: () {},
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemCount: features.length,
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: PIButton(
          text: 'Update',
          onPressed: () {},
          outsidePadding: const EdgeInsetsDirectional.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
        ),
      ),
    );
  }
}
