import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/core/field_validators.dart';
import 'package:plugdin/features/vendor/home/data/models/create_booking_request_model.dart';
import 'package:plugdin/features/vendor/home/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/home/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/date_time_formatter.dart';
import 'package:plugdin/utils/helpers/toast_helper.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class CreateBookingScreen extends StatefulWidget {
  const CreateBookingScreen({
    required this.packageId,
    required this.selectedSlot,
    super.key,
  });

  final String packageId;
  final String selectedSlot;

  @override
  State<CreateBookingScreen> createState() => _CreateBookingScreenState();
}

class _CreateBookingScreenState extends State<CreateBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime? _selectedDate;
  DateTime? _startTime;
  DateTime? _endTime;

  @override
  void initState() {
    super.initState();
    _initializeFromSelectedSlot();
    context.read<VendorHomeCubit>().clearBookingState();
  }

  void _initializeFromSelectedSlot() {
    final slotDate = DateTime.tryParse(widget.selectedSlot);
    if (slotDate != null) {
      _selectedDate = DateTime(slotDate.year, slotDate.month, slotDate.day);
      // Set default start time to 10:00 AM
      _startTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        10,
        0,
      );
      // Set default end time to 6:00 PM
      _endTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        18,
        0,
      );
      _startTimeController.text = PIDateTimeFormatter.formatTime(_startTime);
      _endTimeController.text = PIDateTimeFormatter.formatTime(_endTime);
    }
  }

  @override
  void dispose() {
    _locationController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  String _formatDateTimeToISO8601(DateTime dateTime) {
    return dateTime.toUtc().toIso8601String();
  }

  void _selectStartTime() async {
    if (_selectedDate == null) {
      ToastHelper.showErrorToast('Please ensure date is selected');
      return;
    }

    final initialTime = _startTime ?? DateTime.now();
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialTime),
    );

    if (picked != null) {
      final selectedDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        picked.hour,
        picked.minute,
      );

      if (selectedDateTime.isBefore(DateTime.now())) {
        ToastHelper.showErrorToast('Start time must be in the future');
        return;
      }

      setState(() {
        _startTime = selectedDateTime;
        _startTimeController.text = PIDateTimeFormatter.formatTime(_startTime);
      });
    }
  }

  void _selectEndTime() async {
    if (_selectedDate == null) {
      ToastHelper.showErrorToast('Please ensure date is selected');
      return;
    }

    if (_startTime == null) {
      ToastHelper.showErrorToast('Please select start time first');
      return;
    }

    final initialTime = _endTime ?? _startTime!.add(const Duration(hours: 1));
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialTime),
    );

    if (picked != null) {
      final selectedDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        picked.hour,
        picked.minute,
      );

      if (selectedDateTime.isBefore(_startTime!)) {
        ToastHelper.showErrorToast('End time must be after start time');
        return;
      }

      setState(() {
        _endTime = selectedDateTime;
        _endTimeController.text = PIDateTimeFormatter.formatTime(_endTime);
      });
    }
  }

  String? _startTimeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a start time';
    }
    if (_startTime == null) {
      return 'Please select a valid start time';
    }
    return FieldValidators.timeValidator(value, _startTime);
  }

  String? _endTimeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select an end time';
    }
    if (_endTime == null) {
      return 'Please select a valid end time';
    }
    if (_startTime != null && _endTime != null && _endTime!.isBefore(_startTime!)) {
      return 'End time must be after start time';
    }
    return null;
  }

  void _submitBooking() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_startTime == null || _endTime == null) {
      ToastHelper.showErrorToast('Please select both start and end times');
      return;
    }

    final request = CreateBookingRequestModel(
      packageId: widget.packageId,
      location: _locationController.text.trim(),
      startTime: _formatDateTimeToISO8601(_startTime!),
      endTime: _formatDateTimeToISO8601(_endTime!),
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );

    context.read<VendorHomeCubit>().createBooking(request);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VendorHomeCubit, VendorHomeState>(
      listenWhen: (previous, current) =>
          previous.createBooking != current.createBooking,
      listener: (context, state) {
        if (state.createBooking.isLoaded) {
          ToastHelper.showSuccessToast('Booking created successfully!');
          // Pop back to package detail screen
          context.pop();
          context.pop();
        }
        if (state.createBooking.isFailure) {
          ToastHelper.showErrorToast(
            state.createBooking.errorMessage ??
                'Failed to create booking. Please try again.',
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Booking'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_selectedDate != null)
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
                                PIDateTimeFormatter.formatDate(_selectedDate),
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
                const SizedBox(height: 24),
                PITextField(
                  controller: _locationController,
                  labelText: 'Location',
                  hintText: 'Enter event location',
                  type: PITextFieldType.text,
                  validator: FieldValidators.locationValidator,
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                PITextField(
                  controller: _startTimeController,
                  labelText: 'Start Time',
                  hintText: 'Select start time',
                  type: PITextFieldType.timePicker,
                  readOnly: true,
                  onTap: _selectStartTime,
                  validator: _startTimeValidator,
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                PITextField(
                  controller: _endTimeController,
                  labelText: 'End Time',
                  hintText: 'Select end time',
                  type: PITextFieldType.timePicker,
                  readOnly: true,
                  onTap: _selectEndTime,
                  validator: _endTimeValidator,
                  isRequired: true,
                ),
                const SizedBox(height: 16),
                PITextField(
                  controller: _notesController,
                  labelText: 'Notes (Optional)',
                  hintText: 'Add any additional notes',
                  type: PITextFieldType.description,
                  validator: FieldValidators.descriptionValidator,
                ),
                const SizedBox(height: 32),
                BlocBuilder<VendorHomeCubit, VendorHomeState>(
                  buildWhen: (previous, current) =>
                      previous.createBooking != current.createBooking,
                  builder: (context, state) {
                    final isLoading = state.createBooking.isLoading;
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _submitBooking,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor,
                          disabledBackgroundColor: AppColors.disabledButtonColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.white,
                                  ),
                                ),
                              )
                            : Text(
                                'Create Booking',
                                style: context.b1White,
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

