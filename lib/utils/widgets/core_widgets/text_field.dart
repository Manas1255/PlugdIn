import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';

enum PITextFieldType {
  email,
  password,
  description,
  number,
  text,
  confirmPassword,
  datePicker,
  timePicker,
}

class PITextField extends StatefulWidget {
  const PITextField({
    required this.controller,
    this.padding = EdgeInsets.zero,
    this.labelText,
    this.hintText,
    this.hintColor,
    this.hintFontWeight,
    this.type = PITextFieldType.text,
    this.validator,
    this.prefixPath,
    this.suffixPath,
    this.contentPadding,
    this.readOnly,
    this.descriptionMaxCharacter = 200,
    this.regularMaxCharacter = 100,
    this.onTap,
    this.onChanged,
    this.borderRadius,
    this.passwordToMatch,
    this.backgroundColor,
    this.showSuffixIcon,
    this.errorText,
    this.focusNode,
    this.formatNumber = false,
    this.textInputType,
    this.isRequired = false,
    this.textAlign,
    super.key,
  });

  final TextEditingController controller;
  final EdgeInsetsGeometry padding;
  final String? labelText;
  final String? hintText;
  final Color? hintColor;
  final FontWeight? hintFontWeight;
  final PITextFieldType type;
  final String? Function(String?)? validator;
  final String? prefixPath;
  final String? suffixPath;
  final EdgeInsetsGeometry? contentPadding;
  final bool? readOnly;
  final VoidCallback? onTap;
  final int regularMaxCharacter;
  final int descriptionMaxCharacter;
  final void Function(String)? onChanged;
  final double? borderRadius;
  final String? passwordToMatch;
  final Color? backgroundColor;
  final bool? showSuffixIcon;
  final String? errorText;
  final FocusNode? focusNode;
  final bool? formatNumber;
  final TextInputType? textInputType;
  final bool isRequired;
  final TextAlign? textAlign;

  @override
  State<PITextField> createState() => _PITextFieldState();
}

