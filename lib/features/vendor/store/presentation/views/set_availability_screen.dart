import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/features/vendor/store/data/models/set_availability_request_model.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/toast_helper.dart';
import 'package:plugdin/utils/widgets/back_arrow.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class SetAvailabilityScreen extends StatefulWidget {
  const SetAvailabilityScreen({super.key});

  @override
  State<SetAvailabilityScreen> createState() => _SetAvailabilityScreenState();
}

class _SetAvailabilityScreenState extends State<SetAvailabilityScreen> {
  DateTime? _effectiveFrom;
  DateTime? _effectiveTo;

  @override
  void initState() {
    super.initState();
    context.read<VendorStoreCubit>().resetSetAvailabilityState();
  }

  String _formatDateToISO8601(DateTime date, {bool isEndOfDay = false}) {
    if (isEndOfDay) {
      final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
      return endOfDay.toUtc().toIso8601String();
    } else {
      final startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);
      return startOfDay.toUtc().toIso8601String();
    }
  }

  void _selectEffectiveFrom() {
    showDatePicker(
      context: context,
      initialDate: _effectiveFrom ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    ).then((date) {
      if (date != null) {
        setState(() {
          _effectiveFrom = date;
        });
      }
    });
  }

  void _selectEffectiveTo() {
    showDatePicker(
      context: context,
      initialDate: _effectiveTo ?? (_effectiveFrom ?? DateTime.now()),
      firstDate: _effectiveFrom ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    ).then((date) {
      if (date != null) {
        setState(() {
          _effectiveTo = date;
        });
      }
    });
  }

  void _submitAvailability() {
    if (_effectiveFrom == null) {
      ToastHelper.showErrorToast('Please select an effective from date');
      return;
    }

    if (_effectiveTo == null) {
      ToastHelper.showErrorToast('Please select an effective to date');
      return;
    }

    final request = SetAvailabilityRequestModel(
      effectiveFrom: _formatDateToISO8601(_effectiveFrom!),
      effectiveTo: _formatDateToISO8601(_effectiveTo!, isEndOfDay: true),
    );

    context.read<VendorStoreCubit>().setVendorAvailability(request);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: BackArrowIcon(
          onTap: () {
            context.pop();
          },
        ),
        title: Text(
          'Set Availability',
          style: context.h3,
        ),
      ),
      body: BlocListener<VendorStoreCubit, VendorStoreState>(
        listenWhen: (previous, current) =>
            previous.setAvailabilityState != current.setAvailabilityState,
        listener: (context, state) {
          if (state.setAvailabilityState.isLoaded) {
            context.pop();
            ToastHelper.showSuccessToast('Availability set successfully');
          } else if (state.setAvailabilityState.isFailure) {
            ToastHelper.showErrorToast(
              state.setAvailabilityState.errorMessage ?? 'Failed to set availability',
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Effective From',
                style: context.b1.copyWith(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _selectEffectiveFrom,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceVariant.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: theme.colorScheme.outlineVariant.withOpacity(0.6),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _effectiveFrom != null
                              ? DateFormat('MMMM dd, yyyy').format(_effectiveFrom!)
                              : 'Select date',
                          style: context.b2.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Effective To',
                style: context.b1.copyWith(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _selectEffectiveTo,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceVariant.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: theme.colorScheme.outlineVariant.withOpacity(0.6),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _effectiveTo != null
                              ? DateFormat('MMMM dd, yyyy').format(_effectiveTo!)
                              : 'Select date',
                          style: context.b2.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<VendorStoreCubit, VendorStoreState>(
        builder: (context, state) {
          return SafeArea(
            child: PIButton(
              text: 'Save Availability',
              onPressed: _submitAvailability,
              outsidePadding: const EdgeInsetsDirectional.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              isLoading: state.setAvailabilityState.isLoading,
            ),
          );
        },
      ),
    );
  }
}

