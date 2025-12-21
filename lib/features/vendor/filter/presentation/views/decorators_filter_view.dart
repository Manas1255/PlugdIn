import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/core/enums/city.dart';
import 'package:plugdin/core/enums/filter_view_type.dart';
import 'package:plugdin/features/vendor/filter/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/filter/presentation/cubit/state.dart';
import 'package:plugdin/utils/widgets/core_widgets/custom_dropdown.dart';
import 'package:plugdin/utils/widgets/core_widgets/text_field.dart';

class DecoratorsFilterView extends StatefulWidget {
  const DecoratorsFilterView({super.key});

  @override
  State<DecoratorsFilterView> createState() => _DecoratorsFilterViewState();
}

class _DecoratorsFilterViewState extends State<DecoratorsFilterView> {
  late TextEditingController _priceFromController;
  late TextEditingController _priceToController;
  double? _previousPriceFrom;
  double? _previousPriceTo;
  City? _previousCity;

  @override
  void initState() {
    super.initState();
    final state = context.read<VendorFilterCubit>().state;
    _priceFromController = TextEditingController(
      text: state.priceFrom?.toString() ?? '',
    );
    _priceToController = TextEditingController(
      text: state.priceTo?.toString() ?? '',
    );
    _previousPriceFrom = state.priceFrom;
    _previousPriceTo = state.priceTo;
    _previousCity = state.city;
  }

  @override
  void dispose() {
    _priceFromController.dispose();
    _priceToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorFilterCubit, VendorFilterState>(
      builder: (context, state) {
        // Update controllers if state values changed externally
        if (_previousPriceFrom != state.priceFrom) {
          _priceFromController.text = state.priceFrom?.toString() ?? '';
          _previousPriceFrom = state.priceFrom;
        }
        if (_previousPriceTo != state.priceTo) {
          _priceToController.text = state.priceTo?.toString() ?? '';
          _previousPriceTo = state.priceTo;
        }
        if (_previousCity != state.city) {
          _previousCity = state.city;
        }

        return SingleChildScrollView(
          padding: const EdgeInsetsDirectional.only(
            start: 30,
            end: 30,
            top: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<VendorFilterCubit>().updateViewType(
                        FilterViewType.normalDisplayView,
                      );
                    },
                    child: SvgPicture.asset(
                      AssetPaths.backIcon,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Decorators',
                    style: context.h3.copyWith(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                'City',
                style: context.b1.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              PIDropdown<City>(
                value: state.city,
                hintText: 'Select City',
                items: City.values.map((city) {
                  return DropdownItem<City>(
                    value: city,
                    label: city.toDisplayName(),
                  );
                }).toList(),
                onChanged: (city) {
                  _previousCity = city;
                  context.read<VendorFilterCubit>().setCity(city);
                },
                backgroundColor: AppColors.primaryColor,
                borderRadius: 8,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Price range',
                style: context.b1.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: PITextField(
                      controller: _priceFromController,
                      hintText: 'Price from',
                      textInputType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      borderRadius: 8,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      backgroundColor: AppColors.primaryColor,
                      onChanged: (value) {
                        final parsedValue = double.tryParse(value);
                        _previousPriceFrom = parsedValue;
                        context.read<VendorFilterCubit>().setPriceFrom(
                          parsedValue,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PITextField(
                      controller: _priceToController,
                      hintText: 'Price to',
                      textInputType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      borderRadius: 8,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      backgroundColor: AppColors.primaryColor,
                      onChanged: (value) {
                        final parsedValue = double.tryParse(value);
                        _previousPriceTo = parsedValue;
                        context.read<VendorFilterCubit>().setPriceTo(
                          parsedValue,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