class _PITextFieldState extends State<PITextField> {
  late FocusNode _focusNode;
  bool _obscureText = true;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    // Only add focus listener if we created our own focus node
    // External focus nodes should be managed by parent widgets
    if (widget.focusNode == null) {
      _focusNode.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  String? _validate(String? value) {
    final customError = widget.validator?.call(value);
    final typeError = customError;

    setState(() {
      _errorText = typeError;
    });

    return typeError;
  }

  Future<void> _handleDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(widget.controller.text) ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
              onSurface: AppColors.greyColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                textStyle: context.b2.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: AppColors.offWhite,
              headerBackgroundColor: AppColors.primaryColor,
              headerForegroundColor: AppColors.offWhite,
              weekdayStyle: context.b2.copyWith(
                color: AppColors.greyColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              dayStyle: context.b2.copyWith(
                color: AppColors.greyColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              yearStyle: context.b2.copyWith(
                color: AppColors.greyColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              headerHeadlineStyle: context.b2.copyWith(
                color: AppColors.offWhite,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
              headerHelpStyle: context.b2.copyWith(
                color: AppColors.offWhite,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              rangePickerHeaderHeadlineStyle: context.b2.copyWith(
                color: AppColors.offWhite,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
              rangePickerHeaderHelpStyle: context.b2.copyWith(
                color: AppColors.offWhite,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      widget.controller.text = formattedDate;
      widget.onChanged?.call(formattedDate);
    }
  }

  Future<void> _handleTimePicker() async {
    TimeOfDay initialTime;

    // Try to parse existing time from controller
    if (widget.controller.text.isNotEmpty) {
      try {
        final parts = widget.controller.text.split(':');
        if (parts.length == 2) {
          final hour = int.parse(parts[0]);
          final minute = int.parse(parts[1]);
          initialTime = TimeOfDay(hour: hour, minute: minute);
        } else {
          initialTime = TimeOfDay.now();
        }
      } catch (e) {
        // If parsing fails, use current time
        initialTime = TimeOfDay.now();
      }
    } else {
      initialTime = TimeOfDay.now();
    }

    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
              onSurface: AppColors.greyColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                textStyle: context.b2.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
            timePickerTheme: TimePickerThemeData(
              backgroundColor: AppColors.offWhite,
              hourMinuteTextColor: AppColors.greyColor,
              hourMinuteColor: AppColors.greyShade6.withValues(alpha: 0.3),
              dayPeriodTextColor: AppColors.greyColor,
              dayPeriodColor: AppColors.greyShade6.withValues(alpha: 0.3),
              dayPeriodBorderSide: const BorderSide(
                color: AppColors.greyShade6,
              ),
              dialHandColor: AppColors.primaryColor,
              dialBackgroundColor: AppColors.greyShade5,
              dialTextColor: AppColors.offWhite,
              entryModeIconColor: AppColors.primaryColor,
              helpTextStyle: context.b2.copyWith(
                color: AppColors.greyColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              hourMinuteTextStyle: context.b2.copyWith(
                color: AppColors.greyColor,
                fontWeight: FontWeight.w700,
                fontSize: 32,
              ),
              dayPeriodTextStyle: context.b2.copyWith(
                color: AppColors.greyColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formattedTime = picked.format(context);
      widget.controller.text = formattedTime;
      widget.onChanged?.call(formattedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEmail = widget.type == PITextFieldType.email;
    final isPassword =
        widget.type == PITextFieldType.password ||
        widget.type == PITextFieldType.confirmPassword;
    final isDescription = widget.type == PITextFieldType.description;
    final isNumber = widget.type == PITextFieldType.number;
    final isDatePicker = widget.type == PITextFieldType.datePicker;
    final isTimePicker = widget.type == PITextFieldType.timePicker;

    final fieldError = widget.errorText ?? _errorText;

    // 2. use fieldError
    final borderColor = fieldError != null
        ? AppColors.error
        : _focusNode.hasFocus
        ? AppColors.black
        : AppColors.textFieldBorderColor;

    final textColor = fieldError != null ? AppColors.error : AppColors.black;

    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        isDescription ? 24 : widget.borderRadius ?? 16,
      ),
      borderSide: BorderSide(
        color: borderColor,
      ),
    );

    final iconColor = _errorText != null
        ? AppColors.error
        : AppColors.tertiaryColor;

    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null) ...[
            Row(
              children: [
                Text(
                  widget.labelText!,
                  style: context.b2.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.offWhite,
                  ),
                ),
                if (widget.isRequired) ...[
                  const SizedBox(width: 4),
                  Text(
                    '*',
                    style: context.b2.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.red,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
          ],
          GestureDetector(
            onTap: isDatePicker
                ? _handleDatePicker
                : isTimePicker
                ? _handleTimePicker
                : widget.readOnly != true
                ? null
                : () {},
            child: AbsorbPointer(
              absorbing:
                  isDatePicker || isTimePicker || (widget.readOnly == true),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    isDescription ? 24 : widget.borderRadius ?? 12,
                  ),
                ),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  focusNode: _focusNode,
                  controller: widget.controller,
                  obscureText: isPassword ? _obscureText : false,
                  readOnly: widget.readOnly ?? isDatePicker || isTimePicker,
                  keyboardType:
                      widget.textInputType ??
                      (isPassword
                          ? TextInputType.visiblePassword
                          : isEmail
                          ? TextInputType.emailAddress
                          : isNumber
                          ? TextInputType.number
                          : TextInputType.text),
                  maxLines: isDescription ? 5 : 1,
                  maxLength: isDescription
                      ? widget.descriptionMaxCharacter
                      : widget.regularMaxCharacter,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  inputFormatters: isNumber
                      ? [FilteringTextInputFormatter.digitsOnly]
                      : null,
                  onChanged: (value) {
                    if (_errorText != null) {
                      setState(() {
                        _errorText = null;
                      });
                    }
                    widget.onChanged?.call(value);
                  },
                  onTap: widget.onTap,
                  validator: _validate,
                  style: context.b1.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w400,
                  ),
                  cursorColor: AppColors.black,
                  cursorWidth: 1,
                  textAlign: widget.textAlign ?? TextAlign.start,
                  decoration: InputDecoration(
                    errorText: fieldError,
                    filled: true,
                    fillColor: widget.backgroundColor ?? AppColors.primaryColor,
                    counterText: '',
                    hint:
                        widget.isRequired &&
                            widget.hintText != null &&
                            widget.labelText == null
                        ? RichText(
                            text: TextSpan(
                              text: widget.hintText,
                              style: context.b1.copyWith(
                                color:
                                    widget.hintColor ??
                                    AppColors.darkGreyTextColor,
                                fontWeight:
                                    widget.hintFontWeight ?? FontWeight.w400,
                              ),
                              children: const [
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(color: AppColors.red),
                                ),
                              ],
                            ),
                          )
                        : Text(
                            widget.hintText ?? '',
                            style: context.b2.copyWith(
                              color:
                                  widget.hintColor ??
                                  AppColors.darkGreyTextColor,
                              fontWeight:
                                  widget.hintFontWeight ?? FontWeight.w400,
                            ),
                          ),

                    errorStyle: const TextStyle(fontSize: 0, height: 0),
                    border: baseBorder,
                    enabledBorder: baseBorder,
                    focusedBorder: baseBorder,
                    errorBorder: baseBorder,
                    focusedErrorBorder: baseBorder,
                    prefixIconConstraints: const BoxConstraints(minWidth: 40),
                    suffixIconConstraints: const BoxConstraints(minWidth: 40),
                    prefixIcon: widget.prefixPath != null
                        ? Padding(
                            padding: const EdgeInsetsDirectional.only(
                              start: 12,
                            ),
                            child: SvgPicture.asset(
                              widget.prefixPath!,
                            ),
                          )
                        : null,
                    suffixIcon: widget.showSuffixIcon == false
                        ? null
                        : widget.showSuffixIcon == null
                        ? (isDatePicker
                              ? Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    end: 12,
                                  ),
                                  child: SvgPicture.asset(
                                    AssetPaths.calenderIcon,
                                  ),
                                )
                              : isTimePicker
                              ? Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    end: 12,
                                  ),
                                  child: Icon(
                                    Icons.access_time,
                                    color: iconColor,
                                    size: 20,
                                  ),
                                )
                              : buildSuffixIcon(
                                  iconColor,
                                  isPassword: isPassword,
                                ))
                        : (isDatePicker
                              ? Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    end: 12,
                                  ),
                                  child: SvgPicture.asset(
                                    AssetPaths.calenderIcon,
                                  ),
                                )
                              : isTimePicker
                              ? Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    end: 12,
                                  ),
                                  child: Icon(
                                    Icons.access_time,
                                    color: iconColor,
                                    size: 20,
                                  ),
                                )
                              : buildSuffixIcon(
                                  iconColor,
                                  isPassword: isPassword,
                                )),
                    contentPadding: isDescription
                        ? const EdgeInsetsDirectional.only(start: 16, top: 24)
                        : widget.contentPadding ??
                              const EdgeInsetsDirectional.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                  ),
                ),
              ),
            ),
          ),
          if (_errorText != null) ...[
            const SizedBox(height: 6),
            Text(
              _errorText!,
              style: context.b2.copyWith(
                color: AppColors.error,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget? buildSuffixIcon(Color iconColor, {required bool isPassword}) {
    if (widget.suffixPath != null) {
      return Padding(
        padding: const EdgeInsetsDirectional.only(end: 16),
        child: SvgPicture.asset(
          widget.suffixPath!,
        ),
      );
    } else if (isPassword) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        child: SvgPicture.asset(
          _obscureText ? AssetPaths.eyeOff : AssetPaths.eye,
        ),
      );
    }
    return null;
  }
}
