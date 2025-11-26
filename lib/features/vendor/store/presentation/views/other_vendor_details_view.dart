import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/state.dart';

class OtherVendorDetailsView extends StatelessWidget {
  const OtherVendorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorStoreCubit, VendorStoreState>(
      builder: (context, state) {
        final features = state.otherVendorStoreInfo.data?.features ?? [];
        
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Features',
                  style: context.b1.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                if (features.isEmpty)
                  Text(
                    'No features available.',
                    style: context.l3,
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: features.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  features[index],
                                  style: context.b3,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
