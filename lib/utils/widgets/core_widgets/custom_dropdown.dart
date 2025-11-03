import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class PIDropdown<T> extends StatefulWidget {
  const PIDropdown({
    required this.items,
    required this.onChanged,
    super.key,
    this.value,
    this.hintText,
    this.backgroundColor = AppColors.white,
    this.borderRadius = 16,
    this.contentPadding,
    this.validator,
    this.errorText,
    this.isRequired = false,
    this.labelText,
    this.hintColor,
    this.hintFontWeight,
    this.padding = EdgeInsets.zero,
    this.leading,
    this.textColor = AppColors.black,
    this.borderColor = AppColors.textFieldBorderColor,
    this.width,
    this.titleTextStyle,
    this.optionFontSize,
  });

  final List<DropdownItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? hintText;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(T?)? validator;
  final String? errorText;
  final bool isRequired;
  final String? labelText;
  final Color? hintColor;
  final FontWeight? hintFontWeight;
  final EdgeInsetsGeometry padding;
  final String? leading;
  final Color textColor;
  final Color borderColor;
  final double? width;
  final TextStyle? titleTextStyle;
  final double? optionFontSize;

  @override
  State<PIDropdown<T>> createState() => _PIDropdownState<T>();
}

class _PIDropdownState<T> extends State<PIDropdown<T>> {
  bool _isExpanded = false;

  void _toggleDropdown() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _selectItem(T? value) {
    setState(() {
      _isExpanded = false;
    });
    widget.onChanged?.call(value);
  }

  Widget _buildIconWidget(String iconPath) {
    // Check if it's a network URL or asset path
    if (iconPath.startsWith('http://') || iconPath.startsWith('https://')) {
      return PICNIWidget(
        imageUrl: iconPath,
        width: 16,
        height: 16,
        fit: BoxFit.cover,
        borderRadius: BorderRadius.circular(4),
      );
    } else {
      // Handle asset paths (SVG or PNG)
      if (iconPath.endsWith('.svg')) {
        return SvgPicture.asset(
          iconPath,
          width: 16,
          height: 16,
          colorFilter: const ColorFilter.mode(
            AppColors.black,
            BlendMode.srcIn,
          ),
        );
      } else {
        return Image.asset(
          iconPath,
          width: 16,
          height: 16,
          fit: BoxFit.cover,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final fieldError = widget.errorText;
    final borderColor = fieldError != null
        ? AppColors.red
        : _isExpanded
        ? AppColors.lightGreyShade4
        : widget.borderColor;

    final textColor = fieldError != null ? AppColors.red : widget.textColor;

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
                    color: AppColors.white,
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
          SizedBox(
            width: widget.width,
            child: Column(
              children: [
                // Main dropdown field
                GestureDetector(
                  onTap: _toggleDropdown,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(widget.borderRadius),
                        topRight: Radius.circular(widget.borderRadius),
                        bottomLeft: Radius.circular(
                          _isExpanded ? 0 : widget.borderRadius,
                        ),
                        bottomRight: Radius.circular(
                          _isExpanded ? 0 : widget.borderRadius,
                        ),
                      ),
                      border: Border.all(color: borderColor),
                    ),
                    child: Container(
                      padding:
                          widget.contentPadding ??
                          const EdgeInsetsDirectional.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                      decoration: BoxDecoration(
                        color: widget.backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(widget.borderRadius),
                          topRight: Radius.circular(widget.borderRadius),
                          bottomLeft: Radius.circular(
                            _isExpanded ? 0 : widget.borderRadius,
                          ),
                          bottomRight: Radius.circular(
                            _isExpanded ? 0 : widget.borderRadius,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          if (widget.leading != null) ...[
                            SvgPicture.asset(
                              widget.leading!,
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 12),
                          ],
                          if (widget.value != null) ...[
                            ...(() {
                              final selectedItem = widget.items.firstWhere(
                                (item) => item.value == widget.value,
                              );
                              if (selectedItem.icon != null) {
                                return [
                                  _buildIconWidget(selectedItem.icon!),
                                  const SizedBox(width: 12),
                                ];
                              }
                              return <Widget>[];
                            })(),
                          ],
                          Expanded(
                            child: widget.value != null
                                ? Text(
                                    widget.items
                                        .firstWhere(
                                          (item) => item.value == widget.value,
                                        )
                                        .label,
                                    style:
                                        widget.titleTextStyle ??
                                        context.b1.copyWith(
                                          color: textColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  )
                                : Text(
                                    widget.hintText ?? '',
                                    style: context.b1.copyWith(
                                      color:
                                          widget.hintColor ??
                                          AppColors.lightGreyShade2,
                                      fontWeight:
                                          widget.hintFontWeight ??
                                          FontWeight.w400,
                                    ),
                                  ),
                          ),
                          Transform.rotate(
                            angle: _isExpanded
                                ? 3.14159
                                : 0, // 180 degrees when expanded
                            child: SvgPicture.asset(
                              AssetPaths.dropdownIcon,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Expanded dropdown list
                if (_isExpanded) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      border: Border(
                        left: BorderSide(color: borderColor),
                        right: BorderSide(color: borderColor),
                        bottom: BorderSide(color: borderColor),
                      ),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: widget.items.length,
                      itemBuilder: (context, index) {
                        final item = widget.items[index];
                        final isSelected = item.value == widget.value;
                        final isLast = index == widget.items.length - 1;

                        return InkWell(
                          onTap: () => _selectItem(item.value),
                          child: Container(
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.secondaryColor.withValues(
                                      alpha: 0.1,
                                    )
                                  : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                bottomLeft: isLast
                                    ? const Radius.circular(16)
                                    : Radius.zero,
                                bottomRight: isLast
                                    ? const Radius.circular(16)
                                    : Radius.zero,
                              ),
                            ),
                            child: Row(
                              children: [
                                if (item.icon != null) ...[
                                  _buildIconWidget(item.icon!),
                                  const SizedBox(width: 12),
                                ],
                                Expanded(
                                  child: Text(
                                    item.label,
                                    style: context.b1.copyWith(
                                      color: isSelected
                                          ? AppColors.secondaryColor
                                          : AppColors.black,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      fontSize: widget.optionFontSize,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (fieldError != null) ...[
            const SizedBox(height: 6),
            Text(
              fieldError,
              style: context.b2.copyWith(
                color: AppColors.red,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class DropdownItem<T> {
  const DropdownItem({
    required this.value,
    required this.label,
    this.icon,
  });

  final T value;
  final String label;
  final String? icon;
}
