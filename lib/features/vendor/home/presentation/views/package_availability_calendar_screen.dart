import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/features/vendor/home/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/home/presentation/cubit/state.dart';
import 'package:plugdin/go_router/exports.dart';
import 'package:plugdin/utils/helpers/date_time_formatter.dart';
import 'package:plugdin/utils/widgets/core_widgets/error_widget.dart';
import 'package:plugdin/utils/widgets/core_widgets/loading_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class PackageAvailabilityCalendarScreen extends StatefulWidget {
  const PackageAvailabilityCalendarScreen({
    required this.packageId,
    super.key,
  });

  final String packageId;

  @override
  State<PackageAvailabilityCalendarScreen> createState() =>
      _PackageAvailabilityCalendarScreenState();
}

class _PackageAvailabilityCalendarScreenState
    extends State<PackageAvailabilityCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  DateTime? _selectedAvailableDate;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _fetchAvailability();
  }

  void _fetchAvailability() {
    final now = DateTime.now();
    final from = DateTime(
      now.year,
      now.month,
      now.day,
      0,
      0,
      0,
    ).toUtc().toIso8601String();
    final to = DateTime(
      now.year,
      now.month + 3,
      now.day,
      23,
      59,
      59,
    ).toUtc().toIso8601String();

    context.read<VendorHomeCubit>().fetchPackageAvailability(
      packageId: widget.packageId,
      from: from,
      to: to,
    );
  }

  Set<DateTime> _getAvailableDates(
    List<String>? slots,
  ) {
    if (slots == null || slots.isEmpty) return {};
    return slots
        .map((slot) {
          final date = DateTime.tryParse(slot);
          if (date == null) return null;
          return DateTime(date.year, date.month, date.day);
        })
        .whereType<DateTime>()
        .toSet();
  }

  bool _isAvailable(DateTime day, Set<DateTime> availableDates) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return availableDates.contains(normalizedDay);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!_isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  bool _isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void _proceedToBookingForm() {
    if (_selectedAvailableDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an available date'),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }

    final selectedSlot = context
        .read<VendorHomeCubit>()
        .state
        .packageAvailability
        .data
        ?.slots
        .firstWhere(
          (slot) {
            final slotDate = DateTime.tryParse(slot);
            if (slotDate == null) return false;
            return _isSameDay(
              DateTime(slotDate.year, slotDate.month, slotDate.day),
              _selectedAvailableDate,
            );
          },
          orElse: () => '',
        );

    if (selectedSlot?.isEmpty ?? true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selected date is not available'),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }

    context.pushNamed(
      AppRouteNames.createBookingScreen,
      extra: <String, dynamic>{
        'packageId': widget.packageId,
        'selectedSlot': selectedSlot,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Available Date'),
      ),
      body: BlocBuilder<VendorHomeCubit, VendorHomeState>(
        buildWhen: (previous, current) =>
            previous.packageAvailability != current.packageAvailability,
        builder: (context, state) {
          final availabilityState = state.packageAvailability;

          if (availabilityState.isLoading) {
            return const Center(child: LoadingWidget());
          }

          if (availabilityState.isFailure) {
            return PIErrorWidget(
              errorText:
                  availabilityState.errorMessage ??
                  'Failed to load availability.',
              onPressed: () {
                _fetchAvailability();
              },
            );
          }

          final availability = availabilityState.data;
          if (availability == null) {
            return PIErrorWidget(
              errorText: 'No availability data found.',
              onPressed: () {
                _fetchAvailability();
              },
            );
          }

          final availableDates = _getAvailableDates(availability.slots);

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (availability.message.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: AppColors.secondaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  availability.message,
                                  style: context.b2.copyWith(
                                    color: AppColors.secondaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 16),
                      TableCalendar(
                        firstDay: DateTime.now(),
                        lastDay: DateTime.now().add(const Duration(days: 365)),
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) =>
                            _isSameDay(_selectedDay, day),
                        calendarFormat: _calendarFormat,
                        eventLoader: (day) {
                          return _isAvailable(day, availableDates) ? [day] : [];
                        },
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        calendarStyle: CalendarStyle(
                          outsideDaysVisible: false,
                          weekendTextStyle: context.b2.copyWith(
                            color: AppColors.darkGrey,
                          ),
                          defaultTextStyle: context.b2.copyWith(
                            color: AppColors.black,
                          ),
                          disabledTextStyle: context.b2.copyWith(
                            color: AppColors.grey,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            shape: BoxShape.circle,
                          ),
                          todayDecoration: BoxDecoration(
                            color: AppColors.secondaryColor.withValues(
                              alpha: 0.3,
                            ),
                            shape: BoxShape.circle,
                          ),
                          markerDecoration: BoxDecoration(
                            color: AppColors.green,
                            shape: BoxShape.circle,
                          ),
                          markerSize: 6,
                          canMarkersOverflow: true,
                        ),
                        headerStyle: HeaderStyle(
                          formatButtonVisible: true,
                          titleCentered: true,
                          formatButtonShowsNext: false,
                          formatButtonDecoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          formatButtonTextStyle: context.b2.copyWith(
                            color: AppColors.white,
                          ),
                          leftChevronIcon: Icon(
                            Icons.chevron_left,
                            color: AppColors.secondaryColor,
                          ),
                          rightChevronIcon: Icon(
                            Icons.chevron_right,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: context.b2.copyWith(
                            color: AppColors.darkGrey,
                          ),
                          weekendStyle: context.b2.copyWith(
                            color: AppColors.darkGrey,
                          ),
                        ),
                        onDaySelected: (selectedDay, focusedDay) {
                          final normalizedDay = DateTime(
                            selectedDay.year,
                            selectedDay.month,
                            selectedDay.day,
                          );
                          if (_isAvailable(normalizedDay, availableDates)) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                              _selectedAvailableDate = normalizedDay;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('This date is not available'),
                                backgroundColor: AppColors.amber,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        onFormatChanged: (format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        },
                        onPageChanged: (focusedDay) {
                          setState(() {
                            _focusedDay = focusedDay;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      if (_selectedAvailableDate != null) ...[
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.lightGreyColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: AppColors.secondaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Selected Date',
                                      style: context.l3.copyWith(
                                        color: AppColors.darkGrey,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      PIDateTimeFormatter.formatDate(
                                        _selectedAvailableDate,
                                      ),
                                      style: context.b2.copyWith(
                                        color: AppColors.secondaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              SafeArea(
                minimum: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _selectedAvailableDate != null
                        ? _proceedToBookingForm
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      disabledBackgroundColor: AppColors.disabledButtonColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Continue',
                      style: context.b1White,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
