import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/features/vendor/store/data/models/set_availability_request_model.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/toast_helper.dart';
import 'package:plugdin/utils/widgets/back_arrow.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';
import 'package:table_calendar/table_calendar.dart';

class SetAvailabilityScreen extends StatefulWidget {
  const SetAvailabilityScreen({super.key});

  @override
  State<SetAvailabilityScreen> createState() => _SetAvailabilityScreenState();
}

class _SetAvailabilityScreenState extends State<SetAvailabilityScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  DateTime? _effectiveFrom;
  DateTime? _effectiveTo;
  final Set<String> _selectedDaysOfWeek = {};

  final Map<String, String> _dayAbbreviations = {
    'MON': 'Monday',
    'TUE': 'Tuesday',
    'WED': 'Wednesday',
    'THU': 'Thursday',
    'FRI': 'Friday',
    'SAT': 'Saturday',
    'SUN': 'Sunday',
  };

  final List<String> _daysOfWeek = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

  @override
  void initState() {
    super.initState();
    context.read<VendorStoreCubit>().resetSetAvailabilityState();
    _effectiveFrom = DateTime.now();
  }

  void _toggleDayOfWeek(String day) {
    setState(() {
      if (_selectedDaysOfWeek.contains(day)) {
        _selectedDaysOfWeek.remove(day);
      } else {
        _selectedDaysOfWeek.add(day);
      }
    });
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
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

  void _clearEffectiveTo() {
    setState(() {
      _effectiveTo = null;
    });
  }

  void _submitAvailability() {
    if (_effectiveFrom == null) {
      ToastHelper.showErrorToast('Please select an effective from date');
      return;
    }

    if (_selectedDaysOfWeek.isEmpty) {
      ToastHelper.showErrorToast('Please select at least one day of the week');
      return;
    }

    final weekly = _selectedDaysOfWeek
        .map((day) => WeeklyAvailabilityModel(dayOfWeek: day))
        .toList();

    final request = SetAvailabilityRequestModel(
      effectiveFrom: _formatDate(_effectiveFrom!),
      effectiveTo: _effectiveTo != null ? _formatDate(_effectiveTo!) : null,
      weekly: weekly,
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
                'Select Days of Week',
                style: context.b1.copyWith(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _daysOfWeek.map((day) {
                  final isSelected = _selectedDaysOfWeek.contains(day);
                  return GestureDetector(
                    onTap: () => _toggleDayOfWeek(day),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.secondaryColor
                            : theme.colorScheme.surfaceVariant.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.secondaryColor
                              : theme.colorScheme.outlineVariant.withOpacity(0.6),
                        ),
                      ),
                      child: Text(
                        _dayAbbreviations[day] ?? day,
                        style: context.b2.copyWith(
                          color: isSelected
                              ? AppColors.white
                              : theme.colorScheme.onSurface,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Effective To (Optional)',
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
                  if (_effectiveTo != null) ...[
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: _clearEffectiveTo,
                      icon: const Icon(Icons.clear),
                      tooltip: 'Clear',
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 32),
              Text(
                'Calendar View',
                style: context.b1.copyWith(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: theme.colorScheme.outlineVariant.withOpacity(0.45),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TableCalendar(
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(const Duration(days: 365 * 2)),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: _onDaySelected,
                  calendarFormat: CalendarFormat.month,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    weekendTextStyle: context.b2.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    defaultTextStyle: context.b2,
                    selectedDecoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: AppColors.secondaryColor.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: const BoxDecoration(
                      color: AppColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: context.b1.copyWith(
                      fontSize: 16,
                    ),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: theme.colorScheme.onSurface,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: theme.colorScheme.onSurface,
                    ),
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

