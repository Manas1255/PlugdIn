import 'package:equatable/equatable.dart';
import 'package:plugdin/core/enums/city.dart';
import 'package:plugdin/core/enums/filter_view_type.dart';
import 'package:plugdin/core/enums/role_type.dart';

class CustomerFilterState extends Equatable {
  const CustomerFilterState({
    this.selectedRoleType = RoleType.none,
    this.viewType = FilterViewType.normalDisplayView,
    this.minCapacity = 0,
    this.maxCapacity = 1000000,
    this.city,
    this.priceFrom,
    this.priceTo,
    this.capacity,
    this.feature,
  });

  final RoleType? selectedRoleType;
  final FilterViewType viewType;
  final int minCapacity;
  final int maxCapacity;
  final City? city;
  final double? priceFrom;
  final double? priceTo;
  final int? capacity;
  final String? feature;

  CustomerFilterState copyWith({
    RoleType? selectedRoleType,
    FilterViewType? viewType,
    int? minCapacity,
    int? maxCapacity,
    City? city,
    double? priceFrom,
    double? priceTo,
    int? capacity,
    String? feature,
  }) {
    return CustomerFilterState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
      viewType: viewType ?? this.viewType,
      minCapacity: minCapacity ?? this.minCapacity,
      maxCapacity: maxCapacity ?? this.maxCapacity,
      city: city ?? this.city,
      priceFrom: priceFrom ?? this.priceFrom,
      priceTo: priceTo ?? this.priceTo,
      capacity: capacity ?? this.capacity,
      feature: feature ?? this.feature,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
    viewType,
    minCapacity,
    maxCapacity,
    city,
    priceFrom,
    priceTo,
    capacity,
    feature,
  ];
}

